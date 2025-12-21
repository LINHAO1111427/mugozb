//
//  beGuardVc.m
//  MineCenter
//
//  Created by ssssssss on 2020/12/15.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "guardListVc.h"
#import "guardPrivilegeVc.h"
#import "guardTableViewCell.h"

#import <LibProjModel/HttpApiUserController.h>
#import <LibProjModel/GuardUserVOModel.h>
#import <LibProjModel/HttpApiGuard.h>
 
@interface guardListVc ()<UITableViewDelegate,UITableViewDataSource,guardTableViewCellDelegate>
@property (nonatomic, assign)int type;
@property (nonatomic, assign)int64_t userId;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, assign)EmptyView *emptyV;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, assign)int page;
@end

@implementation guardListVc
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat titleH = kNavBarHeight-kStatusBarHeight-10;
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-titleH-kNavBarHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (instancetype)initWithType:(int)type userId:(int64_t)user_id{
    self = [super init];
    if (self) {
        self.userId = user_id;
        self.type = type;
    }
    return self;
}
 
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 0;
    CGFloat pt = kScreenWidth/375.0;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    EmptyView *emptyV = [[EmptyView alloc] initWithFrame:self.view.bounds];
    if (self.type == 1) {
        emptyV.titleL.text = kLocalizationMsg(@"没有人守护TA");
    }else{
        emptyV.titleL.text = kLocalizationMsg(@"TA没有守护任何人");
    }
    [emptyV showInView:self.tableView];
    self.emptyV = emptyV;
    [self.tableView registerClass:[guardTableViewCell class] forCellReuseIdentifier:@"guardTableViewCellId"];
    
    kWeakSelf(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.page = 0;
        [weakself getGuardData:YES];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakself.page ++;
        [weakself getGuardData:NO];
    }];
    self.tableView.mj_footer.ignoredScrollViewContentInsetBottom = kSafeAreaBottom;
    
    if ([[ProjConfig shareInstence].baseConfig isShowGuardPrivilege]) {
        UIButton *tableHeader = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 68*pt)];
        [tableHeader addTarget:self action:@selector(hederBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [tableHeader setBackgroundImage:[UIImage imageNamed:@"icon_mine_guard_header"] forState:UIControlStateNormal];
        self.tableView.tableHeaderView = tableHeader;
    }

}
- (void)getGuardData:(BOOL)isRefresh{
    kWeakSelf(self);
    [HttpApiGuard getMyGuardList:self.page pageSize:kPageSize queryType:0 type:self.type == 0?1:2 userId:self.userId callback:^(int code, NSString *strMsg, NSArray<GuardUserVOModel *> *arr) {
        [weakself.tableView.mj_header endRefreshing];
        [weakself.tableView.mj_footer endRefreshing];
        if (code == 1) {
            if (isRefresh) {
                [weakself.dataArray removeAllObjects];
            }
            if (arr.count > 0) {
                [weakself.dataArray addObjectsFromArray:arr];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakself.tableView reloadData];
                });
            }
            if (arr.count == 0) {
                [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            weakself.emptyV.hidden = weakself.dataArray.count;
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
        
    }];
          
}
- (void)hederBtnClick:(UIButton *)btn{
    [RouteManager routeForName:RN_center_guardPrivilege currentC:self];
}
#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    guardTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[guardTableViewCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"guardTableViewCellId"];
    }
    GuardUserVOModel *model;
    if (indexPath.row < self.dataArray.count) {
        model = self.dataArray[indexPath.row];
    }
    cell.deleagte = self;
    cell.type = self.type;
    cell.guardModel = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat pt = kScreenWidth/375.0;
    return 150*pt;
}
#pragma mark - guardTableViewCellDelegate 
- (void)guardTableViewCellRenewBtnClickWith:(GuardUserVOModel *)model{
    [RouteManager routeForName:RN_center_buyGuard currentC:self  parameters:@{@"userId":@(model.anchorId)}];
}
#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}
- (void)listWillAppear{
    [self getGuardData:YES];
}
- (void)listWillDisappear{
    
}
@end
