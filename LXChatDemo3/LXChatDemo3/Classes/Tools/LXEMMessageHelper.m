//
//  LXEMMessageHelper.m
//  LXChatDemo3
//
//  Created by Su on 2020/3/3.
//  Copyright © 2020 com.lxiOS. All rights reserved.
//

#import "LXEMMessageHelper.h"

@implementation LXEMMessageHelper

#pragma mark 时间戳转成时间

+ (NSString *)LXTimeWithTimeIntervalLongLong:(long long)timeL
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    // 毫秒值转化为秒 要除1000
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeL/1000];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)LXTimeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    // 毫秒值转化为秒 要除1000
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString longLongValue]/1000];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

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
