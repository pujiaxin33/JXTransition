//
//  JXPageCoverPushedController.m
//  JXNavigationTransition
//
//  Created by jiaxin on 15/12/8.
//  Copyright © 2015年 jiaxin. All rights reserved.
//

#import "JXPageCoverPushedController.h"
#import "JXPageCoverTransition.h"

@interface JXPageCoverPushedController ()

@property (nonatomic, assign) UINavigationControllerOperation operation;
@property (nonatomic, strong) JXInteractiveTransition *interactiveTransitionPop;

@end

@implementation JXPageCoverPushedController

- (void)dealloc{
    NSLog(@"销毁了");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"翻页效果";
    self.view.backgroundColor = [UIColor grayColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic1.jpg"]];
    [self.view addSubview:imageView];
    imageView.frame = self.view.frame;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点我或向右滑动pop" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(74);
    }];
    
    self.interactiveTransitionPop = [JXInteractiveTransition interactiveTransitionWithTransitionType:JXInteractiveTransitionTypePop gestureDirection:JXInteractiveTransitionGestureDirectionRight];
    [self.interactiveTransitionPop addGestureForViewController:self];
}

- (void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    self.operation = operation;
    return [JXPageCoverTransition transitionWithType:operation == UINavigationControllerOperationPush ? JXPageCoverTransitionTypePush : JXPageCoverTransitionTypePop];
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    if (self.operation == UINavigationControllerOperationPush) {
        JXInteractiveTransition *push = [self.delegate interactiveTransitionForPush];
        return push.isInteraction ? push : nil;
    }else {
        return self.interactiveTransitionPop.isInteraction ? self.interactiveTransitionPop : nil;
    }
    
}


@end
