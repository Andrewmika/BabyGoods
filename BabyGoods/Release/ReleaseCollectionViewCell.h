//
//  ReleaseCollectionViewCell.h
//  BabyGoods
//
//  Created by Andrew Shen on 15/5/9.
//  Copyright (c) 2015年 Andrew Shen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "goodModel.h"

@interface ReleaseCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *goodName;
@property (weak, nonatomic) IBOutlet UILabel *ageRange;
- (void)setGoodData:(goodModel *)model;

@end
