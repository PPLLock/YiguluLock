//
//  BasicNavigationController.m
//  BotherSellerOC
//
//  Created by CoderTan on 2017/4/6.
//  Copyright © 2017年 CoderTan. All rights reserved.
//

#import "MHLBasicNavigationController.h"


@interface MHLBasicNavigationController ()<UINavigationControllerDelegate>

@end

@implementation MHLBasicNavigationController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
}

/**
 统一设置导航栏状态栏为黑色
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return  UIStatusBarStyleDefault;
}

- (void)initNavigationBar {
    
      //设置导航栏下不自动下拉
    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;

    //禁用系统的导航侧滑返回手势,解除冲突
    //self.interactivePopGestureRecognizer.enabled = NO;
    
    //设置导航栏两侧字体颜色
    //[[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    UIImage * backgroundImage = [UIImage imageWithColor:[UIColor colorThemeColor]];
    
    [self.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    
    //[self.navigationBar setShadowImage:[UIImage new]];
    
    NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
    //
    attribute[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    attribute[NSFontAttributeName] = FontFamily(18);
    
    [self.navigationBar setTitleTextAttributes:attribute];

    self.navigationBar.tintColor = [UIColor whiteColor];
    
//    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:FontFamily(14),NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
//
//    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:FontFamily(14),NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateHighlighted];
    
    //设置全屏返回手势的代理
    //id target = self.interactivePopGestureRecognizer.delegate;
    
    //添加全屏滑动返回手势
    //SEL backGestureSelector = NSSelectorFromString(@"handleNavigationTransition:");
    
    //self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:backGestureSelector];
    
    //[self.view addGestureRecognizer:self.pan];
    
    self.delegate = self;

}
/**
 设置导航栏样式
 */
//+ (void)load {
//
//    NSArray * array = [NSArray arrayWithObjects:[self class], nil]; //iOS9.0后使用
//
//    if (@available(iOS 9.0, *)) {
//
//        UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:array];
//
//        NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
//
//        attribute[NSForegroundColorAttributeName] = [UIColor whiteColor];
//
//        attribute[NSFontAttributeName] = NavFont(16);
//
//        navBar.titleTextAttributes = attribute;
//
//        UIImage * backgroundImage = [UIImage imageWithColor:[UIColor colorPopulColor]];
//
//        [navBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
//
//
//        [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName:FontFamily(14),NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
//
//         [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName:FontFamily(14),NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateHighlighted];
//
//
//
//
//    } else {
//
//    }
//}

#pragma mark - <UINavigationControllerDelegate>

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if (self.viewControllers.count > 0) { //非根控制器才能全屏滑动返回
        //self.pan.enabled = YES;
        
        // 设置统一返回的按钮样式
//        UIBarButtonItem *backItem = [UIBarButtonItem itemWithImage:@"icon_return" highlightImg:@"icon_return" target:self action:@selector(pop)];
        
        UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_return"] style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
        
        viewController.navigationItem.leftBarButtonItem = backItem;
    
        
    }else {
        //手势不可用
        //self.pan.enabled = NO;
    }
    
    //正式跳转
    [super pushViewController:viewController animated:animated];

}

/**
 返回&出栈
 */
- (void)pop {

    [self.view endEditing:YES];

    [[UIApplication sharedApplication].keyWindow endEditing:YES];

    [self popViewControllerAnimated:YES];


}





@end
