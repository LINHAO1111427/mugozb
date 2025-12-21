//
//  SystemNotiContentVC.m
//  Message
//
//  Created by klc_tqd on 2020/5/15.
//  Copyright © 2020 . All rights reserved.
//

#import "SystemNotiContentVC.h"
#import <LibProjModel/HttpApiMessage.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <MJRefresh/MJRefresh.h>
#import "SystemNotiContentCell.h"
#import <LibProjView/EmptyView.h>

@interface SystemNotiContentVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *dataArr;


@property (nonatomic, weak)EmptyView *emptyV;

@end

@implementation SystemNotiContentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [ProjConfig projBgColor];
    [self creatSubView];
    self.navigationItem.title = self.navTitle;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self reloadSystemNotiContentData:YES];
}

-(void)creatSubView{
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[SystemNotiContentCell class] forCellReuseIdentifier:@"SystemNotiContentCellID"];
    kWeakSelf(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself reloadSystemNotiContentData:YES];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself reloadSystemNotiContentData:NO];
    }];
    self.tableView.mj_footer.ignoredScrollViewContentInsetBottom = kSafeAreaBottom;
    EmptyView *empty = [[EmptyView alloc] init];
    empty.titleL.text = kLocalizationMsg(@"暂无数据");
    [empty showInView:self.view andFrame:CGRectMake(0, 0, self.view.width, self.view.height - 100)];
    _emptyV = empty;
      
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SystemNotiContentCell getSystemNotiContentCellHeight:self.dataArr[indexPath.row]];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

     SystemNotiContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SystemNotiContentCellID" forIndexPath:indexPath];
    
     if (cell == nil) {
        cell = [[SystemNotiContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SystemNotiContentCellID"];
     }
     cell.model = self.dataArr[indexPath.row];
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
    
}


//懒加载
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarHeight ) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [ProjConfig projBgColor];
    }
    return _tableView;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


-(void)reloadSystemNotiContentData:(BOOL)refresh{
    int pageSize = kPageSize;
    int pageIndex = refresh?0:(int)self.dataArr.count/pageSize  + (self.dataArr.count%pageSize?1:0);
    kWeakSelf(self);
    [HttpApiMessage getAppSystemNoticeUserList:[self.noticeId intValue] pageIndex:pageIndex pageSize:pageSize callback:^(int code, NSString *strMsg, NSArray<AppSystemNoticeUserModel *> *arr) {
         if (code == 1) {
               [[NSNotificationCenter defaultCenter] postNotificationName:NotificationUpdateStatus object:@{}];
               [weakself.tableView.mj_header endRefreshing];
               [weakself.tableView.mj_footer endRefreshing];
               if (refresh) {
                   [weakself.dataArr removeAllObjects];
               }
               if (arr.count > 0) {
                   [weakself.dataArr addObjectsFromArray:arr];
               }else{
                   [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
               }
               [weakself.tableView reloadData];
           }else{
               [self.tableView.mj_header endRefreshing];
               [self.tableView.mj_footer endRefreshing];
               [SVProgressHUD showInfoWithStatus:strMsg];
               
           }
            weakself.emptyV.hidden = weakself.dataArr.count;
    }];
  
}



@end
