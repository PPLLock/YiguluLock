//
//  MHLLockHelper.h
//  ManhattanLockDemo
//
//  Created by Samuel on 2019/1/10.
//  Copyright © 2019年 Populstay. All rights reserved.

#import <Foundation/Foundation.h>

#define PPLLockHelperClass [MHLLockHelper shareInstance]

#define PPLObjectPPLLockHelper [[MHLLockHelper shareInstance] PPLObject]

typedef void(^BLEBlock)(BOOL succeed,id info);

@interface MHLLockHelper : NSObject<PPLLockDelegate>

+ (instancetype)shareInstance;

@property (strong, nonatomic) PPLLock * PPLObject;

@property (strong, nonatomic) MHLKeyModel * currentKey;

+ (void)connectKey:(MHLKeyModel *)key connectBlock:(BLEBlock)connectBloc;


+ (void)GetElectricBlock:(BLEBlock)electricBlock;

+ (void)GetDeviceInfoBlock:(BLEBlock)deviceInfoBlock;

+ (void)disconnectBlock:(BLEBlock)disConnectBlock;

+ (void)unlock:(MHLKeyModel *)key unlockBlock:(BLEBlock)unlockBlock;

+ (void)lock:(MHLKeyModel *)key lockBlock:(BLEBlock)lockBlock;
+ (void)setLockTime:(MHLKeyModel*)key complition:(BLEBlock)complition;
+ (void)pullUnlockRecord:(MHLKeyModel *)key complition:(BLEBlock)complition;
+ (void)resetKeyboardPassword:(MHLKeyModel *)key complition:(BLEBlock)complition;
+ (void)resetLock:(MHLKeyModel *)key  complition:(BLEBlock)complition;
+ (void)customKeyboardPwd:(NSString *)newKeyboardPwd
                startDate:(NSDate*)startDate
                  endDate:(NSDate*)endDate
                      key:(MHLKeyModel *)key
               complition:(BLEBlock)complition;

+ (void)deleteKeyboardPwd:(NSString *)keyboadPs
           keyboardPsType:(KeyboardPsType)type
                      key:(MHLKeyModel *)key
               complition:(BLEBlock)complition;

+ (void)GetLockTimeComplition:(BLEBlock)complition;


+ (void)setAutoLockingTime:(int)time key:(MHLKeyModel *)key complition:(BLEBlock)complition;


@end

