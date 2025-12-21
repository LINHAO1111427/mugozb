//
//  SystemNotificationListVC.m
//  Message
//
//  Created by klc_tqd on 2020/5/9.
//  Copyright © 2020 . All rights reserved.
//

#import "SystemNotificationListVC.h"

#import "SystemNotiContentVC.h"
#import <Masonry.h>
#import "SystemNotiListCell.h"
#import <LibTools/LibTools.h>
#import <MJRefresh/MJRefresh.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/HttpApiMessage.h> 
#import <LibProjView/ZGQActionSheetView.h>
#import <LibProjView/EmptyView.h>

@interface SystemNotificationListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSArray *dataArr;


@property (nonatomic, weak)EmptyView *emptyV;

@end

@implementation SystemNotificationListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [ProjConfig projBgColor];
    self.navigationItem.title = kLocalizationMsg(@"通知");
    [self creatSubView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadMessageSystemNotificationData];
}

-(void)creatSubView{
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.tableView registerClass:[SystemNotiListCell class] forCellReuseIdentifier:@"SystemNotiListCellID"];
    
    EmptyView *empty = [[EmptyView alloc] init];
    empty.titleL.text = kLocalizationMsg(@"暂无通知哦~");
    [empty showInView:self.view andFrame:CGRectMake(0, 0, self.view.width, self.view.height - 100)];
    _emptyV = empty;
    
    kWeakSelf(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself reloadMessageSystemNotificationData];
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SystemNotiListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SystemNotiListCellID" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[SystemNotiListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SystemNotiListCellID"];
    }
    
    cell.model = self.dataArr[indexPath.row];
    kWeakSelf(self);
    cell.cellLongTapBlock = ^(int64_t noticeId) {
        [weakself cellLongTabEvent:noticeId];
    };
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AppHomeSystemNoticeVOModel *model =  self.dataArr[indexPath.row];
    [RouteManager routeForName:RN_Message_OneSystemNoticeList currentC:self parameters:@{@"noticeId":@(model.noticeId),@"noticeName":model.showTitle}];
}


//懒加载
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarHeight - kTabBarHeight) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 18, 0);
    }
    return _tableView;
}

-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}


-(void)reloadMessageSystemNotificationData{
    
    kWeakSelf(self);
    [HttpApiMessage getAppSystemNoticeList:^(int code, NSString *strMsg, NSArray<AppHomeSystemNoticeVOModel *> *arr) {
        [weakself.tableView.mj_header endRefreshing];
        if (code == 1) {
            self.dataArr = arr;
            [weakself.tableView reloadData];
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationUpdateStatus object:@{}];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
        weakself.emptyV.hidden = weakself.dataArr.count;
    }];
    
}



-(void)cellLongTabEvent:(int64_t)noticeId{
    NSArray *optionArray = @[kLocalizationMsg(@"已读"),kLocalizationMsg(@"删除")];
    kWeakSelf(self);
    ZGQActionSheetView *sheetView = [[ZGQActionSheetView alloc] initWithOptions:optionArray completion:^(NSInteger index) {
        switch (index) {
            case 0:
                [weakself getClearNotice:noticeId];
                break;
            case 1:
                [weakself getDelNoticeMsg:noticeId];
                break;
            default:
                break;
        }
        
    } cancel:^{
       // NSLog(@"过滤文字取消"));
    }];
    [sheetView show];
}


-(void)getClearNotice:(int64_t)noticeId{
    [HttpApiMessage clearNoticeMsg:noticeId type:3 callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [self reloadMessageSystemNotificationData];
        }
    }];
}


-(void)getDelNoticeMsg:(int64_t)noticeId{
    [HttpApiMessage delNoticeMsg:noticeId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [self reloadMessageSystemNotificationData];
        }
    }];
}


- (UIView *)listView {
    return self.view;
}


@end
