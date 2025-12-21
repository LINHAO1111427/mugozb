//
//  AboutUsViewController.m
//  klcProject
//
//  Created by ssssssss on 2020/7/27.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "AboutUsViewController.h"
#import <LibProjModel/ApiUserIndexNodeModel.h>
#import "MineCenterItemCell.h"
#import <LibProjBase/ProjConfig.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/HttpApiUserController.h>
#import <LibProjView/ForceAlertController.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibTools/LibTools.h>
 

#import <LibProjView/AppVersion.h>
#import <TXImKit/TXImKit.h>

@interface AboutUsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak)UITableView *weakTableV;
@property (nonatomic, strong) NSArray<ApiUserIndexNodeModel*>* modelList;
@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = kLocalizationMsg(@"关于我们");
     [self createUI];
}

- (void)createUI{
    UITableView *tableV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableV registerClass:[MineCenterItemCell class] forCellReuseIdentifier:@"MineCenterItemCell"];
    [self.view addSubview:tableV];
    _weakTableV = tableV;
    [self requestRespModel];
    //tableHeaderView
    UIView *tableHeaderV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 140)];
    tableHeaderV.backgroundColor = kRGB_COLOR(@"#F5F5F5");
    UIImageView *logoImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    logoImageV.image = [ProjConfig getAppIcon];
    logoImageV.layer.cornerRadius = 8;
    logoImageV.clipsToBounds = YES;
    logoImageV.center = tableHeaderV.center;
    logoImageV.contentMode = UIViewContentModeScaleAspectFill;
    [tableHeaderV addSubview:logoImageV];
    self.weakTableV.tableHeaderView = tableHeaderV;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section?1:self.modelList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineCenterItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCenterItemCell" forIndexPath:indexPath];
    ApiUserIndexNodeModel *model = self.modelList[indexPath.row];
    cell.funcionLab.text = model.name;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView reloadData];
    ApiUserIndexNodeModel *model = self.modelList[indexPath.row];
    [RouteManager routeForName:RN_general_webView currentC:self parameters:@{@"url":model.app_url}];
}
 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (void)requestRespModel{
    [HttpApiUserController infoIndex:^(int code, NSString *strMsg, ApiUserIndexRespModel *model) {
        if (code == 1) {
            NSMutableArray *arr = [NSMutableArray array];
            for (ApiUserIndexNodeModel *mod in model.setList) {
                if (mod.id_field != 66 && mod.id_field != 67 && mod.id_field != 68) {
                    [arr addObject:mod];
                }
            }
            self.modelList = arr;
            [self.weakTableV reloadData];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
    
}

 
@end
