//
//  NSString+PPLTime.h
//  ManhattanLockDemo
//
//  Created by Samuel on 2019/6/18.
//  Copyright © 2019 Populstay. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (PPLTime)

+ (NSString *)PPL_currentAllDateWithFormatter:(NSDateFormatter *)fm;


+ (NSString *)PPL_currentNextHourWithFormatter:(NSDateFormatter *)fm;

+ (NSDate *)PPL_timeForString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
