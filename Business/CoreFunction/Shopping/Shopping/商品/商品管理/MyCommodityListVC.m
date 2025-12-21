//
//  MyCommodityListVC.m
//  Shopping
//
//  Created by klc on 2020/7/3.
//  Copyright © 2020 klc. All rights reserved.
//

#import "MyCommodityListVC.h"
#import "myCommodityTableViewCell.h"
#import <LibProjView/ZQAlterField.h>
#import <LibProjView/EmptyView.h>

static NSString *myCommodityTableViewCellId = @"myCommodityTableViewCellId";
@interface MyCommodityListVC ()<UITableViewDelegate,UITableViewDataSource,myCommodityTableViewCellDelegate>
@property (nonatomic, assign)int page;
@property (nonatomic, assign)BOOL isLoadingData;
@property (nonatomic, assign)BOOL isPush;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UITableView *tableView;
@property(nonatomic,strong)ZQAlterField *alertView;
@property (nonatomic, weak)EmptyView *emptyView;
@end

@implementation MyCommodityListVC

- (ZQAlterField *)alertView{
    if (!_alertView) {
        _alertView = [ZQAlterField alertView];
        _alertView.tag = 10060;
        _alertView.title = kLocalizationMsg(@"请输入序号");
        _alertView.textField.keyboardType = UIKeyboardTypeNumberPad;
        _alertView.styleType = noRegCodeStyle;
        _alertView.Maxlength = 20;
    }
    return _alertView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight+kStatusBarHeight-kNavBarHeight) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
   
    kWeakSelf(self);
    self.tableView .mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.page = 0;
        [weakself loadData:YES];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakself.page ++;
        [weakself loadData:NO];
    }];
    self.tableView.mj_footer.ignoredScrollViewContentInsetBottom = kSafeAreaBottom;
    
    [self addEmptyView];
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
    header.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = header;
}
-(void)addEmptyView{
    EmptyView *empty = [[EmptyView alloc] init];
    NSString *str;
    if (self.status == 0) {
        str =  kLocalizationMsg(@"暂时没有商品");
    }else if (self.status == 1){
        str =  kLocalizationMsg(@"暂时没有已上架的商品");
    }else if (self.status == 2){
        str =  kLocalizationMsg(@"暂时没有待上架的商品");
    }else if (self.status == 3){
        str =  kLocalizationMsg(@"暂时没有冻结的商品");
    }
    empty.titleL.text = str;
    [empty showInView:self.tableView];
    _emptyView = empty;
}
- (void)loadData:(BOOL)isRefresh{
    kWeakSelf(self);
    self.isLoadingData = YES;
    [HttpApiShopGoods getGoodsList:self.page pageSize:kPageSize status:self.status callback:^(int code, NSString *strMsg, NSArray<ShopGoodsDTOModel *> *arr) {
         weakself.isLoadingData = NO;
         [weakself.tableView.mj_header endRefreshing];
         [weakself.tableView.mj_footer endRefreshing];
         if (code == 1) {
             if (isRefresh) {
                 [weakself.dataArray removeAllObjects];
             }
             if (arr.count < kPageSize) {
                  [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
                 if (arr.count > 0) {
                     [weakself.dataArray addObjectsFromArray:arr];
                 }
             }
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [weakself.tableView reloadData];
             });
             weakself.emptyView.hidden = weakself.dataArray.count;
         }else{
             [SVProgressHUD showInfoWithStatus:strMsg];
         }
    }];
     
}
#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopGoodsDTOModel *model;
    if (indexPath.row < self.dataArray.count) {
        model = self.dataArray[indexPath.row];
    }
    if (model.status != 3) {
        return 190;
    }else{
        return 120;
    }
     
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;//不能返回0;
}
 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    myCommodityTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[myCommodityTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCommodityTableViewCellId];
    }
    ShopGoodsDTOModel *model;
    if (indexPath.row < self.dataArray.count) {
        model = self.dataArray[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    cell.delegate = self;
    if (model) {
        cell.model = model;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopGoodsDTOModel *model;
    if (indexPath.row < self.dataArray.count) {
        model = self.dataArray[indexPath.row];
    }
    if (model) {
        if (model.channelId == 1) {
            NSDictionary *params = @{@"goodId":@(model.goodsId)};
            [RouteManager routeForName:RN_Shopping_Commodity_DetailVC currentC:self parameters:params];
        }else{
            if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:model.productLinks]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.productLinks]];
            }
        }
    }
}
#pragma mark - myCommodityTableViewCellDelegate
- (void)myCommodityTableViewCellOneSetViewClick:(myCommodityTableViewCell *)cell itemClick:(NSInteger)index {
    switch (index) {
        case 0:
            [self commodityNumUpdateNow:cell.model];
            break;
        case 1:
            [self commodityOnOrOffShelfNow:cell.model];
            break;
        case 2:{
            [RouteManager routeForName:RN_Shopping_AddingGoodsVC currentC:self parameters:@{@"isModify":@(YES),@"model":cell.model}];
        }
            break;
        case 3:
            [self commodityDeleteNow:cell.model index:cell.indexPath];
            break;
            
        default:
            break;
    }
}
- (void)commodityOnOrOffShelfNow:(ShopGoodsDTOModel*)model{
    kWeakSelf(self);
    [HttpApiShopGoods upAndLower:model.goodsId status:model.status == 1?2:1 callback:^(int code, NSString *strMsg, ShopGoodsModel *model) {
        if (code == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself loadData:YES];
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}
- (void)commodityDeleteNow:(ShopGoodsDTOModel *)model index:(NSIndexPath*)indexPath{
    kWeakSelf(self);
    [HttpApiShopGoods delGoods:model.goodsId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            if (indexPath.row < self.dataArray.count) {
                [self.dataArray removeObjectAtIndex:indexPath.row];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakself.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.tableView reloadData];
                    });
                });
            }
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}
- (void)commodityNumUpdateNow:(ShopGoodsDTOModel *)model{
    kWeakSelf(self);
    self.alertView.textField.text = kStringFormat(@"%d", model.sort);
    [self.alertView ensureClickBlock:^(NSString *inputString) {
        [weakself.alertView dismiss];
        [HttpApiShopGoods updateGoodsSort:model.goodsId sort:[inputString intValue] callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                [weakself loadData:YES];
                [SVProgressHUD showInfoWithStatus:strMsg];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }];
    [self.alertView show];
     
}
 
#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}
- (void)listWillAppear{
    if (!self.isPush) {
        [self loadData:YES];
    }
    self.isPush = NO;
}

@end
