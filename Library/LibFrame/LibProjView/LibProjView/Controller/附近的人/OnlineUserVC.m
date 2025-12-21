//
//  OnlineUserVC.m
//  MessageCenter
//
//  Created by klc_tqd on 2020/6/1.
//  Copyright © 2020 . All rights reserved.
//

#import "OnlineUserVC.h"
#import <LibProjModel/HttpApiAnchorController.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/KLCUserInfo.h>

#import <LibTools/LibTools.h>
#import <MJRefresh/MJRefresh.h>
#import <CoreLocation/CLLocationManager.h>
#import <LibProjModel/HttpApiUserController.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjBase/KLCTabBarControl.h>

#import "OnlineUserCell.h"
#import <LibProjView/O2OCallTypeSelectedView.h>
#import "NearbySiftHeaderView.h"
#import <LibProjView/CitySelecteView.h>


#import <LibProjView/CheckRoomPermissions.h>
#import <LibProjView/EmptyView.h>

#import "OnlineUserVIPHintView.h"

@interface OnlineUserVC ()<UITableViewDelegate,UITableViewDataSource,OnlineUserCellDelegate,NearbySiftHeaderViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *dataArr;

@property (nonatomic, weak)EmptyView *emptyV;

@property (nonatomic, strong)NearbySiftHeaderView *headerView;

@property(nonatomic, strong)CitySelecteView *cityView;

@property (nonatomic, copy)NSString *city;

@property (nonatomic, assign)int gender;

@property (nonatomic, weak)OnlineUserVIPHintView *vipHintView;

@end

@implementation OnlineUserVC

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"updateUserSimpleInfo" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getLocationAlways];
    self.gender = -1;
    self.city = @"";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buyVipHandle:) name:@"updateUserSimpleInfo" object:nil];
    self.view.backgroundColor = [ProjConfig projBgColor];
    [self creatSubView];
    
}
- (void)getLocationAlways{
    //定位权限
    BOOL locationAlways = NO;
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)) {
        locationAlways = YES;
    }
    
    CGFloat locationTipH = locationAlways?0:30;
    self.headerView.locationAlways = locationAlways;
    self.headerView.frame = CGRectMake(0, 0, kScreenWidth, 50+locationTipH);
    self.tableView.frame = CGRectMake(0, 50+locationTipH, kScreenWidth, kScreenHeight - kNavBarHeight - kTabBarHeight-50-locationTipH);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadMessageDyData:YES];
    
    [self checkUserVip];
}

///检测用户是否是VIP
- (void)checkUserVip{
    
    if ([KLCAppConfig appConfig].nobleShowNearby) {
        if ([KLCUserInfo getNobleGrade] > 0) {
            self.vipHintView.hidden = YES;
        }else{
            kWeakSelf(self);
            [HttpApiUserController getUserInfo:[ProjConfig userId] callback:^(int code, NSString *strMsg, ApiUserInfoModel *model) {
                
                if (code == 1 && model.nobleGrade > 0) {
                    
                    weakself.vipHintView.hidden = YES;
                    
                    ApiUserInfoModel *userInfo = KLCUserInfo.getUserInfo;
                    userInfo.nobleGrade = model.nobleGrade;
                    [KLCUserInfo setUserInfo:userInfo];
                    
                }else{
                    weakself.vipHintView.hidden = NO;
                }
                
            }];
        }
    }
    
}

///通知
- (void)buyVipHandle:(NSNotification *)notify{
    [self checkUserVip];
}

-(void)creatSubView{
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableView];
    
    
    [self.tableView registerClass:[OnlineUserCell class] forCellReuseIdentifier:@"OnlineUserCellIdentifier"];
    kWeakSelf(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself reloadMessageDyData:YES];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself reloadMessageDyData:NO];
    }];
    
    EmptyView *empty = [[EmptyView alloc] init];;
    empty.titleL.text = kLocalizationMsg(@"暂无附近的人~");
    [empty showInView:self.view andFrame:CGRectMake(0,kNavBarHeight+50, self.view.width, self.view.height - kNavBarHeight-kTabBarHeight-50)];
    _emptyV = empty;
}

- (OnlineUserVIPHintView *)vipHintView{
    if (!_vipHintView) {
        OnlineUserVIPHintView *vipHintV = [[OnlineUserVIPHintView alloc] init];
        [self.view addSubview:vipHintV];
        _vipHintView = vipHintV;
        [vipHintV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.tableView);
            make.top.equalTo(self.view);
        }];
    }
    [self.view bringSubviewToFront:_vipHintView];
    return _vipHintView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ApiUsersLineModel *model = self.dataArr[indexPath.row];
    return [OnlineUserCell getOnlineUserCellHeight:model];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OnlineUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OnlineUserCellIdentifier" forIndexPath:indexPath];
    cell.selfVc = self;
    cell.delegate = self;
    cell.model = self.dataArr[indexPath.row];
    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ApiUsersLineModel  *model  = self.dataArr[indexPath.row];
    [RouteManager routeForName:RN_user_userInfoVC currentC:self parameters:@{@"id":@(model.uid)}];
}

//懒加载
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, kScreenHeight - kNavBarHeight - kTabBarHeight-50) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (NearbySiftHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[NearbySiftHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,50)];
        _headerView.backgroundColor = [UIColor whiteColor];
        _headerView.superVc = self;
        _headerView.delegate = self;
    }
    return _headerView;
}


-(void)reloadMessageDyData:(BOOL)refresh{
    kWeakSelf(self);
    int pageSize = kPageSize;
    int pageIndex = refresh?0:(int)self.dataArr.count/pageSize  + (self.dataArr.count%pageSize?1:0);
    [HttpApiAnchorController getLineUser:self.city pageIndex:pageIndex pageSize:pageSize sex:self.gender status:-1 tabIds:@"" callback:^(int code, NSString *strMsg, NSArray<ApiUsersLineModel *> *arr) {
        if (code == 1) {
            [weakself.tableView.mj_header endRefreshing];
            [weakself.tableView.mj_footer endRefreshing];
            if (refresh) {
                [weakself.dataArr removeAllObjects];
            }
            if (arr.count > 0) {
                [weakself.dataArr addObjectsFromArray:arr];
            }else{
                [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [weakself.tableView reloadData];
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationUpdateStatus object:@{}];
        }else{
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
        weakself.emptyV.hidden = weakself.dataArr.count;
    }];
}

-(void)clickHeaderImageModel:(ApiUsersLineModel *)model{
    
    [RouteManager routeForName:RN_user_userInfoVC currentC:self parameters:@{@"id":@(model.uid)}];
}

-(void)clickBtnTag:(NSInteger)tag andModel:(ApiUsersLineModel *)model{
   // NSLog(@"过滤文字tag==%ld"),(long)tag);
    
    if (![ProjConfig isUserLogin]) {
        [RouteManager routeForName:RN_login_ShowLoginVC currentC:self];
        return;
    }
    
    switch (tag) {
        case 0:{
            //私聊
            [RouteManager routeForName:RN_Message_ConversationChatVC currentC:[ProjConfig currentVC] parameters:@{@"chatType":@"0",@"msgSendId":@(model.uid)}];
        }break;
        case 1:{
            switch ([[ProjConfig shareInstence].baseConfig getOtoType]) {
                case 1:
                { [self O2OConnecte:YES andModel:model]; } break;
                case 2:
                { [self O2OConnecte:NO andModel:model]; } break;
                default:
                {
                    kWeakSelf(self);
                    O2OCallTypeParam *param = [[O2OCallTypeParam alloc] init];
                    param.username = model.userName;
                    param.voiceCoin = model.voiceCoin;
                    param.videoCoin = model.videoCoin;
                    param.callUserRole = model.role;
                    [O2OCallTypeSelectedView showCallTypeViewWith:param callBack:^(NSInteger type, O2OCallTypeSelectedView * _Nonnull callView) {
                        [callView removeFromSuperview];
                        callView = nil;
                        if (type == 1) {// 语音
                            [weakself O2OConnecte:NO andModel:model];
                        }else if(type == 2){//视频
                            [weakself O2OConnecte:YES andModel:model];
                        }
                    }];
                }
                    break;
            }
            
        }
            break;
        case 2:
            //1v1 语音
            //            [self O2OConnecte:NO andModel:model];
            break;
        case 3:
            //直播房间
            [self checkRoom:model];
            break;
        default:
            break;
    }
}


- (void)O2OConnecte:(BOOL)isVideo andModel:(ApiUsersLineModel *)model{
    NSMutableDictionary *muDict = [[NSMutableDictionary alloc] initWithCapacity:1];
    [muDict setObject:@(model.uid) forKey:@"userId"];
    if (isVideo) {
        [muDict setObject:@(YES) forKey:@"isVideo"];
    } else {
        [muDict setObject:@(NO) forKey:@"isVideo"];
    }
    [RouteManager routeForName:RN_live_LaunchOneLive currentC:self parameters:muDict];
}


-(void)checkRoom:(ApiUsersLineModel *)model{
    kWeakSelf(self);
    [[CheckRoomPermissions share] joinRoom:model.roomId liveDataType:model.liveType joinRoom:^(AppJoinRoomVOModel * _Nonnull joinModel) {
        LiveRoomListReqParam *req = [[LiveRoomListReqParam alloc] init];
        req.joinPosition = 9;
        [[CheckRoomPermissions share] joinRoomForModel:joinModel currentVC:weakself otherInfo:req];
    } closeRoom:^(AppHomeHallDTOModel * _Nonnull dtoModel) {
        [[CheckRoomPermissions share] showDetail:dtoModel currentVC:weakself];
    } fail:nil];
}


- (UIView *)listView {
    return self.view;
}
- (void)listWillAppear{
    [self getLocationAlways];
}

#pragma mark - NearbySiftHeaderViewDelegate
- (void)NearbySiftHeaderViewCitySelected:(NearbySiftHeaderView *)headerV{
    if (!self.cityView) {
        self.cityView = [[CitySelecteView alloc]init];
    }
    kWeakSelf(self);
    [self.cityView showInView:[UIApplication sharedApplication].keyWindow withType:CitySelecteTypeNearby callBack:^(BOOL cancel, NSString * _Nonnull city, NSString * _Nonnull gender, NSArray * _Nonnull tags) {
        if (!cancel) {
            weakself.city = city.length > 0? city:@"";
            [weakself  reloadMessageDyData:YES];
        }
        if (weakself.city.length > 0) {
            [headerV reloadShowTitleWith:city gender:weakself.gender];
        }else{
            [headerV reloadShowTitleWith:kLocalizationMsg(@"全部") gender:weakself.gender];
        }
        weakself.cityView = nil;
    }];
}

- (void)NearbySiftHeaderViewGenderSelected:(NearbySiftHeaderView *)headerV selectedGender:(int)gender{
    if (gender == 0) {
        self.gender = -1;
    }else{
        self.gender = gender;
    }
    [self reloadMessageDyData:YES];
}


@end
