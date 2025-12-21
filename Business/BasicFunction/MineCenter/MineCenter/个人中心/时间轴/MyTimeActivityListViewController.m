//
//  MyTimeActivityListViewController.m
//  MineCenter
//
//  Created by klc on 2020/5/21.
//

#import "MyTimeActivityListViewController.h"
#import "MineTimeAxisTableViewCell.h"

@interface MyTimeActivityListViewController ()<UITableViewDelegate, UITableViewDataSource,MineTimeAxisTableViewCellDelegate>
@property(nonatomic,strong)UITableView *timeTableView;
@property (nonatomic, weak)EmptyView *empty;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *showArray;
@property (nonatomic, assign)int page;

@end

@implementation MyTimeActivityListViewController
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)showArray{
    if (!_showArray) {
        _showArray = [NSMutableArray array];
    }
    return _showArray;
}

- (UITableView *)timeTableView{
    if (!_timeTableView) {
        CGRect bounds = CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight);
        _timeTableView = [[UITableView alloc]initWithFrame:bounds style:UITableViewStyleGrouped];
        _timeTableView.backgroundColor = [UIColor whiteColor];
        _timeTableView.estimatedRowHeight = 0;
        _timeTableView.estimatedSectionHeaderHeight = 0;
        _timeTableView.estimatedSectionFooterHeight = 0;
        _timeTableView.mj_footer.ignoredScrollViewContentInsetBottom = kSafeAreaBottom;
    }
    return _timeTableView;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadData:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = kLocalizationMsg(@"我的时间轴");
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.timeTableView.delegate = self;
    self.timeTableView.dataSource = self;
    [self.view addSubview:self.timeTableView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.height-1, kScreenWidth, 0.5)];
    line.backgroundColor = kRGB_COLOR(@"#D8D8D8");
    [self.navigationController.navigationBar addSubview:line];
    
    [self createUI];
     
    
}
- (void)createUI{
    self.page = 0;
    self.timeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    kWeakSelf(self);
    self.timeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.page = 0;
        [weakself loadData:YES];
    }];
    self.timeTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakself.page ++;
        [weakself loadData:NO];
    }];
    EmptyView *emptyV = [[EmptyView alloc] init];
    [emptyV showInView:self.timeTableView];
    _empty = emptyV;
    
    if (kiOS11) {
        self.timeTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    UIView *tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
    tableHeaderView.backgroundColor = [UIColor whiteColor];
    self.timeTableView.tableHeaderView = tableHeaderView;
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, kScreenWidth, 20)];
    titleL.font = [UIFont systemFontOfSize:14];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.textColor = kRGB_COLOR(@"#666666");
    titleL.text = kLocalizationMsg(@"与你相遇，未来可期...");
    [tableHeaderView addSubview:titleL];
}

- (void)loadData:(BOOL)refresh{
    kWeakSelf(self);
    [HttpApiUserController getMyTrendsTime:self.page pageSize:kPageSize callback:^(int code, NSString *strMsg, NSArray<AppTrendsRecordModel *> *arr) {
        if (code == 1) {
            [self.timeTableView.mj_header endRefreshing];
            [self.timeTableView.mj_footer endRefreshing];
            if (arr.count > 0) {
                if (refresh) {
                    [weakself.dataArray removeAllObjects];
                }
                [weakself.dataArray addObjectsFromArray:arr];
                [weakself reloadTableData];//刷新数据
            }else{
                [self.timeTableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            [self.timeTableView.mj_header endRefreshing];
            [self.timeTableView.mj_footer endRefreshing];
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
        weakself.empty.hidden = weakself.dataArray.count;
    }];
}

- (void)reloadTableData{
    [self.showArray removeAllObjects];
    NSMutableArray *indexArray = [NSMutableArray array];
    for (int i = 0; i < self.dataArray.count; i++) {
        AppTrendsRecordModel *model = self.dataArray[i];
        NSString *year = [self getYearBy:model];
        BOOL isContain = [self isContainYear:year array:indexArray];
        if (!isContain) {
            [indexArray addObject:@(i)];
        }
    }
    
    
    [self.timeTableView reloadData];
}
- (BOOL)isContainYear:(NSString *)year array:(NSArray*)indexArray{
    BOOL isCotain = NO;
    for (NSString *yearStr in indexArray) {
        if ([year isEqualToString:yearStr]) {
            isCotain = YES;
        }
    }
    return isCotain;
}
- (NSString *)getYearBy:(AppTrendsRecordModel *)model{
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc]init];
    [dataFormatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone *tz = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dataFormatter setTimeZone:tz];
    return [dataFormatter stringFromDate:model.createTime];
}
- (BOOL)isShowYear:(NSIndexPath *)indexPath{
    BOOL isShow = NO;
    for (NSNumber *index in self.showArray) {
        if ([index intValue] == indexPath.row) {
            isShow = YES;
            break;
        }
    }
    if (isShow) {//排除今年
        AppTrendsRecordModel *model;
        if (indexPath.row < self.dataArray.count) {
            model = self.dataArray[indexPath.row];
        }
        NSString *year = [self getYearBy:model];
        NSDateFormatter *dataFormatter = [[NSDateFormatter alloc]init];
        [dataFormatter setDateFormat:@"yyyy-MM-dd"];
        NSTimeZone *tz = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        [dataFormatter setTimeZone:tz];
        NSString *nowYear = [dataFormatter stringFromDate:[NSDate date]];
        if (year == nowYear) {
            isShow = NO;
        }
    }
    return isShow;
}
#pragma mark - tablview delegate/datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineTimeAxisTableViewCell * cell = (MineTimeAxisTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[MineTimeAxisTableViewCell alloc]initWithIndexpath:indexPath timeAxisType:0];
    }
    cell.delegate = self;
    cell.cell_height = [self getHeight:indexPath];
    cell.isShowYear = [self isShowYear:indexPath];
    cell.trendsRecordModel = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self getHeight:indexPath];
}
- (CGFloat)getHeight:(NSIndexPath *)indexPath{
    AppTrendsRecordModel *trendModel;
    if (indexPath.row < self.dataArray.count) {
        trendModel = self.dataArray[indexPath.row];
    }
    CGFloat rowH = 90;
    BOOL isShow = [self isShowYear:indexPath];
    if (isShow) {
        rowH += 70;
    }
    if (trendModel.reserve1.length > 0) {
        CGSize size = [trendModel.reserve1 boundingRectWithSize:CGSizeMake(kScreenWidth-150, MAXFLOAT) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
        if (size.height+8 < 40) {
            rowH += 40;
        }else{
            rowH += size.height+8;
        }
    }
    switch (trendModel.type) {
        case 3://和TA第1次打招呼
            rowH += 30;
            break;
        case 4://和TA聊天亲密值达到100
            rowH += 30;
            break;
        case 5://第1次守护TA
            rowH += 30;
            break;
         
        default:
            break;
    }
    
    return rowH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   // NSLog(@"过滤文字选中了%ld行"),indexPath.row);
}
#pragma mark - MineTimeAxisTableViewCellDelegate
- (void)MineTimeAxisTableViewCellAvaterBtnClick:(AppTrendsRecordModel *)model{
    [RouteManager routeForName:RN_user_userInfoVC currentC:self parameters:@{@"id":@(model.fkId)}];
}
- (void)MineTimeAxisTableViewCellActionBtnClick:(AppTrendsRecordModel *)model index:(NSInteger)index{
    [RouteManager routeForName:RN_Message_ConversationChatVC currentC:[ProjConfig currentVC] parameters:@{@"chatType":@"0",@"msgSendId":@(model.targetUserId)}];
}

@end
