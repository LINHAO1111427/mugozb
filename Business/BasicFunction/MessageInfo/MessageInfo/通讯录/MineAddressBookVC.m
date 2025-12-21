//
//  MineAddressBookVC.m
//  MessageInfo
//
//  Created by shirley on 2022/2/10.
//

#import "MineAddressBookVC.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <MJRefresh/MJRefresh.h>
#import "MineRelationItemCell.h"

#import <LibProjModel/HttpApiChatMsgController.h>
#import <LibProjView/CheckRoomPermissions.h>
#import <LibProjView/EmptyView.h>
#import "RelationUserListVC.h"
#import "JXCategoryTitleView.h"
#import "JXCategoryIndicatorBackgroundView.h"

@interface MineAddressBookVC ()<UITableViewDelegate, UITableViewDataSource, JXCategoryViewDelegate>

@property (nonatomic, weak) UITableView *tableV;

@property (nonatomic, strong) NSMutableArray *allMuArray;

@property (nonatomic, copy) NSArray *funcArr;

@property (nonatomic, weak)UILabel *muyouL; ///密友
@property (nonatomic, weak)UILabel *beizhuL; ///备注
@property (nonatomic, weak)UILabel *fensiL; ///粉丝
@property (nonatomic, weak)UILabel *qunzuL; ///群组
@property (nonatomic, weak)UILabel *guanzhuL; ///关注

@property (nonatomic, assign)NSInteger selIndex; /// 我的关注选择第几个
@property (nonatomic, weak)EmptyView *emptyV;
@end

@implementation MineAddressBookVC

- (NSMutableArray *)allMuArray{
    if (!_allMuArray) {
        _allMuArray = [[NSMutableArray alloc] init];
    }
    return _allMuArray;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getShowData];
    [self loadAttention:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableHeaderV];
    
    EmptyView *empty = [[EmptyView alloc] init];
    empty.titleL.text = kLocalizationMsg(@"你还相关好友喔");
    [empty showInView:self.tableV];
    _emptyV = empty;
}
#pragma mark - 获取数据
//顶部数据
- (void)getShowData{
    kWeakSelf(self);
    [HttpApiChatMsgController getAddressBookNumber:^(int code, NSString *strMsg, AppAddressBookNumberVOModel *model) {
        if (code == 1) {
            weakself.muyouL.text = [NSString stringWithFormat:@"%d",model.chummyNum];
            weakself.beizhuL.text = [NSString stringWithFormat:@"%d",model.remarkNum];
            weakself.fensiL.text = [NSString stringWithFormat:@"%d",model.fansNum];
            weakself.qunzuL.text = [NSString stringWithFormat:@"%d",model.groupNum];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}
 

//关注列表
- (void)loadAttention:(BOOL)isRefresh{
    kWeakSelf(self);
    [HttpApiChatMsgController getAppBookShowInfoList:self.selIndex==0?4:1 callback:^(int code, NSString *strMsg, NSArray<AppBookShowInfoVOModel *> *arr) {
        if (code == 1) {
            [weakself.allMuArray removeAllObjects];
            [weakself.allMuArray addObjectsFromArray:arr];
            [weakself.tableV reloadData];
            [weakself.tableV.mj_footer endRefreshing];
            [weakself.tableV.mj_footer endRefreshingWithNoMoreData];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
            [weakself.tableV.mj_footer endRefreshing];
        }
        weakself.emptyV.hidden = weakself.allMuArray.count;
    }];
}

- (void)funcBtnClick:(UIButton *)btn{
    NSInteger tag = btn.tag-9960;
    UILabel *titleL = (UILabel *)[btn viewWithTag:btn.tag+100];
    NSString *navTitle = titleL.text;
    [RouteManager routeForName:RN_User_UserRelationList currentC:self parameters:@{@"navTitle":navTitle, @"type":@(tag)}];
}
///1:密友 2:备注 3:粉丝 4:我关注的人 5:我的群组
 

#pragma mark UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allMuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineRelationItemCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell  = [[MineRelationItemCell alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 70) indexPath:indexPath type:self.selIndex];
    }
    AppBookShowInfoVOModel *cellmodel;
    if (indexPath.row < self.allMuArray.count) {
        cellmodel = self.allMuArray[indexPath.row];
    }
    cell.model = cellmodel;
    kWeakSelf(self);
    cell.callBack = ^(int type, BOOL flag, AppBookShowInfoVOModel * _Nonnull model) {
        if (model.userOrGroupId > 0) {
            if (type == 0) {//进入个人中心
                [RouteManager routeForName:RN_user_userInfoVC  currentC:self parameters:@{@"id":@(model.userOrGroupId)}];
            }else if(type == 1){//置顶如否
                [weakself relationTop:model isTop:flag];
            }else if(type == 2){//备注
                [RouteManager routeForName:RN_user_setUserRemark currentC:self parameters:@{@"id":@(model.userOrGroupId),@"remark":model.showName.length > 0?model.showName:@""}];
            }else if(type == 3){//跟随
                [self joinRoomWith:model];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:kLocalizationMsg(@"%@暂没有这个人哦"),model.showName]];
        }
    };
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppBookShowInfoVOModel *model;
    if (indexPath.row < self.allMuArray.count) {
        model = self.allMuArray[indexPath.row];
    }
    [RouteManager routeForName:RN_user_userInfoVC  currentC:self parameters:@{@"id":@(model.userOrGroupId)}];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UIView *)listView{
    return self.view;
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
        [HttpApiChatMsgController addChatTopRecord:self.selIndex==0?4:1 topType:model.groupType topUGID:0 topUserOrGorupId:model.userOrGroupId callback:^(int code, NSString *strMsg, NSArray<ChatTopRecordVOModel *> *arr) {
            if (code == 1) {
                [weakself loadAttention:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }else{
        [HttpApiChatMsgController delChatTopRecord:(int)model.topId topPosition:self.selIndex==0?4:1  callback:^(int code, NSString *strMsg, NSArray<ChatTopRecordVOModel *> *arr) {
            if (code == 1) {
                [weakself loadAttention:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }
}
#pragma mark - ui
- (void)createTableHeaderV{
    
    self.funcArr = @[@{@"name":kLocalizationMsg(@"密友"),@"funcId":@"1"},
                     @{@"name":kLocalizationMsg(@"备注"),@"funcId":@"2"},
                     @{@"name":kLocalizationMsg(@"粉丝"),@"funcId":@"3"},
                     @{@"name":kLocalizationMsg(@"群组"),@"funcId":@"5"},];
    
    CGFloat itemH = 50;
    
    UIView *funcBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.funcArr.count * itemH + 10)];
    funcBgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    for (int i = 0; i< self.funcArr.count; i++) {
        NSDictionary *subDic = self.funcArr[i];
        int funcID = [subDic[@"funcId"] intValue];
        UIButton *btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(0, itemH*i, funcBgView.width, itemH);
        btn.tag = 9960+funcID;
        btn.backgroundColor = [UIColor whiteColor];
        [btn addTarget:self action:@selector(funcBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [funcBgView addSubview:btn];
        
        UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, btn.height)];
        titleL.font = [UIFont systemFontOfSize:14];
        titleL.text = subDic[@"name"];
        titleL.tag = btn.tag + 100;
        titleL.textColor = [UIColor blackColor];
        [btn addSubview:titleL];
        
        UILabel *numL = [[UILabel alloc] initWithFrame:CGRectMake(titleL.maxX+10, 0, btn.width-20-(titleL.maxX+10), btn.height)];
        numL.font = [UIFont systemFontOfSize:14];
        numL.text = @"0";
        numL.textAlignment = NSTextAlignmentRight;
        numL.textColor = [UIColor blackColor];
        [btn addSubview:numL];
        
        switch (funcID) {
            case 1:///密友
                self.muyouL = numL;
                break;
            case 2: ///备注
                self.beizhuL = numL;
                break;
            case 3: ///粉丝
                self.fensiL = numL;
                break;
            case 5: ///群组
                self.qunzuL = numL;
                break;
            default:
                break;
        }
    }
    [self.view addSubview:funcBgView];
    
    UIView *headerBgView = [[UIView alloc] initWithFrame:CGRectMake(0, funcBgView.maxY, kScreenWidth, itemH)];
    [self.view addSubview:headerBgView];
    
   
    JXCategoryTitleView *myCategoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(headerBgView.width-10-120, (headerBgView.height-30)/2.0, 120, 30)];
    myCategoryView.cellSpacing = 0;
    myCategoryView.delegate = self;
    myCategoryView.titles = @[kLocalizationMsg(@"全部"),kLocalizationMsg(@"密友")];
    myCategoryView.layer.cornerRadius = 15;
    myCategoryView.layer.masksToBounds = YES;
    myCategoryView.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2].CGColor;
    myCategoryView.layer.borderWidth = 1.0;
    myCategoryView.titleColor = [UIColor lightGrayColor];
    myCategoryView.titleSelectedColor = [UIColor blackColor];
    myCategoryView.titleLabelMaskEnabled = YES;
    myCategoryView.cellWidth = myCategoryView.width/2.0;
    myCategoryView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
    [headerBgView addSubview:myCategoryView];
    
    JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
    backgroundView.indicatorHeight = 30;
    backgroundView.indicatorWidthIncrement = 0;
    backgroundView.indicatorColor = [UIColor whiteColor];
    myCategoryView.indicators = @[backgroundView];
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, myCategoryView.x-10-10, headerBgView.height)];
    titleL.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    titleL.text = kLocalizationMsg(@"我的关注");
    titleL.textColor = [UIColor blackColor];
    [headerBgView addSubview:titleL];
    _guanzhuL = titleL;
    
    [self.tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(headerBgView.mas_bottom);
    }];
    kWeakSelf(self);
    self.tableV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself loadAttention:NO];
    }];
}
- (UITableView *)tableV{
    if (!_tableV) {
        UITableView *tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        tableV.delegate = self;
        tableV.dataSource = self;
        tableV.showsVerticalScrollIndicator = NO;
        tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableV];
        _tableV = tableV;
    }
    return _tableV;
}



#pragma mark -  JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index{
    self.selIndex = index;
    [self loadAttention:YES];
}

@end
