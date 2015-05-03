//
//  UnifiedUserInfoManager.m
//  BabyGoods
//
//  Created by Andrew Shen on 15/4/25.
//  Copyright (c) 2015年 Andrew Shen. All rights reserved.
//

#import "UnifiedUserInfoManager.h"

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
- (void)saveUserPhoneNum:(NSString *)phoneNumber
{
    [_defaults setObject:phoneNumber forKey:@"PhoneNum"];
    [_defaults synchronize];
}

- (NSString *)getUnserPhoneNum
{
    NSString *strPhoneNum;
    
    return strPhoneNum;
}
@end
