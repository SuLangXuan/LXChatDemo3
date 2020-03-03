//
//  LXMeViewController.m
//  LXChatDemo3
//
//  Created by Su on 2020/3/3.
//  Copyright © 2020 com.lxiOS. All rights reserved.
//

#import "LXMeViewController.h"
#import "LXLoginViewController.h"

@interface LXMeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *hxAppKeyLabel;
@end

@implementation LXMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userIDLabel.text = [NSString stringWithFormat:@"用户ID：%@",[EMClient sharedClient].currentUsername];
    self.hxAppKeyLabel.text = [NSString stringWithFormat:@"%@",KAppKey];
}

- (IBAction)logOut:(id)sender {
    KWeakSelf
    [[EMClient sharedClient] logout:YES completion:^(EMError *aError) {
        if (!aError) {
            NSLog(@"退出登录成功");
            [weakSelf lxShowAlertTitle:@"退出登录成功:" Message:@"" preferredStyle:UIAlertControllerStyleAlert ActionTitle:@"确定" actionBlock:^{
                [UIApplication sharedApplication].keyWindow.rootViewController = [[LXBaseNavViewController alloc] initWithRootViewController:[LXLoginViewController new]];
            }];
        } else {
            NSLog(@"退出登录失败的原因---%@", aError.errorDescription);
            [weakSelf lxShowAlertTitle:@"退出登录失败的原因:" Message:aError.errorDescription preferredStyle:UIAlertControllerStyleAlert ActionTitle:@"重新退出登录" actionBlock:^{}];
        }
    }];
}



@end
