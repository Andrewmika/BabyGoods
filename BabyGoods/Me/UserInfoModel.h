//
//  UserInfoModel.h
//  BabyGoods
//
//  Created by Andrew Shen on 15/5/3.
//  Copyright (c) 2015年 Andrew Shen. All rights reserved.
//

#import <Foundation/Foundation.h>

#define user_name    @"goodUserName"
#define user_mobile  @"userMobile"
#define user_address @"userAddr"
#define user_loginName @"loginName"

@interface UserInfoModel : NSObject
@property (nonatomic,strong) NSString *userName;    // 用户名字
@property (nonatomic,strong) NSString *userMobile;    // 用户电话
@property (nonatomic,strong) NSString *userAddr;    // 用户地址
@property (nonatomic,strong) NSString *loginName;    // 用户登录名

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
