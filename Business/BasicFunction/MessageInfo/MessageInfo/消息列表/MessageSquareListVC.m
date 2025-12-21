//
//  MessageSquareListVC.m
//  Message
//
//  Created by klc_sl on 2021/8/7.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "MessageSquareListVC.h"
#import "MsgSquareChatListCell.h"
#import <LibProjModel/HttpApiChatFamilyController.h>
#import <MJRefresh/MJRefresh.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/EmptyView.h>

@interface MessageSquareListVC ()

@property (nonatomic, copy)NSArray *chatList;
@property (nonatomic, weak)EmptyView *emptyV;

@end

@implementation MessageSquareListVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = kLocalizationMsg(@"聊天广场");
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MsgSquareChatListCell class] forCellReuseIdentifier:@"MsgSquareChatListCellID"];

    kWeakSelf(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself getSquareInfo];
    }];
    
    EmptyView *empty = [[EmptyView alloc] initWithFrame:self.view.bounds];
    empty.titleL.text = kLocalizationMsg(@"广场还没有数据呦~");
    empty.hidden = YES;
    [self.tableView addSubview:empty];
    _emptyV = empty;
    [empty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 200));
        make.center.equalTo(self.view);
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getSquareInfo];
}

- (void)getSquareInfo{
    kWeakSelf(self);
    [HttpApiChatFamilyController getAppHomeChatPlazaVO:^(int code, NSString *strMsg, NSArray<AppHomeChatPlazaVOModel *> *arr) {
        [weakself.tableView.mj_header endRefreshing];
        if (code == 1) {
            weakself.chatList = arr;
            [weakself.tableView reloadData];
            if (arr.count == 0) {
                weakself.emptyV.titleL.text = kLocalizationMsg(@"广场无内容");
            }
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
            weakself.emptyV.titleL.text = strMsg;
        }
        weakself.emptyV.hidden = self.chatList.count;
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chatList.count;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     MsgSquareChatListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MsgSquareChatListCellID" forIndexPath:indexPath];
     [cell showSquareInfo:self.chatList[indexPath.row]];
     return cell;
 }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.chatList.count > indexPath.row) {
        AppHomeChatPlazaVOModel *squareInfo = self.chatList[indexPath.row];
        [RouteManager routeForName:RN_Message_ConversationChatVC currentC:self parameters:@{@"chatType":@"2",@"msgSendId":@(squareInfo.familyId)}];
    }

}

@end
