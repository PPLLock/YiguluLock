//
//  MHLOnFoundDeviceModel.h
//  ManhattanLockDemo
//
//  Created by Samuel on 2019/1/11.
//  Copyright © 2019年 Populstay. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MHLOnFoundDeviceModel : NSObject

@property (nonatomic, strong) NSString *blueName;
//设备名称
@property (nonatomic, strong) CBPeripheral *peripheral;

@property (nonatomic, strong) CBCharacteristic * GPrint_Chatacter;
@property (nonatomic, strong) NSString * UUIDString; //UUID
@property (nonatomic, strong) NSString * distance;  //中心到外设的距离
/**
 是否绑定
 */
@property (nonatomic,assign)BOOL hasBind;
/**
 锁MAC地址
 */
@property (nonatomic, strong) NSString * lockMac;


@end


