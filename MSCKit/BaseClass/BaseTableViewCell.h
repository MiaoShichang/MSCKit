//
//  BaseTableViewCell.h
//  MSCKitDemo
//
//  Created by miaoshichang on 2018/1/11.
//  Copyright © 2018年 MiaoShichang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

@property (nonatomic, weak)UIViewController *parentVC;

/**
 * @brief 重写该方法，方便添加新view，不用重写init方法
 */
- (void)setupViewsOnView:(UIView *)contentView;

//
+ (CGFloat)heightForCell:(id)model;
- (void)fillCell:(id)model;


#pragma mark -- 辅助
+ (void)registerToTableView:(UITableView *)tableView;
+ (id)cellFromTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath;
+ (id)cellFromTableView:(UITableView *)tableView;

@end
