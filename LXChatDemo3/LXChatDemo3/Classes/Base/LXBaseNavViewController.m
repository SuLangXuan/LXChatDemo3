//
//  LXBaseNavViewController.m
//  LXChatDemo3
//
//  Created by Su on 2020/3/2.
//  Copyright © 2020 com.lxiOS. All rights reserved.
//

#import "LXBaseNavViewController.h"

@interface LXBaseNavViewController ()

@end

@implementation LXBaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //只要导航栏push就隐藏tabbar
    //判段当前viewcontroller是否是根控制器
    if (self.childViewControllers.count >0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
