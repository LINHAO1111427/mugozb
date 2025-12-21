//
//  OfficialMessageListVC.m
//  Message
//
//  Created by klc_sl on 2020/8/24.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "OfficialMessageListVC.h"

#import "OfficialMessageItemCell.h"
 
#import <LibTools/LibTools.h>
#import <MJRefresh/MJRefresh.h>
#import <LibProjBase/LibProjBase.h>
 
#import <LibProjModel/HttpApiMessage.h>
#import <LibProjModel/HttpApiOfficialNews.h>

#import <LibProjView/EmptyView.h>

@interface OfficialMessageListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak)UITableView *weakTableV;
@property (nonatomic, weak)EmptyView *emptyV;
@property (nonatomic, strong)NSMutableArray *allMuArray;
@end

@implementation OfficialMessageListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = kLocalizationMsg(@"官方消息");
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadOfficialList:YES];
    
    [self clearOfficialMessage];
}


- (void)clearOfficialMessage{
    [HttpApiMessage clearNoticeMsg:-1 type:5 callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
    }];
}


- (UITableView *)weakTableV{
    if (!_weakTableV) {
        UITableView *tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
        tableV.dataSource = self;
        tableV.delegate = self;
        tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableV.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [tableV registerClass:[OfficialMessageItemCell class] forCellReuseIdentifier:@"OfficialMessageItemCellIdentifier"];
        [self.view addSubview:tableV];
        kWeakSelf(self);
        tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakself loadOfficialList:YES];
        }];
        tableV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakself loadOfficialList:NO];
        }];
        _weakTableV = tableV;
        [tableV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(self.view);
        }];
        if (@available(iOS 11.0, *)) {
            tableV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _weakTableV;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allMuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OfficialMessageItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OfficialMessageItemCellIdentifier" forIndexPath:indexPath];
    cell.model = (_allMuArray.count > indexPath.row)?_allMuArray[indexPath.row]:nil;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_allMuArray.count > indexPath.row) {
        [RouteManager routeForName:RN_Message_OfficialDetailNotice currentC:self parameters:@{@"model":_allMuArray[indexPath.row]}];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 250.0;
}

- (NSMutableArray *)allMuArray{
    if (!_allMuArray) {
        _allMuArray = [[NSMutableArray alloc] init];
    }
    return _allMuArray;
}

- (EmptyView *)emptyV{
    if (!_emptyV) {
        EmptyView *emptyView = [[EmptyView alloc] init];
        emptyView.iconImgV.image  = [UIImage imageNamed:@"home_guangchang_meiyouzhubo"];
        emptyView.titleL.text = kLocalizationMsg(@"～暂无消息～");
        [emptyView showInView:self.view];
        _emptyV = emptyView;
    }
    return _emptyV;
}

- (void)loadOfficialList:(BOOL)refresh{
    kWeakSelf(self);
    int pageSize = kPageSize;
    int pageIndex = refresh?0:(int)self.allMuArray.count/pageSize  + (self.allMuArray.count%pageSize?1:0);
    [HttpApiOfficialNews getOfficialNewsList:pageIndex pageSize:pageSize callback:^(int code, NSString *strMsg, NSArray<AppOfficialNewsDTOModel *> *arr) {
        if (code == 1) {
            [weakself.weakTableV.mj_header endRefreshing];
            [weakself.weakTableV.mj_footer endRefreshing];
            if (refresh) {
                [weakself.allMuArray removeAllObjects];
            }
            if (arr.count > 0) {
                [weakself.allMuArray addObjectsFromArray:arr];
                [weakself.weakTableV reloadData];
            }else{
                [weakself.weakTableV.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            [weakself.weakTableV.mj_header endRefreshing];
            [weakself.weakTableV.mj_footer endRefreshing];
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
        weakself.emptyV.hidden = weakself.allMuArray.count;
    }];
}


- (UIView *)listView {
    return self.view;
}


@end
