//
//  LXRegisterViewController.m
//  LXChatDemo3
//
//  Created by Su on 2020/3/2.
//  Copyright © 2020 com.lxiOS. All rights reserved.
//

#import "LXRegisterViewController.h"

@interface LXRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation LXRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
}
- (IBAction)register:(id)sender {
    
    
    KWeakSelf
    [[EMClient sharedClient] registerWithUsername:self.accountTF.text password:self.passwordTF.text completion:^(NSString *aUsername, EMError *aError) {
        if (!aError) {
            NSLog(@"注册成功");
            [weakSelf lxShowAlertTitle:@"注册成功" Message:@"" preferredStyle:UIAlertControllerStyleAlert ActionTitle:@"去登录" actionBlock:^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
        } else {
            NSLog(@"注册失败的原因---%@", aError.errorDescription);
            [weakSelf lxShowAlertTitle:@"注册失败的原因:" Message:aError.errorDescription preferredStyle:UIAlertControllerStyleAlert ActionTitle:@"重新注册" actionBlock:^{}];
        }
    }];
    
}


@end
