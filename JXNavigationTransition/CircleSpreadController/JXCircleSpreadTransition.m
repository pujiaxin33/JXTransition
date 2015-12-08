//
//  JXCircleSpreadTransition.m
//  JXNavigationTransition
//
//  Created by jiaxin on 15/12/8.
//  Copyright © 2015年 jiaxin. All rights reserved.
//

#import "JXCircleSpreadTransition.h"
#import "JXCircleSpreadController.h"
#import "JXCircleSpreadPresentedController.h"

@interface JXCircleSpreadTransition ()

@property (nonatomic, assign) JXCircleSpreadTransitionType type;

@end

@implementation JXCircleSpreadTransition

+ (instancetype)transitionWithTransitionType:(JXCircleSpreadTransitionType)type
{
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(JXCircleSpreadTransitionType)type
{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.8f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    switch (self.type) {
        case JXCircleSpreadTransitionTypePresent:
            [self doPresentAnimation:transitionContext];
            break;
        case JXCircleSpreadTransitionTypeDismiss:
            [self doDismissAnimation:transitionContext];
            break;
        default:
            break;
    }
}

- (void)doPresentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UINavigationController *fromNaviVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    JXCircleSpreadController *fromVC = [fromNaviVC.viewControllers lastObject];
    JXCircleSpreadPresentedController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    CGRect finalFrameForToVC = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame =  finalFrameForToVC;
    [containerView addSubview:toVC.view];
    
    //以点击的点画圆
    CGPoint clickedPoint = fromVC.clickedPoint;
    CGRect rect = CGRectMake(clickedPoint.x - 3, clickedPoint.y - 3, 6, 6);
    //因为用户点击的位置随意，所以暴力将展开的圆的半径设置为800
    UIBezierPath *endPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(clickedPoint.x - 800, clickedPoint.y - 800, 1600, 1600) cornerRadius:800];
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:3];
    //把layer的path设置end状态的path，这也是动画结束时候的状态
    layer.path = endPath.CGPath;
    toVC.view.layer.mask = layer;
    
    CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    circleAnimation.fromValue = (__bridge id)(path.CGPath);
    circleAnimation.toValue = (__bridge id)(endPath.CGPath);
    circleAnimation.duration = [self transitionDuration:transitionContext];
    circleAnimation.delegate = self;
    circleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [circleAnimation setValue:transitionContext forKey:@"transitionContext"];
    [layer addAnimation:circleAnimation forKey:@"circle"];
}

- (void)doDismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    JXCircleSpreadPresentedController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGPoint clickedPoint = fromVC.clickedPoint;
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(clickedPoint.x - 800, clickedPoint.y - 800, 1600, 1600) cornerRadius:800];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(clickedPoint.x - 3, clickedPoint.y - 3, 6, 6) cornerRadius:3];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = endPath.CGPath;
    fromVC.view.layer.mask = layer;
    
    CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    circleAnimation.delegate = self;
    circleAnimation.fromValue = (__bridge id)(startPath.CGPath);
    circleAnimation.toValue = (__bridge id)(endPath.CGPath);
    circleAnimation.duration = [self transitionDuration:transitionContext];
    circleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [circleAnimation setValue:transitionContext forKey:@"transitionContext"];
    [layer addAnimation:circleAnimation forKey:@"circleDismiss"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    switch (self.type) {
        case JXCircleSpreadTransitionTypePresent:
        {
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:YES];
            [transitionContext viewControllerForKey:UITransitionContextToViewKey].view.layer.mask = nil;
        }
            break;
        case JXCircleSpreadTransitionTypeDismiss:
        {
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:YES];
        }
            break;
        default:
            break;
    }
    
}

@end
