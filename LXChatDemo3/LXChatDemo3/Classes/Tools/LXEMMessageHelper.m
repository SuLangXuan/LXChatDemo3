//
//  LXEMMessageHelper.m
//  LXChatDemo3
//
//  Created by Su on 2020/3/3.
//  Copyright © 2020 com.lxiOS. All rights reserved.
//

#import "LXEMMessageHelper.h"

@implementation LXEMMessageHelper



+ (NSString *)lxparseEMMessage:(EMMessage *)message{
    EMMessageBody *msgBody = message.body;
    switch (msgBody.type) {
        case EMMessageBodyTypeText:
        {
            // 收到的文字消息
            EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
            NSString *txt = textBody.text;
            NSLog(@"收到的文字是 txt -- %@",txt);
            return txt;
        }
        break;
        default:
            return @"";
        break;
    }
    
}

//**************** 单例 start **********************
static id instance = nil;
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    //NSLog(@"%ld", onceToken);
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    
    return instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return instance;
}

//****************  单例 end **********************

@end
