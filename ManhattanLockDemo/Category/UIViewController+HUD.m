//
//  UIViewController+Category.m
//
//  Created by Samuel on 19/8/26.
//  Copyright © 2016年 Populstay. All rights reserved.
//

#import "UIViewController+HUD.h"

#define PLLWindow [UIApplication sharedApplication].keyWindow

@implementation UIViewController (HUD)

- (void)showHUD:(NSString *)status{
    [SSToastHelper showHUD:status containerView:self.view];
}
- (void)showToast:(NSString *)status{
    
    [SSToastHelper showToastWithStatus:status containerView:self.view];
    
}
- (void)showHUDToWindow:(NSString *)status{
 
    [SSToastHelper showHUD:status containerView:PLLWindow];
}
- (void)hideHUD{
    [SSToastHelper hideHUD];
}
- (void)showLockNotNearToast{
       [self showToast:LS(@"Please confirm that the lock is nearby")];
}

- (void)showOperationFailedToast{
    [self showToast:LS(@"Operation failed,please try again")];
}

- (void)showOperationSuccessToast{
    [self showToast:LS(@"Operation successfully")];
}


- (void)showNetWorkErrorToast{
    [self showToast:LS(@"Network connection failed, please confirm to open WiFi or cellular network")];
}

- (void)showLockOperateFailed{
    [self showToast:LS(@"alter_Failed")];
}


@end
