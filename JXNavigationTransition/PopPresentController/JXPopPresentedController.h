//
//  JXPopPresentedController.h
//  JXNavigationTransition
//
//  Created by jiaxin on 15/12/2.
//  Copyright © 2015年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JXPopPresentedControllerDelegate <NSObject>

- (void)presentedOneControllerPressedDissmiss;//让presentingViewController来dismiss自己
- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPresent;//返回一个可交互的present对象

@end

@interface JXPopPresentedController : UIViewController <UIViewControllerTransitioningDelegate>

@property (nonatomic, assign) id<JXPopPresentedControllerDelegate> delegate;

@end
