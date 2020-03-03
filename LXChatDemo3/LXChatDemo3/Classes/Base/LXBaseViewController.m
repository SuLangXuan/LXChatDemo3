//
//  LXBaseViewController.m
//  LXChatDemo3
//
//  Created by Su on 2020/3/2.
//  Copyright © 2020 com.lxiOS. All rights reserved.
//

#import "LXBaseViewController.h"
#import "LXLoginViewController.h"

@interface LXBaseViewController ()<EMClientDelegate>

@end

@implementation LXBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
}



/*!
 *  \~chinese
 *  SDK连接服务器的状态变化时会接收到该回调
 *
 *  有以下几种情况, 会引起该方法的调用:
 *  1. 登录成功后, 手机无法上网时, 会调用该回调
 *  2. 登录成功后, 网络状态变化时, 会调用该回调
 *
 *  @param aConnectionState 当前状态
 *
 *  \~english
 *  Invoked when server connection state has changed
 *
 *  @param aConnectionState Current state
 */
- (void)connectionStateDidChange:(EMConnectionState)aConnectionState{
    NSLog(@"网络状态变化,or 手机无法上网");
    //    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"网络状态变化,手机无法上网" message:@"" preferredStyle:UIAlertControllerStyleAlert];//默认在中间显示，底部直接写0
    //    UIAlertAction *sureAc = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
    //    [ac addAction:sureAc];
    //    [self presentViewController:ac animated:YES completion:nil];
}

/*!
 *  \~chinese
 *  自动登录完成时的回调
 *
 *  @param aError 错误信息
 *
 *  \~english
 *  Invoked when auto login is completed
 *
 *  @param aError Error
 */
- (void)autoLoginDidCompleteWithError:(EMError *)aError{
    NSLog(@"自动登录完成时的回调");
}

/*!
 *  \~chinese
 *  当前登录账号在其它设备登录时会接收到此回调
 *
 *  \~english
 *  Invoked when current IM account logged into another device
 */
- (void)userAccountDidLoginFromOtherDevice{
    NSLog(@"当前登录账号在其它设备登录时会接收到此回调");
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"当前登录账号在其它设备登录时会接收到此回调" message:@"" preferredStyle:UIAlertControllerStyleAlert];//默认在中间显示，底部直接写0
    UIAlertAction *sureAc = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[LXBaseNavViewController alloc] initWithRootViewController:[LXLoginViewController new]];
    }];
    [ac addAction:sureAc];
    [self presentViewController:ac animated:YES completion:nil];
}

/*!
 *  \~chinese
 *  当前登录账号已经被从服务器端删除时会收到该回调
 *
 *  \~english
 *  Invoked when current IM account is removed from server
 */
- (void)userAccountDidRemoveFromServer{
    NSLog(@"当前登录账号已经被从服务器端删除时会收到该回调");
    
}

/*!
 *  \~chinese
 *  服务被禁用
 *
 *  \~english
 *  Delegate method will be invoked when User is forbidden
 */
- (void)userDidForbidByServer{
    NSLog(@"用户的账号被禁用");
}

/*!
 *  \~chinese
 *  当前登录账号被强制退出时会收到该回调，有以下原因：
 *    1.密码被修改；
 *    2.登录设备数过多；
 *    3.从服务器端被强制下线;
 *
 *  \~english
 *  Delegate method will be invoked when current IM account is forced to logout with the following reasons:
 *    1. The password is modified
 *    2. Logged in too many devices
 */
- (void)userAccountDidForcedToLogout:(EMError *)aError{
    NSLog(@"1用户的账号从服务器端被强制下线or,2用户在别的设备上登录，把当前设备上登录的用户踢出or,3.从服务器端被强制下线");
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"1用户的账号从服务器端被强制下线or,2用户在别的设备上登录，把当前设备上登录的用户踢出or,3.从服务器端被强制下线" message:@"" preferredStyle:UIAlertControllerStyleAlert];//默认在中间显示，底部直接写0
    UIAlertAction *sureAc = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[LXBaseNavViewController alloc] initWithRootViewController:[LXLoginViewController new]];
    }];
    [ac addAction:sureAc];
    [self presentViewController:ac animated:YES completion:nil];
}



- (void)lxShowAlertTitle:(NSString *)title Message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style ActionTitle:(NSString *)actionTitle actionBlock:(action)acblock{
    KWeakSelf
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];//默认在中间显示，底部直接写0
    UIAlertAction *sureAc = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        acblock();
    }];
    [ac addAction:sureAc];
    [weakSelf presentViewController:ac animated:YES completion:nil];
}

@end
