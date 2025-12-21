//
//  FamilyIncomeRankVC.m
//  Ranking
//
//  Created by ssssssss on 2020/12/24.
//  Copyright © 2020 KLC. All rights reserved.
// 收益榜

#import "FamilyIncomeRankVC.h"

#import "RankTable.h"
#import "TotalUserRankCell.h"
#import "TotalRankHeader.h"

#import <LibTools/LibTools.h>
#import <MJRefresh/MJRefresh.h>
#import <LibProjBase/LibProjBase.h>
 
#import <LibProjModel/HttpApiChatFamilyController.h>
#import <LibProjModel/AppFamilyUserRankVOModel.h>

#import <SDWebImage/SDWebImage.h>

@interface FamilyIncomeRankVC ()<UITableViewDelegate,UITableViewDataSource,TotalRankHeaderDelegate>
@property (nonatomic, strong)RankTable *tableView;
@property (nonatomic, strong)TotalRankHeader *header;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, assign)NSInteger showType;
@end

@implementation FamilyIncomeRankVC
 
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.header];
    [self.view addSubview:self.tableView];

    kWeakSelf(self);
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself loadData:NO];
    }];
    [self.tableView setContentInset:UIEdgeInsetsMake(self.header.height-80, 0, 0, 0)];
}

- (void)loadData:(BOOL)refresh{
    kWeakSelf(self);
    int pageSize = kPageSize;
    int pageIndex = refresh?0:(int)self.dataArray.count/pageSize  + (self.dataArray.count%pageSize?1:0);
    [HttpApiChatFamilyController getAppFamilyUserRankVO:self.familyId pageIndex:pageIndex pageSize:pageSize queryType:2 callback:^(int code, NSString *strMsg, NSArray<AppFamilyUserRankVOModel *> *arr) {
        
        [weakself.tableView.mj_header endRefreshing];
        [weakself.tableView.mj_footer endRefreshing];
        
        if (code == 1) {
            if (refresh) {
                [weakself.dataArray removeAllObjects];
            }
            if (arr.count > 0) {
                [weakself.dataArray addObjectsFromArray:arr];
            }else{
                [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [weakself headerDataUpdate];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakself.tableView.textLayer.hidden = weakself.dataArray.count > 3?YES:NO;
                [weakself.tableView reloadData];
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (void)headerDataUpdate{
    NSMutableArray *arr = [NSMutableArray array];
    NSInteger num  =0;
    if (self.dataArray.count >= 3) {
        num = 3;
    }else{
        num = self.dataArray.count;
    }
    for (int i = 0; i < num; i++) {
        AppFamilyUserRankVOModel *model = self.dataArray[i];
        [arr addObject:model];
    }
    self.header.dataArray = [NSArray arrayWithArray:arr];
}

#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}
- (void)listWillAppear{
    [self loadData:YES ];
}
 
#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArray.count > 3) {
        return self.dataArray.count-3;
    }else{
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TotalUserRankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TotalUserRankCellID" forIndexPath:indexPath];
    AppFamilyUserRankVOModel *model;
    if (indexPath.row+3 < self.dataArray.count) {
        model = self.dataArray[indexPath.row+3];
    }
    if (model) {
        NSString *numS = [NSString stringWithFormat:@"%.0f",model.familyTotalIncome];
        cell.numL.attributedText = [numS attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -3, 15, 15) before:YES];
        [cell updateData:model.userRank avater:model.userAvatar username:model.userName sex:model.sex age:model.age wealthLevel:model.wealthGradeImg nobleLevel:model.nobleGradeImg];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppFamilyUserRankVOModel *model;
    if (indexPath.row+3 < self.dataArray.count) {
        model = self.dataArray[indexPath.row+3];
        [RouteManager routeForName:RN_user_userInfoVC currentC:self parameters:@{@"id":@(model.userId)}];
    }
}
#pragma mark - TotalRankHeaderDelegate
- (void)TotalRankHeader:(TotalRankHeader *)headerV clickIndex:(NSInteger)index {
    if (index < self.dataArray.count) {
        AppFamilyUserRankVOModel *model = self.dataArray[index];
        [RouteManager routeForName:RN_user_userInfoVC currentC:self parameters:@{@"id":@(model.userId)}];
    }
}

- (void)showUserInfo:(id)userInfoM userHeaderView:(nonnull RankUserInfoHeaderView *)headerV {
    if ([userInfoM isKindOfClass:[AppFamilyUserRankVOModel class]]) {
        AppFamilyUserRankVOModel *dtoM = (AppFamilyUserRankVOModel *)userInfoM;
        [headerV.userIconV sd_setImageWithURL:[NSURL URLWithString:dtoM.userAvatar] placeholderImage:[ProjConfig getAppIcon]];
        headerV.userNameL.text = dtoM.userName;
        NSString *numS = [NSString stringWithFormat:@"%.0f",dtoM.familyTotalIncome];
        headerV.coinL.attributedText = [numS attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -3, 15, 15) before:YES];
    }
}


#pragma mark - lazy
- (TotalRankHeader *)header{
    if (!_header) {
        _header = [[TotalRankHeader alloc] init];
        _header.bgImageV.image = [UIImage imageNamed:@"icon_rank_income_header"];
        _header.delegate = self;
    }
    return _header;
}
- (RankTable *)tableView{
    if (!_tableView) {
        _tableView = [[RankTable alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped headerHeight:self.header.height-80];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[TotalUserRankCell class] forCellReuseIdentifier:@"TotalUserRankCellID"];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
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
