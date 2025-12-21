//
//  MyIncomeDetailViewController.m
//  Shopping
//
//  Created by yww on 2020/8/6.
//  Copyright © 2020 klc. All rights reserved.
//  收入明细

#import "MyShopIncomeDetailListVC.h"
#import "ShopIncomeDetailTableViewCell.h"
#import <LibProjModel/HttpApiShopBusiness.h>
#import <LibProjView/EmptyView.h>
 
@interface MyShopIncomeDetailListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, assign)int pageIndex;
@property (nonatomic, weak)EmptyView *emptyView;

@end

@implementation MyShopIncomeDetailListVC
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kRGB_COLOR(@"#F6F6F6");
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.navTitle;
    self.pageIndex = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    kWeakSelf(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.pageIndex = 0;
        [weakself loadData:YES];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakself.pageIndex ++;
        [weakself loadData:NO];
    }];
    self.tableView.mj_footer.ignoredScrollViewContentInsetBottom = kSafeAreaBottom;
    [self addEmptyView];
    [self addHeaderView];
     
}
- (void)addHeaderView{
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(12, 0, kScreenWidth+40, 30)];
    headerV.backgroundColor = kRGB_COLOR(@"#FFEBE0");
    UILabel *label = [[UILabel alloc] initWithFrame:headerV.bounds];
    label.text = kLocalizationMsg(@"提示：第三方商品订单(非官方小店商品)请前往相应第三方平台查案");
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = kRGB_COLOR(@"#FF5500");
    [headerV addSubview:label];
    self.tableView.tableHeaderView = headerV;
    [self startAnimation:label];
}
- (void)startAnimation:(UILabel *)label{
    kWeakSelf(self);
    [UIView animateWithDuration:10.0 delay:1.5 options:UIViewAnimationOptionCurveLinear animations:^{
        CGRect lbframe = label.frame;
        lbframe.origin.x = - lbframe.size.width-12;
        label.frame = lbframe;
    } completion:^(BOOL finished) {
        label.frame = CGRectMake(12, 0, kScreenWidth+40, 30);
        [weakself startAnimation:label];
    }];
}
 
-(void)addEmptyView{
    EmptyView *empty = [[EmptyView alloc] init];
    empty.titleL.text = kLocalizationMsg(@"暂无记录");
    empty.detailL.text = kLocalizationMsg(@"你还需要继续努力哦～");
    [empty showInView:self.tableView];
    _emptyView = empty;
}
- (void)loadData:(BOOL)isRefresh{
    kWeakSelf(self);
    /*
    ShopBusiness_getWithdrawList *list = [[ShopBusiness_getWithdrawList alloc]init];
    list.pageIndex = self.pageIndex;
    list.pageSize = kPageSize;
    [HttpApiShopBusiness getWithdrawList:list callback:^(int code, NSString *strMsg, ShopWithdrawDTOModel *model) {
        [weakself.tableView.mj_header endRefreshing];
        [weakself.tableView.mj_footer endRefreshing];
        if (isRefresh) {
            [weakself.dataArray removeAllObjects];
        }
        if (code == 1) {
            if (model.shopWithdrawRecordList.count < kPageSize) {
                [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [weakself.dataArray addObjectsFromArray:model.shopWithdrawRecordList];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself.tableView reloadData];
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
        weakself.emptyView.hidden = weakself.dataArray.count;
    }];
    */
}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopIncomeDetailTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[ShopIncomeDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ShopIncomeTableViewCell"];
    }
     
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}
@end
