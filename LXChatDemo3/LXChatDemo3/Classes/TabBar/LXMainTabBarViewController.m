//
//  LXMainTabBarViewController.m
//  LXChatDemo3
//
//  Created by Su on 2020/3/2.
//  Copyright © 2020 com.lxiOS. All rights reserved.
//

#import "LXMainTabBarViewController.h"
#import "LXChatListViewController.h"
#import "LXMeViewController.h"

@interface LXMainTabBarViewController ()

@end

@implementation LXMainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildVC];
}

- (void)addChildVC{
    [self addChildViewController:[LXChatListViewController new] title:@"会话" imageName:@"" selectImageName:@""];
    [self addChildViewController:[LXChatListViewController new] title:@"联系人" imageName:@"" selectImageName:@""];
    [self addChildViewController:[LXMeViewController new] title:@"我的" imageName:@"" selectImageName:@""];
    
}


- (void)addChildViewController:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName{
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    LXBaseNavViewController *navVC = [[LXBaseNavViewController alloc] initWithRootViewController:vc];
    [self addChildViewController:navVC];
}


@end
