//
//  PPLDefine.h
//  ManhattanLockDemo
//
//  Created by Samuel on 2019/1/8.
//  Copyright © 2019年 Populstay. All rights reserved.
//

#ifndef PPLDefine_h
#define PPLDefine_h

#define PPLLockURL @"http://api.populife.szmuen.cn/"


#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define STATUSBAR_HEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define NAVIGATIONBAR_HEIGHT 44.0
#define BAR_TOTAL_HEIGHT  (NAVIGATIONBAR_HEIGHT + STATUSBAR_HEIGHT)

#define LS(localized) NSLocalizedString(localized, nil)
#define NET_REQUEST_ERROR_NO_DATA -1001
#define DEFAULT_CONNECT_TIMEOUT  10

#define weakify(var) __weak typeof(var) XYWeak_##var = var;
#define strongify(var) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong typeof(var) var = XYWeak_##var; \
_Pragma("clang diagnostic pop")

#define TTWindow [UIApplication sharedApplication].keyWindow
#define TTAppdelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
// rgb（Hex->decimal）
#define RGBFromHexadecimal(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
#define RGB_A(r,g,b,a) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define FontFamily(SIZE) [UIFont fontWithName:@"Apple SD Gothic Neo" size:SIZE]

#define COMMON_BLUE_COLOR RGB(0,185,255)
#define COMMON_FONT_BLACK_COLOR RGB(29,29,38)
#define COMMON_FONT_GRAY_COLOR RGB(178,178,178)

#endif /* PPLDefine_h */
