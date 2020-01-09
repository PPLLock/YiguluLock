//
//  MHLDemoViewController.m
//  ManhattanLockDemo
//
//  Created by Samuel on 2019/1/12.
//  Copyright © 2019年 Populstay. All rights reserved.

#import "MHLDemoViewController.h"
#import "MHLKeyboardPasswordController.h"
#import <SVProgressHUD/SVProgressHUD.h>

#define TokenKey @"token"

@interface MHLDemoViewController ()
@end

@implementation MHLDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.title = _model.name;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Password" style:UIBarButtonItemStyleDone target:self action:@selector(keyboardPwdAction)];

}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    PPLObjectPPLLockHelper.delegate = PPLLockHelperClass;
    
    [PPLObjectPPLLockHelper startScan];
    
    
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
//    PPLObjectPPLLockHelper.delegate = nil;
//
//    [PPLObjectPPLLockHelper stopScan];
    
}


- (IBAction)unlock:(UIButton *)sender {
    
    if (!_model) {
        
        [self showToast:@"Lock data is empty"];
        
        return;
    }
    
    [SVProgressHUD show];
    
    [MHLLockHelper connectKey:_model connectBlock:^(BOOL succeed, id info) {
        
        [SVProgressHUD dismiss];
        
        if (succeed) {
            
            [MHLLockHelper unlock:self->_model unlockBlock:^(BOOL succeed, id info) {
                
                [self showOperationSuccessToast];
                
            }];
            
        }
        
        
    } ];
}
- (IBAction)lock:(UIButton *)sender {
  
    if (!_model) {
        
        [self showToast:@"Lock data is empty"];
        
        return;
    }
    
    [SVProgressHUD show];
    
    [MHLLockHelper connectKey:_model connectBlock:^(BOOL succeed, id info) {
        
        [SVProgressHUD dismiss];
        
        if (succeed) {
            
            [MHLLockHelper lock:self->_model lockBlock:^(BOOL succeed, id info) {
               
                if (succeed) {
                   
                    [self showOperationSuccessToast];
                    
                }
                
            }];
            
        }
        
        
    } ];
    
}
- (IBAction)readRecord:(UIButton *)sender {
    
    if (!_model) {
        
        [self showToast:@"Lock data is empty"];
        
        return;
    }
    
    [SVProgressHUD show];
    
    [MHLLockHelper connectKey:_model connectBlock:^(BOOL succeed, id info) {
        
        [SVProgressHUD dismiss];
        
        if (succeed) {
            
            [MHLLockHelper pullUnlockRecord:self->_model complition:^(BOOL succeed, id info) {
               
                if (succeed) {
                    
                    [self showOperationSuccessToast];
                }
                
            }];
            
        }
        
        
    } ];
    
}
- (IBAction)readLockTime:(UIButton *)sender {
    
    if (!_model) {
        
        [self showToast:@"Lock data is empty"];
        
        return;
    }
    
    [SVProgressHUD show];
    
    [MHLLockHelper connectKey:_model connectBlock:^(BOOL succeed, id info) {
        
        [SVProgressHUD dismiss];
        
        if (succeed) {
            
            [MHLLockHelper GetLockTimeComplition:^(BOOL succeed, id info) {
            
                if (succeed) {

                    [self showOperationSuccessToast];
                    
                    NSLog(@"info = %@",info);
 
                }
                
                
            }];
            
        }
        
        
    } ];
}
- (IBAction)setLockTime:(UIButton *)sender {
    
    if (!_model) {
        
        [self showToast:@"Lock data is empty"];
        
        return;
    }
    
    weakify(self)
    
    [SVProgressHUD show];
    
    [MHLLockHelper connectKey:_model connectBlock:^(BOOL succeed, id info) {
        
        [SVProgressHUD dismiss];
        
        strongify(self)
        
        if (succeed) {
            
            [MHLLockHelper setLockTime:self->_model complition:^(BOOL succeed, id info) {
                
                if (succeed) {
                    
                       [self showOperationSuccessToast];
                }
                
                
            }];
            
        }
        
        
    } ];
    
}
- (IBAction)setAutolocking:(UIButton *)sender {
    
    if (!_model) {
        
        [self showToast:@"Lock data is empty"];
        
        return;
    }
    
    [SVProgressHUD show];
    
    [MHLLockHelper connectKey:_model connectBlock:^(BOOL succeed, id info) {
        
        [SVProgressHUD dismiss];
        
        if (succeed) {
            
            [MHLLockHelper setAutoLockingTime:5 key:self->_model complition:^(BOOL succeed, id info) {
                
                if (succeed) {
                    
                     [self showOperationSuccessToast];
                }
                
                
            }];
            
        }
        
        
    } ];
    
}
- (IBAction)openAndCloseAutoLock:(UISwitch *)sender {
    
    int time;
    
    if (sender.isOn) {
        
        time = 5;
        
    }else {
        
        time = 0;
    }
    
    if (!_model) {
        
        [self showToast:@"Lock data is empty"];
        
        return;
    }
    
    [SVProgressHUD show];
    
    [MHLLockHelper connectKey:_model connectBlock:^(BOOL succeed, id info) {
        
        [SVProgressHUD dismiss];
        
        if (succeed) {
            
            [MHLLockHelper setAutoLockingTime:time key:self->_model complition:^(BOOL succeed, id info) {
                
                if (succeed) {
                    
                    [self showOperationSuccessToast];
                }
                
                
            }];
            
        }
        
        
    } ];
    
    
}


- (IBAction)resetLockAction:(UIButton *)sender {
    
    if (!_model) {
        
        [self showToast:@"Lock data is empty"];
        
        return;
    }
    
    weakify(self)

    [SVProgressHUD show];
    
    [MHLLockHelper connectKey:_model connectBlock:^(BOOL succeed, id info) {
        
        [SVProgressHUD dismiss];
        
        strongify(self)
        
        if (succeed) {
            
            [MHLLockHelper resetLock:self->_model complition:^(BOOL succeed, id info) {
                
                if (succeed) {
                    
                    NSString * pred = [NSString stringWithFormat:@"lockId = \"%@\"",_model.lockId];
                    
                    RLMResults * locks = [MHLKeyModel objectsWhere:pred];
                    
                    RLMRealm * realm = [RLMRealm defaultRealm];
                    
                    if (locks.count) {
                        
                        [realm beginWriteTransaction];
                        
                        [realm deleteObject:[locks lastObject]];
                        
                        [realm commitWriteTransaction];
                        
                    }
                    
                    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
                    
                    [defaults removeObjectForKey:TokenKey];
                    
                    [defaults synchronize];
                    
                    [self showOperationSuccessToast];
                    
                    if ([self.delegate respondsToSelector:@selector(resetLockSuccess)]) {
                        
                        [self.delegate resetLockSuccess];
                    }
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }
                
            }];
            
        }
        
    }];
    
}

#pragma mark ---- 时间戳转换为NSDate
- (NSDate *)timestampForDate:(NSTimeInterval)timeInterval
{
    NSTimeInterval time = timeInterval / 1000;//传入的时间戳str如果是精确到毫秒的记得要/1000
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:time];
    
    return date;
}

//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    PPLObjectPPLLockHelper.delegate = nil;
//    //[PPLObjectPPLLockHelper startScan];
//}

- (IBAction)readLockInfoAction:(UIButton *)sender {
    
    if (!_model) {
        
        [self showToast:@"Lock data is empty"];
        
        return;
    }
    
    weakify(self)
    
    [SVProgressHUD show];
    
    [MHLLockHelper connectKey:_model connectBlock:^(BOOL succeed, id info) {
        
        [SVProgressHUD dismiss];
        
        strongify(self)
        
        if (succeed) {
            
            [MHLLockHelper GetDeviceInfoBlock:^(BOOL succeed, id info) {
                
                if (succeed) {
                    
                    NSLog(@"info = %@",info);
                    
                    [self showOperationSuccessToast];
                    
                }
                
            }];
            
        }
        
    }];
}

- (void)keyboardPwdAction
{
    MHLKeyboardPasswordController * keyboardPasswordVC = [[MHLKeyboardPasswordController alloc] init];
    
    keyboardPasswordVC.model = _model;
    
    [self.navigationController pushViewController:keyboardPasswordVC animated:YES];
}

@end
