//
//  TotalConsortiaRankTable.m
//  Ranking
//
//  Created by ssssssss on 2020/12/24.
//  Copyright © 2020 KLC. All rights reserved.
// 公会榜

#import "TotalConsortiaRankTable.h"

#import "RankTable.h"
#import "FamilyTotalRankCell.h"
#import "TotalRankHeader.h"
#import "RankSectionHeader.h"
 
#import <LibTools/LibTools.h>
#import <MJRefresh/MJRefresh.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/GuildListVOModel.h>
#import <LibProjModel/HttpApiAPPFinance.h>
#import <SDWebImage/SDWebImage.h>

@interface TotalConsortiaRankTable ()<UITableViewDelegate,UITableViewDataSource,TotalRankHeaderDelegate>
@property (nonatomic, strong)RankTable *tableView;
@property (nonatomic, strong)TotalRankHeader *header;
@property (nonatomic, strong)RankSectionHeader *sectionHeader;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, assign)NSInteger showType;
@end

@implementation TotalConsortiaRankTable

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.header];
    [self.view addSubview:self.tableView];

    [self.tableView setContentInset:UIEdgeInsetsMake(self.header.height-80, 0, 0, 0)];
    
    self.sectionHeader.selectIndex = 0;
}

- (void)loadData:(BOOL)refresh{
    kWeakSelf(self);
    [HttpApiAPPFinance guildList:(int)self.showType callback:^(int code, NSString *strMsg, PageInfo *pageInfo, NSArray<GuildListVOModel *> *arr) {
        if (code == 1) {
            [weakself.dataArray removeAllObjects];
            [weakself.dataArray addObjectsFromArray:arr];
            [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
            [weakself headerDataUpdate];
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
        GuildListVOModel *model = self.dataArray[i];
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
    GuildListVOModel *model;
    if (indexPath.row+3 < self.dataArray.count) {
        model = self.dataArray[indexPath.row+3];
    }
    if (model) {
        [cell updateData:model.serialNumber avater:model.guildAvatar username:model.guildName num:model.guildTotalVotes introduce:@""];
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
//    GuildListVOModel *model;
}

#pragma mark - TotalRankHeaderDelegate
- (void)TotalRankHeader:(TotalRankHeader *)headerV clickIndex:(NSInteger)index {
}

- (void)showUserInfo:(id)userInfoM userHeaderView:(nonnull RankUserInfoHeaderView *)headerV {
    if ([userInfoM isKindOfClass:[GuildListVOModel class]]) {
        GuildListVOModel *dtoM = (GuildListVOModel *)userInfoM;
        [headerV.userIconV sd_setImageWithURL:[NSURL URLWithString:dtoM.guildAvatar] placeholderImage:[ProjConfig getAppIcon]];
        headerV.userNameL.text = dtoM.guildName;
        NSString *numS = [NSString stringWithFormat:@"%.0f",dtoM.guildTotalVotes];
        headerV.coinL.attributedText = [numS attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -3, 15, 15) before:YES];
    }
}

#pragma mark - lazy
- (TotalRankHeader *)header{
    if (!_header) {
        _header = [[TotalRankHeader alloc]init];
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
            int selectType = (index==3?0:index+1);
            if (weakself.showType != selectType) {
                weakself.showType = selectType;
                [weakself loadData:YES];
            }
        };
    }
    return _sectionHeader;
}
@end
