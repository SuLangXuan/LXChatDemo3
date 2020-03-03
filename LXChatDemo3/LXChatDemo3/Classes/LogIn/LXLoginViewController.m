//
//  LXLoginViewController.m
//  LXChatDemo3
//
//  Created by Su on 2020/3/2.
//  Copyright © 2020 com.lxiOS. All rights reserved.
//

#import "LXLoginViewController.h"
#import "LXRegisterViewController.h"
#import "LXMainTabBarViewController.h"

@interface LXLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@end

@implementation LXLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"登录";
}

- (IBAction)login:(id)sender {
    KWeakSelf
    [[EMClient sharedClient] loginWithUsername:self.accountTF.text password:self.passwordTF.text completion:^(NSString *aUsername, EMError *aError) {
        if (!aError) {
            NSLog(@"登录成功");
            //自动登录：即首次登录成功后，不需要再次调用登录方法，在下次 APP 启动时，SDK 会自动为您登录。并且如果您自动登录失败，也可以读取到之前的会话信息。
            [[EMClient sharedClient].options setIsAutoLogin:YES];
            [UIApplication sharedApplication].keyWindow.rootViewController = [LXMainTabBarViewController new];
        } else {
            [weakSelf lxShowAlertTitle:@"登录失败的原因:" Message:aError.errorDescription preferredStyle:UIAlertControllerStyleAlert ActionTitle:@"重新登录" actionBlock:^{}];
        }
    }];
    
}

- (IBAction)autoWrite:(id)sender {
    self.accountTF.text = @"xuan";
    self.passwordTF.text = @"123";
    
}

- (IBAction)goToRegisterVC:(id)sender {
    
    [self.navigationController pushViewController:[LXRegisterViewController new] animated:YES];
    
}


@end
