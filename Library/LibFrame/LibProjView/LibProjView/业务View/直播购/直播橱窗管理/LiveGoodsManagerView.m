//
//  LiveGoodsManagerView.m
//  LibProjView
//
//  Created by klc_sl on 2020/7/10.
//  Copyright © 2020 . All rights reserved.
//

#import "LiveGoodsManagerView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/FunctionSheetBaseView.h>
#import <LibProjModel/HttpApiShopGoods.h>
#import "LiveGoodsItemCell.h"
#import "SingleGoodSelectedCell.h"
#import <MJRefresh/MJRefresh.h>
#import <LibProjView/EmptyView.h>


@interface LiveGoodsManagerView ()<UITableViewDelegate, UITableViewDataSource,SingleGoodSelectedCellDelegate>

@property (nonatomic, weak)UITableView *tableV;
@property (nonatomic, weak)UILabel *titleL;
@property (nonatomic, strong)NSMutableArray *items;
@property (nonatomic, weak)EmptyView *emptyV;
@property (nonatomic, assign)GoodsManagerType managerType;
@property (nonatomic, copy)LiveGoodsManagerCallback callBack;
@property (nonatomic, strong)ShopGoodsDTOModel *selectedModel;
@end

@implementation LiveGoodsManagerView

+ (void)showGoodsListType:(GoodsManagerType)managerType selectedModel:(ShopGoodsDTOModel*)selectedModel CallBack:(LiveGoodsManagerCallback)callBack{
    LiveGoodsManagerView *list = [[LiveGoodsManagerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight*3.0/5.0)];
    list.callBack = callBack;
    list.managerType = managerType;
    if (selectedModel) {
        list.selectedModel  = selectedModel;
    }
    [list createUI];
    [FunctionSheetBaseView showTitle:kLocalizationMsg(@"橱窗管理") detailView:list cover:NO cancelBack:nil];
}
 
- (NSMutableArray *)items{
    if (!_items) {
        _items = [[NSMutableArray alloc] init];
    }
    return _items;
}

- (EmptyView *)emptyV{
    if (!_emptyV) {
        EmptyView *emptyV = [[EmptyView alloc] init];
        emptyV.titleL.text = kLocalizationMsg(@"暂无商品");
        [emptyV showInView:self];
        _emptyV = emptyV;
    }
    return _emptyV;
}


- (void)createUI{
    ///直播橱窗管理
    UITableView *tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    tableV.tableFooterView = [UIView new];
    if (self.managerType == GoodsManagerTypeShortVideo) {
        [tableV registerClass:[SingleGoodSelectedCell class] forCellReuseIdentifier:@"LiveGoodsItemCellIdentifier"];
    }else{
        [tableV registerClass:[LiveGoodsItemCell class] forCellReuseIdentifier:@"LiveGoodsItemCellIdentifier"];
    }
    
    [self addSubview:tableV];
    _tableV = tableV;
    
    kWeakSelf(self);
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself getShopingGoodsList:YES];
    }];
    tableV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself getShopingGoodsList:NO];
    }];
    [self getShopingGoodsList:YES];
}


- (void)getShopingGoodsList:(BOOL)refresh{
    kWeakSelf(self);
    int pageSize = kPageSize;
    int pageIndex = refresh?0:(int)self.items.count/pageSize + (self.items.count%pageSize?1:0);
    [HttpApiShopGoods getLiveGoodsList:pageIndex pageSize:pageSize status:2 callback:^(int code, NSString *strMsg, NSArray<ShopGoodsDTOModel *> *arr) {
        [weakself.tableV.mj_header endRefreshing];
        [weakself.tableV.mj_footer endRefreshing];
        NSString *showStr = @"";
        if (code == 1) {
            if (refresh) {
                [weakself.items removeAllObjects];
            }
            [weakself.items addObjectsFromArray:arr];
            if (arr.count < pageSize) {
                [weakself.tableV.mj_footer endRefreshingWithNoMoreData];
            }
            [weakself.tableV reloadData];
            showStr =  weakself.items.count?@"":strMsg;
        }else{
            showStr = strMsg;
        }
        weakself.emptyV.detailL.text = showStr;
        weakself.emptyV.hidden = weakself.items.count;
    }];
}


#pragma mark - tableView -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.managerType == GoodsManagerTypeShortVideo) {
        SingleGoodSelectedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LiveGoodsItemCellIdentifier" forIndexPath:indexPath];
        if (_items.count > indexPath.row) {
            ShopGoodsDTOModel *model = _items[indexPath.row];
            model.checked = NO;
            if (model.goodsId == self.selectedModel.goodsId) {
                model.checked = YES;
            }
            cell.goods = model;
        }
        cell.delegate = self;
        return cell;
    }else{
        LiveGoodsItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LiveGoodsItemCellIdentifier" forIndexPath:indexPath];
        if (_items.count > indexPath.row) {
            cell.goods = _items[indexPath.row];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 112;
}

#pragma mark - SingleGoodSelectedCellDelegate
- (void)SingleGoodSelectedCellDidSelected:(ShopGoodsDTOModel *)selectedGoods{
    self.callBack(NO, selectedGoods);
    [FunctionSheetBaseView deletePopView:self];
}


@end
