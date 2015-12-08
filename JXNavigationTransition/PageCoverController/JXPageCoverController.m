//
//  JXPageCoverController.m
//  JXNavigationTransition
//
//  Created by jiaxin on 15/12/8.
//  Copyright © 2015年 jiaxin. All rights reserved.
//

#import "JXPageCoverController.h"
#import "JXPageCoverPushedController.h"

@interface JXPageCoverController () <JXPageCoverPushedControllerDelegate>

@property (nonatomic, strong) JXInteractiveTransition *interactiveTransitionPush;

@end

@implementation JXPageCoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"翻页效果";
    self.view.backgroundColor = [UIColor grayColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic2.jpeg"]];
    [self.view addSubview:imageView];
    imageView.frame = self.view.frame;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点我或向左滑动push" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(74);
    }];
    
    self.interactiveTransitionPush = [JXInteractiveTransition interactiveTransitionWithTransitionType:JXInteractiveTransitionTypePush gestureDirection:JXInteractiveTransitionGestureDirectionLeft];
    WeakSelf(self);
    self.interactiveTransitionPush.pushConfig = ^{
        [weakSelf push];
    };
    [self.interactiveTransitionPush addGestureForViewController:self];
}

- (void)push{
    JXPageCoverPushedController *pushVC = [JXPageCoverPushedController new];
    self.navigationController.delegate = pushVC;
    pushVC.delegate = self;
    [self.navigationController pushViewController:pushVC animated:YES];
}

- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPush
{
    return self.interactiveTransitionPush;
}

@end
