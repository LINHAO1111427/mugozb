//
//  TotalFamilyRankTable.m
//  Ranking
//
//  Created by ssssssss on 2020/12/24.
//  Copyright © 2020 KLC. All rights reserved.
//  家族榜单

#import "TotalFamilyRankTable.h"

#import "RankTable.h"
#import "FamilyTotalRankCell.h"
#import "TotalRankHeader.h"
#import "RankSectionHeader.h"

#import <LibTools/LibTools.h>
#import <MJRefresh/MJRefresh.h>
#import <LibProjBase/LibProjBase.h>

#import <LibProjModel/HttpApiChatFamilyController.h>
#import <LibProjModel/AppHomeChatFamilyVOModel.h>
#import <SDWebImage/SDWebImage.h>

@interface TotalFamilyRankTable ()<UITableViewDelegate,UITableViewDataSource,TotalRankHeaderDelegate>
@property (nonatomic, strong)RankTable *tableView;
@property (nonatomic, strong)TotalRankHeader *header;
@property (nonatomic, strong)RankSectionHeader *sectionHeader;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, assign)int showType;
@end

@implementation TotalFamilyRankTable

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.header];
    [self.view addSubview:self.tableView];
    kWeakSelf(self);
    //    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    //        [weakself loadData:YES];
    //    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself loadData:NO];
    }];
    [self.tableView setContentInset:UIEdgeInsetsMake(self.header.height-80, 0, 0, 0)];
    
    self.sectionHeader.selectIndex = self.selectIndex;
}
- (void)loadData:(BOOL)refresh{
    int pageSize = kPageSize;
    int pageIndex = refresh?0:(int)self.dataArray.count/pageSize  + (self.dataArray.count%pageSize?1:0);
    kWeakSelf(self);
    [HttpApiChatFamilyController getHomeChatFamilyList:@"" latitude:0 longitude:0 pageIndex:pageIndex pageSize:pageSize queryType:self.showType callback:^(int code, NSString *strMsg, NSArray<AppHomeChatFamilyVOModel *> *arr) {
        if (code == 1) {
            [weakself.tableView.mj_header endRefreshing];
            [weakself.tableView.mj_footer endRefreshing];
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
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
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
        AppHomeChatFamilyVOModel *model = self.dataArray[i];
        [arr addObject:model];
    }
    self.header.dataArray = [NSArray arrayWithArray:arr];
}
#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}

- (void)listWillAppear{
    [self loadData:YES];
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
    FamilyTotalRankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FamilyTotalRankCellID" forIndexPath:indexPath];
    AppHomeChatFamilyVOModel *model;
    if (indexPath.row+3 < self.dataArray.count) {
        model = self.dataArray[indexPath.row+3];
    }
    if (model) {
        double price = 0.0;
        ///3：日榜 4：周榜 5：月榜 6：总榜
        switch (self.showType) {
            case 3:
                price = model.familyDayRating;
                break;
            case 4:
                price = model.familyWeekRating;
                break;
            case 5:
                price = model.familyMonthRating;
                break;
            case 6:
                price = model.familyTotalRating;
                break;
            default:
                break;
        }
        [cell updateData:model.familyRank avater:model.familyIcon username:model.familyName num:price introduce:model.familyDescription];
        [cell.levelImgV sd_setImageWithURL:[NSURL URLWithString:model.familyGradeIcon]];
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
    if (indexPath.row+3 < self.dataArray.count) {
        AppHomeChatFamilyVOModel *model = self.dataArray[indexPath.row+3];
        [RouteManager routeForName:RN_Family_FamilyInfoVC currentC:self parameters:@{@"familyId":@(model.familyId)}];
    }
}

#pragma mark - TotalRankHeaderDelegate
- (void)TotalRankHeader:(TotalRankHeader *)headerV clickIndex:(NSInteger)index{
    if (index < self.dataArray.count) {
        AppHomeChatFamilyVOModel *model = self.dataArray[index];
        [RouteManager routeForName:RN_Family_FamilyInfoVC currentC:self parameters:@{@"familyId":@(model.familyId)}];
    }
}

- (void)showUserInfo:(id)userInfoM userHeaderView:(nonnull RankUserInfoHeaderView *)headerV{
    if ([userInfoM isKindOfClass:[AppHomeChatFamilyVOModel class]]) {
        AppHomeChatFamilyVOModel *dtoM = (AppHomeChatFamilyVOModel *)userInfoM;
        [headerV.userIconV sd_setImageWithURL:[NSURL URLWithString:dtoM.familyIcon] placeholderImage:[ProjConfig getAppIcon]];
        headerV.userNameL.text = dtoM.familyName;
        
        double price = 0.0;
        ///3：日榜 4：周榜 5：月榜 6：总榜
        switch (self.showType) {
            case 3:
                price = dtoM.familyDayRating;
                break;
            case 4:
                price = dtoM.familyWeekRating;
                break;
            case 5:
                price = dtoM.familyMonthRating;
                break;
            case 6:
                price = dtoM.familyTotalRating;
                break;
            default:
                break;
        }
        
        NSString *numS = [NSString stringWithFormat:@"%.0f",price];
        headerV.coinL.attributedText = [numS attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -3, 15, 15) before:YES];
        [headerV.levelImgV sd_setImageWithURL:[NSURL URLWithString:dtoM.familyGradeIcon]];
    }
}


#pragma mark - lazy
- (TotalRankHeader *)header{
    if (!_header) {
        _header = [[TotalRankHeader alloc] init];
        _header.bgImageV.image = [UIImage imageNamed:@"icon_rank_consortia_header"];
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
        [_tableView registerClass:[FamilyTotalRankCell class] forCellReuseIdentifier:@"FamilyTotalRankCellID"];
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
- (RankSectionHeader *)sectionHeader{
    if (!_sectionHeader) {
        NSArray *titles = @[kLocalizationMsg(@"日榜"),kLocalizationMsg(@"周榜"),kLocalizationMsg(@"月榜"),kLocalizationMsg(@"总榜")];
        kWeakSelf(self);
        _sectionHeader = [[RankSectionHeader alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 60) titles:titles];
        _sectionHeader.btnClickCallBack = ^(int index) {
            int selectType = (index==3?6:index+3);
            if (weakself.showType != selectType) {
                weakself.showType = selectType;
                [weakself loadData:YES];
            }
        };
    }
    return _sectionHeader;
}

@end
