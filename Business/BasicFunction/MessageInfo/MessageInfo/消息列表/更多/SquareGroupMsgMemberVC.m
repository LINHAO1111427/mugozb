//
//  SquareGroupMsgMemberVC.m
//  Message
//
//  Created by klc_tqd on 2020/5/14.
//  Copyright © 2020 . All rights reserved.
//

#import "SquareGroupMsgMemberVC.h"

#import "GroupMemberCell.h"

#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/HttpApiChatFamilyController.h>

@interface SquareGroupMsgMemberVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSArray<AppHomeFamilyUserVOModel *> *dataArr;

@end

@implementation SquareGroupMsgMemberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = kLocalizationMsg(@"成员列表");
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[GroupMemberCell class] forCellReuseIdentifier:@"GroupMemberCellID"];
    
    [self getGroupUserList];
}

- (void)getGroupUserList{
    kWeakSelf(self);
    [HttpApiChatFamilyController getFamilyUserList:self.groupId pageIndex:0 pageSize:200 callback:^(int code, NSString *strMsg, NSArray<AppHomeFamilyUserVOModel *> *arr) {
        if (code == 1) {
            weakself.dataArr = arr;
            [weakself.tableView reloadData];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GroupMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupMemberCellID" forIndexPath:indexPath];
    cell.userModel = (self.dataArr.count > indexPath.row)?self.dataArr[indexPath.row]:nil;
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.dataArr.count > indexPath.row) {
        AppHomeFamilyUserVOModel *userModel = self.dataArr[indexPath.row];
        [self showFuncAlert:userModel selectIndex:indexPath];
    }
}


//获取tableView上面所有的NSIndexPath
- (NSArray<NSIndexPath *> *)cellsForTableView:(UITableView *)tableView
{
    NSInteger sections = tableView.numberOfSections;
    NSMutableArray *indexPathArr = [[NSMutableArray alloc]  init];
    for (int section = 0; section < sections; section++) {
        NSInteger rows =  [tableView numberOfRowsInSection:section];
        for (int row = 0; row < rows; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            [indexPathArr addObject:indexPath];
        }
    }
    return indexPathArr;
}



//懒加载
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
    }
    return _tableView;
}


- (void)showFuncAlert:(AppHomeFamilyUserVOModel *)userModel selectIndex:(NSIndexPath *)indexPath{
    if (userModel.userId == [ProjConfig userId]) {
        [RouteManager routeForName:RN_user_userInfoVC currentC:self parameters:@{@"id":@(userModel.userId)}];
        return;
    }
    kWeakSelf(self);
    if (self.isSquareMute) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:kLocalizationMsg(@"管理%@"),userModel.userName] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alertVC addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"查看资料") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [RouteManager routeForName:RN_user_userInfoVC currentC:weakself parameters:@{@"id":@(userModel.userId)}];
        }]];
        ///是否禁言
        [alertVC addAction:[UIAlertAction actionWithTitle:userModel.isItBanned?kLocalizationMsg(@"解除禁言"):kLocalizationMsg(@"禁言") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakself setUserMute:userModel selectIndex:indexPath];
        }]];
        
        [alertVC addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"取消") style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertVC animated:YES completion:nil];
        
    }else{
        [RouteManager routeForName:RN_user_userInfoVC currentC:self parameters:@{@"id":@(userModel.userId)}];
    }
}

///禁言
- (void)setUserMute:(AppHomeFamilyUserVOModel *)userModel selectIndex:(NSIndexPath *)indexPath{
    GroupMemberCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    int handleType = userModel.isItBanned+1;
    [HttpApiChatFamilyController addOrDelMuteUser:self.groupId optType:handleType userId:userModel.userId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            userModel.isItBanned = (handleType==2?0:1);
            cell.userModel = userModel;
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}



@end
