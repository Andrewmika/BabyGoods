//
//  EditGoodViewController.h
//  BabyGoods
//
//  Created by Andrew Shen on 15/5/9.
//  Copyright (c) 2015年 Andrew Shen. All rights reserved.
//  编辑物品信息

#import <UIKit/UIKit.h>
#import "goodModel.h"
#import <AVOSCloud.h>

@interface EditGoodViewController : UIViewController
@property (nonatomic,strong) goodModel *model;    // 物品model
@property (nonatomic,strong) AVObject *object;    // 物品原始对象
@end
