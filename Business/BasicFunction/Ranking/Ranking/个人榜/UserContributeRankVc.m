//
//  UserContributeRankVc.m
//  Ranking
//
//  Created by ssssssss on 2020/12/24.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "UserContributeRankVc.h"
#import "UserRankTable.h"
#import "TotalUserRankCell.h"
#import "UserContributeRankHeader.h"

#import <LibTools/LibTools.h>
#import <MJRefresh/MJRefresh.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/RanksDtoModel.h>
#import <LibProjModel/HttpApiAPPFinance.h>

@interface UserContributeRankVc ()<UITableViewDelegate,UITableViewDataSource,UserContributeRankHeaderDelegate>
@property (nonatomic, strong)UserRankTable *tableView;
@property (nonatomic, strong)UserContributeRankHeader *header;
 
@property (nonatomic, copy)NSArray *dataArray;
@end

@implementation UserContributeRankVc
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.header];
    [self.view addSubview:self.tableView];

    RankClearView *tableHeader = [[RankClearView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.header.height-80)];
    self.tableView.tableHeaderView = tableHeader;
//    [self.tableView setContentInset:UIEdgeInsetsMake(self.header.height-80, 0, 0, 0)];
    [self loadData:YES];
}
 
- (void)loadData:(BOOL)refresh {
    kWeakSelf(self);
    [HttpApiAPPFinance contributionList:[ProjConfig userId] findType:3 sex:-1 showId:@"" type:0 callback:^(int code, NSString *strMsg, NSArray<RanksDtoModel *> *arr) {
        if (code == 1) {
            weakself.dataArray = arr;
            [weakself headerDataUpdate];
            [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
            
            weakself.tableView.textLayer.hidden = weakself.dataArray.count > 3?YES:NO;
            [weakself.tableView reloadData];
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
        RanksDtoModel *model = self.dataArray[i];
        [arr addObject:model];
    }
    self.header.dataArray = [NSArray arrayWithArray:arr];
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
    RanksDtoModel *model;
    if (indexPath.row+3 < self.dataArray.count) {
        model = self.dataArray[indexPath.row+3];
    }
    if (model) {
        NSString *numS = [NSString stringWithFormat:@"%.0f",model.delta];
        cell.numL.attributedText = [numS attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -3, 15, 15) before:YES];
        [cell updateData:model.sort avater:model.avatar username:model.username sex:model.sex age:model.age wealthLevel:model.wealthGradeImg nobleLevel:model.nobleGradeImg];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    headerV.backgroundColor = [UIColor clearColor];
    UIView *contentV = [[UIView alloc]initWithFrame:headerV.bounds];
    contentV.backgroundColor = [UIColor whiteColor];
    UIBezierPath*maskPath = [UIBezierPath bezierPathWithRoundedRect:contentV.bounds byRoundingCorners:(UIRectCornerTopRight | UIRectCornerTopLeft) cornerRadii:CGSizeMake(12,12)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = contentV.bounds;
    maskLayer.path = maskPath.CGPath;
    contentV.layer.mask = maskLayer;
    [headerV addSubview:contentV];
    return headerV;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RanksDtoModel *model;
    if (indexPath.row+3 < self.dataArray.count) {
        model = self.dataArray[indexPath.row+3];
        [RouteManager routeForName:RN_user_userInfoVC  currentC:self parameters:@{@"id":@(model.userId)}];
    }
}
#pragma mark - TotalRankHeaderDelegate
- (void)UserContributeRankHeaderBtnClickWith:(NSInteger)index{
    if (index < self.dataArray.count) {
        RanksDtoModel *model = self.dataArray[index];
        [RouteManager routeForName:RN_user_userInfoVC  currentC:self parameters:@{@"id":@(model.userId)}];
    }
}
 
#pragma mark - lazy
- (UserContributeRankHeader *)header{
    if (!_header) {
        _header = [[UserContributeRankHeader alloc]init];
        _header.delegate = self;
    }
    return _header;
}
 
- (UserRankTable *)tableView{
    if (!_tableView) {
        _tableView = [[UserRankTable alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped headerHeight:self.header.height-80];
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

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action{
    [BaseNavBarItem navBarBgClear:self foregroundColor:[UIColor whiteColor]];
    return [[UIBarButtonItem alloc] initWithCustomView:[BaseNavBarItem navBackBtnImage:[UIImage imageNamed:@"main_navbar_back"] target:target action:action]];
}

@end
 
