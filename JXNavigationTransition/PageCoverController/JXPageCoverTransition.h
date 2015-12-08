//
//  JXPageCoverTransition.h
//  JXNavigationTransition
//
//  Created by jiaxin on 15/12/8.
//  Copyright © 2015年 jiaxin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, JXPageCoverTransitionType) {
    JXPageCoverTransitionTypePush = 0,
    JXPageCoverTransitionTypePop
};

@interface JXPageCoverTransition : NSObject <UIViewControllerAnimatedTransitioning>

/**
 *  动画过渡代理管理的是push还是pop
 */
@property (nonatomic, assign) JXPageCoverTransitionType type;
/**
 *  初始化动画过渡代理
 * @prama type 初始化pop还是push的代理
 */
+ (instancetype)transitionWithType:(JXPageCoverTransitionType)type;
- (instancetype)initWithTransitionType:(JXPageCoverTransitionType)type;

@end
