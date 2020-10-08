//
//  MHLDeviceTableViewController.m
//  ManhattanLockDemo
//
//  Created by Samuel on 2019/1/10.
//  Copyright © 2019年 Populstay. All rights reserved.
//

#import "MHLDeviceTableViewController.h"
#import "MHLOnFoundDeviceModel.h"
#import "MHLDeviceCell.h"
#import "MHLDemoViewController.h"
#import "MHLNetworkHelper.h"
#import "MHLKeyModel.h"

#define  AppKey    @"1083jf71h3f3e7" //@"1bf83dg4311e7"

#define  Appsecret @"1fcddfd2057aef80647221b01e82c62e5c3a00f3"//@"1fcddfd2057aef80647221b01e82c62e8e8b77ef"

#define TokenKey @"token"



@interface MHLDeviceTableViewController ()<PPLLockDelegate,MHLDemoDelegate>
{
    MHLOnFoundDeviceModel * _selectModel;
    
    NSString * _accessToken;
}

@property (nonatomic,strong) NSMutableArray *blueListArr;

@end

@implementation MHLDeviceTableViewController

static  NSString * lockDeviceCellID = @"deviceCell";

- (NSMutableArray *)blueListArr
{
    if (!_blueListArr) {
        
        _blueListArr = [NSMutableArray array];
    }
    
    return _blueListArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Nearby lock";
    
    [self setupTableView];

   
    
    //_accessToken = @"e38d392a04564d27655dec481384d99e";//服务器调平台接口获取，有效期30分钟，失效后需要重新调用该接口获取
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Demo" style:UIBarButtonItemStyleDone target:self action:@selector(demoAction)];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    PPLObjectPPLLockHelper.delegate = self;
    
    [PPLObjectPPLLockHelper setupBluetooth];
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSString * token = [defaults objectForKey:TokenKey];
    
    _accessToken = token;
    
    if (!token) {
        
        [self getAccessToken];
    }
    
   
}

- (void)demoAction
{

    MHLDemoViewController * demoVC = [[MHLDemoViewController alloc] init];
    
    RLMResults * locks = [MHLKeyModel allObjects];
    
    if (locks.count) {
        
        demoVC.model = [locks lastObject];
        
    }else {
        
        [self showToast:@"No lock data"];
        
        return;
    
    }
    
    demoVC.delegate = self;
    
    [self.navigationController pushViewController:demoVC animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    PPLObjectPPLLockHelper.delegate = PPLLockHelperClass;
    
    [PPLObjectPPLLockHelper startScan];
    
    
}

- (void)setupTableView
{
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MHLDeviceCell class]) bundle:nil] forCellReuseIdentifier:lockDeviceCellID];
    
    self.tableView.rowHeight = 70.f;
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.blueListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHLDeviceCell * cell = [tableView dequeueReusableCellWithIdentifier:lockDeviceCellID];
    
    MHLOnFoundDeviceModel *blueModel = self.blueListArr[indexPath.row];
    
    cell.nameLab.text = blueModel.blueName;
    
    if (blueModel.hasBind || blueModel.blueName.length > 8) {
        
        cell.addImageV.hidden = YES;
        
        cell.nameLab.textColor = [UIColor lightGrayColor];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }else {
        
        RLMResults * locks = [MHLKeyModel allObjects];
        
        if (locks.count) {
            
            MHLKeyModel * model = [locks lastObject];
            
            if ([model.name isEqualToString:blueModel.blueName]) {
               
                cell.addImageV.hidden = YES;
                
                cell.nameLab.textColor = [UIColor lightGrayColor];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }else {
              
                cell.addImageV.hidden = NO;
                
                cell.nameLab.textColor = [UIColor blackColor];
                
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
                
            }
            
        }else {
          
            
            cell.addImageV.hidden = NO;
            
            cell.nameLab.textColor = [UIColor blackColor];
            
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            
        }
        
    }

    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (PPLObjectPPLLockHelper.state == PPLManagerStatePoweredOff) {
        
        [self showToast:@"Please turn on Bluetooth"];
        
        return;
    }

    
    MHLOnFoundDeviceModel * blueModel = self.blueListArr[indexPath.row];
    
    _selectModel = blueModel;
    
    if (blueModel.hasBind) {
        
        return;
        
    }
    //停止扫描
    [PPLObjectPPLLockHelper stopScan];
    
    [self showHUDToWindow:LS(@"Connecting...")];
    
    [PPLObjectPPLLockHelper connect:blueModel.peripheral];
    
}

- (void)PPLCenterManagerDidUpdateState:(PPLManagerState)state
{
    if (state == PPLManagerStatePoweredOn) {
        
        [self showHUD:LS(@"Searching for nearby locks...")];
        
        [PPLObjectPPLLockHelper startScan];
    
    }else if(state == PPLManagerStatePoweredOff){
        
        [self hideHUD];
        
        [self showToast:@"Please turn on your phone Bluetooth first."];
        
    }
}

- (void)didFindPeripheral:(CBPeripheral *)peripheral lockName:(NSString *)lockName mac:(NSString *)mac hasBind:(BOOL)hasBind
{
  
    NSInteger perpheralIndex = -1 ;
    
    NSInteger count = self.blueListArr.count;
    
    for (int i = 0;  i < count; i++) {
        MHLOnFoundDeviceModel *model = [[MHLOnFoundDeviceModel alloc]init];
        model = self.blueListArr[i];
        if ([model.peripheral.identifier isEqual:peripheral.identifier]) {
            perpheralIndex = i ;
            break ;
        }
        
    }
    
    MHLOnFoundDeviceModel * model = [[MHLOnFoundDeviceModel alloc]init];
    
    model.peripheral = peripheral;
    
    model.blueName = lockName;
    
    model.lockMac = mac;
    
    model.hasBind = hasBind;
    
    
    if (perpheralIndex != -1) {
        
        [self.blueListArr replaceObjectAtIndex:perpheralIndex withObject:model];
        
    }else{
        
        [self.blueListArr addObject:model];
        
    }
    
    NSInteger arrCount = self.blueListArr.count;
    
    int j = 0;
    
    for (int i = 0 ; i < arrCount; i ++) {
        
        MHLOnFoundDeviceModel *model = [[MHLOnFoundDeviceModel alloc]init];
        model = self.blueListArr[i];
        
        if (!model.hasBind) {
            
            [self.blueListArr exchangeObjectAtIndex:j++ withObjectAtIndex:i];
        }
        
    }
    
    if (self.blueListArr.count > 0) {
        
        [self.tableView reloadData];
        
        [self  hideHUD];
        
    }
    
}

- (void)didConnectToPeripheral:(CBPeripheral *)peripheral lockName:(NSString *)lockName
{

    if (_accessToken) {
        
        [PPLObjectPPLLockHelper lockInitializeWithToken:_accessToken];
    
    }else {
        
        [self hideHUD];
        
        [self showToast:@"Token timeout or invalid"];
    }
    
    
}

- (void)PLLError:(PPLLockError)error command:(int)command errorMsg:(NSString *)errorMsg
{
    
    
    NSLog(@"error = %ld",(long)error);
    
    if (error == PPLLockErrorConnectOut) {
        
        [self hideHUD];
        
        [self showOperationFailedToast];
        
        return;
    
    }
    
    if (error == PPLLockErrorAccessTokenError) {
        
        [self hideHUD];
        
        [self showToast:@"Token timeout or invalid"];
        
        return;
        
        
    }
    
    [self hideHUD];
}

#pragma mark ---- 初始化成功
- (void)didLockInitializeWithLockDic:(NSDictionary *)lockDic
{
    [PPLObjectPPLLockHelper disconnect];
    
    NSLog(@"lockDic = %@",lockDic);
    
    [self hideHUD];
    
    [self.tableView reloadData];
    
    [self showToast:@"Initialization lock succeeded"];
    
    MHLKeyModel * keyModel = [[MHLKeyModel alloc] init];
    
    keyModel.accessToken = _accessToken;

    keyModel.name = _selectModel.blueName;
    
    keyModel.mac = _selectModel.lockMac;
    
    keyModel.timestamp = lockDic[@"timestamp"];
    
    keyModel.electricQuantity = lockDic[@"electricQuantity"];

    keyModel.timezoneRawOffSet = lockDic[@"timezoneRawOffset"];
    
    keyModel.protocolVersion = lockDic[@"protocolVersion"];
    
    keyModel.hardwareVersion = lockDic[@"hardwareVersion"];
    
    keyModel.firwareVersion = lockDic[@"firwareVersion"];
    
    keyModel.lockId = lockDic[@"lockId"];
    
    keyModel.uuid = lockDic[@"lockId"];
    
    MHLDemoViewController  * demoVC = [[MHLDemoViewController alloc] init];
    
    NSLog(@"lockId = %@ &&& accessToken = %@",keyModel.lockId,keyModel.accessToken);
    
    demoVC.model = keyModel;
    
    RLMRealm * realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    
    [MHLKeyModel createOrUpdateInRealm:realm withValue:keyModel];
    
    [realm commitWriteTransaction];
    
    demoVC.delegate = self;
    
    [self.navigationController pushViewController:demoVC animated:YES];
    
}

- (void)getAccessToken
{
    
    [MHLNetworkHelper requestExperUserKeyWithAppKey:AppKey appSecrect:Appsecret Handler:^(int code, NSString *data, NSError *error) {
        
        if(code == 200) {
            
            if (data && ![data isKindOfClass:[NSNull class]]) {
                
                _accessToken = data;
                
                NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
                
                [defaults setObject:data forKey:TokenKey];
                
                [defaults synchronize];
            }
            
        }
            
    }];
}

- (void)resetLockSuccess
{
    PPLObjectPPLLockHelper.delegate = self;
    
    [PPLObjectPPLLockHelper setupBluetooth];
}


@end
