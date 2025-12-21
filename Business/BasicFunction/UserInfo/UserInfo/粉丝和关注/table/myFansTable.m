//
//  myFansTable.m
//  Fans
//
//  Created by ssssssss on 2020/12/8.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "myFansTable.h"
#import "AttentOrFansTableViewCell.h"
#import <LibProjBase/LibProjBase.h>
#import <LibProjBase/RouteManager.h>
#import <LibProjView/EmptyView.h>
#import <LibProjView/CheckRoomPermissions.h>
#import <LibProjModel/HttpApiChatMsgController.h>

@interface myFansTable()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);

@property(nonatomic, strong)NSMutableArray *allMuArray;
@property (nonatomic, weak)EmptyView *emptyV;
@property (nonatomic, assign)int type;
@end
@implementation myFansTable
- (NSMutableArray *)allMuArray{
    if (!_allMuArray) {
        _allMuArray = [NSMutableArray array];
    }
    return _allMuArray;
}

- (instancetype)initWithFrame:(CGRect)frame type:(int)type{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    
    self.delegate = self;
    self.dataSource = self;
    kWeakSelf(self);
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadData:YES];
    }];
    /*
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself loadData:NO];
    }];
    self.mj_footer.ignoredScrollViewContentInsetBottom = kISiPhoneXX ? 34 : 0;
    */
    EmptyView *empty = [[EmptyView alloc] init];
    empty.titleL.text = kLocalizationMsg(@"你还没有粉丝");
    [empty showInView:self];
    _emptyV = empty;
    
}
- (void)loadData:(BOOL)isRefresh{
    [self loadFansData];
}
- (void)loadFansData{
    kWeakSelf(self);
    [HttpApiChatMsgController getAppBookShowInfoList:3 callback:^(int code, NSString *strMsg, NSArray<AppBookShowInfoVOModel *> *arr) {
        if (code == 1) {
            [weakself.allMuArray removeAllObjects];
            [weakself.allMuArray addObjectsFromArray:arr];
            [weakself reloadData];
            [weakself.mj_footer endRefreshing];
            [weakself.mj_footer endRefreshingWithNoMoreData];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
            [weakself.mj_footer endRefreshing];
        }
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
    AttentOrFansTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell  = [[AttentOrFansTableViewCell alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 70) indexPath:indexPath type:self.type];
    }
    AppBookShowInfoVOModel *cellmodel;
    if (indexPath.row < _allMuArray.count) {
        cellmodel = _allMuArray[indexPath.row];
    }
    cell.model = cellmodel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    kWeakSelf(self);
    cell.callBack = ^(int type, BOOL flag, AppBookShowInfoVOModel * _Nonnull model) {
        if (model.userOrGroupId > 0) {
            if (type == 0) {//进入个人中心
                [RouteManager routeForName:RN_user_userInfoVC  currentC:weakself.superVc parameters:@{@"id":@(model.userOrGroupId)}];
            }else if(type == 1){//置顶如否
                [weakself relationTop:model isTop:flag];
            }else if(type == 2){//备注
                [RouteManager routeForName:RN_user_setUserRemark currentC:weakself.superVc  parameters:@{@"id":@(model.userOrGroupId),@"remark":model.showName.length > 0?model.showName:@""}];
            }else if(type == 3){//跟随
                [self joinRoomWith:model];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:kLocalizationMsg(@"%@暂没有这个人哦"),model.showName]];
        }
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ApiUserAttenModel *model;
    if (indexPath.row < _allMuArray.count) {
        model = _allMuArray[indexPath.row];
    }
    [RouteManager routeForName:RN_user_userInfoVC  currentC:self.superVc parameters:@{@"id":@(model.uid)}];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *searchV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    searchV.backgroundColor = [UIColor whiteColor];
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 4, kScreenWidth-30, 32)];
    searchBtn.layer.cornerRadius = 15;
    searchBtn.clipsToBounds = YES;
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    searchBtn.backgroundColor = kRGB_COLOR(@"#FAFAFA");
    [searchBtn setTitle:kLocalizationMsg(@" 搜索用户") forState:UIControlStateNormal];
    [searchBtn setTitleColor:kRGB_COLOR(@"#999999") forState:UIControlStateNormal];
    [searchBtn setImage:[UIImage imageNamed:@"HomePgae_search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [searchV addSubview:searchBtn];
    return searchV;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (void)searchBtnClick:(UIButton *)btn{
   // NSLog(@"过滤文字尽情期待搜索"));
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
        [HttpApiChatMsgController addChatTopRecord:3 topType:model.groupType topUGID:0 topUserOrGorupId:model.userOrGroupId callback:^(int code, NSString *strMsg, NSArray<ChatTopRecordVOModel *> *arr) {
            if (code == 1) {
                [weakself loadData:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }else{
        [HttpApiChatMsgController delChatTopRecord:(int)model.topId topPosition:3 callback:^(int code, NSString *strMsg, NSArray<ChatTopRecordVOModel *> *arr) {
            if (code == 1) {
                [weakself loadData:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }
}

#pragma mark - JXPagingViewListViewDelegate
- (void)listDidAppear{
    [self loadData:YES];
}
- (UIScrollView *)listScrollView {
    self.backgroundColor = [UIColor whiteColor];
    return self;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}
- (UIView *)listView {
    return self;
}
@end
