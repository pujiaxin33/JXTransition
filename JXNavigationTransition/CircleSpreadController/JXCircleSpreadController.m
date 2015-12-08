//
//  JXCircleSpreadController.m
//  JXNavigationTransition
//
//  Created by jiaxin on 15/12/8.
//  Copyright © 2015年 jiaxin. All rights reserved.
//

#import "JXCircleSpreadController.h"
#import "JXCircleSpreadPresentedController.h"

@implementation JXCircleSpreadController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic1.jpg"]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    self.clickedPoint = [touch locationInView:touch.view];
    JXCircleSpreadPresentedController *presentedVC = [JXCircleSpreadPresentedController new];
    [self presentViewController:presentedVC animated:YES completion:nil];
}

@end
