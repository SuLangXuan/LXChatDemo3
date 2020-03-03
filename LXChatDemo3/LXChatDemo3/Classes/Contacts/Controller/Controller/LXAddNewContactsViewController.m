//
//  LXAddNewContactsViewController.m
//  LXChatDemo3
//
//  Created by Su on 2020/3/3.
//  Copyright © 2020 com.lxiOS. All rights reserved.
//

#import "LXAddNewContactsViewController.h"

@interface LXAddNewContactsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *idTF;
@property (weak, nonatomic) IBOutlet UITextField *msgTF;


@end

@implementation LXAddNewContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)addNewContacts:(id)sender {
    KWeakSelf
    [[EMClient sharedClient].contactManager addContact:self.idTF.text message:self.msgTF.text completion:^(NSString *aUsername, EMError *aError) {
        if (!aError) {
            NSLog(@"添加好友成功 -- %@",aUsername);
            [weakSelf lxShowAlertTitle:@"添加好友申请发送成功" Message:@"" preferredStyle:UIAlertControllerStyleAlert ActionTitle:@"ok" actionBlock:^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            
        } else {
            NSLog(@"添加好友失败的原因 --- %@", aError.errorDescription);
            [weakSelf lxShowAlertTitle:@"添加好友申请发送成功" Message:@"" preferredStyle:UIAlertControllerStyleAlert ActionTitle:@"ok" actionBlock:^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
        }
    }];
}


@end
