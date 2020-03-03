//
//  LXEMMessageHelper.h
//  LXChatDemo3
//
//  Created by Su on 2020/3/3.
//  Copyright © 2020 com.lxiOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// emmessage 解析类
@interface LXEMMessageHelper : NSObject
/** 单例 */
+ (instancetype _Nonnull )sharedInstance;
///解析消息数据
+ (NSString *)lxparseEMMessage:(EMMessage *)message;
@end

NS_ASSUME_NONNULL_END
