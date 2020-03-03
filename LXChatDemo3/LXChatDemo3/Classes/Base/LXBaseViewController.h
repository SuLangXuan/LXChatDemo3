//
//  LXBaseViewController.h
//  LXChatDemo3
//
//  Created by Su on 2020/3/2.
//  Copyright © 2020 com.lxiOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^action)(void);

@interface LXBaseViewController : UIViewController




/// 系统弹窗
/// @param title <#title description#>
/// @param message <#message description#>
/// @param style <#style description#>
/// @param actionTitle <#actionTitle description#>
/// @param acblock 点击按钮要做的事
- (void)lxShowAlertTitle:(NSString *)title Message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style ActionTitle:(NSString *)actionTitle actionBlock:(action)acblock;
@end

NS_ASSUME_NONNULL_END
