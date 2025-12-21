//
//  LiveBroadcastDataVC.m
//  UserInfo
//
//  Created by klc on 2020/3/20.
//

#import "LiveBroadcastDataVC.h"

#import "LiveBroadcastDataCell.h"

#import "UserInfoRes.h"
#import <LibTools/LibTools.h>

#import <LibProjModel/HttpApiPublicLive.h>

#import <LibProjView/PopView.h>
#import <LibProjView/PopTableListView.h>
#import <LibProjView/EmptyView.h>


@interface LiveBroadcastDataVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic, weak)EmptyView *emptyV;
@property(nonatomic,strong)UIButton *rightButton;
@property(nonatomic,strong)PopTableListView *popListView;

@property(nonatomic,assign)int64_t typeIndex;

@end

@implementation LiveBroadcastDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = kLocalizationMsg(@"直播数据");
    [self rightBtn];
    [self creatSubView];
}


-(void)rightBtn{
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    //    [self.rightButton setTitle:kLocalizationMsg(@"按钮") forState:UIControlStateNormal];
    //    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:@"center_moreSele"] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
    rightItem.imageInsets = UIEdgeInsetsMake(0, -15,0, 0);
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

-(void)rightButtonClicked:(UIButton *)sender{
    //    UIImageView *triangleView = [[UIImageView alloc] initWithImage:nil];
    //       triangleView.bounds = CGRectMake(0, 0, 0, 0);
    //       PopView *popView = [PopView popUpContentView:self.popListView direct:PopViewDirection_PopUpBottom onView:sender offset:0 triangleView:triangleView animation:YES];
    //       popView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    //       self.popListView = nil;
    PopView *popView = [PopView popUpContentView:self.popListView direct:PopViewDirection_PopUpBottom onView:sender];
    popView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
}

-(void)creatSubView{
    
    self.typeIndex = 4;
    
    [self.view addSubview:self.tableView];
    
    NSString * nibName=  [UserInfoRes getNibFullName:@"LiveBroadcastDataCell"];
    //@"Frameworks/UserInfo.framework/LiveBroadcastDataCell"
    [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:[NSBundle mainBundle]] forCellReuseIdentifier:LiveBroadcastDataCellIdentifier];

    [self loadData:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 310;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LiveBroadcastDataCell *cell = [tableView dequeueReusableCellWithIdentifier:LiveBroadcastDataCellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[LiveBroadcastDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LiveBroadcastDataCellIdentifier];
    }
    
    cell.model = self.dataArr[indexPath.row];
    cell.playBtn.tag = 10000 + indexPath.row;
    [cell.playBtn addTarget:self action:@selector(clickPlayBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
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

//播放按钮
-(void)clickPlayBtn:(UIButton *)sender{

}





//懒加载
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        kWeakSelf(self);
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakself loadData:YES];
        }];
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakself loadData:NO];
        }];
        self.tableView.mj_footer.ignoredScrollViewContentInsetBottom = kSafeAreaBottom;
    }
    return _tableView;
}
- (EmptyView *)emptyV{
    if (!_emptyV) {
        EmptyView *emptyView = [[EmptyView alloc] init];
        emptyView.iconImgV.image  = [UIImage imageNamed:@"home_guangchang_meiyouzhubo"];
        emptyView.titleL.text = kLocalizationMsg(@"～暂无直播数据～");
        emptyView.detailL.text = kLocalizationMsg(@"赶紧去直播吧");
        [emptyView showInView:self.view];
        _emptyV = emptyView;
    }
    return _emptyV;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}



- (void)loadData:(BOOL)refresh{
 
    int pageSize = kPageSize;
    int page = refresh?0:(int)self.dataArr.count/pageSize  + (self.dataArr.count%pageSize?1:0);
    int beforeDay = -1;
    switch (self.typeIndex) {
        case 0:
            beforeDay = 3;
            break;
        case 1:
            beforeDay = 7;
            break;
        case 2:
            beforeDay = 15;
        case 3:
            beforeDay = 30;
            break;
        case 4:
            beforeDay = -1;
            break;
        default:
            break;
    }
    kWeakSelf(self);
    [HttpApiPublicLive getLiveData:beforeDay page:page pageSize:pageSize callback:^(int code, NSString *strMsg, NSArray<AppUsersLiveDataVOModel *> *arr) {
        if (code == 1) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            if (arr.count > 0) {
                if (refresh) {
                    [weakself.dataArr removeAllObjects];
                }
                [weakself.dataArr addObjectsFromArray:arr];
                
            }else{
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [self.tableView reloadData];
        }else{
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
        weakself.emptyV.hidden = weakself.dataArr.count;
    }];
}


- (PopTableListView *)popListView{
    if (_popListView == nil) {
        _popListView = [[PopTableListView alloc] initWithTitles:@[kLocalizationMsg(@"最近3天"),kLocalizationMsg(@"最近7天"),kLocalizationMsg(@"最近15天"),kLocalizationMsg(@"最近30天"),kLocalizationMsg(@"全部")] imgNames:@[@"",@"",@"",@""]];
        _popListView.backgroundColor = [UIColor whiteColor];
        _popListView.layer.cornerRadius = 5;
        kWeakSelf(self);
        _popListView.seleBlock = ^(int64_t seleIndex) {
            weakself.typeIndex = seleIndex;
            [weakself loadData:YES];
            [PopView hidenPopView];
        };
        
    }
    return _popListView;
}

@end
