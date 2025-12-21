//
//  UserBlackListVC.m
//  UserInfo
//
//  Created by klc_sl on 2021/11/13.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "UserBlackListVC.h"
#import "UserInfoRes.h"
#import "UserListItemCell.h"
#import <LibProjView/EmptyView.h>
#import <LibProjModel/HttpApiUserController.h>

@interface UserBlackListVC ()

@property (nonatomic, strong)NSMutableArray *listArr;
@property (nonatomic,weak)EmptyView *emptyV;

@end

@implementation UserBlackListVC

- (NSMutableArray *)listArr{
    if (!_listArr) {
        _listArr = [[NSMutableArray alloc] init];
    }
    return _listArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = kLocalizationMsg(@"黑名单管理");
    if (kiOS(15)) {
        self.tableView.sectionHeaderTopPadding = 0;
    }
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:[UserInfoRes getNibFullName:@"UserListItemCell"] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:UserListItemCellIdentifier];
    
    kWeakSelf(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadData:YES];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself loadData:NO];
    }];
    self.tableView.mj_footer.ignoredScrollViewContentInsetBottom = kSafeAreaBottom;
    
    EmptyView *empty = [[EmptyView alloc] init];
    empty.iconImgV.image = [UIImage imageNamed:@"home_guangchang_meiyouzhubo"];
    empty.titleL.text = kLocalizationMsg(@"未找到相关内容");
    [empty showInView:self.view];
    _emptyV = empty;

    [self loadData:YES];
}


-(void)loadData:(BOOL)refresh{

    int pageSize = kPageSize;
    int page = refresh?0:(int)self.listArr.count/pageSize  + (self.listArr.count%pageSize?1:0);
    
    kWeakSelf(self);
    [HttpApiUserController getBlockList:page pageSize:pageSize callback:^(int code, NSString *strMsg, NSArray<ApiUserBlackInfoVOModel *> *arr) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (code == 1) {
            if (refresh) {
                [weakself.listArr removeAllObjects];
            }
            if (arr.count > 0) {
                [weakself.listArr addObjectsFromArray:arr];
            }else{
                [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [weakself.tableView reloadData];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
        weakself.emptyV.hidden = weakself.listArr.count;
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UserListItemCell *cell = [tableView dequeueReusableCellWithIdentifier:UserListItemCellIdentifier forIndexPath:indexPath];
    if (self.listArr.count > indexPath.row) {
        cell.model = self.listArr[indexPath.row];
        kWeakSelf(self);
        cell.clickCancelBtn = ^(UserListItemCell *cell) {
            [weakself cancelBlackHandle:cell.model.userId];
        };
    }
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.listArr.count > indexPath.row) {
        ApiUserBlackInfoVOModel *model = self.listArr[indexPath.row];
        [RouteManager routeForName:RN_user_userInfoVC currentC:self parameters:@{@"id":@(model.userId)}];
    }
}


///取消拉黑操作
- (void)cancelBlackHandle:(int64_t)userId{
    kWeakSelf(self);
    [HttpApiUserController blockOperation:0 userId:userId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        [SVProgressHUD dismiss];
        if (code == 1) {
            [weakself loadData:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}




@end
