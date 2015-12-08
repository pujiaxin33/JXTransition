//
//  JXPopPresentedTransition.m
//  JXNavigationTransition
//
//  Created by jiaxin on 15/12/2.
//  Copyright © 2015年 jiaxin. All rights reserved.
//

#import "JXPopPresentTransition.h"

@interface JXPopPresentTransition ()

@property (nonatomic, assign) JXPopPresentTransitionType type;

@end

@implementation JXPopPresentTransition

+ (instancetype)transitionWithTransitionType:(JXPopPresentTransitionType)type
{
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(JXPopPresentTransitionType)type
{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return _type == JXPopPresentTransitionTypePresent ? 0.5 : 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    switch (self.type) {
        case JXPopPresentTransitionTypePresent:
            [self presentAnimation:transitionContext];
            break;
        case JXPopPresentTransitionTypeDismiss:
            [self dismissAnimation:transitionContext];
        default:
            break;
    }
}

- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //这里的fromVC是navigationcontroller!!!
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //containerView用来添加将要显示的东西，fromVC不用添加，如果添加了，dismiss的时候会被移除掉
    UIView *containerView = [transitionContext containerView];
    
    //使用截屏代替fromVC.view,如果直接使用fromview，那么containerview就不要addfromview了
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = fromVC.view.frame;
    fromVC.view.hidden = YES;
    
    [containerView addSubview:tempView];
    [containerView addSubview:toVC.view];
    toVC.view.frame = CGRectMake(0, containerView.height, containerView.width, 400);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
         usingSpringWithDamping:0.55
          initialSpringVelocity:1/0.55
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         tempView.transform = CGAffineTransformMakeScale(0.8, 0.8);
                         toVC.view.transform = CGAffineTransformMakeTranslation(0, -400);
                     }
                     completion:^(BOOL finished) {
                         //如果要可交互，就必须要判断是否cancelled，cancelled之后就进行复原操作
                         if ([transitionContext transitionWasCancelled]) {
                             [transitionContext completeTransition:NO];
                             fromVC.view.hidden = NO;
                             [tempView removeFromSuperview];
                         }else {
                             [transitionContext completeTransition:YES];
                         }
                     }];
}

- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIView *tempView = [containerView.subviews firstObject];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         tempView.transform = CGAffineTransformIdentity;
                         fromVC.view.transform  = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         //如果要可交互，也要判断，成功之后也要去除多余的控件
                         if ([transitionContext transitionWasCancelled]) {
                             [transitionContext completeTransition:NO];
                         }else {
                             toVC.view.hidden = NO;
                             [tempView removeFromSuperview];
                             [transitionContext completeTransition:YES];
                         }
                     }];
}

@end






