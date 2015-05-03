//
//  UserInfoModel.m
//  BabyGoods
//
//  Created by Andrew Shen on 15/5/3.
//  Copyright (c) 2015年 Andrew Shen. All rights reserved.
//

#import "UserInfoModel.h"
#import "NSDictionary+safeManager.h"
#import "UnifiedUserInfoManager.h"

@implementation UserInfoModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        if ([dict safeWithkey:user_name])
        {
            self.userName = [dict safeWithkey:user_name];
        }
        
        if ([dict safeWithkey:user_mobile])
        {
            self.userMobile = [dict safeWithkey:user_mobile];
        }
        
        if ([dict safeWithkey:user_address])
        {
            self.userAddr = [dict safeWithkey:user_address];
        }

        if ([dict safeWithkey:user_loginName])
        {
            self.loginName = [dict safeWithkey:user_loginName];
        }

    }
    return self;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.userName = @"";
        self.userMobile = @"";
        self.userAddr = @"";
        self.loginName = [[UnifiedUserInfoManager share] getUnserPhoneNum];
    }
    return self;
}
@end
