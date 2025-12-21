//
//  Dynamic08ClassfiyListVc.m
//  klcLive
//
//  Created by SWH05 on 2022/2/14.
//  Copyright © 2022 KLC. All rights reserved.
//

#import "Dynamic02ClassfiyListVc.h"
#import <MJRefresh/MJRefresh.h>
#import <Masonry/Masonry.h>

#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/HttpApiDynamicController.h>
#import <LibProjModel/ApiUserVideoModel.h>
 
#import <LibProjBase/LibProjBase.h>

#import <LibProjView/EmptyView.h>
#import <LibProjView/DYCommentListView.h>
#import <LibProjView/LiveShareView.h>
#import <LibProjView/PopView.h>
#import <LibProjView/ForceAlertController.h>
#import <LibProjView/CustomPopUpAlert.h>
#import <LibProjView/CollectionWaterfallLayout.h>

#import "LibProjViewRes.h"
#import "Dynamic02ClassfiyItemCell.h"

@interface Dynamic02ClassfiyListVc ()<UITableViewDelegate,UITableViewDataSource,Dynamic02ClassfiyItemCellDelegate>

@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
@property (nonatomic, weak)UITableView *tableV;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, weak)EmptyView *weakEmptyV;

@end

@implementation Dynamic02ClassfiyListVc

- (void)viewDidLoad {
    [super viewDidLoad];
    ///创建试图
    [self createUI];
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)createUI{
    
    UITableView *tableV = [[UITableView alloc] init];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableV.showsVerticalScrollIndicator = NO;
    NSString *nibName = [LibProjViewRes getNibFullName:@"Dynamic02ClassfiyItemCell"];
    [tableV registerNib:[UINib nibWithNibName:nibName bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Dynamic02ClassfiyItemCell"];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (kiOS(11.0)) {
        tableV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else
        if (kiOS(13.0)) {
            tableV.automaticallyAdjustsScrollIndicatorInsets = YES;
        }
    
    [self.view addSubview:tableV];
    [tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];

    kWeakSelf(self);
    tableV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself loadData:NO];
    }];
    _tableV = tableV;
    
}

- (EmptyView *)weakEmptyV{
    if (!_weakEmptyV) {
        EmptyView *empty = [[EmptyView alloc] init];
        if (self.type == 2) {
            empty.iconImgV.image = [UIImage imageNamed:@"default_emtpy_atten"];
            empty.detailL.text = kLocalizationMsg(@"暂时没有关注的人哦～ 快去关注吧!");
        }else{
            empty.iconImgV.image = [UIImage imageNamed:@"default_emtpy_content"];
            empty.detailL.text = kLocalizationMsg(@"暂无数据，去其他页面看看吧～");
        }
        [self.view addSubview:empty];
        [empty mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(300, 300));
            make.center.equalTo(self.view);
        }];
        _weakEmptyV = empty;
    }
    return _weakEmptyV;
}


- (void)loadData:(BOOL)isRefresh{
    //请求数据
    int pageSize = kPageSize;
    int page = isRefresh?0:(int)self.dataArray.count/pageSize  + (self.dataArray.count%pageSize?1:0);
    kWeakSelf(self);
    [HttpApiDynamicController getDynamicList:0 page:page pageSize:pageSize touid:self.userId type:self.type callback:^(int code, NSString *strMsg, PageInfo *pageInfo, NSArray<ApiUserVideoModel *> *arr) {
        [weakself.tableV.mj_header endRefreshing];
        [weakself.tableV.mj_footer endRefreshing];
        if (code == 1) {
            if (isRefresh) {
                [weakself.dataArray removeAllObjects];
            }
            if (arr.count > 0) {
                [weakself.dataArray addObjectsFromArray:arr];
            }else{
                [weakself.tableV.mj_footer endRefreshingWithNoMoreData];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself.tableV reloadData];
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
        weakself.weakEmptyV.hidden = weakself.dataArray.count;
    }];
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Dynamic02ClassfiyItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Dynamic02ClassfiyItemCell" forIndexPath:indexPath];
    cell.videoModel = (indexPath.section < self.dataArray.count)?self.dataArray[indexPath.section]:nil;
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200.0;
}

///是否喜欢该条动态
- (void)likeDynamic:(ApiUserVideoModel *)videoModel{
    kWeakSelf(self);
    [HttpApiDynamicController dynamicZan:videoModel.id_field callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [SVProgressHUD showSuccessWithStatus:strMsg];
            videoModel.isLike = !videoModel.isLike;
            videoModel.likes = videoModel.likes + (videoModel.isLike?1:-1);
            videoModel.likes = videoModel.likes>=0?videoModel.likes:0;
            [weakself.tableV reloadData];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

//点击分享
- (void)shareDynamic:(ApiUserVideoModel *)videoModel{
    kWeakSelf(self);
    if (videoModel.uid == [KLCUserInfo getUserId]) {
        ShareFunctionItem *shareFuncId = [ShareFunctionItem shareIcon:[UIImage imageNamed:@"icon_more_delete"] name:kLocalizationMsg(@"删除") clickBlock:^{
            [weakself deleteDynamicWith:videoModel];
        }];
        [LiveShareView showShareViewForType:1 shareId:videoModel.id_field moreFunction:@[[ShareFunctionItem getCopyLinkFunction], shareFuncId]];
    } else {
        ShareFunctionItem *reportFunctionItem = [ShareFunctionItem shareIcon:[UIImage imageNamed:@"icon_more_report"] name:kLocalizationMsg(@"举报") clickBlock:^{
            [RouteManager routeForName:RN_dynamic_dynamicReportVC currentC:weakself parameters:@{@"id":@(videoModel.id_field)}];
        }];
        [LiveShareView showShareViewForType:1 shareId:videoModel.id_field moreFunction:@[[ShareFunctionItem getCopyLinkFunction], reportFunctionItem]];
    }
}
- (void)showDynamicMoreActionWith:(Dynamic02ClassfiyItemCell *)cell videoModel:(ApiUserVideoModel *)videoModel{
    kWeakSelf(self);
    NSArray *itemArr;
    if (videoModel.personalTop) {
        itemArr = @[@{@"name":kLocalizationMsg(@"取消置顶"),@"image":@"",@"type":@"1"},
                    @{@"name":kLocalizationMsg(@"删除"),@"image":@"",@"type":@"2"}];
    }else{
        itemArr = @[@{@"name":kLocalizationMsg(@"置顶"),@"image":@"",@"type":@"1"},
                    @{@"name":kLocalizationMsg(@"删除"),@"image":@"",@"type":@"2"}];
    }
    
    CGFloat itemHeight = 32;
    UIView *popListV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, itemArr.count*itemHeight+20)];
    popListV.backgroundColor = [UIColor whiteColor];
    popListV.layer.cornerRadius = 5;
    for (int i = 0; i< itemArr.count; i++) {
        NSDictionary *subDic = itemArr[i];
        UIButton *btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(0, 10+i*itemHeight, popListV.width, itemHeight);
        [popListV addSubview:btn];
         
        
        UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, btn.width-10, btn.height)];
        titleL.text = subDic[@"name"];
        titleL.textAlignment = NSTextAlignmentCenter;
        titleL.font = [UIFont systemFontOfSize:14];
        titleL.textColor = [UIColor blackColor];
        [btn addSubview:titleL];
        
        NSInteger selectType = [subDic[@"type"] intValue];
        [btn klc_whenTapped:^{
            if (selectType == 1) {
                [self addDynamicPersonalTop:videoModel];
            }else if (selectType == 2){
                if (videoModel.uid == [KLCUserInfo getUserId]) {
                    [weakself deleteDynamicWith:videoModel];
                } 
            }
            [PopView hidenPopView];
        }];
    }
    
    
    PopView *popView = [PopView popUpContentView:popListV direct:PopViewDirection_PopUpBottom onView:cell.moreBtn];
    popView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
}
- (void)addDynamicPersonalTop:(ApiUserVideoModel *)videoModel{
    kWeakSelf(self);
    NSString *message = kLocalizationMsg(@"确定要置顶这条动态？");
    if (videoModel.personalTop) {
        message = kLocalizationMsg(@"确定要将这条动态取消置顶？");
    }
    ForceAlertController *alertVC = [ForceAlertController alertTitle:kLocalizationMsg(@"提示") message:message];
    [alertVC addOptions:kLocalizationMsg(@"取消") textColor:ForceAlert_BlackColor clickHandle:nil];
    [alertVC addOptions:kLocalizationMsg(@"确定") textColor:ForceAlert_NormalColor clickHandle:^{
        [HttpApiDynamicController addDynamicPersonalTop:videoModel.id_field  optType:videoModel.personalTop==1?2:1 callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            [SVProgressHUD showInfoWithStatus:strMsg];
            if (code == 1) {
                [weakself loadData:YES];
            }
        }];
    }];
    [[ProjConfig currentVC] presentViewController:alertVC animated:YES completion:nil];
}
- (void)deleteDynamicWith:(ApiUserVideoModel *)videoModel{
    kWeakSelf(self);
    ForceAlertController *alertVC = [ForceAlertController alertTitle:kLocalizationMsg(@"提示") message:kLocalizationMsg(@"确定删除这条动态？")];
    [alertVC addOptions:kLocalizationMsg(@"取消") textColor:ForceAlert_BlackColor clickHandle:nil];
    [alertVC addOptions:kLocalizationMsg(@"删除") textColor:ForceAlert_NormalColor clickHandle:^{
        [HttpApiDynamicController delDynamic:videoModel.id_field callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            [SVProgressHUD showInfoWithStatus:strMsg];
            if (code == 1) {
                [weakself loadData:YES];
            }
        }];
    }];
    [[ProjConfig currentVC] presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark -Dynamic02ClassfiyItemCellDelegate
- (void)dynamicClassfiyItemCell:(Dynamic02ClassfiyItemCell *)cell zanBtnClick:(ApiUserVideoModel *)videoModel{
    [self likeDynamic:videoModel];
}
 
- (void)dynamicClassfiyItemCell:(Dynamic02ClassfiyItemCell *)cell commitBtnClick:(ApiUserVideoModel *)videoModel{
    DYCommentListView *listV = [[DYCommentListView alloc] initWithCommentModel:videoModel];
    listV.commentSuccess = ^(int commentNum) {
        videoModel.comments = (int)commentNum;
        cell.videoModel = videoModel;
    };
    kWeakSelf(self);
    listV.showUserInfo = ^(int64_t toUserId) {
        [weakself pushNextPage];
        [RouteManager routeForName:RN_user_userInfoVC currentC:weakself parameters:@{@"id":@(videoModel.uid)}];
    };
    [listV show];
}
 
- (void)dynamicClassfiyItemCell:(Dynamic02ClassfiyItemCell *)cell dynamicLabClick:(ApiUserVideoModel *)videoModel{
    [self pushNextPage];
    [RouteManager routeForName:RN_dynamic_topic currentC:self parameters:@{@"topicName":videoModel.topicName, @"topicId":@(videoModel.topicId)}];
}
- (void)dynamicClassfiyItemCell:(Dynamic02ClassfiyItemCell *)cell shareBtnClick:(ApiUserVideoModel *)videoModel{
    [self shareDynamic:videoModel];
}
- (void)dynamicClassfiyItemCell:(Dynamic02ClassfiyItemCell *)cell showDynamicDetail:(ApiUserVideoModel *)videoModel{
    [self pushNextPage];
    [RouteManager routeForName:RN_dynamic_playVideoVC currentC:self parameters:@{@"models":@[videoModel],@"hasLoading":@(NO)}];
}
- (void)dynamicClassfiyItemCell:(Dynamic02ClassfiyItemCell *)cell moreBtnClick:(ApiUserVideoModel *)videoModel{
    [self showDynamicMoreActionWith:cell videoModel:videoModel];
}
//主播对主播 弹框提示
-(void)AnchorAndAnchorAlert:(NSMutableDictionary *)muDict{
    //主播与主播
    CustomPopUpAlert *customAlert = [CustomPopUpAlert alertTitle:kLocalizationMsg(@"你当前通话的对象为主播") message:kStringFormat(kLocalizationMsg(@"接通后会扣除你的%@哦~"),kUnitStr) liveType:LiveTypeForAnchorAndAnchor];
    customAlert.clickCancelBlock = ^{
        
    };
    customAlert.clickSureBlock = ^(NSString * _Nonnull passwordStr) {
        [RouteManager routeForName:RN_live_LaunchOneLive currentC:self parameters:muDict];
    };
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self presentViewController:customAlert animated:YES completion:nil];
    });
}

///跳转到下一个页面的数据设置
- (void)pushNextPage{
  
    if (self.pushNextPageBlock) {
        self.pushNextPageBlock();
    }
}

#pragma mark - JXPagingViewListViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollCallback) {
        self.scrollCallback(scrollView);
    }
}

- (void)listWillAppear{
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData:YES];
}

- (UIScrollView *)listScrollView {
    return self.tableV;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (UIView *)listView {
    return self.view;
}


@end
