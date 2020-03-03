//
//  LXBaseViewController.m
//  LXChatDemo3
//
//  Created by Su on 2020/3/2.
//  Copyright © 2020 com.lxiOS. All rights reserved.
//

#import "LXBaseViewController.h"
#import "LXLoginViewController.h"

@interface LXBaseViewController ()<EMClientDelegate,EMContactManagerDelegate>

@end

@implementation LXBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ///登录相关的回调
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    
    ///好友请求相关回调
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
}


#pragma mark - EMClientDelegate 登录回调

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
    KWeakSelf
    [self lxShowAlertTitle:@"当前登录账号在其它设备登录时会接收到此回调" Message:@"" preferredStyle:UIAlertControllerStyleAlert ActionTitle:@"确定" actionBlock:^{
        [weakSelf lxBackToLoginVC];
    }];
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
    NSLog(@"1.密码被修改；or,2.从服务器端被强制下线");
    KWeakSelf
    [self lxShowAlertTitle:@"1.密码被修改；or,2.从服务器端被强制下线" Message:@"" preferredStyle:UIAlertControllerStyleAlert ActionTitle:@"确定" actionBlock:^{
        [weakSelf lxBackToLoginVC];
    }];
}

#pragma mark - EMContactManagerDelegate 好友申请回调

#pragma mark 1.用户A发送加用户B为好友的申请，用户B会收到这个回调
/*!
 *  用户A发送加用户B为好友的申请，用户B会收到这个回调
 *
 *  @param aUsername   用户名
 *  @param aMessage    附属信息
 */
- (void)friendRequestDidReceiveFromUser:(NSString *)aUsername
                                message:(NSString *)aMessage{
    
    KWeakSelf
    [self lxShowAlertTitle:[NSString stringWithFormat:@"%@ 请求添加你h为好友",aUsername] Message:aMessage preferredStyle:UIAlertControllerStyleAlert ActionTitleYes:@"同意" actionBlockYes:^{
        // 调用:
        [[EMClient sharedClient].contactManager approveFriendRequestFromUser:aUsername completion:^(NSString *aUsername, EMError *aError) {
            if (!aError) {
                NSLog(@"同意加好友申请成功");
                [weakSelf lxShowAlertTitle:@"添加好友成功" Message:@"" preferredStyle:UIAlertControllerStyleAlert ActionTitle:@"ok" actionBlock:^{}];
            } else {
                NSLog(@"同意加好友申请失败的原因 --- %@", aError.errorDescription);
                [weakSelf lxShowAlertTitle:@"同意加好友申请失败的原因" Message:aError.errorDescription preferredStyle:UIAlertControllerStyleAlert ActionTitle:@"ok" actionBlock:^{}];
            }
        }];
    } ActionTitleNo:@"拒绝" actionBlockNo:^{
        
        [[EMClient sharedClient].contactManager declineFriendRequestFromUser:aUsername completion:^(NSString *aUsername, EMError *aError) {
            if (!aError) {
                NSLog(@"拒绝加好友申请成功");
                [weakSelf lxShowAlertTitle:@"拒绝加好友申请成功" Message:@"" preferredStyle:UIAlertControllerStyleAlert ActionTitle:@"ok" actionBlock:^{}];
            } else {
                NSLog(@"拒绝加好友申请失败的原因 --- %@", aError.errorDescription);
                [weakSelf lxShowAlertTitle:@"拒绝加好友申请失败的原因" Message:aError.errorDescription preferredStyle:UIAlertControllerStyleAlert ActionTitle:@"ok" actionBlock:^{}];
            }
        }];
        
    }];
    
}

/*!
 @method
 @brief 用户A发送加用户B为好友的申请，用户B同意后，用户A会收到这个回调
 */
- (void)friendRequestDidApproveByUser:(NSString *)aUsername{
    [self lxShowAlertTitle:[NSString stringWithFormat:@"%@ 同意你添加他为好友",aUsername] Message:@"" preferredStyle:UIAlertControllerStyleAlert ActionTitleYes:@"ok" actionBlockYes:^{
        
    } ActionTitleNo:@"打招呼" actionBlockNo:^{
        
    }];
}

/*!
 @method
 @brief 用户A发送加用户B为好友的申请，用户B拒绝后，用户A会收到这个回调
 */
- (void)friendRequestDidDeclineByUser:(NSString *)aUsername{
    [self lxShowAlertTitle:[NSString stringWithFormat:@"%@ 拒绝你添加他为好友",aUsername] Message:@"" preferredStyle:UIAlertControllerStyleAlert ActionTitle:@"ok" actionBlock:^{}];
}



/*!
 *  \~chinese
 *  用户B同意用户A的好友申请后，用户A和用户B都会收到这个回调
 *
 *  @param aUsername   用户好友关系的另一方
 *
 *  \~english
 *  Delegate method will be invoked id the user is added as a contact by another user.
 *
 *  Both user A and B will receive this callback after User B agreed user A's add-friend invitation
 *
 *  @param aUsername   Another user of user‘s friend relationship
 */
- (void)friendshipDidAddByUser:(NSString *)aUsername{
    [self lxShowAlertTitle:aUsername Message:@"双方都收到的回调" preferredStyle:UIAlertControllerStyleAlert ActionTitle:@"ok" actionBlock:^{
        
    }];
}



#pragma mark - myself


- (void)lxShowAlertTitle:(NSString *)title Message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style ActionTitle:(NSString *)actionTitle actionBlock:(action)acblock{
    KWeakSelf
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];//默认在中间显示，底部直接写0
    UIAlertAction *sureAc = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        acblock();
    }];
    [ac addAction:sureAc];
    [weakSelf presentViewController:ac animated:YES completion:nil];
}

- (void)lxShowAlertTitle:(NSString *)title Message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style ActionTitleYes:(NSString *)actionTitleYes actionBlockYes:(action)acblockYes ActionTitleNo:(NSString *)actionTitleNo actionBlockNo:(action)acblockNo{
    KWeakSelf
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];//默认在中间显示，底部直接写0
    UIAlertAction *sureAc = [UIAlertAction actionWithTitle:actionTitleYes style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        acblockYes();
    }];
    UIAlertAction *noAc = [UIAlertAction actionWithTitle:actionTitleNo style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        acblockNo();
    }];
    [ac addAction:sureAc];
    [ac addAction:noAc];
    [weakSelf presentViewController:ac animated:YES completion:nil];
}

- (void)lxBackToLoginVC{
    [UIApplication sharedApplication].keyWindow.rootViewController = [[LXBaseNavViewController alloc] initWithRootViewController:[LXLoginViewController new]];
}


@end
