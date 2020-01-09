//
//  MHLLockHelper.m
//  ManhattanLockDemo
//
//  Created by Samuel on 2019/1/10.
//  Copyright © 2019年 Populstay. All rights reserved.
//

#import "MHLLockHelper.h"

NSString * const PPLBLE_CONNECT = @"ble_connect";

NSString * const PPLBLE_DISCONNECT = @"ble_disconnect";

NSString * const PPLBLE_INITLOCKREQ = @"ble_initLockReq";

NSString * const PPLBLE_INITLOCK = @"ble_initLock";

NSString * const PPLBLE_ELECTIC = @"ble_electic";

NSString * const PPLBLE_DEVICE = @"ble_device";

NSString * const PPLBLE_UNLOCK = @"ble_unlock";

NSString * const PPLBLE_LOCK = @"ble_lock";

NSString * const PPLBLE_PULLLOCKRECORD = @"ble_pullLockRecord";

NSString * const PPLBLE_SETLOCKTIME = @"ble_setLockTime";

NSString * const PPLBLE_READLOCKTIME = @"ble_readLockTime";

NSString * const PPLBLE_SETAUTOLOCKTIME = @"ble_setAutoLockTime";

NSString * const PPLBLE_ENTERFIRWAREUPGRADE = @"ble_enterFirwareUpgrade";

NSString * const PPLBLE_RETSETLOCK = @"ble_resetLock";

NSString * const PPLBLE_RETSETEKEY = @"ble_resetEkey";

NSString * const PPLBLE_RETSETKEYBOARDPWD = @"ble_resetKeyboardPwd";

NSString * const PPLBLE_DELETEKEYBOARDPWD = @"ble_deleteKeyboardPwd";

NSString * const PPLBLE_CUSTOMKEYBOARDPWD = @"ble_customKeyboardPwd";

NSString * const PPLBLE_MODIFYKEYBOARDPWD = @"ble_modifyKeyboardPwd";

NSString *const PPLBLEErrorCodeKey = @"errorCode";
NSString *const PPLBLECommandKey = @"command";

@interface MHLLockHelper ()

@property (atomic,strong) NSMutableDictionary * bleBlockDict;

@end

@implementation MHLLockHelper

static  MHLLockHelper * instace;

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instace = [[self alloc] initPPLLockHelper];
        
        
    });
    
    return instace;
}

#pragma mark ----- 初始化中心对象  蓝牙交互
- (instancetype)initPPLLockHelper{
    
    self.PPLObject = [[PPLLock alloc] initWithDelegate:self];
    
    [self.PPLObject setupBluetooth];
    
    _bleBlockDict = [NSMutableDictionary dictionary];
    
    return self;
    
}

- (void)PPLCenterManagerDidUpdateState:(PPLManagerState)state
{
    if (state == PPLManagerStatePoweredOn) {
        
        [self.PPLObject startScan];

    }else if (state == PPLManagerStatePoweredOff){
        
        [_PPLObject stopScan];
        
    }else if (state == PPLManagerStateUnsupported){
        
        NSLog(@"Your device does not support ble4.0, unable to use our app.");
    }
}

+ (void)connectKey:(MHLKeyModel *)key connectBlock:(BLEBlock)connectBloc
{
    if (!key) {
        
        connectBloc(NO,nil);
        
        return;
    }
    
    if (key.name.length == 0) {
       
        connectBloc(NO,nil);
        
        return;
        
    }
    
    if (connectBloc) {
        
        [[MHLLockHelper shareInstance].bleBlockDict setObject:connectBloc forKey:PPLBLE_CONNECT];
    }
    
    [PPLObjectPPLLockHelper connectPeripheralWithLockName:key.name];
}

+ (void)GetElectricBlock:(BLEBlock)electricBlock
{
    if (electricBlock) {
        
        [[MHLLockHelper shareInstance].bleBlockDict setObject:electricBlock forKey:PPLBLE_ELECTIC];
    }
    
    [PPLObjectPPLLockHelper getElectricQuantity];
}

+ (void)GetDeviceInfoBlock:(BLEBlock)deviceInfoBlock
{
    if (deviceInfoBlock) {
        
        [[MHLLockHelper shareInstance].bleBlockDict setObject:deviceInfoBlock forKey:PPLBLE_DEVICE];
    }
    
    [PPLObjectPPLLockHelper getDeviceInfo];
    
}

+ (void)setLockTime:(MHLKeyModel*)key complition:(BLEBlock)complition
{
    if (!key) {
        
        complition(NO,nil);
        
        return;
    }
    
    if (complition) {
        
        [[MHLLockHelper shareInstance].bleBlockDict setObject:complition forKey:PPLBLE_SETLOCKTIME];
    }
    
    [PPLObjectPPLLockHelper setLockTime_LockId:key.lockId accessToken:key.accessToken currentTime:[NSDate date]];
}

+ (void)resetLock:(MHLKeyModel *)key  complition:(BLEBlock)complition;
{
    if (!key) {
        
        complition(NO,nil);
        
        return;
    }
    
    if (complition) {
        
        [[MHLLockHelper shareInstance].bleBlockDict setObject:complition forKey:PPLBLE_RETSETLOCK];
    }
    
    [PPLObjectPPLLockHelper resetLock_LockId:key.lockId accessToken:key.accessToken];
    
}

+ (void)resetKeyboardPassword:(MHLKeyModel *)key complition:(BLEBlock)complition
{
    if (!key) {
        
        complition(NO,nil);
        
        return;
    }
    
    if (complition) {
        
        [[MHLLockHelper shareInstance].bleBlockDict setObject:complition forKey:PPLBLE_RETSETKEYBOARDPWD];
        
    }
    
    [PPLObjectPPLLockHelper resetKeyboardPassword_LockId:key.lockId accessToken:key.accessToken];
}


+ (void)customKeyboardPwd:(NSString *)newKeyboardPwd
                startDate:(NSDate*)startDate
                  endDate:(NSDate*)endDate
                      key:(MHLKeyModel *)key
               complition:(BLEBlock)complition
{
    if (!key) {
        
        complition(NO,nil);
        
        return;
    }
    
    if (complition) {
        
        
        [[MHLLockHelper shareInstance].bleBlockDict setObject:complition forKey:PPLBLE_CUSTOMKEYBOARDPWD];
        
    }
    
    [PPLObjectPPLLockHelper  addKeyboardPassword_LockId:key.lockId accessToken:key.accessToken password:newKeyboardPwd startDate:startDate endDate:endDate];
}

+ (void)deleteKeyboardPwd:(NSString *)keyboadPs
           keyboardPsType:(KeyboardPsType)type
                      key:(MHLKeyModel *)key
               complition:(BLEBlock)complition
{
    if (!key) {
        
        complition(NO,nil);
        
        return;
    }
    
    if (complition) {
        
        
        [[MHLLockHelper shareInstance].bleBlockDict setObject:complition forKey:PPLBLE_DELETEKEYBOARDPWD];
        
    }
    
    [PPLObjectPPLLockHelper  deleteOneKeyboardPassword_LockId:key.lockId accessToken:key.accessToken password:keyboadPs passwordType:type];
}


+ (void)GetLockTimeComplition:(BLEBlock)complition
{
 
    if (complition) {

        
        [[MHLLockHelper shareInstance].bleBlockDict setObject:complition forKey:PPLBLE_READLOCKTIME];
        
    }
    
    [PPLObjectPPLLockHelper getLockTime];
}

+ (void)setAutoLockingTime:(int)time key:(MHLKeyModel *)key complition:(BLEBlock)complition
{
    if (!key) {
        
        complition(NO,nil);
        
        return;
    }
    
    if (complition) {
        
        [[MHLLockHelper shareInstance].bleBlockDict setObject:complition forKey:PPLBLE_SETAUTOLOCKTIME];
        
    }
    
    [PPLObjectPPLLockHelper setAutoLockingTime_LockId:key.lockId accessToken:key.accessToken time:time];
}


+ (void)disconnectBlock:(BLEBlock)disConnectBlock
{
    if (disConnectBlock) {
        [[MHLLockHelper shareInstance].bleBlockDict setObject:disConnectBlock forKey:PPLBLE_DISCONNECT];
    }
    
    [PPLObjectPPLLockHelper disconnect];
}

+ (void)unlock:(MHLKeyModel *)key unlockBlock:(BLEBlock)unlockBlock
{
    if (!key) {
        
        unlockBlock(NO,nil);
        
        return;
    }
    
    if (unlockBlock) {
        
        [[MHLLockHelper shareInstance].bleBlockDict setObject:unlockBlock forKey:PPLBLE_UNLOCK];
    }

        
    [PPLObjectPPLLockHelper unlockWithLockId:key.lockId accessToken:key.accessToken];

}

+ (void)lock:(MHLKeyModel *)key lockBlock:(BLEBlock)lockBlock
{
    if (!key) {
        
        lockBlock(NO,nil);
        
        return;
    }
    
    if (lockBlock) {
        
        [[MHLLockHelper shareInstance].bleBlockDict setObject:lockBlock forKey:PPLBLE_LOCK];
    }
        
    [PPLObjectPPLLockHelper lockWithLockId:key.lockId accessToken:key.accessToken];
    
    
}

+ (void)pullUnlockRecord:(MHLKeyModel *)key complition:(BLEBlock)complition
{
    if (!key) {
        
        complition(NO,nil);
        
        return;
    }
    
    if (complition) {
        
        [[MHLLockHelper shareInstance].bleBlockDict setObject:complition forKey:PPLBLE_PULLLOCKRECORD];
    }
    
    [PPLObjectPPLLockHelper getOperateLog_LockId:key.lockId accessToken:key.accessToken];
    
}


#pragma mark PPLLockDelegate
- (void)didConnectToPeripheral:(CBPeripheral *)peripheral lockName:(NSString *)lockName
{
      [_PPLObject stopScan];
    
       BLEBlock connectBlock = _bleBlockDict[PPLBLE_CONNECT];
    
    if (connectBlock) {
        
        NSMutableDictionary * info = [NSMutableDictionary dictionary];
        
        info[@"curPeripheral"] = peripheral;
        
        info[@"lockName"] = lockName;
        
        connectBlock(YES,info);
    }
}

- (void)didDisconnect
{
    BLEBlock connectBlock = _bleBlockDict[PPLBLE_DISCONNECT];
    
    if (connectBlock) {
        
        connectBlock(YES,nil);
    }
}


- (void)didLockInitializeWithLockDic:(NSDictionary *)lockDic
{
    BLEBlock initLockBlock = _bleBlockDict[PPLBLE_INITLOCK];
    
    if (initLockBlock) {
        
        initLockBlock(YES,lockDic);
    }
}

- (void)didElectricQuantity:(int)electricQuantity
{
    BLEBlock electricBlock = _bleBlockDict[PPLBLE_ELECTIC];
    
    if (electricBlock) {
        
         NSMutableDictionary * info = [NSMutableDictionary dictionary];
        
        info[@"electricQuantity"] = @(electricQuantity);
        
        electricBlock(YES,info);
    }
    
}

- (void)didGetDeviceInfo:(NSDictionary *)infoDic
{
    
    BLEBlock deviceInfoBlock = _bleBlockDict[PPLBLE_DEVICE];
    
    if (deviceInfoBlock) {
        
        if (!infoDic) {
            
            deviceInfoBlock(NO,nil);
            
            return;
        }
        
        deviceInfoBlock(YES,infoDic);
    }
    
}

- (void)didOnSetLockTime
{
    BLEBlock setLockTimeBlock = _bleBlockDict[PPLBLE_SETLOCKTIME];
    
    if (setLockTimeBlock) {
        
        setLockTimeBlock(YES,nil);
    }
    
}

- (void)didUnlock
{
    BLEBlock unlockBlock = _bleBlockDict[PPLBLE_UNLOCK];
    if (unlockBlock) {
     
        [_bleBlockDict removeObjectForKey:PPLBLE_UNLOCK];
        
        unlockBlock(YES,nil);
   
    }
    
    [SSToastHelper showToastWithStatus:@"Unlock success"];
}

- (void)didlock
{
    BLEBlock lockBlock = _bleBlockDict[PPLBLE_LOCK];
    if (lockBlock) {
    
        [_bleBlockDict removeObjectForKey:PPLBLE_LOCK];
         
         lockBlock(YES,nil);

    }
    
    [SSToastHelper showToastWithStatus:@"Lock success"];

}

- (void)didGetOperateLog
{
    BLEBlock lockBlock = _bleBlockDict[PPLBLE_PULLLOCKRECORD];
    
    if (lockBlock) {
        
        [_bleBlockDict removeObjectForKey:PPLBLE_PULLLOCKRECORD];
    
        lockBlock(YES,nil);//获取成功后调用平台接口查询记录
        
    }
    
}

- (void)didOnResetLock
{
    BLEBlock resetLockBlock = _bleBlockDict[PPLBLE_RETSETLOCK];
    
    if (resetLockBlock) {
        
        [_bleBlockDict removeObjectForKey:PPLBLE_RETSETLOCK];
        
        resetLockBlock(YES,nil);
        
    }
}

- (void)didOnResetKeyboardPassword
{
    BLEBlock resetKeyboardPwdBlock = _bleBlockDict[PPLBLE_RETSETKEYBOARDPWD];
    
    if (resetKeyboardPwdBlock) {
        
        [_bleBlockDict removeObjectForKey:PPLBLE_RETSETKEYBOARDPWD];
        
        resetKeyboardPwdBlock(YES,nil);
        
    }
}

- (void)didOnDeleteUserKeyBoardPassword
{
    BLEBlock deleteKeyboardPwdBlock = _bleBlockDict[PPLBLE_DELETEKEYBOARDPWD];
    
    if (deleteKeyboardPwdBlock) {
        
        [_bleBlockDict removeObjectForKey:PPLBLE_DELETEKEYBOARDPWD];
        
        deleteKeyboardPwdBlock(YES,nil);
        
    }
}

- (void)didOnAddUserKeyBoardPassword
{
    BLEBlock addKeyboardPwdBlock = _bleBlockDict[PPLBLE_CUSTOMKEYBOARDPWD];
    
    if (addKeyboardPwdBlock) {
        
        [_bleBlockDict removeObjectForKey:PPLBLE_CUSTOMKEYBOARDPWD];
        
        addKeyboardPwdBlock(YES,nil);
        
    }
    
}


- (void)didGetLockTime:(NSDictionary *)lockTimeDic
{
    BLEBlock getLockTimeBlock = _bleBlockDict[PPLBLE_READLOCKTIME];
    
    if (getLockTimeBlock) {
        
        [_bleBlockDict removeObjectForKey:PPLBLE_READLOCKTIME];
        
        getLockTimeBlock(YES,lockTimeDic);
        
    }
}

- (void)didOnAutoLockingTime
{
    BLEBlock setAutoLockTimeBlock = _bleBlockDict[PPLBLE_SETAUTOLOCKTIME];
    
    if (setAutoLockTimeBlock) {
        
        [_bleBlockDict removeObjectForKey:PPLBLE_SETAUTOLOCKTIME];
        
        setAutoLockTimeBlock(YES,nil);
        
    }
    
}

- (void)PLLError:(PPLLockError)error command:(int)command errorMsg:(NSString *)errorMsg
{
    [SSToastHelper showToastWithStatus:errorMsg];
    
    NSLog(@"%@",[NSString stringWithFormat:@"ERROR:%ld COMAND %d errorMsg%@",(long)error,command,errorMsg]);
    
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    
    info[PPLBLEErrorCodeKey] = @(error);
    
    info[PPLBLECommandKey] = @(command);
        
    [MHLLockHelper removeBlock:info untilExecute:YES];
        
}

+ (void)removeBlock:(id)info untilExecute:(BOOL)execute{
    
    NSMutableDictionary *bleBlockDict = [[MHLLockHelper shareInstance].bleBlockDict copy];
    
    [[MHLLockHelper shareInstance].bleBlockDict removeAllObjects];
    
    [bleBlockDict enumerateKeysAndObjectsUsingBlock:^(NSString *key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqualToString:PPLBLE_CONNECT])
        {
            BLEBlock connectBlock = bleBlockDict[key];
            
            connectBlock(NO,info);
            
        }
    }];
}

@end
