//
//  contactModel.h
//  BabyGoods
//
//  Created by Andrew Shen on 15/5/9.
//  Copyright (c) 2015年 Andrew Shen. All rights reserved.
//  联系人model

#import <Foundation/Foundation.h>

#define contact_name @"contactName"
#define contact_mobile @"contactMobile"
#define contact_userLoginName @"userLoginName" // 自己的login
@interface contactModel : NSObject
@property (nonatomic,strong) NSString *contactName;    // 联系人名
@property (nonatomic,strong) NSString *contactMobile;    // 联系人电话
@property (nonatomic,strong) NSString *contactUserLoginName;    // 自身Login

@end
