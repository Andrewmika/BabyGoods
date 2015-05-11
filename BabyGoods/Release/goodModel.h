//
//  goodModel.h
//  BabyGoods
//
//  Created by Andrew Shen on 15/5/3.
//  Copyright (c) 2015年 Andrew Shen. All rights reserved.
//  物品model

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVGeoPoint.h>

#define good_name  @"goodName"
#define good_ages  @"goodAges"
#define good_image @"goodImage"
#define good_imagePath @"goodImagePath"
#define good_userName @"goodUserName"
#define good_geoPoint @"geoPoint" // 经纬度

@interface goodModel : NSObject

@property (nonatomic,strong) NSString *goodName;    // 物品名称
@property (nonatomic,strong) NSString *goodAges;    // 年龄段
@property (nonatomic,strong) NSString *goodUserName;    // 用户名字
@property (nonatomic,strong) UIImage *image;    // 图片
@property (nonatomic,strong) NSString *imagePath;    // 图片路径
@property (nonatomic,strong) AVGeoPoint *geoPoint;    // 经纬度
@end
