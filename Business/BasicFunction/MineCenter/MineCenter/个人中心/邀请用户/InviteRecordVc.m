//
//  InviteRecordVc.m
//  MineCenter
//
//  Created by ssssssss on 2020/12/10.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "InviteRecordVc.h"
#import "InviteRecordTableViewCell.h"
#import <LibProjModel/HttpApiUserInvitation.h>
#import <LibProjModel/UserInvitationVOModel.h>
#import <LibProjView/EmptyView.h>
#import <LibProjBase/LibProjBase.h>
 
@interface InviteRecordVc ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, assign)int page;
@property (nonatomic, weak)EmptyView *emptyV;
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation InviteRecordVc
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getRecordData:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.page = 0;
    self.navigationItem.title = kLocalizationMsg(@"邀请记录");
    kWeakSelf(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.page = 0;
        [weakself getRecordData:YES];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakself.page ++;
        [weakself getRecordData:NO];
    }];
    [self.view addSubview:self.tableView];
}

- (void)getRecordData:(BOOL)isRefresh{
    kWeakSelf(self);
    [HttpApiUserInvitation userInvitationList:self.page pageSize:kPageSize callback:^(int code, NSString *strMsg, NSArray<UserInvitationVOModel *> *arr) {
        [weakself.tableView.mj_header endRefreshing];
        [weakself.tableView.mj_footer endRefreshing];
        if (code == 1) {
            if (isRefresh) {
                [weakself.dataArray removeAllObjects];
            }
            if (arr.count == 0) {
                [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [weakself.dataArray addObjectsFromArray:arr];
            weakself.emptyV.hidden = weakself.dataArray.count;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself.tableView reloadData];
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}
- (EmptyView *)emptyV{
    if (!_emptyV) {
        EmptyView *emptyView = [[EmptyView alloc] init];
        emptyView.titleL.text = kLocalizationMsg(@"～暂无邀请记录～");
        emptyView.detailL.text  = kLocalizationMsg(@"赶紧去邀请好友试试吧");
        [emptyView showInView:self.view];
        _emptyV = emptyView;
    }
    return _emptyV;
}
#pragma mark - tableview deleagte datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InviteRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InviteRecordTableViewCellID" forIndexPath:indexPath];
   if (cell == nil) {
       cell = [[InviteRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InviteRecordTableViewCellID"];
   }
    UserInvitationVOModel *model;
    if (indexPath.row < self.dataArray.count) {
        model = self.dataArray[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

#pragma mark - lazy
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[InviteRecordTableViewCell class] forCellReuseIdentifier:@"InviteRecordTableViewCellID"];
    }
    return _tableView;
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
