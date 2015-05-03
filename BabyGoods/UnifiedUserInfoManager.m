//
//  UnifiedUserInfoManager.m
//  BabyGoods
//
//  Created by Andrew Shen on 15/4/25.
//  Copyright (c) 2015年 Andrew Shen. All rights reserved.
//

#import "UnifiedUserInfoManager.h"

#define Dict_loginName @"loginName"
@implementation UnifiedUserInfoManager
+ (UnifiedUserInfoManager *)share
{
    static UnifiedUserInfoManager *shareInfoManager = nil;
    static dispatch_once_t singleInfoMgr;
    dispatch_once(&singleInfoMgr, ^{
        shareInfoManager = [[self alloc] init];
    });
    return shareInfoManager;
}

- (instancetype)init
{
    if (self = [super init])
    {
        _defaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}
- (void)saveUserLoginName:(NSString *)LoginName
{
    [_defaults setObject:LoginName forKey:Dict_loginName];
    [_defaults synchronize];
}

- (NSString *)getUserLoginName
{
    NSString *strLoginName;
    [_defaults objectForKey:Dict_loginName];
    return strLoginName;
}

- (void)releaseAllDefaults
{
    [_defaults removeObjectForKey:Dict_loginName];
}
@end
