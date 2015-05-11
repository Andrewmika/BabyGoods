//
//  goodModel.m
//  BabyGoods
//
//  Created by Andrew Shen on 15/5/3.
//  Copyright (c) 2015年 Andrew Shen. All rights reserved.
//

#import "goodModel.h"

@implementation goodModel

- (AVGeoPoint *)geoPoint
{
    if (!_geoPoint)
    {
        _geoPoint = [AVGeoPoint geoPoint];
    }
    return _geoPoint;
}
@end
