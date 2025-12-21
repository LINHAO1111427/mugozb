//
//  SearchAnchorVC.m
//  TCDemo
//
//  Created by admin on 2019/10/25.
//  Copyright © 2019 CH. All rights reserved.
//

#import "SearchAnchorVC.h"

#import "UserInfoRes.h"

#import <LibProjView/SearchNaviView.h>
#import "SearchAnchorItemCell.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/ProjConfig.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjBase/BaseNavBarItem.h>

#import <LibProjView/CheckRoomPermissions.h>
#import <LibProjView/EmptyView.h>

@interface SearchAnchorVC ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic)UITableView *weakTableV;
@property (nonatomic,strong)NSMutableArray *searchMuArr;
@property (nonatomic,weak)EmptyView *emptyV;
@property (nonatomic, copy)NSString *searchText;

@property (nonatomic, strong)SearchNaviView *searchView;

@end

@implementation SearchAnchorVC

- (void)dealloc
{
    [self searchVCDealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [BaseNavBarItem navbar:self bgImage:[UIImage imageWithColor:[UIColor whiteColor]] foregroundColor:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchVCDealloc) name:NotificationUserLogout object:nil];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0 ,kScreenWidth ,kScreenHeight-kNavBarHeight-kSafeAreaBottom) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    NSBundle *bundle = [NSBundle bundleForClass:[SearchAnchorItemCell class]];
    NSString *nibName = [UserInfoRes getNibFullName:@"SearchAnchorItemCell"];
    [tableView registerNib:[UINib nibWithNibName:nibName bundle:bundle] forCellReuseIdentifier:SearchAnchorItemCellIdentifier];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    _weakTableV = tableView;
    kWeakSelf(self);
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadData:YES];
    }];
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself loadData:NO];
    }];
    EmptyView *empty = [[EmptyView alloc] init];
    empty.iconImgV.image = [UIImage imageNamed:@"home_guangchang_meiyouzhubo"];
    empty.titleL.text = kLocalizationMsg(@"未找到相关内容");
    [empty showInView:self.view];
    _emptyV = empty;
    [self addSearchBar];
    
}

- (void)searchVCDealloc{
    self.navigationItem.leftBarButtonItem  = nil;
    self.navigationItem.rightBarButtonItem  = nil;
    [_searchMuArr removeAllObjects];
    _searchMuArr = nil;
    [_searchView removeFromSuperview];
    _searchView = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (NSMutableArray *)searchMuArr{
    if (_searchMuArr == nil) {
        _searchMuArr = [[NSMutableArray alloc] init];
    }
    return _searchMuArr;
}

//添加搜索条
- (void)addSearchBar {
    
    _searchView = [[SearchNaviView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-80, 30)];
    _searchView.backgroundColor = [UIColor whiteColor];
    
    kWeakSelf(self);
    _searchView.searchText = ^(NSString * text) {
        [weakself searchText:text];
    };
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_searchView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[BaseNavBarItem navItemTitle:kLocalizationMsg(@"取消") bgColor:[ProjConfig normalColors] textColor:[UIColor whiteColor] clickHandle:^{
        [weakself searchVCDealloc];
        [weakself.navigationController popViewControllerAnimated:YES];
    }]];
    
}

- (void)searchText:(NSString *)text{
    self.searchText = text;
    [self.searchMuArr removeAllObjects];
    [self.weakTableV reloadData];
    [self loadData:YES];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.searchMuArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchAnchorItemCell *cell = [tableView dequeueReusableCellWithIdentifier:SearchAnchorItemCellIdentifier forIndexPath:indexPath];
    if (self.searchMuArr.count > indexPath.row) {
        cell.model = self.searchMuArr[indexPath.row];
        kWeakSelf(self);
        cell.followBtnBlock = ^(SearchAnchorItemCell *cell) {
            if (cell.model.roomId > 0) {
                [[CheckRoomPermissions share] joinRoom:cell.model.roomId liveDataType:cell.model.liveType joinRoom:^(AppJoinRoomVOModel * _Nonnull joinModel) {
                    LiveRoomListReqParam *req = [[LiveRoomListReqParam alloc] init];
                    req.joinPosition = 9;
                    [[CheckRoomPermissions share] joinRoomForModel:joinModel currentVC:weakself otherInfo:req];
                } closeRoom:^(AppHomeHallDTOModel * _Nonnull dtoModel) {
                    [[CheckRoomPermissions share] showDetail:dtoModel currentVC:weakself];
                } fail:nil];
            }
        };
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
    if (self.searchMuArr.count > indexPath.row) {
        LiveBeanModel *model = _searchMuArr[indexPath.row];
        [RouteManager routeForName:RN_user_userInfoVC currentC:self parameters:@{@"id":@(model.uid)}];
    }
}

-(void)loadData:(BOOL)refresh{
    
    if (!self.searchText || [self.searchText isEmpty]) {
        [self.weakTableV.mj_header endRefreshing];
        [self.weakTableV.mj_footer endRefreshing];
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入内容")];
        return;
    }

    int pageSize = kPageSize;
    int page = refresh?0:(int)self.searchMuArr.count/pageSize  + (self.searchMuArr.count%pageSize?1:0);
    kWeakSelf(self);
    [HttpApiUserController lobby:self.searchText page:page pageSize:pageSize type:1 callback:^(int code, NSString *strMsg, PageInfo *pageInfo, NSArray<LiveBeanModel *> *arr) {
        if (code == 1) {
            [weakself.weakTableV.mj_header endRefreshing];
            [weakself.weakTableV.mj_footer endRefreshing];
            if (refresh) {
                [weakself.searchMuArr removeAllObjects];
            }
            if (arr.count > 0) {
                [weakself.searchMuArr addObjectsFromArray:arr];
                [weakself.weakTableV reloadData];
            }else{
                [weakself.weakTableV reloadData];
                [weakself.weakTableV.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            [self.weakTableV.mj_header endRefreshing];
            [self.weakTableV.mj_footer endRefreshing];
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
        weakself.emptyV.hidden = weakself.searchMuArr.count;
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

@end
