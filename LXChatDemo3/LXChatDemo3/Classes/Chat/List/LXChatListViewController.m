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
@property (nonatomic,strong) NSMutableArray<EMConversation *> *conversationArr;
@end

@implementation LXChatListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tb.delegate = self;
    self.tb.dataSource = self;
    [self.tb registerClass:[UITableViewCell class] forCellReuseIdentifier:@"test"];
    [self.tb registerNib:[UINib nibWithNibName:KLXChatListConversationsTableViewCell bundle:nil] forCellReuseIdentifier:KLXChatListConversationsTableViewCell];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    [self getSortAfterConversationListArr];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //    [self.tb reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSArray *arr = [[EMClient sharedClient].chatManager getAllConversations];
    return self.conversationArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSArray *arr = [[EMClient sharedClient].chatManager getAllConversations];
    EMConversation *conversation = self.conversationArr[indexPath.row];
    int num = [conversation unreadMessagesCount];
    LXChatListConversationsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KLXChatListConversationsTableViewCell forIndexPath:indexPath];
    cell.lxnameLabel.text = conversation.conversationId;
    cell.lxUnReadCountLabel.text = [NSString stringWithFormat:@"%d",num];
    cell.lxmessageLabel.text = [LXEMMessageHelper lxparseEMMessage:conversation.latestMessage];
    cell.lxTimeLabel.text = [LXEMMessageHelper LXTimeWithTimeIntervalString:[NSString stringWithFormat:@"%lld",conversation.latestMessage.timestamp]];
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LXChatSingleViewController *vc = [LXChatSingleViewController new];
    EMConversation *conversation = self.conversationArr[indexPath.row];
    vc.conversationId = conversation.conversationId;
    [self.navigationController pushViewController:vc animated:YES];
}

/*!
 @method
 @brief 接收到一条及以上非cmd消息
 */
- (void)messagesDidReceive:(NSArray *)aMessages{
    [self getSortAfterConversationListArr];
    
    
}


///获取按时间排序的数组
- (void)getSortAfterConversationListArr{
    NSMutableArray<EMConversation *> *arr = [NSMutableArray arrayWithArray:[[EMClient sharedClient].chatManager getAllConversations]];
    
//    for (EMConversation *con in arr) {
//        NSLog(@"%@",con.conversationId);
//    }
    
    
    //时间戳越大的时间越新，距离1972 越远
    EMConversation *tempConversion  = [EMConversation new];
    for (int i = 0; i<arr.count-1; i++) {
        for (int j = 0; j<arr.count-1-i; j++) {
            if (arr[j].latestMessage.timestamp<arr[j+1].latestMessage.timestamp) {
                tempConversion = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = tempConversion;
            }
        }
    }
    
    [self.conversationArr removeAllObjects];
    [self.conversationArr addObjectsFromArray:arr];
    
//    for (EMConversation *con in arr) {
//        NSLog(@"%@",con.conversationId);
//    }
    
    [self.tb reloadData];
    
}

- (NSMutableArray<EMConversation *> *)conversationArr{
    if (_conversationArr == nil) {
        _conversationArr = [NSMutableArray array];
    }
    return _conversationArr;
}


@end
