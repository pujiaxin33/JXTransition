//
//  JXInteractiveTransition.h
//  JXNavigationTransition
//
//  Created by jiaxin on 15/12/3.
//  Copyright © 2015年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GestureConfig)();

typedef NS_ENUM(NSUInteger, JXInteractiveTransitionGestureDirection) {
    JXInteractiveTransitionGestureDirectionLeft = 0,
    JXInteractiveTransitionGestureDirectionRight,
    JXInteractiveTransitionGestureDirectionUp,
    JXInteractiveTransitionGestureDirectionDown,
};

typedef NS_ENUM(NSUInteger, JXInteractiveTransitionType) {
    JXInteractiveTransitionTypePresent,
    JXInteractiveTransitionTypeDismiss,
    JXInteractiveTransitionTypePush,
    JXInteractiveTransitionTypePop,
};

@interface JXInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL isInteraction;
@property (nonatomic, copy) GestureConfig presentConfig;
@property (nonatomic, copy) GestureConfig pushConfig;

+ (instancetype)interactiveTransitionWithTransitionType:(JXInteractiveTransitionType)type gestureDirection:(JXInteractiveTransitionGestureDirection)direction;
- (instancetype)initWithTransitionType:(JXInteractiveTransitionType)type gestureDirection:(JXInteractiveTransitionGestureDirection)direction;

- (void)addGestureForViewController:(UIViewController *)viewController;

@end
