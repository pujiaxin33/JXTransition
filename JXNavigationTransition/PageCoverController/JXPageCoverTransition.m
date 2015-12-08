//
//  JXPageCoverTransition.m
//  JXNavigationTransition
//
//  Created by jiaxin on 15/12/8.
//  Copyright © 2015年 jiaxin. All rights reserved.
//

#import "JXPageCoverTransition.h"

@implementation JXPageCoverTransition

+ (instancetype)transitionWithType:(JXPageCoverTransitionType)type
{
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(JXPageCoverTransitionType)type
{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    switch (self.type) {
        case JXPageCoverTransitionTypePush:
            [self doPushAnimation:transitionContext];
            break;
        case JXPageCoverTransitionTypePop:
            [self doPopAnimation:transitionContext];
            break;
        default:
            break;
    }
}

- (void)doPushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = fromVC.view.frame;
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    fromVC.view.hidden = YES;
    [containerView insertSubview:toVC.view atIndex:0];
    
    [tempView setAnchorPointTo:CGPointMake(0, 0.5)];
    
    CATransform3D transform3d = CATransform3DIdentity;
    transform3d.m34 = -0.002;
    containerView.layer.sublayerTransform = transform3d;
    
    //增加阴影
    CAGradientLayer *fromGradient = [CAGradientLayer layer];
    fromGradient.frame = fromVC.view.bounds;
    fromGradient.colors = @[(id)[UIColor blackColor].CGColor,
                            (id)[UIColor blackColor].CGColor];
    fromGradient.startPoint = CGPointMake(0.0, 0.5);
    fromGradient.endPoint = CGPointMake(0.8, 0.5);
    UIView *fromShadow = [[UIView alloc]initWithFrame:fromVC.view.bounds];
    fromShadow.backgroundColor = [UIColor clearColor];
    [fromShadow.layer insertSublayer:fromGradient atIndex:1];
    fromShadow.alpha = 0.0;
    [tempView addSubview:fromShadow];
    
    CAGradientLayer *toGradient = [CAGradientLayer layer];
    toGradient.frame = fromVC.view.bounds;
    toGradient.colors = @[(id)[UIColor blackColor].CGColor,
                          (id)[UIColor blackColor].CGColor];
    toGradient.startPoint = CGPointMake(0.0, 0.5);
    toGradient.endPoint = CGPointMake(0.8, 0.5);
    UIView *toShadow = [[UIView alloc]initWithFrame:fromVC.view.bounds];
    toShadow.backgroundColor = [UIColor clearColor];
    [toShadow.layer insertSublayer:toGradient atIndex:1];
    toShadow.alpha = 1.0;
    [toVC.view addSubview:toShadow];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
        animations:^{
            tempView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
            fromShadow.alpha = 1;
            toShadow.alpha = 0;
        }
        completion:^(BOOL finished) {
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext completeTransition:NO];
                [tempView removeFromSuperview];
                fromVC.view.hidden = NO;
            }else {
                [transitionContext completeTransition:YES];
            }
    }];
}

- (void)doPopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIView *tempView = containerView.subviews.lastObject;
    [containerView addSubview:toVC.view];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        tempView.layer.transform = CATransform3DIdentity;
        fromVC.view.subviews.lastObject.alpha = 1;
        tempView.subviews.lastObject.alpha = 0;
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else {
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;
            [tempView removeFromSuperview];
        }
    }];
}

@end
