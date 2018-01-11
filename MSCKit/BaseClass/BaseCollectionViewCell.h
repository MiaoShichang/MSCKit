//
//  BaseCollectionViewCell.h
//  MSCKitDemo
//
//  Created by miaoshichang on 2018/1/11.
//  Copyright © 2018年 MiaoShichang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) UIViewController*parentVC;

- (void)setupViewsOnView:(UIView *)contentView;

//辅助
+ (void)registerToColletionView:(UICollectionView *)colletionView;
+ (instancetype)cellFromColletionView:(UICollectionView *)colletionView forIndexPath:(NSIndexPath *)indexPath;

@end
