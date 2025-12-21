//
//  TotalIncomeRankTable.m
//  Ranking
//
//  Created by ssssssss on 2020/12/24.
//  Copyright © 2020 KLC. All rights reserved.
// 收益榜

#import "TotalIncomeRankTable.h"

#import "RankTable.h"
#import "TotalUserRankCell.h"
#import "TotalRankHeader.h"
#import "TotalMyRankView.h"
#import "RankSectionHeader.h"
 
#import <LibTools/LibTools.h>
#import <MJRefresh/MJRefresh.h>
#import <LibProjBase/LibProjBase.h>
 
#import <LibProjModel/HttpApiAPPFinance.h>

#import <LibProjModel/RanksDtoModel.h>
#import <SDWebImage/SDWebImage.h>

@interface TotalIncomeRankTable ()<UITableViewDelegate,UITableViewDataSource,TotalRankHeaderDelegate>
@property (nonatomic, strong)RankTable *tableView;
@property (nonatomic, strong)TotalRankHeader *header;
@property (nonatomic, strong)RankSectionHeader *sectionHeader;
@property (nonatomic, strong)TotalMyRankView *bottomView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, assign)NSInteger showType;
@end

@implementation TotalIncomeRankTable
 
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.header];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    
    [self.tableView setContentInset:UIEdgeInsetsMake(self.header.height-80, 0, 0, 0)];
    
    self.sectionHeader.selectIndex = 0;
    
}

- (void)loadData:(BOOL)refresh isMine:(BOOL)isMine{
    kWeakSelf(self);
    [HttpApiAPPFinance votesList:0 sex:-1 type:(int)self.showType uid:isMine?[ProjConfig userId]:0 callback:^(int code, NSString *strMsg, PageInfo *pageInfo, NSArray<RanksDtoModel *> *arr) {
        if (isMine) {
            if (code == 1) {
                weakself.bottomView.contributeModel = arr.firstObject;
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }else{
            if (code == 1) {
                [weakself.dataArray removeAllObjects];
                [weakself.dataArray addObjectsFromArray:arr];
                [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
                [weakself headerDataUpdate];
                weakself.tableView.textLayer.hidden = weakself.dataArray.count > 3?YES:NO;
                [weakself.tableView reloadData];
                [weakself loadData:YES isMine:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
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

#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}
- (void)listWillAppear{
    [self loadData:YES isMine:NO];
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
    return 60;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.sectionHeader;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RanksDtoModel *model;
    if (indexPath.row+3 < self.dataArray.count) {
        model = self.dataArray[indexPath.row+3];
        [RouteManager routeForName:RN_user_userInfoVC  currentC:self parameters:@{@"id":@(model.userId)}];
    }
}
#pragma mark - TotalRankHeaderDelegate
- (void)TotalRankHeader:(TotalRankHeader *)headerV clickIndex:(NSInteger)index {
    if (index < self.dataArray.count) {
        RanksDtoModel *model = self.dataArray[index];
        [RouteManager routeForName:RN_user_userInfoVC currentC:self parameters:@{@"id":@(model.userId)}];
    }
}

- (void)showUserInfo:(id)userInfoM userHeaderView:(nonnull RankUserInfoHeaderView *)headerV {
    if ([userInfoM isKindOfClass:[RanksDtoModel class]]) {
        RanksDtoModel *dtoM = (RanksDtoModel *)userInfoM;
        [headerV.userIconV sd_setImageWithURL:[NSURL URLWithString:dtoM.avatar] placeholderImage:[ProjConfig getAppIcon]];
        headerV.userNameL.text = dtoM.username;
        NSString *numS = [NSString stringWithFormat:@"%.0f",dtoM.delta];
        headerV.coinL.attributedText = [numS attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -3, 15, 15) before:YES];
        [headerV.levelImgV sd_setImageWithURL:[NSURL URLWithString:dtoM.nobleMedal]];
    }
}


#pragma mark - lazy
- (TotalMyRankView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[TotalMyRankView alloc]initWithFrame:CGRectMake(0, self.tableView.maxY, kScreenWidth, 70+kSafeAreaBottom)];
    }
    return _bottomView;
}
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
        _tableView = [[RankTable alloc]initWithFrame:CGRectMake(0, -kNavBarHeight, kScreenWidth, kScreenHeight+kNavBarHeight-70-kSafeAreaBottom) style:UITableViewStyleGrouped headerHeight:self.header.height-80];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[TotalUserRankCell class] forCellReuseIdentifier:@"TotalUserRankCellID"];
    }
    return _tableView;
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (RankSectionHeader *)sectionHeader{
    if (!_sectionHeader) {
        NSArray *titles = @[kLocalizationMsg(@"日榜"),kLocalizationMsg(@"周榜"),kLocalizationMsg(@"月榜"),kLocalizationMsg(@"总榜")];
        kWeakSelf(self);
        _sectionHeader = [[RankSectionHeader alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 60) titles:titles];
        _sectionHeader.btnClickCallBack = ^(int index) {
            int selectType = (index==3?0:index+1);
            if (weakself.showType != selectType) {
                weakself.showType = selectType;
                [weakself loadData:YES isMine:NO];
            }
        };
    }
    return _sectionHeader;
}
@end
