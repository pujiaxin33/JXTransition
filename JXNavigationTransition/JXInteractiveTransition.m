//
//  JXInteractiveTransition.m
//  JXNavigationTransition
//
//  Created by jiaxin on 15/12/3.
//  Copyright © 2015年 jiaxin. All rights reserved.
//

#import "JXInteractiveTransition.h"

@interface JXInteractiveTransition ()

@property (nonatomic, weak) UIViewController *vc;//这里要用weak，不能用strong，不然无法释放
@property (nonatomic, assign) JXInteractiveTransitionType type;
@property (nonatomic, assign) JXInteractiveTransitionGestureDirection direction;

@end

@implementation JXInteractiveTransition

+ (instancetype)interactiveTransitionWithTransitionType:(JXInteractiveTransitionType)type gestureDirection:(JXInteractiveTransitionGestureDirection)direction
{
    return [[self alloc] initWithTransitionType:type gestureDirection:direction];
}

- (instancetype)initWithTransitionType:(JXInteractiveTransitionType)type gestureDirection:(JXInteractiveTransitionGestureDirection)direction
{
    self = [super init];
    if (self) {
        self.type = type;
        self.direction = direction;
    }
    return self;
}

- (void)addGestureForViewController:(UIViewController *)viewController
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    self.vc = viewController;
    [viewController.view addGestureRecognizer:pan];
}

- (void)handleGesture:(UIPanGestureRecognizer *)pan
{
    CGFloat percent = 0;
    CGFloat width = WindowSize.width;
    switch (self.direction) {
        case JXInteractiveTransitionGestureDirectionLeft:
        {
            CGFloat transitionX = -[pan translationInView:pan.view].x;
            percent = transitionX/width;
        }
            break;
        case JXInteractiveTransitionGestureDirectionRight:
        {
            CGFloat transitionX = [pan translationInView:pan.view].x;
            percent = transitionX/width;
        }
            break;
        case JXInteractiveTransitionGestureDirectionUp:
        {
            CGFloat transitionY = -[pan translationInView:pan.view].y;
            percent = transitionY/width;
        }
            break;
        case JXInteractiveTransitionGestureDirectionDown:
        {
            CGFloat transitionY = [pan translationInView:pan.view].y;
            percent = transitionY/width;            
        }
            break;
        default:
            break;
    }
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            //isInteraction如果为YES表示触发了手势，用百分比手势进行交互，反之就返回nil，直接进行转场操作
            self.isInteraction = YES;
            //startGesture 表示转场进行何种操作（present\dismiss\push\pop）这些操作看作一个复杂的动画，然后由手势百分比对这个动画进行进度调整
            [self startGesture];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            //根据手势百分比更新转场动画进度，在此手势交互状态不要调用[self cancelInteractiveTransition];
            [self updateInteractiveTransition:percent];
        }
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        {
            self.isInteraction = NO;
            //这里的finish和cancel影响，transition自定义转场动画的transitionWasCancelled
            if (percent > 0.5) {
                [self finishInteractiveTransition];
            }else {
                [self cancelInteractiveTransition];
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)startGesture
{
    switch (self.type) {
        case JXInteractiveTransitionTypePresent:
        {
            if (self.presentConfig) {
                self.presentConfig();
            }
        }
            break;
        case JXInteractiveTransitionTypeDismiss:
        {
            [_vc dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case JXInteractiveTransitionTypePush:
        {
            if (self.pushConfig) {
                self.pushConfig();
            }
        }
            break;
        case JXInteractiveTransitionTypePop:
        {
            [_vc.navigationController popViewControllerAnimated:YES];
        }
            break;
        default:
            break;
    }
}

@end
