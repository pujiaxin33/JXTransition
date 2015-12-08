//
//  JXPopPresentController.m
//  JXNavigationTransition
//
//  Created by jiaxin on 15/12/2.
//  Copyright © 2015年 jiaxin. All rights reserved.
//

#import "JXPopPresentController.h"
#import "JXPopPresentedController.h"
#import "JXInteractiveTransition.h"

@interface JXPopPresentController () <JXPopPresentedControllerDelegate>

@property (nonatomic, strong) JXInteractiveTransition *interactivePresent;

@end

@implementation JXPopPresentController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"pop present";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zrx3.jpg"]];
    imageView.layer.cornerRadius = 10;
    imageView.layer.masksToBounds = YES;
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(70);
        make.centerX.equalTo(self.view);
        make.width.and.height.equalTo(@(250));
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点我或者右滑present" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageView);
        make.top.equalTo(imageView.mas_bottom).offset(10);
    }];
    
    self.interactivePresent = [JXInteractiveTransition interactiveTransitionWithTransitionType:JXInteractiveTransitionTypePresent gestureDirection:JXInteractiveTransitionGestureDirectionUp];
    __weak typeof(self) weakSelf = self;
    self.interactivePresent.presentConfig = ^{
        //present的过程，就是一个复杂的动画，通过block告诉interactivetransition,这个动画过程是怎么样的，然后系统会自动将它根据百分比去刷新界面
        [weakSelf present];
    };
    //将可交互的手势加在一个视图控制器上面，然后由这个手势触发
    [self.interactivePresent addGestureForViewController:self];
}

- (void)present
{
    JXPopPresentedController *presentedVC = [JXPopPresentedController new];
    presentedVC.delegate = self;
    [self presentViewController:presentedVC animated:YES completion:nil];
}

- (void)presentedOneControllerPressedDissmiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPresent
{
    return _interactivePresent;
}

@end
