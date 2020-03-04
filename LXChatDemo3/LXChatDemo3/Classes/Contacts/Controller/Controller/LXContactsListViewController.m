//
//  LXContactsListViewController.m
//  LXChatDemo3
//
//  Created by Su on 2020/3/3.
//  Copyright © 2020 com.lxiOS. All rights reserved.
//

#import "LXContactsListViewController.h"
#import "LXAddNewContactsTableViewCell.h"
#import "LXAddNewContactsViewController.h"
#import "LXChatSingleViewController.h"

#define KLXAddNewContactsTableViewCell @"LXAddNewContactsTableViewCell"

@interface LXContactsListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tb;
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation LXContactsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tb.dataSource = self;
    self.tb.delegate = self;
    [self.tb registerClass:[UITableViewCell class] forCellReuseIdentifier:@"test"];
    [self.tb registerNib:[UINib nibWithNibName:KLXAddNewContactsTableViewCell bundle:nil] forCellReuseIdentifier:KLXAddNewContactsTableViewCell];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self getContactsData];
}

- (void)getContactsData{
    KWeakSelf
    [[EMClient sharedClient].contactManager getContactsFromServerWithCompletion:^(NSArray *aList, EMError *aError) {
        if (!aError) {
            NSLog(@"获取所有好友成功 -- %@",aList);
            [weakSelf.dataArr removeAllObjects];
            [weakSelf.dataArr addObjectsFromArray:aList];
            [weakSelf.tb reloadData];
        } else {
            NSLog(@"获取所有好友失败的原因 --- %@", aError.errorDescription);
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = [[EMClient sharedClient].chatManager getAllConversations];
    return self.dataArr.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        //add friends
        LXAddNewContactsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KLXAddNewContactsTableViewCell forIndexPath:indexPath];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"test" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArr[indexPath.row-1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        LXAddNewContactsViewController *vc =  [LXAddNewContactsViewController  new];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        LXChatSingleViewController *vc = [LXChatSingleViewController new];
        vc.conversationId = self.dataArr[indexPath.row-1];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}



@end
