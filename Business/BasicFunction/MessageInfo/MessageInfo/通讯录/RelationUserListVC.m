//
//  RelationUserListVC.m
//  Fans
//
//  Created by ssssssss on 2020/12/8.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "RelationUserListVC.h"
#import <LibProjBase/LibProjBase.h>
#import <LibProjBase/RouteManager.h>
#import <LibProjView/EmptyView.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <MJRefresh/MJRefresh.h>
#import <LibProjModel/HttpApiChatMsgController.h>
#import <LibProjView/CheckRoomPermissions.h>
#import "MineRelationItemCell.h"
 
@interface RelationUserListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *allMuArray;
@property (nonatomic, weak)EmptyView *emptyV;

@end

@implementation RelationUserListVC

- (NSMutableArray *)allMuArray{
    if (!_allMuArray) {
        _allMuArray = [NSMutableArray array];
    }
    return _allMuArray;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight)];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[MineRelationItemCell class] forCellReuseIdentifier:@"MIneRelationItemCellID"];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.navTitle;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    kWeakSelf(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadUserList:YES];
    }];
    /*
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself loadUserList:NO];
    }];
    self.tableView.mj_footer.ignoredScrollViewContentInsetBottom = kISiPhoneXX ? 34 : 0;
    */
    
    EmptyView *empty = [[EmptyView alloc] init];
    empty.titleL.text = kLocalizationMsg(@"暂无数据");
    empty.detailL.text = kLocalizationMsg(@"互动会让更多的人看到你～");
    [empty showInView:self.view];
    _emptyV = empty;
    
    [self loadUserList:YES];
}

//谁看过我
- (void)loadUserList:(BOOL)isRefresh{
    kWeakSelf(self);
    [HttpApiChatMsgController getAppBookShowInfoList:self.showType callback:^(int code, NSString *strMsg, NSArray<AppBookShowInfoVOModel *> *arr) {
        if (code == 1) {
            [weakself.allMuArray removeAllObjects];
            [weakself.allMuArray addObjectsFromArray:arr];
            [weakself.tableView reloadData];
            [weakself.tableView.mj_footer endRefreshing];
            [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
            [weakself.tableView.mj_footer endRefreshing];
        }
        weakself.emptyV.hidden = weakself.allMuArray.count;
    }];
     
}
#pragma mark - tablew
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allMuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineRelationItemCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell  = [[MineRelationItemCell alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 70) indexPath:indexPath type:self.showType];
    }
    AppBookShowInfoVOModel *cellmodel;
    if (indexPath.row < self.allMuArray.count) {
        cellmodel = self.allMuArray[indexPath.row];
    }
    cell.model = cellmodel;
    kWeakSelf(self);
    cell.callBack = ^(int type, BOOL flag, AppBookShowInfoVOModel * _Nonnull model) {
        if (model.userOrGroupId > 0) {
            if (type == 0) {
                if (weakself.showType == 5) {//群组粉丝团
                    NSString *nameStr = [NSString stringWithFormat:@"%@",model.showName];
                    [RouteManager routeForName:RN_Message_ConversationChatVC currentC:self parameters:@{@"chatType":@"3",@"msgSendId":@(model.userOrGroupId),@"navTitle":nameStr}];
                }else{//进入个人中心
                    [RouteManager routeForName:RN_user_userInfoVC  currentC:self parameters:@{@"id":@(model.userOrGroupId)}];
                }
            }else if(type == 1){//置顶如否
                [weakself relationTop:model isTop:flag];
            }else if(type == 2){//备注
                [RouteManager routeForName:RN_user_setUserRemark currentC:self parameters:@{@"id":@(model.userOrGroupId), @"remark":model.showName.length > 0?model.showName:@""}];
            }else if(type == 3){//跟随
                [self joinRoomWith:model];
            }
        }else{
            if (self.showType == 5) {
                [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:kLocalizationMsg(@"%@暂没有聊天群"),model.showName]];
            }else{
                [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:kLocalizationMsg(@"%@暂没有这个人哦"),model.showName]];
            }
            
        }
    };
    return cell;
}
#pragma mark - 操作
- (void)joinRoomWith:(AppBookShowInfoVOModel *)model{
    [[CheckRoomPermissions share] joinRoom:model.roomId liveDataType:(int)model.liveType joinRoom:^(AppJoinRoomVOModel * _Nonnull joinModel) {
        LiveRoomListReqParam *req = [[LiveRoomListReqParam alloc] init];
        req.joinPosition = 9;
        [[CheckRoomPermissions share] joinRoomForModel:joinModel currentVC:[ProjConfig currentVC] otherInfo:req];
    } closeRoom:^(AppHomeHallDTOModel * _Nonnull dtoModel) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"该直播间已关闭")];
    } fail:nil];
}
- (void)relationTop:(AppBookShowInfoVOModel *)model isTop:(BOOL)isTop{
    kWeakSelf(self);
    if (isTop) {
        [HttpApiChatMsgController addChatTopRecord:self.showType topType:model.groupType topUGID:0 topUserOrGorupId:model.userOrGroupId callback:^(int code, NSString *strMsg, NSArray<ChatTopRecordVOModel *> *arr) {
            if (code == 1) {
                [weakself loadUserList:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }else{
        [HttpApiChatMsgController delChatTopRecord:(int)model.topId topPosition:self.showType callback:^(int code, NSString *strMsg, NSArray<ChatTopRecordVOModel *> *arr) {
            if (code == 1) {
                [weakself loadUserList:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppBookShowInfoVOModel *model;
    if (indexPath.row < self.allMuArray.count) {
        model = self.allMuArray[indexPath.row];
    }
    if (self.showType == 5) {//群组粉丝团
        NSString *nameStr = [NSString stringWithFormat:@"%@",model.showName];
        [RouteManager routeForName:RN_Message_ConversationChatVC currentC:self parameters:@{@"chatType":@"3",@"msgSendId":@(model.userOrGroupId),@"navTitle":nameStr}];
    }else{//进入个人中心
        [RouteManager routeForName:RN_user_userInfoVC  currentC:self parameters:@{@"id":@(model.userOrGroupId)}];
    }
}


@end
