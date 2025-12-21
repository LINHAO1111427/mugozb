//
//  GameRecordView.m
//  LibProjView
//
//  Created by klc_sl on 2020/7/16.
//  Copyright © 2020 . All rights reserved.
//

#import "GameRecordView.h"
#import <LibTools/LibTools.h>
#import <LibProjView/FunctionSheetBaseView.h>
#import <Masonry/Masonry.h>
#import "GameRecordItemCell.h"
#import <MJRefresh/MJRefresh.h>
#import <LibProjModel/HttpApiGame.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/EmptyView.h>

@interface GameRecordView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak)UITableView *tableV;

@property (nonatomic, strong)NSMutableArray *items;

@property (nonatomic, weak)EmptyView *emptyV;

@end

@implementation GameRecordView

- (void)dealloc
{
    [_items removeAllObjects];
    _items = nil;
}

+ (void)showRecord{
    GameRecordView *rule = [[GameRecordView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight*3.0/5.0-50)];
    [rule createUI];
    [FunctionSheetBaseView showTitle:kLocalizationMsg(@"抽奖记录") detailView:rule cover:NO];
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
    UITableView *tableV = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.tableFooterView = [UIView new];
    tableV.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [tableV registerClass:[GameRecordItemCell class] forCellReuseIdentifier:@"GameRecordItemCellIdentifer"];
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself getGameRecord:YES];
    }];
    tableV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself getGameRecord:NO];
    }];
    
    [self addSubview:tableV];
    _tableV = tableV;
    [self getGameRecord:YES];
}

- (NSMutableArray *)items{
    if (!_items) {
        _items = [[NSMutableArray alloc] init];
    }
    return _items;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GameRecordItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GameRecordItemCellIdentifer" forIndexPath:indexPath];
    if (_items.count> indexPath.row) {
        GameLuckDrawModel *model = _items[indexPath.row];
        cell.titleL.text = model.gameName;
        cell.coinL.text = [NSString stringWithFormat:@"-%.0lf%@", model.gameCoin,[KLCAppConfig unitStr]];
        cell.resultL.text = model.isAwards?kLocalizationMsg(@"已中奖"):kLocalizationMsg(@"未中奖");
        cell.resultL.textColor = model.isAwards?[UIColor redColor]:[UIColor lightGrayColor];
        cell.timeL.text = model.addTime;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


///获得抽奖记录
- (void)getGameRecord:(BOOL)refresh{
    kWeakSelf(self);
    int pageSize = kPageSize;
    int pageIndex = refresh?0:(_items.count/pageSize+_items.count%pageSize?1:0);
    [HttpApiGame getUserLuckDrawList:-1 pageIndex:pageIndex pageSize:pageSize callback:^(int code, NSString *strMsg, NSArray<GameLuckDrawModel *> *arr) {
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
