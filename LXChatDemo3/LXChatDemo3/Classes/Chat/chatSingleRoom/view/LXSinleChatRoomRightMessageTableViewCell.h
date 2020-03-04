//
//  LXSinleChatRoomRightMessageTableViewCell.h
//  LXChatDemo3
//
//  Created by Su on 2020/3/4.
//  Copyright © 2020 com.lxiOS. All rights reserved.
//

#import "LXBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXSinleChatRoomRightMessageTableViewCell : LXBaseTableViewCell
@property (weak, nonatomic) IBOutlet UIView *nameView;
@property (weak, nonatomic) IBOutlet UILabel *lxTimelabel;
@property (weak, nonatomic) IBOutlet UILabel *lxNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lxMessageLabel;
@property (weak, nonatomic) IBOutlet UIView *bgview;
@end

NS_ASSUME_NONNULL_END
