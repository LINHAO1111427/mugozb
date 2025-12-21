//
//  MineSettingVC.m
//  klcProject
//
//  Created by ssssssss on 2020/7/25.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "MineSettingVC.h"

#import <TXImKit/TXImKit.h>
#import <LibTools/LibTools.h>

#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/HttpApiUserController.h>
#import <LibProjModel/HttpApiBingAccount.h>
#import <LibProjModel/ApiUserIndexNodeModel.h>
#import <LibProjModel/UserLogoutVerificationDTOModel.h>

#import <LibProjBase/LibProjBase.h>
#import <LibProjBase/ProjBaseData.h>

#import <LibProjView/AppVersion.h>


#import <LibProjView/ForceAlertController.h>

#import "MineSettingItemCell.h"
#import "AboutUsViewController.h"

@interface MineSettingVC ()<UITableViewDelegate,UITableViewDataSource,MineSettingItemCellDelegate>
@property (nonatomic, weak)UITableView *weakTableV;
@property (nonatomic, strong)NSArray *settingArray;
@property (nonatomic, strong)NSArray *languageListArray;
@end

@implementation MineSettingVC


- (instancetype)init{
    self = [super init];
    if (self) {
        _settingArray = [[ProjConfig shareInstence].businessConfig getSettingTitleArray];
        _languageListArray = [[ProjConfig shareInstence].businessConfig getAppLanguageList];
    }
    return self;
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = kLocalizationMsg(@"设置");
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}

- (void)createUI{
    UITableView *tableV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableV registerClass:[MineSettingItemCell class] forCellReuseIdentifier:@"MineSettingItemCell"];
    [self.view addSubview:tableV];
    _weakTableV = tableV;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.settingArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *dic = self.settingArray[section];
    return ((NSArray *)dic[@"list"]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineSettingItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineSettingItemCell" forIndexPath:indexPath];
    NSArray *arr = self.settingArray[indexPath.section][@"list"];
    NSDictionary *dict = arr[indexPath.row];
    cell.delegate = self;
    int type = [dict[@"type"] intValue];
    int tag = [dict[@"tag"] intValue];
    NSString *title = dict[@"title"];
    NSString *contentStr = @"";
    
    switch (tag) {
        case 3001://消息设置
        case 3002://关于我们
            break;
        case 3003://缓存
            contentStr = [NSString stringWithFormat:@"%.2fMB",[ProjectCache cacheSize]];;
            break;
        case 3004:{//手机号
            NSString *mobile = KLCUserInfo.getUserInfo.mobile;
            if (mobile.length > 0 && ![mobile isEqualToString:@"-1"]) {
                contentStr = [NSString stringWithFormat:@"%@",KLCUserInfo.getUserInfo.mobile];
            }
        }
            break;
        case 3005://密码修改
            break;
        case 3006://账号注销
            break;
        case 3007://当前版本
            contentStr = [IPhoneInfo appVersionNO];
            break;
        case 3008://退出登录
            break;
        case 3010://隐私设置
            break;
        default:
            break;
    }
    [cell showInfoType:type titleStr:title contentStr:contentStr];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView reloadData];
    kWeakSelf(self);
    NSArray *arr = self.settingArray[indexPath.section][@"list"];
    NSDictionary *dict = arr[indexPath.row];
    int tag = [dict[@"tag"] intValue];
    switch (tag) {
        case 3000://是否显示位置
            break;
        case 3001:{//消息设置
           // NSLog(@"过滤文字消息设置"));
            [RouteManager routeForName:RN_center_setting_messageSet currentC:self];
        }
            break;
        case 3002:{//关于我们
            AboutUsViewController *aboutUsVc = [[AboutUsViewController alloc]init];
            [self.navigationController pushViewController:aboutUsVc animated:YES];
        }
            break;
        case 3003:{//缓存
            UIAlertController *alertCache = [UIAlertController alertControllerWithTitle:nil message:kLocalizationMsg(@"您确定要清理缓存吗？") preferredStyle:UIAlertControllerStyleAlert];
            [alertCache addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"确定") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakself clearCache];
            }]];
            [alertCache addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"取消") style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alertCache animated:YES completion:nil];
        }
            break;
        case 3004:{//手机号
            NSString *mobile = KLCUserInfo.getUserInfo.mobile;
            if (mobile.length > 0 && ![mobile isEqualToString:@"-1"]) {
                [RouteManager routeForName:RN_center_setting_bindOrModifyPhone currentC:self parameters:@{@"title":kLocalizationMsg(@"手机号修改"),@"type":@1}];
            }else{
                [RouteManager routeForName:RN_center_setting_bindOrModifyPhone currentC:self parameters:@{@"title":kLocalizationMsg(@"手机号绑定"),@"type":@0}];
            }
        }
            break;
        case 3005:{//密码修改
            [RouteManager routeForName:RN_center_setting_changePassword currentC:self parameters:@{@"title":dict[@"title"]}];
        }
            break;
        case 3006:{//账号注销
            [self resignAccount];
        }
            break;
        case 3007:{//当前版本
            [self checkVersion];
        }
            break;
        case 3008:{//退出登录
            UIAlertController *alertExit = [UIAlertController alertControllerWithTitle:nil message:kLocalizationMsg(@"您真的要退出吗？") preferredStyle:UIAlertControllerStyleAlert];
            [alertExit addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"确定") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakself Logout];
            }]];
            [alertExit addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"取消") style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alertExit animated:YES completion:nil];
        }
            break;
        case 3009://位置是否保密
            break;
        case 3010://隐私设置
            [RouteManager routeForName:RN_center_SafeAndPrivacy currentC:self];
            break;
        case 3020: // 更换语言
        {
            UIAlertController *changeLanguageAlert = [UIAlertController alertControllerWithTitle:kLocalizationMsg(@"语言") message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
            
            for (NSDictionary *dic in self.languageListArray) {
                UIAlertAction *action = [UIAlertAction actionWithTitle:dic[@"title"]
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * _Nonnull action) {
                    [self languageActionClick:dic];
                }];
                [changeLanguageAlert addAction:action];
            }
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:kLocalizationMsg(@"取消")
                                                             style:UIAlertActionStyleCancel
                                                           handler:^(UIAlertAction * _Nonnull action) {}];
            [changeLanguageAlert addAction:cancelAction];
            
            [self presentViewController:changeLanguageAlert animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
    
}

- (void)languageActionClick:(NSDictionary *)dic{
    
    NSString *mark = dic[@"mark"];
    if (!mark.length){
        return;
    }
    [LanguageConfig setUserLanguage:mark];
    [[ProjConfig shareInstence].baseConfig showHomeMainVC];
}

- (void)resignAccount{
    [HttpApiBingAccount logoutVerification:^(int code, NSString *strMsg, UserLogoutVerificationDTOModel *model) {
        if (model.role > 0 && model.logOffSwitch == 0) {
            if (model.votes > 0) {
                [self alertVotesTipWith:model];//收益剩余提示
            }else if(model.coin > 0){
                [self alertCoinTipWith:model];//余额提示
            }else{
                [RouteManager routeForName:RN_center_setting_cancelAccount currentC:self];
            }
        }else{
            if (model.coin > 0) {
                [self alertCoinTipWith:model];//余额提示
            }else{
                [RouteManager routeForName:RN_center_setting_cancelAccount currentC:self];
            }
        }
    }];
}
- (void)alertCoinTipWith:(UserLogoutVerificationDTOModel *)model{
    kWeakSelf(self);
    NSString *msg = [NSString stringWithFormat:kLocalizationMsg(@"你的账户还有%.0f%@，可以先找消费完再注销哦！"),model.coin,[KLCAppConfig unitStr]];
    ForceAlertController *alert = [ForceAlertController alertTitle:kLocalizationMsg(@"账户注销提示") message:msg];
    [alert addOptions:kLocalizationMsg(@"确认注销") textColor:ForceAlert_BlackColor clickHandle:^{
        [RouteManager routeForName:RN_center_setting_cancelAccount currentC:weakself];
    }];
    [alert addOptions:[NSString stringWithFormat:kLocalizationMsg(@"去花%@"),[KLCAppConfig unitStr]] textColor:ForceAlert_NormalColor clickHandle:nil];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)alertVotesTipWith:(UserLogoutVerificationDTOModel *)model{
    NSString *msg = [NSString stringWithFormat:kLocalizationMsg(@"你的账户还有%.0f%@，请先提现后再注销账户"),model.votes,[KLCAppConfig incomeUnitStr]];
    ForceAlertController *alert = [ForceAlertController alertTitle:kLocalizationMsg(@"账户注销提示") message:msg];
    [alert addOptions:kLocalizationMsg(@"我知道了") textColor:ForceAlert_NormalColor clickHandle:nil];
    [self presentViewController:alert animated:YES completion:nil];
}

///退出
- (void)Logout{
    [HttpApiUserController logout:^(int code, NSString *strMsg, SingleStringModel *model) {
        
    }];
    [ProjConfig logout];
}

///检查版本
-  (void)checkVersion{
    [AppVersion versionJudgment];
}

///清理缓存
- (void)clearCache{
    [ProjectCache clearCache];
    [_weakTableV reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}



#pragma mark - MineSettingItemCellDelegate
- (void)MineSettingItemCell:(MineSettingItemCell *)cell switchBarStatus:(BOOL)isOpen{
}

@end
