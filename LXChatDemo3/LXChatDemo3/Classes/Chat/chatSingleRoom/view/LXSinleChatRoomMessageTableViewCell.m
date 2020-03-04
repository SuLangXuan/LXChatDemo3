//
//  LXSinleChatRoomMessageTableViewCell.m
//  LXChatDemo3
//
//  Created by Su on 2020/3/4.
//  Copyright © 2020 com.lxiOS. All rights reserved.
//

#import "LXSinleChatRoomMessageTableViewCell.h"

@implementation LXSinleChatRoomMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgview.layer.cornerRadius = 3;
    self.nameView.layer.cornerRadius = 30;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
