//
//  CommodityDetailViewController.m
//  Shopping
//
//  Created by klc on 2020/7/4.
//  Copyright © 2020 klc. All rights reserved.
//

#import "CommodityDetailVC.h"

#import "CommodityInfoTable.h"
#import "CommodityDetailTable.h"

#import "CommodityDetailBottomView.h"
#import <LibProjView/CommodityPaySelectedView.h>

#import <LibProjBase/MobManager.h>

#import "PurchaseCarAnimationTool.h"
#import <LibProjView/FunctionSheetBaseView.h>
#import <LibProjView/LiveShareView.h>

#import <LibProjModel/HttpApiShopGoods.h>
#import <LibProjModel/ShopGoodsDetailDTOModel.h>
#import <LibProjModel/ShopGoodsDTOModel.h>
#import <LibProjModel/ShopGoodsModel.h>
#import <LibProjModel/ShopCarModel.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/AdminLoginSwitchModel.h>
#import <LibProjModel/HttpApiUserController.h>
#import <LibProjModel/HttpApiShopCar.h>
#import "GoodDetailNaviView.h"
#import "CommodityReommendListCell.h"
#import <LibProjView/EmptyView.h>

@interface CommodityDetailVC ()<CommodityInfoTableDelegate,CommodityDetailBottomViewDelegate,CommodityReommendListCellDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak)UITableView *tableV;

@property (nonatomic, strong)CommodityDetailBottomView *bottomView;
@property (nonatomic, strong)ShopGoodsDetailDTOModel *detailModel;
@property (nonatomic, strong)ShopAttrComposeModel *selectedAttributeModel;

@property (nonatomic, assign)int buyNum; ///选择购买的数量

@property (nonatomic, weak)GoodDetailNaviView *naviView;

@property (nonatomic, weak)CommodityInfoTable *infoView;

@property (nonatomic, weak)EmptyView *emptyV;

@end

@implementation CommodityDetailVC

- (void)dealloc
{
   // NSLog(@"过滤文字%s"),__func__);
}


- (CommodityDetailBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[CommodityDetailBottomView alloc]initWithFrame:CGRectMake(0, self.view.height-kSafeAreaBottom-60, kScreenWidth, kSafeAreaBottom+60)];
        _bottomView.delegate = self;
        _bottomView.hidden = YES;
    }
    return _bottomView;
}

- (UITableView *)tableV{
    if (!_tableV) {
        UITableView *tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-60) style:UITableViewStyleGrouped];
        tableV.delegate = self;
        tableV.dataSource = self;
        tableV.hidden = YES;
        tableV.showsVerticalScrollIndicator = NO;
        tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableV registerClass:[CommodityDetailTable class] forCellReuseIdentifier:@"CommodityDetailTableID"];
        [tableV registerClass:[CommodityReommendListCell class] forCellReuseIdentifier:@"CommodityReommendListViewID"];
        [self.view addSubview:tableV];
        [self.view sendSubviewToBack:tableV];
        //页面设置
        if (@available(iOS 11.0, *)) {
            tableV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableV = tableV;
    }
    return _tableV;
}

- (EmptyView *)emptyV{
    if (!_emptyV) {
        EmptyView *emptyView = [[EmptyView alloc] init];
        emptyView.iconImgV.image  = [UIImage imageNamed:@"home_guangchang_meiyouzhubo"];
        emptyView.titleL.text = kLocalizationMsg(@"～暂无商品信息～");
        [self.view addSubview:emptyView];
        [emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.tableV);
        }];
        _emptyV = emptyView;
    }
    return _emptyV;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRGB_COLOR(@"#F4F4F4");
    
    kWeakSelf(self);
    self.tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself getCommodityData];
    }];
    
    [self createView];
    [self getCommodityData];
}

- (void)createView{
    kWeakSelf(self);
    GoodDetailNaviView *naviView = [[GoodDetailNaviView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavBarHeight)];
    [naviView.backBtn addTarget:self action:@selector(navBackBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [naviView.shoppingCartBtn addTarget:self action:@selector(shoppingCartBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [naviView.messageBtn addTarget:self action:@selector(messageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    naviView.didSelectItem = ^(NSInteger index) {
        if (index == 0) {
            [weakself.tableV setContentOffset:CGPointMake(0, 0) animated:YES];
        }else{
            CGRect rect = [weakself.tableV rectForSection:index-1];
            [weakself.tableV setContentOffset:CGPointMake(0, rect.origin.y-kNavBarHeight) animated:YES];
        }
    };
    [self.view addSubview:naviView];
    self.naviView = naviView;
}


- (void)navBackBtnClick:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shoppingCartBtnClick:(UIButton *)btn{
    [RouteManager routeForName:RN_Shopping_PurchaseCar_ListVC currentC:self parameters:nil];
}

- (void)messageBtnClick:(UIButton *)btn{
    [RouteManager routeForName:RN_Message_MessageChatListVC currentC:self parameters:nil];
}

- (void)getCommodityData{
    kWeakSelf(self);
    [HttpApiShopGoods getGoodsDetail:[self.goodId intValue] callback:^(int code, NSString *strMsg, ShopGoodsDetailDTOModel *model) {
        [weakself.tableV.mj_header endRefreshing];
        if (code == 1) {
            weakself.detailModel = model;

            ShopAttrComposeModel *attriModel = [self getFirstSelectedAttributeModel:self.detailModel];
            weakself.selectedAttributeModel = attriModel;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakself.naviView.shopCarNum = model.shopCarNum;
                [weakself showGoodsInfo];
            });
        }else{
//            [SVProgressHUD showInfoWithStatus:strMsg];
            weakself.emptyV.detailL.text = strMsg;
        }
        weakself.emptyV.hidden = weakself.detailModel.anchorId?YES:NO;
        weakself.naviView.titleView.hidden = weakself.detailModel.anchorId?NO:YES;
    }];
}


- (void)showGoodsInfo{
    
    if (self.detailModel.anchorId == [ProjConfig userId]) {
        self.tableV.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        
    }else{
        [self.view addSubview:self.bottomView];
        self.bottomView.hidden = NO;
        self.tableV.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-self.bottomView.height);
    }
    
    NSArray *arr = [self.detailModel.shopGoods.detailPicture componentsSeparatedByString:@","];
    for (NSString *url in arr) {
        [CommodityDetailTable getWebImageWith:url callBack:nil];
    }

    CommodityInfoTable *headerV = [[CommodityInfoTable alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    headerV.superVc = self;
    headerV.delegate = self;
    headerV.detailModel = self.detailModel;
    self.tableV.tableHeaderView = headerV;
    [self.tableV reloadData];
    self.tableV.hidden = NO;
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!(scrollView.isTracking || scrollView.isDecelerating)) {
        //不是用户滚动的，比如setContentOffset等方法，引起的滚动不需要处理。
        return;
    }
    NSArray<NSIndexPath *> * indexPathList = [self.tableV indexPathsForVisibleRows];
    if (indexPathList.count) {
        
        NSIndexPath *path = indexPathList.firstObject;
        NSInteger sectionNum = path.section;
        ///如果是两个section同时有，第一个section已经高过导航栏
        CGRect sectionRt = [self.tableV rectForSection:sectionNum];
        if ((sectionRt.origin.y < (scrollView.contentOffset.y+kNavBarHeight)) && ((sectionNum+1) < [self.tableV numberOfSections])) {
            ++sectionNum;
            sectionRt = [self.tableV rectForSection:sectionNum];
        }
    
        if ((scrollView.contentOffset.y + kNavBarHeight+ 50) > sectionRt.origin.y) {
            self.naviView.selectTitleViewIndex = (sectionNum+1);
        }else{
            self.naviView.selectTitleViewIndex = sectionNum;
        }
    }else{
        self.naviView.selectTitleViewIndex = 0;
    }
    self.naviView.bgAlpha = scrollView.contentOffset.y/(kScreenWidth-kNavBarHeight);
}



#pragma mark - uitableviewdelegate uitableviewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) { ///详情
        return 1;
    }else{ ///推荐商品
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) { ///详情
        CommodityDetailTable *cell = [tableView dequeueReusableCellWithIdentifier:@"CommodityDetailTableID" forIndexPath:indexPath];
        cell.shopGoods = self.detailModel.shopGoods;
        return cell;
    }else{ ///推荐商品
        CommodityReommendListCell *listView = [tableView dequeueReusableCellWithIdentifier:@"CommodityReommendListViewID" forIndexPath:indexPath];;
        listView.itemArr = self.detailModel.recommendGoodsDTOS;
        listView.delegate = self;
        return listView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) { ///详情
        return UITableViewAutomaticDimension;
    }else{ ///推荐商品
        return [CommodityReommendListCell viewHeight:self.detailModel.recommendGoodsDTOS.count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    
    UIView *marginV = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, headerV.height-10)];
    marginV.backgroundColor = [UIColor whiteColor];
    [headerV addSubview:marginV];
    
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth-34, marginV.height)];
    titleL.textColor = kRGB_COLOR(@"#333333");
    titleL.font = [UIFont systemFontOfSize:14];
    titleL.textAlignment = NSTextAlignmentLeft;
    [marginV addSubview:titleL];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(12, 20, 3, 16)];
    line.backgroundColor = kRGB_COLOR(@"#FF5500");
    line.centerY = titleL.centerY;
    line.layer.masksToBounds = YES;
    line.layer.cornerRadius = 1.5;
    [marginV addSubview:line];
    
    if (section == 0) {
        titleL.text = kLocalizationMsg(@"商品详情");
    }else{
        titleL.text = kLocalizationMsg(@"商品推荐");
    }
    
    return headerV;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


#pragma mark - CommodityDetailBottomViewDelegate
- (void)CommodityDetailBottomViewBtnClick:(CommodityDetailBottomView *)bottomView index:(NSInteger)index{
    if (index == 0) {
        NSDictionary *params = @{@"businessId":@(self.detailModel.shopGoods.businessId)};
        [RouteManager routeForName:RN_Store_Home_DetailVC currentC:self parameters:params];
    }else if (index == 1){
        
        [LiveShareView showShareViewForType:3 shareId:0 moreFunction:nil];
        
    }else if (index == 2){
        [RouteManager routeForName:RN_Message_ConversationChatVC currentC:[ProjConfig currentVC] parameters:@{@"chatType":@"0",@"msgSendId":@(self.detailModel.anchorId)}];
    }
}

- (ShopAttrComposeModel *)getFirstSelectedAttributeModel:(ShopGoodsDetailDTOModel *)detailModel{
    ShopAttrComposeModel *model = detailModel.composeList.firstObject;
    CGFloat price;
    if (model.favorablePrice > 0) {
        price = model.favorablePrice;
    }else{
        price = model.price;
    }
    for (ShopAttrComposeModel *mod in self.detailModel.composeList) {
        if (mod.favorablePrice > 0) {
            if (mod.favorablePrice < price) {
                price = mod.favorablePrice;
                model = mod;
            }
        }else{
            if (mod.price < price) {
                price = mod.price;
                model = mod;
            }
        }
    }
    return model;
}

- (void)CommodityDetailBottomViewShopCartBtnClick:(CommodityDetailBottomView *)bottomView{
    kWeakSelf(self);
    [CommodityPaySelectedView showInSuperV:self.view withDetailModel:self.detailModel selectedModel:self.selectedAttributeModel selctedNum:self.buyNum type:PaySelectedTypeShopCart callBack:^(BOOL isBtnClick, ShopAttrComposeModel * _Nonnull attModel, int buy_num, int btn_index, UIImageView * _Nonnull imageV, CGFloat height) {
        if (!isBtnClick) {
            weakself.buyNum = buy_num;;
            [self.infoView changeSelectedAttriBute:attModel num:buy_num];
        }else{
            if (btn_index == 0) {
                [weakself appendToShopCart:attModel number:buy_num imageV:imageV height:height];//加入购物车
            }
        }
    }];
}
- (void)CommodityDetailBottomViewBuyBtnClick:(CommodityDetailBottomView *)bottomView{
    kWeakSelf(self);
    [CommodityPaySelectedView showInSuperV:self.view withDetailModel:self.detailModel selectedModel:self.selectedAttributeModel selctedNum:self.buyNum type:PaySelectedTypeBuy callBack:^(BOOL isBtnClick, ShopAttrComposeModel * _Nonnull attModel, int buy_num, int btn_index, UIImageView * _Nonnull imageV, CGFloat height) {
        if (!isBtnClick) {
            weakself.buyNum = buy_num;
            [self.infoView changeSelectedAttriBute:attModel num:buy_num];
        }else{
            if (btn_index == 1) {
                [weakself buyNow:attModel buy_num:buy_num];//立即购买
            }
        }
    }];
}

- (void)buyNow:(ShopAttrComposeModel *)attModel buy_num:(int)buy_num{
    ShopCarModel *shopCarModel = [[ShopCarModel alloc]init];
    shopCarModel.goodsNum = buy_num;
    shopCarModel.goodsPicture = self.detailModel.shopGoods.goodsPicture;
    shopCarModel.goodsName = self.detailModel.shopGoods.goodsName;
    shopCarModel.goodsId = self.detailModel.shopGoods.id_field;
    shopCarModel.businessId = self.detailModel.shopGoods.businessId;
    shopCarModel.id_field = 0;
    if (attModel) {
        shopCarModel.composeId = attModel.id_field;
        if (attModel.name2.length > 0) {
            shopCarModel.skuName = [NSString stringWithFormat:@"%@;%@",attModel.name1,attModel.name2];
        }else{
            shopCarModel.skuName = [NSString stringWithFormat:@"%@",attModel.name1];
        }
        shopCarModel.goodsPrice = attModel.favorablePrice > 0?attModel.favorablePrice:attModel.price;
    }else{
        shopCarModel.composeId = 0;
        shopCarModel.goodsPrice = self.detailModel.shopGoods.favorablePrice > 0?self.detailModel.shopGoods.favorablePrice:self.detailModel.shopGoods.price;
        shopCarModel.skuName = @"";
    }
    NSMutableArray *orderList = [NSMutableArray array];
    NSDictionary *dict = @{
        @"businessId":self.detailModel.shopGoods.businessId > 0?@(self.detailModel.shopGoods.businessId):0,
        @"businessLogo":self.detailModel.businessLogo.length > 0?self.detailModel.businessLogo:@"",
        @"businessName":self.detailModel.businessName.length > 0?self.detailModel.businessName:@"",
        @"commodityList":@[shopCarModel]
    };
    [orderList addObject:dict];
    [RouteManager routeForName:RN_Shopping_ShopOrder_ConfirmVC currentC:self parameters:@{@"orderList":orderList}];
}

- (void)appendToShopCart:(ShopAttrComposeModel *)attributeModel number:(int)num imageV:(UIImageView *)imageV height:(CGFloat)height{
    if (num > 0) {
        kWeakSelf(self);
        [HttpApiShopCar saveShopCar:attributeModel?attributeModel.id_field:0 goodsId:self.detailModel.shopGoods.id_field goodsNum:num callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                [PurchaseCarAnimationTool shakeAnimation:self.naviView.shoppingCartBtn];
                [weakself getCommodityData];
                [SVProgressHUD showInfoWithStatus:strMsg];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }
}

#pragma mark - CommodityInfoTableDelegate
- (void)CommodityInfoTableSelectedAttriModelChange:(ShopAttrComposeModel *)model{
    self.selectedAttributeModel = model;
    
}
- (void)commodityInfoRefresh{
    [PurchaseCarAnimationTool shakeAnimation:self.naviView.shoppingCartBtn];
    [self getCommodityData];
}


#pragma mark - CommodityReommendListCellDelegate
- (void)CommodityReommendListCell:(CommodityReommendListCell *)cell selectOneGoods:(ShopGoodsDTOModel *)dtoModel{
    if (dtoModel.channelId == 1) {
        NSDictionary *params = @{@"goodId":@(dtoModel.goodsId)};
        [RouteManager routeForName:RN_Shopping_Commodity_DetailVC currentC:self parameters:params];
    }else{
        if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:dtoModel.productLinks]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:dtoModel.productLinks]];
        }
    }
}

@end
