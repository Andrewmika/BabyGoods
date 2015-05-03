//
//  FindCollectionViewCell.m
//  BabyGoods
//
//  Created by Andrew Shen on 15/4/4.
//  Copyright (c) 2015年 Andrew Shen. All rights reserved.
//

#import "FindCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@implementation FindCollectionViewCell

- (void)setGoodData:(goodModel *)model
{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.imagePath] placeholderImage:[UIImage imageNamed:@"imageViewBG"]];
    [self.lbName setText:model.goodName];
    [self.lbAge setText:model.goodAges];
}
@end
