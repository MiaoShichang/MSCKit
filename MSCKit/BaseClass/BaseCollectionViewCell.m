//
//  BaseCollectionViewCell.m
//  MSCKitDemo
//
//  Created by miaoshichang on 2018/1/11.
//  Copyright © 2018年 MiaoShichang. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setupViewsOnView:self.contentView];
    }
    
    return self;
}

- (void)setupViewsOnView:(UIView *)contentView
{
    
}

// 辅助
+ (NSString *)identifier
{
    return NSStringFromClass([self class]);
}

+ (void)registerToColletionView:(UICollectionView *)colletionView
{
    [colletionView registerClass:[self class] forCellWithReuseIdentifier:[self identifier]];
}

+ (instancetype)cellFromColletionView:(UICollectionView *)colletionView forIndexPath:(NSIndexPath *)indexPath
{
    return [colletionView dequeueReusableCellWithReuseIdentifier:[self identifier] forIndexPath:indexPath];
}

@end
