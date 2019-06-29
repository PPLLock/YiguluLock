//  MHLNetworkHelper.m
//  ManhattanLockDemo
//  Created by Samuel on 2019/1/7.
//  Copyright © 2019年 Populstay. All rights reserved.


#import "MHLNetworkHelper.h"
#import "AFNetworking.h"


@implementation MHLNetworkHelper

+ (void)requestExperUserKeyWithAppKey:(NSString *)appKey appSecrect:(NSString *)appSecret
                              Handler:(void (^)(int code,NSString * data, NSError *error))handler
{
    
    NSString * requestUrl = @"http://mop.yigululock.com/open/v1/auth/access-token/get";
    
    AFHTTPSessionManager* afManager = [AFHTTPSessionManager manager];
    
    afManager.requestSerializer.timeoutInterval = 30;
    
    id param = @{@"appKey":appKey,@"appSecret":appSecret};
    
    [afManager POST:requestUrl parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        int  code = [[responseObject objectForKey:@"code"] intValue];
        
        NSDictionary * dic  = [responseObject objectForKey:@"data"];
        
        NSString * str = dic[@"accessToken"];
        
        if (handler){
            
            handler(code,str,nil);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (handler) {
            
            handler(-1,nil,error);
        }
    }];
}

@end
