//
//  ShopWithdrawAccountVC.m
//  Shopping
//
//  Created by ssssssss on 2020/8/6.
//  Copyright © 2020 klc. All rights reserved.
//

#import "ShopWithdrawAccountVC.h"

#import "ShopWithdrawAccountCell.h"
#import "ShopMineAddAccountView.h"
#import "ShopAddWithdrawalAccountVC.h"

#import <LibProjModel/HttpApiAPPFinance.h>
#import <LibProjView/EmptyView.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>

@interface ShopWithdrawAccountVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray *accountArr;
@property (nonatomic, weak)UITableView *weakTableV;
@property (nonatomic, strong)AppUsersCashAccountModel *selctedModel;

@end

@implementation ShopWithdrawAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = kLocalizationMsg(@"提现账户");
    
    [self addFooterView];
    
}
- (void)addFooterView{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80+90+kSafeAreaBottom)];
    footerView.backgroundColor = [UIColor clearColor];
    self.weakTableV.tableFooterView = footerView;
    
    
    UIView *addView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    addView.backgroundColor = [UIColor whiteColor];
    [footerView addSubview:addView];
    
    UIImageView *addImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 40, 40)];
    addImageView.image = [UIImage imageNamed:@"icon_account_add"];
    [addView addSubview:addImageView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(addImageView.maxX+10, 0, 100, 20)];
    titleLabel.centerY = 40;
    titleLabel.textColor = kRGB_COLOR(@"#333333");
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.text = kLocalizationMsg(@"添加账号");
    [addView addSubview:titleLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(70, 79, kScreenWidth-80, 1)];
    line.backgroundColor = kRGB_COLOR(@"#EEEEEE");
    [addView addSubview:line];
    
    UIButton *addAccountBtn = [[UIButton alloc]initWithFrame:addView.bounds];
    [addAccountBtn addTarget:self action:@selector(addAccountBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    addAccountBtn.backgroundColor = [UIColor clearColor];
    [addView addSubview:addAccountBtn];
    
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, addView.maxY+40, kScreenWidth-40, 40)];
    sureBtn.layer.cornerRadius  = 20;
    sureBtn.clipsToBounds = YES;
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn setTitle:kLocalizationMsg(@"确定") forState:UIControlStateNormal];
    sureBtn.backgroundColor = [ProjConfig normalColors];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:sureBtn];
}
 
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

- (UITableView *)weakTableV{
    if (_weakTableV == nil) {
        UITableView *tableV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableV.delegate = self;
        tableV.dataSource = self;
        tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        [tableV registerClass:[ShopWithdrawAccountCell class] forCellReuseIdentifier:ShopWithdrawAccountCellIdentifier];
        tableV.backgroundColor =kRGB_COLOR(@"#EDEDED");
        [self.view addSubview:tableV];
        _weakTableV = tableV;
    }
    return _weakTableV;
}
- (void)addAccountBtnClick:(UIButton *)btn{
    ShopAddWithdrawalAccountVC *accountVC = [[ShopAddWithdrawalAccountVC alloc] initWith:NO model:self.selctedModel];
    accountVC.isEdit = NO;
    [self.navigationController pushViewController:accountVC animated:YES];
}
- (void)sureBtnClick:(UIButton *)btn{
    if (self.selctedModel) {
        if (self.selectHandle) {
            self.selectHandle(self.selctedModel);
        }
        _defaultModel = nil;
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请选择提现账户")];
    }
}
- (void)loadData{
    kWeakSelf(self);
    [HttpApiAPPFinance withdrawAccount:^(int code, NSString *strMsg, NSArray<AppUsersCashAccountModel *> *arr) {
        if (code == 1) {
            weakself.accountArr = [NSMutableArray arrayWithArray:arr];
            for (AppUsersCashAccountModel *model in arr) {
                if (model.isDefault) {
                    weakself.defaultModel = model;
                    if (!self.selctedModel) {
                        self.selctedModel = model;
                    }
                    break;
                }
            }
            if (arr.count > 0) {
                [weakself.weakTableV reloadData];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _accountArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopWithdrawAccountCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[ShopWithdrawAccountCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ShopWithdrawAccountCellIdentifier];;
    }
    AppUsersCashAccountModel *model;
    if (indexPath.row < _accountArr.count) {
        model = _accountArr[indexPath.row];
    }
    if (model) {
        [cell setDefaultModel:self.selctedModel showModel:model];
    }
    kWeakSelf(self);
    cell.deleteModel = ^(AppUsersCashAccountModel * _Nonnull accountModel) {
        [weakself removeAccountModel:accountModel];
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selctedModel = self.accountArr[indexPath.row];
    [self.weakTableV reloadData];
}
#pragma mark - 左滑删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
   return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
  return UITableViewCellEditingStyleNone;
}
 
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    __block AppUsersCashAccountModel *model;
    if (indexPath.row < _accountArr.count) {
        model = _accountArr[indexPath.row];
    }
     
    kWeakSelf(self);
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:kLocalizationMsg(@"删除") handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [weakself removeAccountModel:model];
    }];
    
    UITableViewRowAction *edite = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:kLocalizationMsg(@"编辑") handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        tableView.editing = NO;
        if (model) {
            ShopAddWithdrawalAccountVC *accountVC = [[ShopAddWithdrawalAccountVC alloc] initWith:YES model:model];
            accountVC.isEdit = YES;
            [weakself.navigationController pushViewController:accountVC animated:YES];
        }
    }];
    return @[delete, edite];
}

 
- (void)removeAccountModel:(AppUsersCashAccountModel *)model{
    kWeakSelf(self);
    __weak typeof(AppUsersCashAccountModel *) weakModel = model;
    [HttpApiAPPFinance withdrawAccountDel:model.id_field callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            NSMutableArray *muArr = [weakself.accountArr mutableCopy];
            [muArr removeObject:weakModel];
            weakself.accountArr = muArr;
            [weakself.weakTableV reloadData];
            if (muArr.count == 0) {
                if (self.selectHandle) {
                    self.selectHandle(nil);
                }
            }
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


 
@end
