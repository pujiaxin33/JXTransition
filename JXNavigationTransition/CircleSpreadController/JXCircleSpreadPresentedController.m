//
//  JXCircleSpreadPresentedController.m
//  JXNavigationTransition
//
//  Created by jiaxin on 15/12/8.
//  Copyright © 2015年 jiaxin. All rights reserved.
//

#import "JXCircleSpreadPresentedController.h"
#import "JXCircleSpreadTransition.h"

@interface JXCircleSpreadPresentedController () <UIViewControllerTransitioningDelegate>

@end

@implementation JXCircleSpreadPresentedController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic2.jpeg"]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.clickedPoint = [[touches anyObject] locationInView:[touches anyObject].view];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [JXCircleSpreadTransition transitionWithTransitionType:JXCircleSpreadTransitionTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [JXCircleSpreadTransition transitionWithTransitionType:JXCircleSpreadTransitionTypeDismiss];
}

@end
