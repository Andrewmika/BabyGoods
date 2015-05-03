//
//  NSDictionary+safeManager.h
//  BabyGoods
//
//  Created by Andrew Shen on 15/5/3.
//  Copyright (c) 2015年 Andrew Shen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (safeManager)

- (id)safeWithkey:(NSString *)key;
@end
