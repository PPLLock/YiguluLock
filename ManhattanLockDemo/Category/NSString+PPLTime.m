//
//  NSString+PPLTime.m
//  ManhattanLockDemo
//
//  Created by Samuel on 2019/6/18.
//  Copyright © 2019 Populstay. All rights reserved.
//

#import "NSString+PPLTime.h"

@implementation NSString (PPLTime)

+ (NSString *)PPL_currentAllDateWithFormatter:(NSDateFormatter *)fm
{
    
    NSDate * date = [NSDate date];

    NSString * dateStr = [fm stringFromDate:date];
    
    return dateStr;
    
}

+ (NSString *)PPL_currentNextHourWithFormatter:(NSDateFormatter *)fm
{
    
    NSDate * date = [NSDate date];

    
    NSInteger currentinterval = 60*60;
    
    NSDate * currentDate = [date dateByAddingTimeInterval:currentinterval];
    
    NSString * dateStr = [fm stringFromDate:currentDate];
    
    return dateStr;
    
}

+ (NSDate *)PPL_timeForString:(NSString *)string
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate * date = [formatter dateFromString:string];
    
    return date;
}

@end
