//
//  MHLNetworkHelper.h
//  ManhattanLockDemo
//
//  Created by Samuel on 2019/1/7.
//  Copyright © 2019年 Populstay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHLKeyModel.h"



@interface MHLNetworkHelper : NSObject


/**
 获取accessToken
 
 @param appKey
 @param appSecrect
 @param handler 返回回调
 */
+ (void)requestExperUserKeyWithAppKey:(NSString *)appKey appSecrect:(NSString *)appSecret
                                  Handler:(void (^)(int code,NSString * data, NSError *error))handler;


@end


