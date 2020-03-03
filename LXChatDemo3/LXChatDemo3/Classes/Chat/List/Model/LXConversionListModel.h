//
//  LXConversionListModel.h
//  LXChatDemo3
//
//  Created by Su on 2020/3/3.
//  Copyright © 2020 com.lxiOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXConversionListModel : NSObject
@property (nonatomic,assign) int unReadCount;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *lastMessage;
@property (nonatomic,strong) EMConversation *conversation;
@end

NS_ASSUME_NONNULL_END
