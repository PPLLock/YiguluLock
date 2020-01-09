//
//  MHLKeyModel.m
//  ManhattanLockDemo
//
//  Created by Samuel on 2019/1/7.
//  Copyright © 2019年 Populstay. All rights reserved.
//

#import "MHLKeyModel.h"

@implementation MHLKeyModel

+ (NSString *)primaryKey
{
    return @"uuid";
}

+ (NSDictionary *)defaultPropertyValues
{
    return @{@"uuid": [[NSUUID UUID] UUIDString]};
}


@end
