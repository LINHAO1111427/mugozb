//
//  GameMinePrizeView.m
//  LibProjView
//
//  Created by klc_sl on 2020/7/16.
//  Copyright © 2020 . All rights reserved.
//

#import "GameMinePrizeView.h"
#import "MinePrizeGroupCell.h"
#import <LibProjView/FunctionSheetBaseView.h>
#import <LibTools/LibTools.h>
#import <MJRefresh/MJRefresh.h>
#import <Masonry/Masonry.h>
#import <LibProjModel/HttpApiGame.h>
#import <LibProjModel/GamePrizeRecordModel.h>
#import <LibProjModel/GameAwardsDTOModel.h>
#import <LibProjModel/GameUserPrizeDTOModel.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/EmptyView.h>

@interface GamePrizeHeaderView : UITableViewHeaderFooterView

@property (nonatomic, weak)UILabel *titleL;
@end

@implementation GamePrizeHeaderView
- (UILabel *)titleL{
    if (!_titleL) {
        UILabel *contentL = [[UILabel alloc] init];
        contentL.font = [UIFont systemFontOfSize:13];
        contentL.textColor = kRGB_COLOR(@"#333333");
        [self addSubview:contentL];
        _titleL = contentL;
        [contentL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).mas_offset(12);
            make.centerY.equalTo(self);
        }];
    }
    return _titleL;
}
@end





@interface GameMinePrizeView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak)UITableView *tableV;

@property (nonatomic, strong)NSMutableArray *items;

@property (nonatomic, weak)EmptyView *emptyV;

@end

@implementation GameMinePrizeView

- (void)dealloc
{
    [_items removeAllObjects];
    _items = nil;
}

+ (void)showMinePrize{
    GameMinePrizeView *rule = [[GameMinePrizeView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight*3.0/5.0-50)];
    [rule createUI];
    [FunctionSheetBaseView showTitle:kLocalizationMsg(@"我的奖品") detailView:rule cover:NO];
}

- (EmptyView *)emptyV{
    if (!_emptyV) {
        EmptyView *emptyView = [[EmptyView alloc] init];
        emptyView.iconImgV.image = [UIImage imageNamed:@"home_guangchang_meiyouzhubo"];
        emptyView.titleL.text = kLocalizationMsg(@"暂无数据");
        [emptyView showInView:self];
        _emptyV = emptyView;
    }
    return _emptyV;
}

- (void)createUI{
    kWeakSelf(self);
    UITableView *tableV = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    tableV.tableFooterView = [UIView new];
    tableV.backgroundColor = [UIColor whiteColor];
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableV registerClass:[MinePrizeGroupCell class] forCellReuseIdentifier:@"MinePrizeGroupCellIdentifer"];
    [tableV registerClass:[GamePrizeHeaderView class] forHeaderFooterViewReuseIdentifier:@"MinePrizeGroupCellHeaderV"];
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself getMinePrize:YES];
    }];
    tableV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself getMinePrize:NO];
    }];
    
    [self addSubview:tableV];
    _tableV = tableV;
    [self getMinePrize:YES];
}

- (NSMutableArray *)items{
    if (!_items) {
        _items = [[NSMutableArray alloc] init];
    }
    return _items;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _items.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MinePrizeGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MinePrizeGroupCellIdentifer" forIndexPath:indexPath];
    if (_items.count > indexPath.section) {
        GameUserPrizeDTOModel *model = _items[indexPath.section];
        cell.items = model.gamePrizeRecordList;
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.0;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_items.count > section) {
        GamePrizeHeaderView *headerV = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MinePrizeGroupCellHeaderV"];
        GameUserPrizeDTOModel *model = _items[section];
        headerV.titleL.text = model.luckDrawDate;
        return headerV;
        
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}


///获得抽奖记录
- (void)getMinePrize:(BOOL)refresh{
    
    kWeakSelf(self);
    int pageSize = kPageSize;
    int pageIndex = refresh?0:(_items.count/pageSize+_items.count%pageSize?1:0);
    [HttpApiGame getUserPrizeList:-1 pageIndex:pageIndex pageSize:pageSize callback:^(int code, NSString *strMsg, NSArray<GameUserPrizeDTOModel *> *arr) {
        
        if (code == 1) {
            [weakself.tableV.mj_header endRefreshing];
            [weakself.tableV.mj_footer endRefreshing];
            if (refresh) {
                [weakself.items removeAllObjects];
            }
            if (arr.count > 0) {
                [weakself.items addObjectsFromArray:arr];
            }else{
                [weakself.tableV.mj_footer endRefreshingWithNoMoreData];
            }
            [weakself.tableV reloadData];
        }else{
            [self.tableV.mj_header endRefreshing];
            [self.tableV.mj_footer endRefreshing];
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
        weakself.emptyV.hidden = weakself.items.count;
    }];
}



@end



