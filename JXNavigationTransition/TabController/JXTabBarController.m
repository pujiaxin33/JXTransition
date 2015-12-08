//
//  JXTabBarController.m
//  JXNavigationTransition
//
//  Created by jiaxin on 15/12/8.
//  Copyright © 2015年 jiaxin. All rights reserved.
//

#import "JXTabBarController.h"
#import "JXTabBarTransition.h"

@interface JXTabBarController () <UITabBarControllerDelegate>

@end

@implementation JXTabBarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIViewController *first = [UIViewController new];
        first.view.backgroundColor = [UIColor redColor];
        first.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"红色" image:nil selectedImage:nil];
        UIViewController *second = [UIViewController new];
        second.view.backgroundColor = [UIColor greenColor];
        second.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"绿色" image:nil selectedImage:nil];
        UIViewController *three = [UIViewController new];
        three.view.backgroundColor = [UIColor blueColor];
        three.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"蓝色" image:nil selectedImage:nil];
        self.viewControllers = @[first, second, three];
        self.delegate = self;
    }
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return [JXTabBarTransition new];
}

@end
