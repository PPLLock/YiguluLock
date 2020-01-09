//
//  PPLLock.h
//  PPLLock
//
//  Created by Samuel on 2019/1/2.
//  Copyright © 2019年 Populstay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

/*!
 *  @enum PPLManagerState
 *
 *  @discussion Represents the current state of a Manager.
 *  @constant PPLManagerStateUnknown       State unknown, update imminent.
 *  @constant PPLManagerStateResetting     The connection with the system service was momentarily lost, update imminent.
 *  @constant PPLManagerStateUnsupported   The platform doesn't support the Bluetooth Low Energy Central/Client role.
 *  @constant PPLManagerStateUnauthorized  The application is not authorized to use the Bluetooth Low Energy role.
 *  @constant PPLManagerStatePoweredOff    Bluetooth is currently powered off.
 *  @constant PPLManagerStatePoweredOn     Bluetooth is currently powered on and available to use.
 *
 */

typedef NS_ENUM(NSInteger, PPLManagerState) {
    PPLManagerStateUnknown = 0,
    PPLManagerStateResetting,
    PPLManagerStateUnsupported,
    PPLManagerStateUnauthorized,
    PPLManagerStatePoweredOff,
    PPLManagerStatePoweredOn,
} ;

/*!
 @header PPLLock.h
 
 Main PPLLock header
 */

/*!
 PPLLockError
 @brief Enum for error codes
 
 This enum represents all the possible errors that can be returned
 */

typedef NS_ENUM(NSInteger, PPLLockError)
{
    /** Connection timed out */
    PPLLockErrorConnectOut = 1100,
    /** Bluetooth Unavailable */
    PPLLockErrorBlEUnavailable = 1101,
    /** Init Lock  fail */
    PPLLockErrorInitLockFail  = 1102,
    /** Lock verfy fail */
    PPLLockErrorVerfyFail  = 1103,
    /** Get lock power fail */
    PPLLockErrorGetElecticFail  = 1104,
    /** Get device info fail */
    PPLLockErrorGetDeviceInfoFail  = 1105,
    /** Unlock fail */
    PPLLockErrorUnlockFail  = 1106,
    /** Lock fail */
    PPLLockErrorlockFail  = 1107,
     /** Get lock record fail */
    PPLLockErrorGetRecordFail  = 1108,
    /** Set lock time fail */
    PPLLockErrorSetTimeFail  = 1109,
    /** Get lock time fail */
    PPLLockErrorGetTimeFail  = 1110,
    /** Set Auto lock fail */
    PPLLockErrorSetAutoLockFail  = 1111,
    /** Reset lock fail */
    PPLLockErrorResetLockFail  = 1112,
    /** Add Keyboard Password fail */
    PPLLockErrorAddKeyboardPasswordFail  = 1113,
    /** Delete Keyboard Password fail */
    PPLLockErrorDeleteKeyboardPasswordFail  = 1114,
    /** Reset Keyboard Password fail */
    PPLLockErrorResetKeyboardPasswordFail  = 1115,
    /** Network Error */
    PPLLockErrorNetowrkError  = 1116,
    /** AccessToken Error */
    PPLLockErrorAccessTokenError  = 1117,
    /** Not a white list */
    PPLLockErrorNotWhiteList  = 1118,
    /** Application status exception */
    PPLLockErrorStatusException  = 1119,
    /** CRC Check Error */
    PPLLockErrorCRC  = 1120,
    /** Lock Id Error */
    PPLLockErrorLockId = 1121,
    /** Locks for non-current applications */
    PPLLockErrorNonCurLock = 1122,
    /** The lock has been deleted */
    PPLLockErrorLockDeleted = 1123,
    /** Writing data failed */
    PPLLockErrorWriteData = 1124,
    /** Lock ID is empty */
    PPLLockErrorLockIdEmpty = 1125,
    /** AccessToken is empty */
    PPLLockErrorAccessTokenEmpty = 1126,
    /** Cloud access failure */
    PPLLockErrorAccessCloudFail = 1127,
    /** The parameter is empty */
    PPLLockErrorParamEmpty = 1128,
    /** Password Type Error */
    PPLLockErrorPasswordTypeError = 1129,
    
    /** Enter Firmware Update fail */
    PPLLockErrorEnterFirewareUpdateFail  = 1130,
};

/*!
 *  @enum KeyboardPsType
 *
 *  @discussion Keyboard password type
 *  @constant KeyboardPsTypeOnce           One-time
 *  @constant KeyboardPsTypePermanent      Permanent
 *  @constant KeyboardPsTypePeriod         Period
 */
typedef NS_ENUM(NSInteger, KeyboardPsType)
{
    KeyboardPsTypeOnce = 1,
    KeyboardPsTypePermanent = 2,
    KeyboardPsTypePeriod = 4,
};

/*!
 PPLLockDelegate
 @brief Protocol for receiving PPLLock events
 
 The registered delegate will receive events from the main PPLLock class
 */
@protocol PPLLockDelegate <NSObject>

@optional

/*! Invoked whenever the central manager's state has been updated.
 
 @param state  enum: PPLManagerState
*/
- (void)PPLCenterManagerDidUpdateState:(PPLManagerState)state;

/*! Tells the delegate that a Bluetooth peripheral was found.
 
 @param peripheral The discovered peripheral.
 @param lockName The name of the peripheral. Using [peripheral name] is more reliable.
 @param mac Mac address of the peripheral.
 @param hasBind Indicates whether the external door lock device is already bound. If it is already bound, this value is YES..
 */
- (void)didFindPeripheral:(CBPeripheral*)peripheral lockName:(NSString*)lockName mac:(NSString*)mac hasBind:(BOOL)hasBind;

/*! Tells the delegate that they successfully connected to a device.
 
 @param peripheral The peripheral connected to.
 @param lockName The name of the peripheral. Using [peripheral name] is more reliable.
 */
- (void)didConnectToPeripheral:(CBPeripheral*)peripheral lockName:(NSString*)lockName;

/*! Tells the delegate that they disconnected from a device.
 */
- (void)didDisconnect;

/*! This method is invoked when {@link lockInitialize} has succeeded.
 
 @param lockDic:electricQuantity,timezoneRawOffset,timestamp,protocolVersion,hardwareVersion,firwareVersion
 
 */
- (void)didLockInitializeWithLockDic:(NSDictionary*)lockDic;

/*! Tells the delegate that they  lock power successfully callback

 @param electricQuantity Lock power, integer value 1-100
 
 */
- (void)didElectricQuantity:(int)electricQuantity;

/*! Tells the delegate that they Device Info Successfully
 
 @param infoDic  a dictionary, including:modelNum,hardwareVersion,firwareVersion,protocolVersion
 
 */
- (void)didGetDeviceInfo:(NSDictionary*)infoDic;

/*! Tells the delegate that they successfully unlocked the device.
 */
- (void)didUnlock;

/*! Tells the delegate that they successfully locked the device.
 */
- (void)didlock;

/*! Tells the delegate that they Get callback PPLAFter successful operation record

 */
- (void)didGetOperateLog;

/*! Tells the delegate that they Get Lock Time Successfully
 
 @param lockTimeDic dictionary, including: Timestamp、week、timezone
 ,Week takes a value of 0-6, indicating Sunday-Saturday;Time zone:
 0: UTC 1~11: UTC+1~UTC+11 12: East and West 12th District 23~13: UTC-11~UTC-1
 */
- (void)didGetLockTime:(NSDictionary *)lockTimeDic;

/*! Tells the delegate that they Set lock time to succeed This method is invoked when {@link setLockTime_LockId:accessToken:currentTime:} has succeeded.
 
 */
- (void)didOnSetLockTime;

/*! Tells the delegate that they Set auto locking time to succeed
 */
- (void)didOnAutoLockingTime;

/*! Informs the delegate that the lock was reset to factory settings and all passwords will be cleared.
 
 * @discussion Reset the binding state of the lock, the lock can be bound.
 */
- (void)didOnResetLock;

/*! Add User KeyBoard Password  Successfully
 */
- (void)didOnAddUserKeyBoardPassword;

/*! Delete User KeyBoard Password Successfully
 */
- (void)didOnDeleteUserKeyBoardPassword;

/*! Password can be regenerated PPLAFter successful password reset
 */
- (void)didOnResetKeyboardPassword;

/*! Enter firmware upgrade status
 */
- (void)didOnEnterFirmwareUpdate;

/*! This method is invoked when the lock returns an error
 
  @param error     error code
  @param command   command value
  @param errorMsg  Error description
 */
- (void)PLLError:(PPLLockError)error command:(int)command errorMsg:(NSString*)errorMsg;

@end

@interface PPLLock : NSObject

/*! An object that will receive the PPLLock delegate methods
 */
@property (nonatomic, weak) id<PPLLockDelegate> delegate;

/*!
 *  @property state
 *
 *  @discussion The current state of the manager, initially set to <code>PPLManagerStateUnknown</code>.
 *                Updates are provided by required delegate method {@link PPLCenterManagerDidUpdateState:}.
 *
 */
@property(nonatomic, assign, readonly) PPLManagerState state;

+ (PPLLock*)sharedPPLLock;

/*! Initialize the PPLLock class
 */
-(id)initWithDelegate:(id<PPLLockDelegate>)PPLDelegate;

/*! Creating a Bluetooth object
 
 @see PPLCenterManagerDidUpdateState:.
 */
- (void)setupBluetooth;

/*! Start scanning nearby peripherals
 
 @see didFindPeripheral:lockName:mac:.
 */
- (void)startScan;

/*! Stop scanning and call this method to stop scanning nearby peripherals when an available device is found to reduce overhead
 */
- (void)stopScan;

/*! Connect to selected device.
 
 @param peripheral The peripheral returned in the delegate method didFindPeripheral:
 
 @see didConnectToPeripheral:lockName:.
 
 @see PLLError: command: errorMsg:.
 */
- (void)connect:(CBPeripheral*)peripheral;

/*! Connecting peripheral
  Connect to the device by specifying the device name
 
 @param lockName Specified device name
 
 @see didConnectToPeripheral:lockName:.
 
 @see PLLError: command: errorMsg:.
 */
- (void)connectPeripheralWithLockName:(NSString *)lockName;

/*! Disconnect from currently connected device
 
 @see didDisconnect.
 
 @see PLLError: command: errorMsg:.
 */
- (void)disconnect;

/*! Initialize lock
 
 @param accessToken Access token
 
 @see didLockInitializeWithLockDic:.
 
 @see PLLError: command: errorMsg:.
 */
- (void)lockInitializeWithToken:(NSString *)accessToken;

/*! Get Lock battery
 
 @see  didElectricQuantity:.
 
 @see  PLLError: command: errorMsg:.
 */
- (void)getElectricQuantity;

/*! Get Device Info
 
 @see didGetDeviceInfo:.
 
 @see  PLLError: command: errorMsg:.
 */
- (void)getDeviceInfo;

/*!unlock
 
 @param lockId ,returned when the lock is bound
 @param accessToken initialize SDK return

 @see didUnlock.
 
 @see PLLError: command: errorMsg:.
 */
- (void)unlockWithLockId:(NSString *)lockId accessToken:(NSString *)accessToken;


/*!lock
 
 @param lockId ,returned when the lock is bound
 @param accessToken initialize SDK return
 
 @see didlock.
 
 @see PLLError: command: errorMsg:.
 */
- (void)lockWithLockId:(NSString *)lockId accessToken:(NSString *)accessToken;

/*! Query operation records from the lock
 
 @param lockId ,returned when the lock is bound
 
 @param accessToken initialize SDK return
 
 @see didGetOperateLog.
 
 @see PLLError: command: errorMsg:.
 */
- (void)getOperateLog_LockId:(NSString *)lockId accessToken:(NSString *)accessToken;

/*! Read lock time
 
 @see didGetLockTime:.
 
 @see PLLError: command: errorMsg:.
 */
- (void)getLockTime;

/*! Set lock time
 
 @param  lockId ,returned when the lock is bound
 @param  accessToken Call the API to get it by passing in AppKey and AppSecret
 @param  currentTime current time
 
 @see  didOnSetLockTime.
 
 @see  PLLError: command: errorMsg:.
 */
- (void)setLockTime_LockId:(NSString *)lockId accessToken:(NSString *)accessToken currentTime:(NSDate *)currentTime;

/*!  Set Auto Locking Time
 
 @param  lockId ,returned when the lock is bound
 @param  accessToken Call the API to get it by passing in AppKey and AppSecret
 @param  time Set the auto lock time, set to 0 if auto lock is turned off,The default is 5 seconds, and the value ranges from 0 to 255.
 
 @see  didOnAutoLockingTime.
 
 @see  PLLError: command: errorMsg:.
 */
- (void)setAutoLockingTime_LockId:(NSString *)lockId accessToken:(NSString *)accessToken time:(int)time;

/*! Reset Lock Restore lock to factory settings, delete all electronic keys and keyboard passwords
 
 @param lockId ,returned when the lock is bound
 @param accessToken initialize SDK return
 
 @see   didOnResetLock.
 
 @see   PLLError: command: errorMsg:.
 */
- (void)resetLock_LockId:(NSString *)lockId accessToken:(NSString *)accessToken;

/*! Add keyboard passcode
 @param  lockId ,returned when the lock is bound
 @param  accessToken Call the API to get it by passing in AppKey and AppSecret
 @param  keyboardPs The Passcode to add ,Passcode range : 6 - 8 Digits in length
 @param  startDate The time when it becomes valid
 @param  endDate The time when it is expired
 
 @see  didOnAddUserKeyBoardPassword.
 
 @see  PLLError: command: errorMsg:.
 */
- (void)addKeyboardPassword_LockId:(NSString *)lockId accessToken:(NSString *)accessToken password:(NSString *)keyboardPs startDate:(NSDate*)startDate endDate:(NSDate*)endDate;

/**
 *  Delete a single keyboard passcode
 
 @param  lockId ,returned when the lock is bound
 @param  accessToken Call the API to get it by passing in AppKey and AppSecret
 @param  keyboardPs KeyboardPassword range : 6 - 9 Digits in length
 @param  passwordType  KeyboardPassword type{@see emum KeyboardPsType}
 
 @see    didOnDeleteUserKeyBoardPassword.
 @see    PLLError: command: errorMsg:.
 */
- (void)deleteOneKeyboardPassword_LockId:(NSString *)lockId accessToken:(NSString *)accessToken password:(NSString *)keyboardPs passwordType:(KeyboardPsType)passwordType;


/** Reset keyboard Passcode
 
 @param lockId ,returned when the lock is bound
 @param accessToken Call the API to get it by passing in AppKey and AppSecret
 
 @see    didOnResetKeyboardPassword.
 @see    PLLError: command: errorMsg:.
 */
- (void)resetKeyboardPassword_LockId:(NSString *)lockId accessToken:(NSString *)accessToken;


/** Put device into firmware upgrade state
 
 @param lockId ,returned when the lock is bound
 @param accessToken Call the API to get it by passing in AppKey and AppSecret
 
 @see    didOnEnterFirmwareUpdate.
 @see    PLLError: command: errorMsg:.
 */
- (void)enterFirmWareUpgarde_LockId:(NSString *)lockId accessToken:(NSString *)accessToken;


@end
