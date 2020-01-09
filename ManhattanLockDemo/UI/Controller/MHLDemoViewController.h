//
//  MHLDemoViewController.h
//  ManhattanLockDemo
//
//  Created by Samuel on 2019/1/12.
//  Copyright © 2019年 Populstay. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MHLDemoDelegate <NSObject>

- (void)resetLockSuccess;

@end

@interface MHLDemoViewController : UIViewController

@property (strong, nonatomic) MHLKeyModel * model;

@property (weak, nonatomic) id <MHLDemoDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
