//
//  SSToastHelper.h
// ManhattanLockDemo

//  Created by Samuel on 2019/1/11.
//  Copyright © 2019年 Populstay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

void async_main(dispatch_block_t block);
void async_global(dispatch_block_t block);
void sync_global(dispatch_block_t block);
void sync_main(dispatch_block_t block);

@interface SSToastHelper : NSObject

+ (void)showToastWithStatus:(NSString *)status;

+ (void)showToastWithStatus:(NSString *)status containerView:(UIView*)containerView;

+ (void)showHUDToWindow:(NSString *)status;

+ (void)showHUD:(NSString *)status containerView:(UIView*)containerView;

+ (void)hideHUD;


@end
