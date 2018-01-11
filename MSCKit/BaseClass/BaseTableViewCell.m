//
//  BaseTableViewCell.m
//  MSCKitDemo
//
//  Created by miaoshichang on 2018/1/11.
//  Copyright © 2018年 MiaoShichang. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupViewsOnView:self.contentView];
    }
    return self;
}

- (void)setupViewsOnView:(UIView *)contentView
{
    NSLog(@"【class %@】setupViewsOnView",NSStringFromClass([self class]));
}

- (void)fillCell:(id)model
{
    NSLog(@"%@, -- fillCell", NSStringFromClass([self class]));
}

+ (CGFloat)heightForCell:(id)model
{
    return 44.f;
}

#pragma mark -- 辅助
+ (NSString *)identifier
{
    return [NSString stringWithFormat:@"Base_%@", NSStringFromClass([self class])];
}

+ (void)registerToTableView:(UITableView *)tableView
{
    [tableView registerClass:[self class] forCellReuseIdentifier:[self identifier]];
}

+ (id)cellFromTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath
{
    return [tableView dequeueReusableCellWithIdentifier:[self identifier] forIndexPath:indexPath];
}

+ (id)cellFromTableView:(UITableView *)tableView
{
    return [tableView dequeueReusableCellWithIdentifier:[self identifier]];
}

@end
