//
//  LXChatSingleViewController.m
//  LXChatDemo3
//
//  Created by Su on 2020/3/3.
//  Copyright © 2020 com.lxiOS. All rights reserved.
//

#import "LXChatSingleViewController.h"

@interface LXChatSingleViewController ()
@property (weak, nonatomic) IBOutlet UITextField *messageTF;

@end

@implementation LXChatSingleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //新建/获取一个会话    根据 conversationId 创建一个 conversation。
    [[EMClient sharedClient].chatManager getConversation:self.conversationId type:EMConversationTypeChat createIfNotExist:YES];
}

- (IBAction)sendMessageBtn:(id)sender {
    
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:self.messageTF.text];
    // 获取当前登录的环信id
    NSString *from = [[EMClient sharedClient] currentUsername];

    //生成Message
    EMMessage *message = [[EMMessage alloc] initWithConversationID:self.conversationId from:from to:self.conversationId body:body ext:nil];
    message.chatType = EMChatTypeChat;// 设置为单聊消息
    
    
    //调用示例:
    [[EMClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
        NSLog(@"附件上传的进度 --- %d", progress);
    } completion:^(EMMessage *message, EMError *error) {
        if (!error) {
            NSLog(@"发送消息成功");
        } else {
            NSLog(@"发送消息失败的原因 --- %@", error.errorDescription);
        }
    }];
    
    
}


@end
