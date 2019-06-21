//
//  UIViewController+Category.h
//
//  Created by Samuel on 19/8/26.
//  Copyright © 2016年 Populstay. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIViewController (HUD)

- (void)showHUD:(NSString *)status;

- (void)showToast:(NSString *)status;

- (void)showHUDToWindow:(NSString *)status;

- (void)hideHUD;

- (void)showLockNotNearToast;

- (void)showNetWorkErrorToast;

- (void)showOperationFailedToast;

- (void)showOperationSuccessToast;


@end
