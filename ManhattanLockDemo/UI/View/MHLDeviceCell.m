//
//  MHLDeviceCell.m
//  ManhattanLockDemo
//  Created by Samuel on 2019/1/10.
//  Copyright © 2019年 Populstay. All rights reserved.

#import "MHLDeviceCell.h"

@implementation MHLDeviceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.addImageV.tintColor = [UIColor colorThemeColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
}

@end
