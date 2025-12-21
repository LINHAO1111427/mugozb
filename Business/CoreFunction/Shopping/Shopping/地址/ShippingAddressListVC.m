//
//  ShippingAddressListVC.m
//  Shopping
//
//  Created by klc on 2020/7/20.
//  Copyright © 2020 klc. All rights reserved.
//

#import "ShippingAddressListVC.h"
#import "ShopAddressTableViewCell.h"
#import <LibProjModel/HttpApiShopCar.h>
#import <LibProjModel/ShopAddressModel.h>
#import <LibProjView/EmptyView.h>

@interface ShippingAddressListVC ()<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, weak)EmptyView *emptyView;
@property (nonatomic, assign)BOOL isRequestingData;
@end

@implementation ShippingAddressListVC
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kRGB_COLOR(@"#F6F6F6");
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
         
    }
    return _tableView;
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getShopAddressList];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = kLocalizationMsg(@"选择收货地址");
    [self.view addSubview:self.tableView];
    [self addEmptyView];
    UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 36, 36)];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [addBtn setTitle:kLocalizationMsg(@"添加") forState:UIControlStateNormal];
    [addBtn setTitleColor:kRGB_COLOR(@"#333333") forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = item;
    
}
-(void)addEmptyView{
    EmptyView *empty = [[EmptyView alloc] init];
    empty.titleL.text = kLocalizationMsg(@"暂无地址");
    empty.detailL.text = kLocalizationMsg(@"赶紧去添加一个地址吧～");
    [empty showInView:self.tableView];
    _emptyView = empty;
}
- (void)getShopAddressList{
    kWeakSelf(self);
    self.isRequestingData = YES;
    [HttpApiShopCar getShopAddrList:^(int code, NSString *strMsg, NSArray<ShopAddressModel *> *arr) {
        weakself.isRequestingData = NO;
        if (code == 1) {
            [weakself.dataArray removeAllObjects];
            if (arr.count > 0) {
                [weakself.dataArray addObjectsFromArray:arr];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself.tableView reloadData];
            });
            weakself.emptyView.detailL.text = self.dataArray.count?kLocalizationMsg(@"有地址值"):kLocalizationMsg(@"赶紧去添加一个地址吧～");
        }else{
            weakself.emptyView.detailL.text = strMsg;
        }
        weakself.emptyView.hidden = weakself.dataArray.count;
    }];
}

- (void)addBtnClick:(UIButton *)btn{
    [RouteManager routeForName:RN_Shopping_Address_EditeVC currentC:self parameters:@{@"isModify":@(NO)}];
}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopAddressTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[ShopAddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ShopAddressTableViewCell"];
    }
    cell.backgroundColor = [UIColor whiteColor];
    ShopAddressModel *model;
    if (indexPath.row < self.dataArray.count) {
        model = self.dataArray[indexPath.row];
    }
    if (model.id_field  == [self.selectedAddressId intValue]) {
        cell.isChoice = YES;
    }else{
        cell.isChoice = NO;
    }
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopAddressModel *model;
    if (indexPath.row < self.dataArray.count) {
        model = self.dataArray[indexPath.row];
    }
    self.selectedAddressId = @(model.id_field);
    [self.navigationController popViewControllerAnimated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shopAddressSelected" object:model];
    });
}

#pragma mark - 左滑删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
   return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
  return UITableViewCellEditingStyleNone;
}
 
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    __block ShopAddressModel *model;
    if (indexPath.row < self.dataArray.count) {
        model = self.dataArray[indexPath.row];
    }
    kWeakSelf(self);
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:kLocalizationMsg(@"删除") handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [weakself deleteAddress:model];
    }];
    
    UITableViewRowAction *edite = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:kLocalizationMsg(@"编辑") handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
       // NSLog(@"过滤文字点击了编辑"));
        tableView.editing = NO;
        if (model) {
            [RouteManager routeForName:RN_Shopping_Address_EditeVC currentC:self parameters:@{@"isModify":@(YES),@"model":model}];
        }
    }];
    return @[delete, edite];
}
- (void)deleteAddress:(ShopAddressModel *)model{
    kWeakSelf(self);
    [HttpApiShopCar delShopAddress:model.id_field callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [SVProgressHUD showSuccessWithStatus:strMsg];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself getShopAddressList];
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}
@end
