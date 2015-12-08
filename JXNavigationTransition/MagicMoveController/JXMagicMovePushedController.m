//
//  JXMagicMovePushedController.m
//  JXNavigationTransition
//
//  Created by jiaxin on 15/12/7.
//  Copyright © 2015年 jiaxin. All rights reserved.
//

#import "JXMagicMovePushedController.h"
#import "JXMagicMoveTransition.h"
#import "JXInteractiveTransition.h"

@interface JXMagicMovePushedController ()

@property (nonatomic, strong) JXInteractiveTransition *interactiveTransitionPop;

@end

@implementation JXMagicMovePushedController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zrx4.jpg"]];
    self.headerImageView = imageView;
    [self.view addSubview:imageView];
    imageView.center = CGPointMake(self.view.center.x, self.view.center.y - self.view.height / 2 + 210);
    imageView.bounds = CGRectMake(0, 0, 280, 280);
    UITextView *textView = [UITextView new];
    textView.text = @"这是类似于KeyNote的神奇移动效果，向右滑动可以通过手势控制POP动画";
    textView.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero).priorityLow();
        make.top.mas_equalTo(imageView.mas_bottom).offset(20);
    }];
    
    self.interactiveTransitionPop = [JXInteractiveTransition interactiveTransitionWithTransitionType:JXInteractiveTransitionTypePop gestureDirection:JXInteractiveTransitionGestureDirectionRight];
    [self.interactiveTransitionPop addGestureForViewController:self];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return [JXMagicMoveTransition transitionWithTransitionType:operation == UINavigationControllerOperationPush ? JXMagicMoveTransitionTypePush : JXMagicMoveTransitionTypePop];
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.interactiveTransitionPop.isInteraction ? self.interactiveTransitionPop : nil;
}


@end
