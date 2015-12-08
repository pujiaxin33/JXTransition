//
//  JXMagicMoveTransition.h
//  JXNavigationTransition
//
//  Created by jiaxin on 15/12/7.
//  Copyright © 2015年 jiaxin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, JXMagicMoveTransitionType) {
    JXMagicMoveTransitionTypePush,
    JXMagicMoveTransitionTypePop,
};

@interface JXMagicMoveTransition : NSObject <UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithTransitionType:(JXMagicMoveTransitionType)type;
- (instancetype)initWithTransitionType:(JXMagicMoveTransitionType)type;

@end
