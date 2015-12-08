//
//  JXPopPresentedTransition.h
//  JXNavigationTransition
//
//  Created by jiaxin on 15/12/2.
//  Copyright © 2015年 jiaxin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, JXPopPresentTransitionType) {
    JXPopPresentTransitionTypePresent,
    JXPopPresentTransitionTypeDismiss,
};

@interface JXPopPresentTransition : NSObject <UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithTransitionType:(JXPopPresentTransitionType)type;
- (instancetype)initWithTransitionType:(JXPopPresentTransitionType)type;

@end
