//
//  JXPopPresentedController.m
//  JXNavigationTransition
//
//  Created by jiaxin on 15/12/2.
//  Copyright © 2015年 jiaxin. All rights reserved.
//

#import "JXPopPresentedController.h"
#import "JXPopPresentTransition.h"
#import "JXInteractiveTransition.h"

@interface JXPopPresentedController () <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) JXInteractiveTransition *interactiveDismiss;

@end

@implementation JXPopPresentedController

- (void)dealloc
{
    NSLog(@"销毁了222222222");
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        //重写init方法并在里面签订协议，这样就可以触发协议方法，返回自定义对象
        self.transitioningDelegate = self;
        //modalPresentationStyle设置为UIModalPresentationCustom后，就跟导航控制器转场动画一样，对于fromVC的添加和移除由系统完成
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.layer.cornerRadius = 5.f;
    self.view.layer.masksToBounds = YES;
    self.view.layer.borderWidth = 2.f;
    self.view.layer.borderColor = [UIColor cyanColor].CGColor;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点我或者下滑" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    self.interactiveDismiss = [JXInteractiveTransition interactiveTransitionWithTransitionType:JXInteractiveTransitionTypeDismiss gestureDirection:JXInteractiveTransitionGestureDirectionDown];
    [self.interactiveDismiss addGestureForViewController:self];
}

- (void)dismiss
{
    if (_delegate && [_delegate respondsToSelector:@selector(presentedOneControllerPressedDissmiss)]) {
        [_delegate presentedOneControllerPressedDissmiss];
    }
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [JXPopPresentTransition transitionWithTransitionType:JXPopPresentTransitionTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [JXPopPresentTransition transitionWithTransitionType:JXPopPresentTransitionTypeDismiss];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return _interactiveDismiss.isInteraction ? _interactiveDismiss : nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator
{
    JXInteractiveTransition *interactivePresent = [self.delegate interactiveTransitionForPresent];
    return interactivePresent.isInteraction ? interactivePresent : nil;
}

@end
