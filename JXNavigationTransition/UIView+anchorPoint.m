//
//  UIView+anchorPoint.m
//  JXNavigationTransition
//
//  Created by jiaxin on 15/12/8.
//  Copyright © 2015年 jiaxin. All rights reserved.
//

#import "UIView+anchorPoint.h"

@implementation UIView (anchorPoint)

- (void)setAnchorPointTo:(CGPoint)point
{
    self.frame = CGRectOffset(self.frame, (point.x - self.layer.anchorPoint.x)*self.frame.size.width, (point.y - self.layer.anchorPoint.y)*self.frame.size.height);
    self.layer.anchorPoint = point;
}

@end
