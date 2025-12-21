//
//  ShoppingAcceptAddressSelectedView.m
//  LibProjView
//
//  Created by klc on 2020/7/20.
//  Copyright © 2020 . All rights reserved.
//

#import "ShoppingAddressSelectedView.h"
#import "SAProvinceModel.h"
#import "SANavHeaderView.h"
#import "SASelectedTableViewCell.h"
#import <MJExtension/MJExtension.h>
#import <LibProjView/FunctionSheetBaseView.h>

@interface ShoppingAddressSelectedView()<
UITableViewDelegate,
UITableViewDataSource,
SANavHeaderViewDelegate
>
@property (nonatomic, copy)AddressCallBack callBack;
@property (nonatomic, strong)NSArray *dataArray;
@property (nonatomic, strong)SASelctedModel *selectedModel;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)SANavHeaderView *headerView;

@property (nonatomic, assign)int  selected_level;
@property (nonatomic, assign)NSInteger  current_rowPro;
@property (nonatomic, assign)NSInteger  current_rowRegion;
@property (nonatomic, assign)NSInteger  current_rowCounty;

@end
@implementation ShoppingAddressSelectedView
+ (void)showInSuperV:(UIView *)superV height:(CGFloat)height selectedModel:(SASelctedModel *)model callBack:(AddressCallBack)callBack{
    
   __block ShoppingAddressSelectedView *addressSelectedView = [[ShoppingAddressSelectedView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height-40)];
    
    addressSelectedView.backgroundColor = [UIColor whiteColor];
    addressSelectedView.selectedModel = model;
    addressSelectedView.callBack = callBack;
    addressSelectedView.current_rowPro = -1;
    addressSelectedView.current_rowRegion = -1;
    addressSelectedView.current_rowCounty = -1;
    [addressSelectedView addSubview:addressSelectedView.tableView];
    kWeakSelf(addressSelectedView);
    [FunctionSheetBaseView showTitle:kLocalizationMsg(@"请选择收货地区") detailView:addressSelectedView cover:YES cancelBack:^{
        if (weakaddressSelectedView.selectedModel.areaId_three > 0) {
            addressSelectedView.callBack(YES, weakaddressSelectedView.selectedModel);
        }
        [FunctionSheetBaseView deletePopView:addressSelectedView];
    }];
     
    
    SANavHeaderView *headerView = [[SANavHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    headerView.delegate = addressSelectedView;
    addressSelectedView.headerView = headerView;
    [addressSelectedView addSubview:headerView];
}
- (SASelctedModel *)selectedModel{
    if (!_selectedModel) {
        _selectedModel = [[SASelctedModel alloc]init];
    }
    return _selectedModel;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, self.width, self.height-kSafeAreaBottom-40) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (NSArray *)dataArray{
    if (!_dataArray) {
        NSArray *dataArr = [[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ShoppingB.bundle/shopAddress" ofType:@"plist"]];
        NSMutableArray *mArray = [NSMutableArray array];
        for (NSDictionary *subDic in dataArr) {
            SAProvinceModel *model = [SAProvinceModel mj_objectWithKeyValues:subDic];
            [mArray addObject:model];
        }
        _dataArray = mArray;
    }
    return _dataArray;
}
#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (self.selected_level) {
        case 0:
            return self.dataArray.count;
            break;
        case 1:{
            SAProvinceModel *modelPro = self.dataArray[self.current_rowPro];
            return modelPro.cities.count;
        }
            break;
        case 2:{
            SAProvinceModel *modelPro = self.dataArray[self.current_rowPro];
            SARegionModel *modelRegion = modelPro.cities[self.current_rowRegion];
            return modelRegion.counties.count;
        }
            break;
            
        default:
            return 0;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SASelectedTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[SASelectedTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SASelectedTableCell"];
    }
    NSString *title = @"";
    switch (self.selected_level) {
        case 0:{//省市
            SAProvinceModel *modelPro;
            if (indexPath.row < self.dataArray.count) {
                modelPro = self.dataArray[indexPath.row];
            }
            if (self.selectedModel.areaId_one == modelPro.areaId) {
                cell.isChoice = YES;
            }else{
                cell.isChoice = NO;
            }
            title = modelPro.areaName;
        }
            break;
        case 1:{//地区
            SAProvinceModel *modelPro;
            if (self.current_rowPro < self.dataArray.count) {
                modelPro = self.dataArray[self.current_rowPro];
            }
            SARegionModel *modelRegion;
            if (indexPath.row < modelPro.cities.count) {
                modelRegion = modelPro.cities[indexPath.row];
            }
            if (self.selectedModel.areaId_two == modelRegion.areaId) {
                cell.isChoice = YES;
            }else{
                cell.isChoice = NO;
            }
            title = modelRegion.areaName;
        }
            break;
        case 2:{//县/街道
            SAProvinceModel *modelPro;
            if (self.current_rowPro < self.dataArray.count) {
                modelPro = self.dataArray[self.current_rowPro];
            }
            SARegionModel *modelRegion;
            if (self.current_rowRegion < modelPro.cities.count) {
                modelRegion = modelPro.cities[self.current_rowRegion];
            }
            SACountyModel *modelCounty;
            if (indexPath.row < modelRegion.counties.count) {
                modelCounty = modelRegion.counties[indexPath.row];
            }
            if (self.selectedModel.areaId_three == modelCounty.areaId) {
                cell.isChoice = YES;
            }else{
                cell.isChoice = NO;
            }
            title = modelCounty.areaName;
        }
            break;
            
        default:
            break;
    }
    if (title.length > 0) {
        cell.title = title;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   NSInteger index= 0;
   switch (self.selected_level) {
        case 0:{//省市
            SAProvinceModel *modelPro;
            if (indexPath.row < self.dataArray.count) {
                modelPro = self.dataArray[indexPath.row];
            }
            self.selectedModel = nil;
            if (modelPro) {
                self.selectedModel.areaId_one = modelPro.areaId;
                self.selectedModel.areaName_one = modelPro.areaName;
            }
             
            self.selected_level = 1;
            index = 0;
            self.current_rowPro = indexPath.row;
        }
            break;
        case 1:{//地区
            SAProvinceModel *modelPro;
            if (self.current_rowPro < self.dataArray.count) {
                modelPro = self.dataArray[self.current_rowPro];
            }
            SARegionModel *modelRegion;
            if (indexPath.row < modelPro.cities.count) {
                modelRegion = modelPro.cities[indexPath.row];
            }
            self.selectedModel = nil;
            if (modelPro) {
                self.selectedModel.areaId_one = modelPro.areaId;
                self.selectedModel.areaName_one = modelPro.areaName;
            }
            if (modelRegion) {
                self.selectedModel.areaId_two = modelRegion.areaId;
                self.selectedModel.areaName_two = modelRegion.areaName;
            }
            
            self.selected_level = 2;
            index = 1;
            self.current_rowRegion = indexPath.row;
        }
            break;
        case 2:{//县/街道
            SAProvinceModel *modelPro;
            if (self.current_rowPro < self.dataArray.count) {
                modelPro = self.dataArray[self.current_rowPro];
            }
            SARegionModel *modelRegion;
            if (self.current_rowRegion < modelPro.cities.count) {
                modelRegion = modelPro.cities[self.current_rowRegion];
            }
            SACountyModel *modelCounty;
            if (indexPath.row < modelRegion.counties.count) {
                modelCounty = modelRegion.counties[indexPath.row];
            }
            self.selectedModel = nil;
            if (modelPro) {
                self.selectedModel.areaId_one = modelPro.areaId;
                self.selectedModel.areaName_one = modelPro.areaName;
            }
            if (modelRegion) {
                self.selectedModel.areaId_two = modelRegion.areaId;
                self.selectedModel.areaName_two = modelRegion.areaName;
            }
            if (modelCounty) {
                self.selectedModel.areaId_three = modelCounty.areaId;
                self.selectedModel.areaName_three = modelCounty.areaName;
            }
            
            self.selected_level = 2;
            index = 2;
            self.current_rowCounty = indexPath.row;
        }
            break;
            
        default:
            break;
    }
    [self.headerView updateDataWith:self.selectedModel selectedIndex:index];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}
#pragma mark - SANavHeaderViewDelegate
- (void)SANavHeaderView:(SANavHeaderView *)headerView didSelectedAt:(NSInteger)index{
    if (index == 0) {//省市
        if (self.selectedModel) {
            self.selectedModel.areaId_two = 0;
            self.selectedModel.areaName_two = @"";
            self.selectedModel.areaId_three = 0;
            self.selectedModel.areaName_three = @"";
        }
        self.selected_level = 0;
    }else if (index == 1){//地区
         if (self.selectedModel) {
             self.selectedModel.areaId_three = 0;
             self.selectedModel.areaName_three = @"";
         }
         self.selected_level = 1;
    }else if (index == 2){//县区
         return;
    }
    [self.headerView updateDataWith:self.selectedModel selectedIndex:self.selected_level];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}
@end
