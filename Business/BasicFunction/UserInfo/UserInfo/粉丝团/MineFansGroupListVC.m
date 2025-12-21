//
//  MineFansGroupListVC.m
//  Fans
//
//  Created by ssssssss on 2020/12/8.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "MineFansGroupListVC.h"
#import <LibProjBase/LibProjBase.h>
#import <LibProjBase/RouteManager.h>
#import <LibProjView/EmptyView.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <MJRefresh/MJRefresh.h>
#import <LibProjModel/HttpApiUserController.h>
#import "MineFansGroupItemCell.h"

@interface MineFansGroupListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property(nonatomic,assign)int page;
@property(nonatomic, strong)NSMutableArray *allMuArray;
@property (nonatomic, weak)EmptyView *emptyV;

@end

@implementation MineFansGroupListVC

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
        [_tableView registerClass:[MineFansGroupItemCell class] forCellReuseIdentifier:@"MineFansGroupItemCellID"];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.navTitle;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.page = 0;
    kWeakSelf(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.page = 0;
        [weakself loadUserList:YES];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself loadUserList:NO];
    }];
    self.tableView.mj_footer.ignoredScrollViewContentInsetBottom = kISiPhoneXX ? 34 : 0;
    
    EmptyView *empty = [[EmptyView alloc] init];
    empty.titleL.text = kLocalizationMsg(@"暂无粉丝团");
    empty.detailL.text = kLocalizationMsg(@"互动会让更多的人看到你～");
    [empty showInView:self.view];
    _emptyV = empty;
    
    [self loadUserList:YES];
}

//谁看过我
- (void)loadUserList:(BOOL)isRefresh{
    kWeakSelf(self);
    [HttpApiUserController browseRecord:self.page pageSize:kPageSize callback:^(int code, NSString *strMsg, NSArray<ApiUserBrowseModel *> *arr) {
        if (code == 1) {
            if (weakself.page == 0) {
                [weakself.allMuArray removeAllObjects];
            }
            [weakself.allMuArray addObjectsFromArray:arr];
            ++weakself.page;
            [weakself.tableView reloadData];
            
            [weakself.tableView.mj_header endRefreshing];
            [weakself.tableView.mj_footer endRefreshing];
            
            if (arr.count == 0) {
                [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
            [weakself.tableView.mj_header endRefreshing];
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
//    return self.allMuArray.count;
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineFansGroupItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineFansGroupItemCellID" forIndexPath:indexPath];
    cell.noMoreBtn = YES;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ApiUserAttenModel *model = _allMuArray[indexPath.row];
    [RouteManager routeForName:RN_user_userInfoVC  currentC:self parameters:@{@"id":@(model.uid)}];
}


@end
