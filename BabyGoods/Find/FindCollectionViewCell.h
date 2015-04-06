//
//  FindCollectionViewCell.h
//  BabyGoods
//
//  Created by Andrew Shen on 15/4/4.
//  Copyright (c) 2015年 Andrew Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *lbName;

@property (strong, nonatomic) IBOutlet UILabel *lbAge;
@end
