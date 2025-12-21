//
//  PurchaseCarListViewController.m
//  Shopping
//
//  Created by klc on 2020/7/9.
//  Copyright © 2020 klc. All rights reserved.
//

#import "PurchaseCarListVC.h"

#import "PurchaseTableViewCell.h"
#import "PurchaseSectionHeaderView.h"
#import "SettleAccountsView.h"
#import <LibProjView/CommodityPaySelectedView.h>
#import <LibProjModel/HttpApiShopCar.h>
#import <LibProjView/EmptyView.h>
#import <LibProjModel/ShopCarModel.h>

@interface PurchaseCarListVC ()<
UITableViewDelegate,
UITableViewDataSource,
PurchaseSectionHeaderViewDelagate,
PurchaseTableViewCellDelagate,
SettleAccountsViewDelegate
>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray<ShopCarDTOModel *> *dataArray;
@property (nonatomic, assign)BOOL isRequestingData;
@property (nonatomic, assign)BOOL isPush;
@property (nonatomic, assign)int page;
@property (nonatomic, strong)SettleAccountsView *settleAccountView;
@property (nonatomic, weak)EmptyView *emptyView;

@property (nonatomic, strong)NSMutableDictionary *selectIndexDic;

@end

@implementation PurchaseCarListVC

- (NSMutableArray<ShopCarDTOModel *> *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableDictionary *)selectIndexDic{
    if (!_selectIndexDic) {
        _selectIndexDic = [[NSMutableDictionary alloc] init];
    }
    return _selectIndexDic;
}

- (SettleAccountsView *)settleAccountView{
    if (!_settleAccountView) {
        _settleAccountView = [[SettleAccountsView alloc]initWithFrame:CGRectMake(0, kScreenHeight-60-kSafeAreaBottom-kNavBarHeight, kScreenWidth, 60+kSafeAreaBottom)];
        _settleAccountView.delegate = self;
    }
    return _settleAccountView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-60-kNavBarHeight-kSafeAreaBottom) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kRGB_COLOR(@"#F6F6F6");
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[PurchaseTableViewCell class] forCellReuseIdentifier:@"PurchaseTableViewCell"];
        if (kiOS(15)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
    }
    return _tableView;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.isPush) {
        [self loadData:YES isAppear:YES];
    }
    self.isPush = NO;
}
-(void)addEmptyView{
    EmptyView *empty = [[EmptyView alloc] init];
    empty.titleL.text = kLocalizationMsg(@"你的购物车空空如也");
    empty.detailL.text = kLocalizationMsg(@"赶紧去添加商品进来吧～");
    [empty showInView:self.tableView];
    _emptyView = empty;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = kLocalizationMsg(@"购物车");
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.settleAccountView];
    self.view.backgroundColor = kRGB_COLOR(@"#F6F6F6");
    self.page = 0;
    //页面设置
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    
    /*
     kWeakSelf(self);
     self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
     weakself.page = 0;
     [weakself loadData:YES isAppear:NO];
     }];
     self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
     weakself.page ++;
     [weakself loadData:NO isAppear:NO];
     }];
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shoppingPaySuccess) name:@"shoppingPaySuccess" object:nil];
    [self addEmptyView];
}

- (void)shoppingPaySuccess{
    [self loadData:YES isAppear:YES];
}

- (void)loadData:(BOOL)isRefresh isAppear:(BOOL)isAppear{
    kWeakSelf(self);
    self.isRequestingData = YES;
    
    [HttpApiShopCar getShopCarList:^(int code, NSString *strMsg, NSArray<ShopCarDTOModel *> *arr) {
        [weakself.tableView.mj_header endRefreshing];
        [weakself.tableView.mj_footer endRefreshing];
        weakself.isRequestingData = NO;
        if (isRefresh) {
            [self.dataArray removeAllObjects];
        }
        if (code > 0) {
//            if (arr.count < weakself.pageSize) {
                [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
//            }
            
            NSMutableArray *muArr = [NSMutableArray arrayWithCapacity:arr.count];
            for (ShopCarDTOModel *dtoModel in arr) {
                dtoModel.checked = 1;
                [dtoModel.shopCarList enumerateObjectsUsingBlock:^(ShopCarModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSString *selectKey = kStringFormat(@"%lld",obj.goodsId);
                    [self.selectIndexDic setObject:@(YES) forKey:selectKey];
                }];
                [muArr addObject:dtoModel];
            }
            [self.dataArray addObjectsFromArray:muArr];

            [weakself updateAmoutMoneyAndNumber];
            
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
        weakself.emptyView.hidden = weakself.dataArray.count;
    }];
}

- (void)updateAmoutMoneyAndNumber{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        CGFloat money = 0.0f;
        NSInteger num = 0;
        ///初始值如果有值就默认全选，如果每值默认不选
        BOOL allSelected = self.dataArray.count?YES:NO;
        
        for (ShopCarDTOModel *sectionModel in self.dataArray) {
            
            for (ShopCarModel *commodityModel in sectionModel.shopCarList) {
                
                BOOL isSelect = [self.selectIndexDic[kStringFormat(@"%lld",commodityModel.goodsId)] boolValue];
                if (isSelect) {
                    num ++;
                    money += commodityModel.goodsNum*commodityModel.goodsPrice;
                }else{
                    allSelected = NO;
                }
            }
        }
        [self.tableView reloadData];
        [self.settleAccountView changeAmountMoney:money commodityNum:num allSelected:allSelected];
        
    });
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"shoppingPaySuccess" object:nil];
}


#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section < self.dataArray.count) {
        ShopCarDTOModel *sectionModel = self.dataArray[section];
        return sectionModel.shopCarList.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PurchaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PurchaseTableViewCell" forIndexPath:indexPath];
    cell.delegate = self;
    
    if (indexPath.section < self.dataArray.count) {
        ShopCarDTOModel *sectionModel = self.dataArray[indexPath.section];
        if (indexPath.row < sectionModel.shopCarList.count) {
            ShopCarModel *carModel = sectionModel.shopCarList[indexPath.row];
            cell.commodityModel = carModel;
            cell.isSelectGoods = [self.selectIndexDic[kStringFormat(@"%lld",carModel.goodsId)] boolValue];
        }
        if (indexPath.row == sectionModel.shopCarList.count-1) {
            cell.lastOne = YES;
        }else{
            cell.lastOne = NO;
        }
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    PurchaseSectionHeaderView *header = [[PurchaseSectionHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 54)];
    header.delegate = self;
    if (section < self.dataArray.count) {
        header.sectionModel = self.dataArray[section];
    }
    header.sectionNum = section;
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44+10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 134;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - PurchaseTableViewCellDelagate
///修改购买数量
- (void)PurchaseTableViewCell:(PurchaseTableViewCell *)cell buyNumChange:(int)num{
    kWeakSelf(self);
    [HttpApiShopCar updateShopCar:cell.commodityModel.composeId goodsNum:num shopCarId:cell.commodityModel.id_field callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [weakself updateAmoutMoneyAndNumber];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

///是否选择商品
- (void)PurchaseTableViewCell:(PurchaseTableViewCell *)cell selectedClick:(BOOL)selected{
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSString *selectKey = kStringFormat(@"%lld",cell.commodityModel.goodsId);
    if (selected) {
        [self.selectIndexDic setObject:@(YES) forKey:selectKey];
    }else{
        [self.selectIndexDic removeObjectForKey:selectKey];
    }
    
    BOOL sectionIsAll = YES;
    ShopCarDTOModel *sectionModel = self.dataArray[indexPath.section];
    for (ShopCarModel *carModel in sectionModel.shopCarList) {
        BOOL isCheck = [self.selectIndexDic[kStringFormat(@"%lld",carModel.goodsId)] boolValue];
        if (!isCheck) {
            sectionIsAll = NO;
        }
    }
    sectionModel.checked = sectionIsAll;
    
    [self.dataArray replaceObjectAtIndex:indexPath.section withObject:sectionModel];
    
    [self updateAmoutMoneyAndNumber];
}


///选择属性
- (void)PurchaseTableViewCellAttributeBtnClick:(PurchaseTableViewCell *)cell{
    ShopCarModel *carM = cell.commodityModel;
    kWeakSelf(self);
    [HttpApiShopGoods getGoodsDetail:carM.goodsId callback:^(int code, NSString *strMsg, ShopGoodsDetailDTOModel *model) {
        if (code == 1) {
            ShopAttrComposeModel *selectedAtrributeModel;
            for (ShopAttrComposeModel *attriModel in model.composeList) {
                if (attriModel.id_field == carM.composeId) {
                    selectedAtrributeModel = attriModel;
                    break;
                }
            }
            if (selectedAtrributeModel) {
                [CommodityPaySelectedView showInSuperV:self.view withDetailModel:model selectedModel:selectedAtrributeModel selctedNum:carM.goodsNum type:PaySelectedTypeOnlySure callBack:^(BOOL isBtnClick, ShopAttrComposeModel * _Nonnull attModel, int buy_num, int btn_index, UIImageView * _Nonnull imageV, CGFloat height) {
                    if (isBtnClick) {
                        if (btn_index == 2) {//确定
                            if (attModel) {
                                //更新属性
                                [weakself updateAttriBute:attModel buy_num:buy_num rowModel:carM];
                            }
                        }
                    }
                }];
            }
            
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

///显示商品详情
- (void)PurchaseTableViewCellCommodityClick:(PurchaseTableViewCell *)cell{
    self.isPush = YES;
    [RouteManager routeForName:RN_Shopping_Commodity_DetailVC currentC:self parameters:@{@"goodId":@(cell.commodityModel.goodsId)}];
}

///更新商品属性
- (void)updateAttriBute:(ShopAttrComposeModel *)attributeModel buy_num:(NSInteger)num rowModel:(ShopCarModel*)rowModel{
    kWeakSelf(self);
    [HttpApiShopCar updateShopCar:attributeModel.id_field goodsNum:(int)num shopCarId:rowModel.id_field callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            rowModel.composeId = attributeModel.id_field;
            rowModel.goodsPrice = attributeModel.favorablePrice>0?attributeModel.favorablePrice:attributeModel.price;
            if (attributeModel.name2.length > 0) {
                rowModel.skuName = [NSString stringWithFormat:@"%@;%@",attributeModel.name1,attributeModel.name2];
            }else{
                rowModel.skuName = attributeModel.name1;
            }
            rowModel.goodsNum = (int)num;
            [weakself updateAmoutMoneyAndNumber];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


#pragma mark - PurchaseSectionHeaderViewDelagate
///点击选择该商店下所有商品
- (void)PurchaseSectionHeaderView:(PurchaseSectionHeaderView *)headerV selectedClick:(BOOL)selected{
    headerV.sectionModel.checked = selected;
    for (ShopCarModel *carModel in headerV.sectionModel.shopCarList) {
        [self.selectIndexDic setObject:@(selected) forKey:kStringFormat(@"%lld",carModel.goodsId)];
    }
    
    [self updateAmoutMoneyAndNumber];
}

///点击进入商店
- (void)PurchaseSectionHeaderViewShopBtnClick:(PurchaseSectionHeaderView *)headerV{
    [RouteManager routeForName:RN_Store_Home_DetailVC currentC:self parameters:@{@"businessId":@(headerV.sectionModel.businessId)}];
}

#pragma mark - SettleAccountsViewDelegate
///全选
- (void)SettleAccountsViewSelectedBtnClick:(BOOL)selected{
    [self.dataArray enumerateObjectsUsingBlock:^(ShopCarDTOModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.checked = selected;
        [self.dataArray replaceObjectAtIndex:idx withObject:obj];
        [obj.shopCarList enumerateObjectsUsingBlock:^(ShopCarModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.selectIndexDic setObject:@(selected) forKey:kStringFormat(@"%lld",obj.goodsId)];
        }];
    }];
    [self updateAmoutMoneyAndNumber];
}

///结算
- (void)SettleAccountsViewSettleBtnClick{
    NSArray *orderList = (NSArray *)[self getOrderList];
    if (orderList.count > 0) {
        self.isPush = YES;
        [RouteManager routeForName:RN_Shopping_ShopOrder_ConfirmVC currentC:self parameters:@{@"orderList":orderList}];
    }
}

///结算，获得订单列表
- (NSArray *)getOrderList{
    
    NSMutableArray *orderList = [NSMutableArray array];
    for (ShopCarDTOModel *shopModel in self.dataArray) {

        int64_t businessId = shopModel.businessId;
        NSString *businessLogo = shopModel.businessLogo;
        NSString *businessName = shopModel.businessName;
        NSMutableArray *goodsList = [NSMutableArray array];
        
        for (ShopCarModel *carModel in shopModel.shopCarList) {
            BOOL isChoice = [self.selectIndexDic[kStringFormat(@"%lld",carModel.goodsId)] boolValue];
            if (isChoice) {
                [goodsList addObject:carModel];
            }
        }
        if (goodsList.count > 0) {
            NSDictionary *dict = @{
                @"businessId":businessId > 0?@(businessId):@(0),
                @"businessLogo":businessLogo.length > 0?businessLogo:@"",
                @"businessName":businessName.length > 0?businessName:@"",
                @"commodityList":goodsList
            };
            [orderList addObject:dict];
        }
    }
    return orderList;
}

#pragma mark - 左滑删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < self.dataArray.count) {
        ShopCarDTOModel *sectionModel = self.dataArray[indexPath.section];
        if (indexPath.row < sectionModel.shopCarList.count) {
            
            ShopCarModel *carModel = sectionModel.shopCarList[indexPath.row];
            if (carModel && !self.isRequestingData) {
                if (editingStyle == UITableViewCellEditingStyleDelete) {
                    if (!self.isRequestingData) {
                        [self deleteCommodity:carModel atSectionModel:sectionModel indexPath:indexPath];
                    }
                }
            }
        }
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kLocalizationMsg(@"删除");
}

///删除
- (void)deleteCommodity:(ShopCarModel *)commodityModel atSectionModel:(ShopCarDTOModel *)sectionModel indexPath:(NSIndexPath*)indexp{
    kWeakSelf(self);
    [HttpApiShopCar delShopCar:commodityModel.id_field callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            if (sectionModel.shopCarList.count == 1) {
                [self.dataArray removeObject:sectionModel];
            }else if(sectionModel.shopCarList.count > 1){
                [sectionModel.shopCarList removeObject:commodityModel];
            }
            [weakself updateAmoutMoneyAndNumber];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


@end
