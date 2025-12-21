//
//  MyInvteIncomeRankVC.m
//  MineCenter
//
//  Created by klc on 2020/7/31.
//

#import "MyInvteIncomeRankVC.h"
#import "MyInviteIncomeRankCell.h"
#import <LibTools/LibTools.h>
#import <LibProjModel/HttpApiAPPFinance.h>
#import <LibProjModel/AppUserIncomeRankingDtoModel.h>
#import "MyInviteBottomView.h"

@interface MyInvteIncomeRankVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy)NSArray *dataArray;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)AppUserIncomeRankingDtoModel *myRankModel;
@property (nonatomic, strong)MyInviteBottomView *myRankView;
@end

@implementation MyInvteIncomeRankVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData:YES isMine:NO];
    [self loadData:YES isMine:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    //页面设置
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableView];
    [self addTableHeader];
    
    CGFloat btnH = kNavBarHeight-kStatusBarHeight;
    UIView *naviBar = [[UIView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight, kScreenWidth, btnH)];
    naviBar.backgroundColor = [UIColor clearColor];
    [self.view insertSubview:naviBar atIndex:2];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(8, 0, btnH, btnH)];
    [backBtn setImage:[UIImage imageNamed:@"main_navbar_back"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [naviBar addSubview:backBtn];
}

- (void)addTableHeader{
    UIImageView *headerImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*450/750.0)];
    headerImageV.image = [UIImage imageNamed:@"icon_invite_rankheader"];
    headerImageV.contentMode = UIViewContentModeScaleAspectFill;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, headerImageV.height-15, kScreenWidth, 17)];
    view.backgroundColor = [UIColor whiteColor];
    UIBezierPath*maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:(UIRectCornerTopRight | UIRectCornerTopLeft) cornerRadii:CGSizeMake(10,10)];//圆角大小
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
    [headerImageV addSubview:view];
    self.tableView.tableHeaderView = headerImageV;
}

- (void)updateMyrankView{
    [self.myRankView removeAllSubViews];
    self.myRankView = [[MyInviteBottomView alloc] initWithFrame:CGRectMake(0, self.tableView.maxY, kScreenWidth, kSafeAreaBottom+75)];
    [self.view addSubview:self.myRankView];
    self.myRankView.myInviteInfoM = self.myRankModel;
}

#pragma mark - 数据

- (void)loadData:(BOOL)refresh isMine:(BOOL)isMine{
    kWeakSelf(self);
    [HttpApiAPPFinance incomeRanking:1 toUserId:isMine?[ProjConfig userId]:0 type:0 callback:^(int code, NSString *strMsg, PageInfo *pageInfo, NSArray<AppUserIncomeRankingDtoModel *> *arr) {
        if (isMine) {
            if (code == 1) {
                weakself.myRankModel = arr.firstObject;
                [weakself updateMyrankView];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }else{
            if (code == 1) {
                weakself.dataArray = arr;
                [weakself.tableView reloadData];
                [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }
    }];
}

//返回
- (void)backBtnClick:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - tableview deleagte datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyInviteIncomeRankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyInviteIncomeRankCellID" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[MyInviteIncomeRankCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyInviteIncomeRankCellID"];
    }
    AppUserIncomeRankingDtoModel *model;
    if (indexPath.row < self.dataArray.count) {
        model = self.dataArray[indexPath.row];
    }
    cell.indexPath = indexPath;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}





#pragma mark - lazy
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kSafeAreaBottom-75)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[MyInviteIncomeRankCell class] forCellReuseIdentifier:@"MyInviteIncomeRankCellID"];
    }
    return _tableView;
}


@end
