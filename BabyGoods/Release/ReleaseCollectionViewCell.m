//
//  ReleaseCollectionViewCell.m
//  BabyGoods
//
//  Created by Andrew Shen on 15/5/9.
//  Copyright (c) 2015年 Andrew Shen. All rights reserved.
//

#import "ReleaseCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@implementation ReleaseCollectionViewCell
- (void)setGoodData:(goodModel *)model
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.imagePath] placeholderImage:[UIImage imageNamed:@"imageViewBG"]];
    [self.goodName setText:model.goodName];
    [self.ageRange setText:model.goodAges];
}

@end
