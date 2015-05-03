//
//  UnifiedUserInfoManager.h
//  BabyGoods
//
//  Created by Andrew Shen on 15/4/25.
//  Copyright (c) 2015年 Andrew Shen. All rights reserved.
//  用户信息存储单例

#import <Foundation/Foundation.h>

@interface UnifiedUserInfoManager : NSObject
{
    NSUserDefaults *_defaults;
}
+ (UnifiedUserInfoManager *)share;

- (void)saveUserLoginName:(NSString *)LoginName;

- (NSString *)getUserLoginName;

- (void)releaseAllDefaults;
@end
