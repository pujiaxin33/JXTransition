//
//  JXCircleSpreadTransition.h
//  JXNavigationTransition
//
//  Created by jiaxin on 15/12/8.
//  Copyright © 2015年 jiaxin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, JXCircleSpreadTransitionType) {
    JXCircleSpreadTransitionTypePresent = 0,
    JXCircleSpreadTransitionTypeDismiss,
};

@interface JXCircleSpreadTransition : NSObject <UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithTransitionType:(JXCircleSpreadTransitionType)type;
- (instancetype)initWithTransitionType:(JXCircleSpreadTransitionType)type;

@end
