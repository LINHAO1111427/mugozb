//
//  DynamicClassfiyListVC.m
//  boboO2O
//
//  Created by klc_03 on 2021/1/15.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "DynamicClassfiyListVC.h"
#import <MJRefresh/MJRefresh.h>
#import <Masonry/Masonry.h>
#import <LibProjModel/HttpApiDynamicController.h>
#import <LibProjModel/ApiUserVideoModel.h>
#import <LibProjView/CollectionWaterfallLayout.h>
#import <LibProjBase/LibProjBase.h>
#import "DynamicClassfiyItemCell.h"
#import <LibProjView/LiveShareView.h>
#import <LibProjView/ForceAlertController.h>

#import <LibProjView/CustomPopUpAlert.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/KLCUserInfo.h>
#import "LibProjViewRes.h"
#import <LibProjView/EmptyView.h>
#import <LibProjView/DYCommentListView.h>

@interface DynamicClassfiyListVC ()<UITableViewDelegate,UITableViewDataSource,DynamicClassfiyItemCellDelegate>

@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
@property (nonatomic, assign)BOOL isPush;
@property (nonatomic, weak)UITableView *tableV;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, weak)EmptyView *weakEmptyV;

@end

@implementation DynamicClassfiyListVC

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
    NSString *nibName = [LibProjViewRes getNibFullName:@"DynamicClassfiyItemCell"];
    [tableV registerNib:[UINib nibWithNibName:nibName bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"DynamicClassfiyItemCell"];
    
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
    DynamicClassfiyItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DynamicClassfiyItemCell" forIndexPath:indexPath];
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
    if (videoModel.uid == [KLCUserInfo getUserId]) {
        ShareFunctionItem *shareFuncId = [ShareFunctionItem shareIcon:[UIImage imageNamed:@"icon_more_delete"] name:kLocalizationMsg(@"删除") clickBlock:^{
            ForceAlertController *alertVC = [ForceAlertController alertTitle:kLocalizationMsg(@"提示") message:kLocalizationMsg(@"确定删除这条动态？")];
            [alertVC addOptions:kLocalizationMsg(@"取消") textColor:ForceAlert_BlackColor clickHandle:nil];
            [alertVC addOptions:kLocalizationMsg(@"删除") textColor:ForceAlert_NormalColor clickHandle:^{
                [HttpApiDynamicController delDynamic:videoModel.id_field callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
                    [SVProgressHUD showInfoWithStatus:strMsg];
                }];
            }];
            [[ProjConfig currentVC] presentViewController:alertVC animated:YES completion:nil];
        }];
        [LiveShareView showShareViewForType:1 shareId:videoModel.id_field moreFunction:@[[ShareFunctionItem getCopyLinkFunction], shareFuncId]];
    } else {
        kWeakSelf(self);
        ShareFunctionItem *reportFunctionItem = [ShareFunctionItem shareIcon:[UIImage imageNamed:@"icon_more_report"] name:kLocalizationMsg(@"举报") clickBlock:^{
            [RouteManager routeForName:RN_dynamic_dynamicReportVC currentC:weakself parameters:@{@"id":@(videoModel.id_field)}];
        }];
        [LiveShareView showShareViewForType:1 shareId:videoModel.id_field moreFunction:@[[ShareFunctionItem getCopyLinkFunction], reportFunctionItem]];
    }
}

#pragma mark -DynamicClassfiyItemCellDelegate-
- (void)dynamicClassfiyItemCell:(DynamicClassfiyItemCell *)cell zanBtnClick:(ApiUserVideoModel *)videoModel{
    [self likeDynamic:videoModel];
}

///跳转到下一个页面的数据设置
- (void)pushNextPage{
    self.isPush = YES;
    if (self.pushNextPageBlock) {
        self.pushNextPageBlock();
    }
}

- (void)dynamicClassfiyItemCell:(DynamicClassfiyItemCell *)cell commitBtnClick:(ApiUserVideoModel *)videoModel{
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


- (void)dynamicClassfiyItemCell:(DynamicClassfiyItemCell *)cell dynamicLabClick:(ApiUserVideoModel *)videoModel{
    [self pushNextPage];
    [RouteManager routeForName:RN_dynamic_topic currentC:self parameters:@{@"topicName":videoModel.topicName, @"topicId":@(videoModel.topicId)}];
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

- (void)dynamicClassfiyItemCell:(DynamicClassfiyItemCell *)cell moreBtnClick:(ApiUserVideoModel *)videoModel{
    [self shareDynamic:videoModel];
}

- (void)dynamicClassfiyItemCell:(DynamicClassfiyItemCell *)cell showUserInfo:(ApiUserVideoModel *)videoModel{
    [self pushNextPage];
    [RouteManager routeForName:RN_user_userInfoVC currentC:self parameters:@{@"id":@(videoModel.uid)}];
}

- (void)dynamicClassfiyItemCell:(DynamicClassfiyItemCell *)cell showDynamicDetail:(ApiUserVideoModel *)videoModel{
    [self pushNextPage];
    [RouteManager routeForName:RN_dynamic_playVideoVC currentC:self parameters:@{@"models":@[videoModel],@"hasLoading":@(NO)}];
}


#pragma mark - JXPagingViewListViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollCallback) {
        self.scrollCallback(scrollView);
    }
}

- (void)listWillAppear{
    self.view.backgroundColor = [UIColor whiteColor];
    if (!self.isPush) {
        self.isPush = NO;
        [self loadData:YES];
    }
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
