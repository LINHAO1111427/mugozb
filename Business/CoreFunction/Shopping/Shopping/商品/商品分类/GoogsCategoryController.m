//
//  GoogsCategoryController.m
//  Shopping
//
//  Created by klc_sl on 2020/7/2.
//  Copyright © 2020 klc. All rights reserved.
//

#import "GoogsCategoryController.h"
#import <LibProjModel/HttpApiShopGoods.h>
#import <LibTools/LibTools.h>

@interface GoogsCategoryController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak)UITableView *tableV;
@property (nonatomic, copy)NSArray<ShopGoodsCategoryModel *> *itemArr;

@end

@implementation GoogsCategoryController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = kLocalizationMsg(@"商品分类");
    self.view.backgroundColor = [UIColor whiteColor];
    [self getCategoryList];
}

- (void)getCategoryList{
    kWeakSelf(self);
    [HttpApiShopGoods getCategoryList:^(int code, NSString *strMsg, NSArray<ShopGoodsCategoryModel *> *arr) {
        if (code == 1) {
            weakself.itemArr = arr;
            [weakself.tableV reloadData];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


- (UITableView *)tableV{
    if (!_tableV) {
        UITableView *tableV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableV.dataSource = self;
        tableV.delegate = self;
        tableV.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        tableV.tableFooterView = [UIView new];
        [tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableViewCellDefault"];
        [self.view addSubview:tableV];
        _tableV = tableV;
    }
    return _tableV;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _itemArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCellDefault" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ShopGoodsCategoryModel *model = _itemArr[indexPath.row];
    cell.textLabel.text = model.name;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = kRGB_COLOR(@"#555555");
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_selectCategory) {
        ShopGoodsCategoryModel *model = _itemArr[indexPath.row];
        _selectCategory(model.id_field, model.name);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

@end
