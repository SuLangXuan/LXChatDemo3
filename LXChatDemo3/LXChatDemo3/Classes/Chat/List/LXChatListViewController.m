//
//  LXChatListViewController.m
//  LXChatDemo3
//
//  Created by Su on 2020/3/2.
//  Copyright © 2020 com.lxiOS. All rights reserved.
//

#import "LXChatListViewController.h"
#import "LXChatListConversationsTableViewCell.h"
#import "LXChatSingleViewController.h"

#define KLXChatListConversationsTableViewCell @"LXChatListConversationsTableViewCell"

@interface LXChatListViewController ()<UITableViewDelegate,UITableViewDataSource,EMChatManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tb;

@end

@implementation LXChatListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tb.delegate = self;
    self.tb.dataSource = self;
    [self.tb registerClass:[UITableViewCell class] forCellReuseIdentifier:@"test"];
    [self.tb registerNib:[UINib nibWithNibName:KLXChatListConversationsTableViewCell bundle:nil] forCellReuseIdentifier:KLXChatListConversationsTableViewCell];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = [[EMClient sharedClient].chatManager getAllConversations];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr = [[EMClient sharedClient].chatManager getAllConversations];
    EMConversation *conversation = arr[indexPath.row];
    int num = [conversation unreadMessagesCount];
    LXChatListConversationsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KLXChatListConversationsTableViewCell forIndexPath:indexPath];
    cell.lxnameLabel.text = conversation.conversationId;
    cell.lxUnReadCountLabel.text = [NSString stringWithFormat:@"%d",num];
    [conversation loadMessagesStartFromId:nil count:1 searchDirection:EMMessageSearchDirectionUp completion:^(NSArray *aMessages, EMError *aError) {
        if (!aError) {
            // aMessage数组中存的是EMMessage
            NSLog(@"从数据库获取消息成功 --- %@", aMessages);
            for (EMMessage *message in aMessages) {
                cell.lxmessageLabel.text = [LXEMMessageHelper lxparseEMMessage:message];
            }
        } else {
            NSLog(@"删除一组会话失败的原因 --- %@", aError.errorDescription);
        }
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LXChatSingleViewController *vc = [LXChatSingleViewController new];
    NSArray *arr = [[EMClient sharedClient].chatManager getAllConversations];
    vc.conversationId = arr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


/*!
@method
@brief 接收到一条及以上非cmd消息
*/
- (void)messagesDidReceive:(NSArray *)aMessages{
    [self.tb reloadData];
}

@end
