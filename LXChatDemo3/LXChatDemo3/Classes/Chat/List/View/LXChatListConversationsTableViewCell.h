//
//  LXChatListConversationsTableViewCell.h
//  LXChatDemo3
//
//  Created by Su on 2020/3/3.
//  Copyright © 2020 com.lxiOS. All rights reserved.
//

#import "LXBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXChatListConversationsTableViewCell : LXBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lxnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lxmessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *lxUnReadCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *lxTimeLabel;

@end

NS_ASSUME_NONNULL_END
