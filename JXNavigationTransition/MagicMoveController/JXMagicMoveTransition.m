//
//  JXMagicMoveTransition.m
//  JXNavigationTransition
//
//  Created by jiaxin on 15/12/7.
//  Copyright © 2015年 jiaxin. All rights reserved.
//

#import "JXMagicMoveTransition.h"
#import "JXMagicMoveController.h"
#import "JXMagicMovePushedController.h"
#import "JXMagicMoveCell.h"

@interface JXMagicMoveTransition ()

@property (nonatomic, assign) JXMagicMoveTransitionType type;

@end

@implementation JXMagicMoveTransition

+ (instancetype)transitionWithTransitionType:(JXMagicMoveTransitionType)type
{
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(JXMagicMoveTransitionType)type
{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    switch (self.type) {
        case JXMagicMoveTransitionTypePush:
            [self doPushAnimation:transitionContext];
            break;
        case JXMagicMoveTransitionTypePop:
            [self doPopAnimation:transitionContext];
            break;
        default:
            break;
    }
}

- (void)doPushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    JXMagicMoveController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    JXMagicMovePushedController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    JXMagicMoveCell *cell = (JXMagicMoveCell *)[fromVC.collectionView cellForItemAtIndexPath:fromVC.currentIndexPath];
    //这里的imageView相当于一个临时的替身演员用于过渡
    UIImageView *imageView = [[UIImageView alloc] initWithImage:cell.headerImageView.image];
    imageView.frame = [cell.headerImageView convertRect:cell.headerImageView.bounds toView:containerView];
    //下路addsubview的顺序不能颠倒，不然替身演员就看不到了
    [containerView addSubview:toVC.view];
    [containerView addSubview:imageView];
    //动画前清理现场和状态调整
    cell.headerImageView.hidden = YES;
    toVC.view.alpha = 0;
    toVC.headerImageView.hidden = YES;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        imageView.frame = [toVC.headerImageView convertRect:toVC.headerImageView.bounds toView:containerView];
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        toVC.headerImageView.hidden = NO;
        imageView.hidden = YES;
    }];
}

- (void)doPopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    JXMagicMovePushedController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    JXMagicMoveController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //containerView会自动把当前环境的fromVC.view添加到index为0的位置，所以push或者pop的时候要把toVC.view添加到合适的层级
    UIView *containerView = [transitionContext containerView];
    
    JXMagicMoveCell *cell = (JXMagicMoveCell *)[toVC.collectionView cellForItemAtIndexPath:toVC.currentIndexPath];
    
    UIImageView *imageView = [containerView.subviews lastObject];
    fromVC.headerImageView.hidden = YES;
    cell.headerImageView.hidden = YES;
    imageView.hidden = NO;
    //toVC一定要添加到最底层，否则会遮盖imageView，而且在手势交互失败的时候，containerView会自动移除它
    [containerView insertSubview:toVC.view atIndex:0];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.alpha = 0;
        imageView.frame = [cell.headerImageView convertRect:cell.headerImageView.bounds toView:containerView];
    }completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
            imageView.hidden = YES;
            fromVC.headerImageView.hidden = NO;
        }else {
            [transitionContext completeTransition:YES];
            cell.headerImageView.hidden = NO;
            [imageView removeFromSuperview];
        }
    }];
}
@end
