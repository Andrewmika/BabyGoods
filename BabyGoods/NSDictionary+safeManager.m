//
//  NSDictionary+safeManager.m
//  BabyGoods
//
//  Created by Andrew Shen on 15/5/3.
//  Copyright (c) 2015年 Andrew Shen. All rights reserved.
//

#import "NSDictionary+safeManager.h"

@implementation NSDictionary (safeManager)
- (id)safeWithkey:(NSString *)key
{
    if ([[self objectForKey:key] isKindOfClass:[NSNull class]])
    {
        return nil;
    }
    else
    {
        return [self objectForKey:key];
    }
}
@end
