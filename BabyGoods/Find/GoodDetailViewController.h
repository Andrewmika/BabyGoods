//
//  GoodDetailViewController.h
//  BabyGoods
//
//  Created by Andrew Shen on 15/5/9.
//  Copyright (c) 2015年 Andrew Shen. All rights reserved.
//  物品详情VC

#import <UIKit/UIKit.h>
#import "goodModel.h"

@interface GoodDetailViewController : UIViewController
@property (nonatomic,strong) goodModel *goodModel;    // 物品model
@end
