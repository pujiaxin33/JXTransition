//
//  JXPageCoverPushedController.h
//  JXNavigationTransition
//
//  Created by jiaxin on 15/12/8.
//  Copyright © 2015年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JXPageCoverPushedControllerDelegate <NSObject>

- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPush;

@end

@interface JXPageCoverPushedController : UIViewController <UINavigationControllerDelegate>

@property (nonatomic, weak) id<JXPageCoverPushedControllerDelegate> delegate;

@end
