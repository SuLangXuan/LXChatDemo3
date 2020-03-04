//
//  LXChatSingleViewController.m
//  LXChatDemo3
//
//  Created by Su on 2020/3/3.
//  Copyright © 2020 com.lxiOS. All rights reserved.
//

#import "LXChatSingleViewController.h"
#import "LXSinleChatRoomMessageTableViewCell.h"
#import "LXSinleChatRoomRightMessageTableViewCell.h"

#define KLXSinleChatRoomMessageTableViewCell @"LXSinleChatRoomMessageTableViewCell"
#define KLXSinleChatRoomRightMessageTableViewCell @"LXSinleChatRoomRightMessageTableViewCell"

@interface LXChatSingleViewController ()<UITableViewDelegate,UITableViewDataSource,EMChatManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *messageTF;
@property (weak, nonatomic) IBOutlet UITableView *tb;
@property (nonatomic,strong) NSMutableArray<EMMessage *> *dataArr;
@end

@implementation LXChatSingleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //新建/获取一个会话    根据 conversationId 创建一个 conversation。
    //
    [[EMClient sharedClient].chatManager getConversation:self.conversationId type:EMConversationTypeChat createIfNotExist:YES];
    self.tb.dataSource = self;
    self.tb.delegate = self;
    [self.tb registerClass:[UITableViewCell class] forCellReuseIdentifier:@"test"];
    [self.tb registerNib:[UINib nibWithNibName:KLXSinleChatRoomMessageTableViewCell bundle:nil] forCellReuseIdentifier:KLXSinleChatRoomMessageTableViewCell];
    [self.tb registerNib:[UINib nibWithNibName:KLXSinleChatRoomRightMessageTableViewCell bundle:nil] forCellReuseIdentifier:KLXSinleChatRoomRightMessageTableViewCell];
    [self getHistoryMessageData];
    self.title = self.conversationId;
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
}

- (void)getHistoryMessageData{
    KWeakSelf
    EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:self.conversationId type:EMConversationTypeChat createIfNotExist:YES];
    [conversation loadMessagesStartFromId:nil count:10 searchDirection:EMMessageSearchDirectionUp completion:^(NSArray *aMessages, EMError *aError) {
        if (!aError) {
            // aMessage数组中存的是EMMessage
            NSLog(@"从数据库获取消息成功 --- %@", aMessages);
            [weakSelf.dataArr removeAllObjects];
            [weakSelf.dataArr addObjectsFromArray:aMessages];
            [weakSelf.tb reloadData];
        } else {
            NSLog(@"删除一组会话失败的原因 --- %@", aError.errorDescription);
        }
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EMMessage *message = self.dataArr[indexPath.row];
    NSString *currentUser = [[EMClient sharedClient] currentUsername];
    if (![currentUser isEqualToString:message.from]) {
        LXSinleChatRoomMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KLXSinleChatRoomMessageTableViewCell forIndexPath:indexPath];
        cell.lxTimelabel.text = [LXEMMessageHelper LXTimeWithTimeIntervalLongLong:message.timestamp];
           cell.lxNameLabel.text = message.from;
           cell.lxMessageLabel.text = [LXEMMessageHelper lxparseEMMessage:message];
        return cell;
    }else{
        LXSinleChatRoomRightMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KLXSinleChatRoomRightMessageTableViewCell forIndexPath:indexPath];
        cell.lxTimelabel.text = [LXEMMessageHelper LXTimeWithTimeIntervalLongLong:message.timestamp];
           cell.lxNameLabel.text = message.from;
           cell.lxMessageLabel.text = [LXEMMessageHelper lxparseEMMessage:message];
        return cell;
    }
    
}

- (IBAction)sendMessageBtn:(id)sender {
    
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:self.messageTF.text];
    // 获取当前登录的环信id
    NSString *from = [[EMClient sharedClient] currentUsername];

    //生成Message
    EMMessage *message = [[EMMessage alloc] initWithConversationID:self.conversationId from:from to:self.conversationId body:body ext:nil];
    message.chatType = EMChatTypeChat;// 设置为单聊消息
    
    KWeakSelf
    //调用示例:
    [[EMClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
        NSLog(@"附件上传的进度 --- %d", progress);
    } completion:^(EMMessage *message, EMError *error) {
        if (!error) {
            [weakSelf getHistoryMessageData];
            NSLog(@"发送消息成功");
            weakSelf.messageTF.text = @"";
            //会话列表同时跟新
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"xuan1" object:nil userInfo:nil];
        } else {
            NSLog(@"发送消息失败的原因 --- %@", error.errorDescription);
        }
    }];
    
    
}

- (NSMutableArray<EMMessage *> *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (void)messagesDidReceive:(NSArray *)aMessages{
    [self getHistoryMessageData];
}

@end
