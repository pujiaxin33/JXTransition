//
//  JXMagicMoveController.m
//  JXNavigationTransition
//
//  Created by jiaxin on 15/12/7.
//  Copyright © 2015年 jiaxin. All rights reserved.
//

#import "JXMagicMoveController.h"
#import "JXMagicMoveCell.h"
#import "JXMagicMovePushedController.h"

@implementation JXMagicMoveController

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(150, 180);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    self = [super initWithCollectionViewLayout:layout];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.title = @"神奇移动";
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"JXMagicMoveCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 33;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentIndexPath = indexPath;
    JXMagicMovePushedController *pushedVC = [[JXMagicMovePushedController alloc] init];
    //在这里签订协议，在push的时候就可以生效了
    self.navigationController.delegate = pushedVC;
    [self.navigationController pushViewController:pushedVC animated:YES];
}

@end
