//
//  LXChatSingleViewController.h
//  LXChatDemo3
//
//  Created by Su on 2020/3/3.
//  Copyright © 2020 com.lxiOS. All rights reserved.
//

#import "LXBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXChatSingleViewController : LXBaseViewController
///当前会话的ID
@property (nonatomic,strong) NSString *conversationId;
@end

NS_ASSUME_NONNULL_END
