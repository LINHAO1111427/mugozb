//
//  LiveTradePreviewTable.m
//  Shopping
//
//  Created by yww on 2020/8/10.
//  Copyright © 2020 klc. All rights reserved.
//

#import "LiveTradePreviewTable.h"
#import "LiveTradePreviewTableViewCell.h"
#import "LiveTradePreviewFooterView.h"
#import <LibProjModel/HttpApiShopBusiness.h>
#import <LibProjModel/ShopLiveAnnouncementDetailDTOModel.h>

@interface LiveTradePreviewTable ()<UITableViewDelegate,UITableViewDataSource,LiveTradePreviewFooterViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, copy)NSArray *dataArray;
@property (nonatomic, strong)LiveTradePreviewFooterView *footView;
@end

@implementation LiveTradePreviewTable
- (LiveTradePreviewFooterView *)footView{
    if (!_footView) {
        _footView = [[LiveTradePreviewFooterView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 370+kSafeAreaBottom)];
        _footView.superVc = self;
        _footView.delegate = self;
        _footView.backgroundColor = [UIColor whiteColor];
    }
    return _footView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LiveTradePreviewTableViewCell class] forCellReuseIdentifier:@"LiveTradePreviewTableViewCellID"];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = self.footView;
    [self getPreviewData];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.tableView addGestureRecognizer:tap];
}
- (void)tap{
    [self.footView endEditing:YES];
}

- (void)getPreviewData{
    kWeakSelf(self);
    [HttpApiShopBusiness getBusinessLiveAnnouncementList:[ProjConfig userId] callback:^(int code, NSString *strMsg, NSArray<ShopLiveAnnouncementDetailDTOModel *> *arr) {
        if (code == 1) {
            weakself.dataArray = arr;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself.tableView reloadData];
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArray.count == 0) {
        return 1;
    }else{
        return self.dataArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LiveTradePreviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LiveTradePreviewTableViewCellID" forIndexPath:indexPath];
    [cell showPreviewModel:(self.dataArray.count>indexPath.row)?self.dataArray[indexPath.row]:nil isEmpty:!self.dataArray.count];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    header.backgroundColor = [UIColor whiteColor];
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(12, 5, kScreenWidth-24, 20)];
    titleL.textAlignment = NSTextAlignmentLeft;
    titleL.font = [UIFont systemFontOfSize:14];
    titleL.text = kLocalizationMsg(@"直播预告");
    titleL.textColor = kRGB_COLOR(@"#333333");
    [header addSubview:titleL];
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
#pragma mark - 左滑删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataArray.count == 0) {
        return NO;
    }else{
        return YES;
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
  return UITableViewCellEditingStyleNone;
}
 
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    __block ShopLiveAnnouncementDetailDTOModel *model;
    if (indexPath.row < self.dataArray.count) {
        model = self.dataArray[indexPath.row];
    }
    kWeakSelf(self);
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:kLocalizationMsg(@"删除") handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [weakself deleteAddress:model];
    }];
    
    return @[delete];
}
- (void)deleteAddress:(ShopLiveAnnouncementDetailDTOModel *)model{
    kWeakSelf(self);
    [HttpApiShopBusiness delLiveAnnouncement:model.id_field callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [SVProgressHUD showSuccessWithStatus:strMsg];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself getPreviewData];
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}
#pragma mark - LiveTradePreviewFooterViewDelegate
- (void)LiveTradePreviewFooterViewAddPreviewBtnClick:(LiveTradePreviewFooterView *)footerView{
    [self getPreviewData];
}
#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}
- (void)listWillAppear{
     
}

@end
