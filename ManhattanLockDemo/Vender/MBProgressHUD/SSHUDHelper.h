//
//  HUDHelper.h
// ManhattanLockDemo

//  Created by Samuel on 2019/1/11.
//  Copyright © 2019年 Populstay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface SSHUDHelper : NSObject

+(SSHUDHelper *_Nullable) sharedInstance;

@property (strong, nonatomic, nullable) UIView *containerView;

@property (nonatomic,assign)MBProgressHUDMode mode;


- (void)show:(NSString*_Nullable)status; 

- (void)dismiss;


@end
