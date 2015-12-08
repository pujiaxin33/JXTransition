//
//  JXTabBarTransition.m
//  JXNavigationTransition
//
//  Created by jiaxin on 15/12/8.
//  Copyright © 2015年 jiaxin. All rights reserved.
//

#import "JXTabBarTransition.h"

@implementation JXTabBarTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.8f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toVC.view];
    
    [UIView transitionFromView:fromVC.view toView:toVC.view duration:[self transitionDuration:transitionContext] options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
