//
//  FansGroupMsgUserListVC.m
//  Message
//
//  Created by klc_tqd on 2020/5/14.
//  Copyright © 2020 . All rights reserved.
//

#import "FansGroupMsgUserListVC.h"

#import "GroupMemberCell.h"

#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/HttpApiAnchorController.h>

@interface FansGroupMsgUserListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSArray<FansInfoModel *> *dataArr;

@end

@implementation FansGroupMsgUserListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = kLocalizationMsg(@"群成员");
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[GroupMemberCell class] forCellReuseIdentifier:@"GroupMemberCellID"];
    
    [self getGroupUserList];
}

- (void)getGroupUserList{
    kWeakSelf(self);
    [HttpApiAnchorController getFansByGroupId:self.groupId callback:^(int code, NSString *strMsg, NSArray<FansInfoModel *> *arr) {
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
    [cell showFansUserInfo:(self.dataArr.count > indexPath.row)?self.dataArr[indexPath.row]:nil anchorId:self.anchorId];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.dataArr.count > indexPath.row) {
        FansInfoModel *userModel = self.dataArr[indexPath.row];
        [RouteManager routeForName:RN_user_userInfoVC currentC:self parameters:@{@"id":@(userModel.userId)}];
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




@end
