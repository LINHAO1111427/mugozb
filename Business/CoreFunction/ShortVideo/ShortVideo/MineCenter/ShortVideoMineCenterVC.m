//
//  ShortVideoMineCenterVC.m
//  MineCenter
//
//  Created by klc on 2020/5/21.
//

#import "ShortVideoMineCenterVC.h"
#import <LibProjView/CustomPopUpAlert.h>
#import <LibProjView/SignToastView.h>
#import <LibProjView/ForceAlertController.h>
#import <LibProjView/MineHeaderView.h>
#import <LibProjView/MineCneterMiddleView.h>
#import <LibProjView/LookeMeTipView.h>

#import <LibProjBase/LibProjBase.h>

#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/HttpApiUserController.h>
#import <LibProjModel/HttpApiAppShortVideo.h>
#import <LibProjModel/HttpApiShopBusiness.h>
#import <LibProjModel/ApiUserInfoMyHeadModel.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/HttpApiShopOrder.h>
#import <LibProjModel/AdminLiveConfigModel.h>
#import <LibProjModel/ShopOrderNumDTOModel.h>
#import <LibProjModel/CustomerServiceSettingModel.h>

#import "SVUserAuthResultVC.h"
#import "ShortVideoCollectionView.h"

@interface ShortVideoMineCenterVC ()<
UIScrollViewDelegate,
MineHeaderViewDelegate,
JXCategoryViewDelegate,
JXCategoryTitleViewDataSource,
JXPagerViewDelegate,
ShortVideoCollectionViewDalegate
>

@property (nonatomic, strong)ApiUserInfoMyHeadModel *mineCenterModel;

@property(nonatomic,strong)MineHeaderView *headerView;
@property(nonatomic,strong)MineCneterMiddleView *groupOneV;
@property(nonatomic,copy)NSArray *oneTitleArray;//按钮群1


@property(nonatomic,strong)UIView *mainHeaderView;//主header

@property (nonatomic, strong)UIView *redSignPoint;
@property (nonatomic, weak)UILabel *youthLab; //青少年模式是否开启

//短视频
@property (nonatomic, weak) JXCategoryTitleView *titleView;
@property (nonatomic, strong) JXPagerView *pagingView;
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *typeArr;
@property(nonatomic,assign)NSInteger selectedIndex;




@end

@implementation ShortVideoMineCenterVC


- (NSMutableArray *)titles{
    if (!_titles) {
        _titles =  [NSMutableArray array];
    }
    return _titles;
}
- (NSMutableArray *)typeArr{
    if (!_typeArr) {
        _typeArr = [NSMutableArray array];
    }
    return _typeArr;
}


- (MineHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[MineHeaderView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight+50, kScreenWidth, 160)];
        _headerView.delegate = self;
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

- (UIView *)redSignPoint{
    if (!_redSignPoint) {
        _redSignPoint = [[UIView alloc]initWithFrame:CGRectMake(21, 5, 6, 6)];
        _redSignPoint.backgroundColor = [UIColor redColor];
        _redSignPoint.layer.cornerRadius = 3;
        _redSignPoint.clipsToBounds = YES;
        _redSignPoint.hidden = YES;
    }
    return _redSignPoint;
}
#pragma mark - 初始化

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _youthLab.hidden = (KLCUserInfo.getUserInfo.isYouthModel == 1)?NO:YES;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadData:YES];
    [self getSignData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    
    _oneTitleArray = [[ProjConfig shareInstence].businessConfig getMineCenterFuncOneArray];
    
    [self mainHeaderViewSetUp];
}

- (void)minePublishBtnClick:(UIButton *)btn{
    [ProjConfig showSuspenPublish];
}
- (void)mainHeaderViewSetUp{
    UIView *mainHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    mainHeader.backgroundColor = [UIColor whiteColor];
    self.mainHeaderView = mainHeader;
    
    UIImageView *signImageV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 22, 22)];
    signImageV.image = [UIImage imageNamed:@"icon_nav_sign"];
    UIButton *signBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];;
    [signBtn addTarget:self action:@selector(signBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIView *signView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth-44, kStatusBarHeight+9, 32, 32)];
    [signView addSubview:signImageV];
    [signView addSubview:self.redSignPoint];
    [signView addSubview:signBtn];
    [mainHeader addSubview:signView];
    
    [self.mainHeaderView addSubview:self.headerView];//头部
    [self addFeatureGroupOneView];//功能群1
    mainHeader.height = [self getMianHeaderheight];
    [self addCategoryView];
}
- (void)getSignData{
    kWeakSelf(self);
    [HttpApiUserController getSignInfo:^(int code, NSString *strMsg, ApiSignInDtoModel *model) {
        if (code == 1 && model.signList.count == 7) {
            weakself.redSignPoint.hidden = model.isSign;
        }else{
            weakself.redSignPoint.hidden = YES;
        }
    }];
}
- (void)loadData:(BOOL)isreFresh{
    kWeakSelf(self);
    [HttpApiUserController getMyHeadInfo:^(int code, NSString *strMsg, ApiUserInfoMyHeadModel *model) {
        [weakself.pagingView.mainTableView.mj_header endRefreshing];
        if (code  == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakself.mineCenterModel = model;
                weakself.headerView.userModel = model;
                [weakself getLookRedData];//谁看过我红点数据
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


- (void)loadShortVideoData:(BOOL)refresh{
    kWeakSelf(self);
    [HttpApiAppShortVideo getUserShortVideoList:1 toUid:-1 callback:^(int code, NSString *strMsg, ApiMyShortVideoModel *model) {
        if (code == 1) {
            [weakself.titles removeAllObjects];
            [weakself.typeArr removeAllObjects];
            for (int i = 0; i < 3; i++) {
                NSDictionary *dic;
                NSString *title;
                if (i == 0) {
                    title = [NSString stringWithFormat:kLocalizationMsg(@"作品 %d"),model.myNumber];
                    dic = @{@"title":title,@"type":@0};
                    
                }else if (i == 1){
                    title = [NSString stringWithFormat:kLocalizationMsg(@"喜欢 %d"),model.likeNumber];
                    dic = @{@"title":title,@"type":@1};
                    
                }else if (i == 2){
                    title = [NSString stringWithFormat:kLocalizationMsg(@"购买 %d"),model.buyNumber];
                    dic = @{@"title":title,@"type":@2};
                }
                [weakself.titles addObject:title];
                [weakself.typeArr addObject:dic];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                int num = model.buyNumber + model.likeNumber + model.myNumber;
                weakself.headerView.videoNum =  num;
                [weakself.titleView reloadData];
                [weakself.pagingView.listContainerView reloadData];
            });
        }
    }];
}
- (void)getLookRedData{
    if ([ProjConfig isUserLogin]) {
        [HttpApiUserController isVisit:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                self.headerView.show_lookRedPoint = model.no_use;
            }
        }];
    }
}

- (CGFloat)getMianHeaderheight{
    return self.groupOneV.maxY+10;
}

- (void)addFeatureGroupOneView{
    kWeakSelf(self);
    MineCneterMiddleView *middleView = [[MineCneterMiddleView alloc] initWithFrame:CGRectMake(0, self.headerView.maxY, kScreenWidth, 0.1)];
    [self.mainHeaderView addSubview:middleView];
    [middleView createFunctionView:self.oneTitleArray];
    middleView.clickBtnBlock = ^(NSString * _Nonnull title, NSInteger indexType) {
        [weakself showFunction:title type:indexType];
    };
    self.groupOneV = middleView;
}

- (void)signBtnClick:(UIButton *)btn{
    kWeakSelf(self);
    [SignToastView showSignViewWithComplition:^(BOOL isSignIn) {
        if (isSignIn) weakself.redSignPoint.hidden = isSignIn;
    }];
}
- (void)itemBtnClick:(UIButton *)btn{
    
    NSString *title = btn.titleLabel.text;
    if (!title) {
        title = @"";
    }
    [self showFunction:title type:btn.tag];
}


- (void)showFunction:(NSString *)title type:(NSInteger)type{
    switch (type) {
            ///up
        case 1001://邀请码
            [RouteManager routeForName:RN_center_inviteCode  currentC:self parameters:@{@"title":title}];
            break;
        case 1004://充值中心
            [RouteManager routeForName:RN_center_myAccountAC currentC:self];
            break;
        case 1005://贵族中心
            [RouteManager routeForName:RN_User_buyVIP currentC:self parameters:@{@"title":title}];
            break;
        case 1007:{//任务中心
            [RouteManager routeForName:RN_center_taskCenter currentC:self];
        }
            break;
        case 1008://收益中心
        {
            //主播认证(是否是主播)
            kWeakSelf(self);
            if ([KLCAppConfig appConfig].incomeCashAuth) {
                [self getAnchorAuthority:^(BOOL success) {
                    if (success) {
                        [weakself pushEarningView];
                    }
                }];
            }else{
                [self pushEarningView];
            }
        }
            break;
        case 2016://设置
            [RouteManager routeForName:RN_center_settingAC currentC:self parameters:@{@"id":@(self.mineCenterModel.userInfo.userId),@"title":title}];
            break;
        case 2018:{//在线客服
            [RouteManager routeForName:RN_center_setting_onLineService currentC:self];
        }
            break;
        case 2021:{//认证中心
            [self getAnchorAuthority:^(BOOL success) {
                if (success) {
                    [self.navigationController pushViewController:[[SVUserAuthResultVC alloc] init] animated:YES];
                }
            }];
        }
            break;
    }
}

///跳转到收益中心
- (void)pushEarningView{
    NSString *param = [NSString stringWithFormat:@"%@/pub/h5page/index.html#/userRevenue?_token_=%@&_uid_=%lld",[ProjConfig baseUrl],[ProjConfig userToken],[ProjConfig userId]];
    if ([[ProjConfig shareInstence].baseConfig externalWithdrawal]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:param]];
    }else{
        [RouteManager routeForName:RN_general_webView currentC:self parameters:@{@"url":param}];
    }
}

- (void)getAnchorAuthority:(void(^)(BOOL success))callBack{
    [HttpApiUserController getMyAnchor:^(int code, NSString *strMsg, MyAnchorVOModel *model) {
        if (code == 1) {
            if (model.anchorAuditStatus == 0 && model.role > 0) {
                callBack(YES);
            }else{
                [self authorityTipShow:model];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


- (void)authorityTipShow:(MyAnchorVOModel *)model{
    NSString *tipStr;
    NSString *sureStr = kLocalizationMsg(@"确定");
    switch(model.anchorAuditStatus) {
        case 0://已经成为主播（通过）
            if (model.role <= 0) {
                tipStr = [[ProjConfig shareInstence].baseConfig getAnchorTipsStr];
                sureStr = kLocalizationMsg(@"去认证");
            }else{
                tipStr = kLocalizationMsg(@"恭喜，已经成功认证!");
            }
            break;
        case 1://审核中
            tipStr= kLocalizationMsg(@"你的认证正在审核中...");
            break;
        case 2://审核失败
            tipStr = kLocalizationMsg(@"审核未通过,快去重新认证吧！");
            sureStr = kLocalizationMsg(@"去认证");
            break;
        case -1://未申请过主播认证
            tipStr = [[ProjConfig shareInstence].baseConfig getAnchorTipsStr];
            sureStr = kLocalizationMsg(@"去认证");
            break;
        default:
            break;
    }
    kWeakSelf(self);
    ForceAlertController *alert = [ForceAlertController alertTitle:kLocalizationMsg(@"提示") message:tipStr];
    [alert addOptions:kLocalizationMsg(@"取消") textColor:ForceAlert_BlackColor clickHandle:nil];
    [alert addOptions:sureStr textColor:ForceAlert_NormalColor clickHandle:^{
        if (model.anchorAuditStatus == -1 && model.role <= 0) {
            [weakself authorityGenderJudge:model];
        }else if (model.anchorAuditStatus == 1 && model.role <= 0){
           // NSLog(@"过滤文字主播审核等待"));
        }else{
            [RouteManager routeForName:RN_center_anchorAuthAC currentC:self];
        }
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)authorityGenderJudge:(MyAnchorVOModel *)model{
    APPConfigModel *config =KLCAppConfig.appConfig;
    if (config.adminLiveConfig.authIsSex == 0 && [KLCUserInfo getGender] != 2) {//只允许女性
        //弹框
        CustomPopUpAlert *customAlert = [CustomPopUpAlert alertTitle:kLocalizationMsg(@"温馨提示") message:kLocalizationMsg(@"暂时只支持小姐姐认证哦~") liveType:LiveTypeForCommon];
        customAlert.clickCancelBlock = ^{
            
        };
        customAlert.clickSureBlock = ^(NSString * _Nonnull passwordStr) {
            
        };
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self presentViewController:customAlert animated:YES completion:nil];
        });
    }else{
        [RouteManager routeForName:RN_center_anchorAuthAC currentC:self];
    }
}
- (void)customerSeverCall{
    [RouteManager routeForName:RN_center_setting_contactService currentC:self];
}

- (void)shopCheckIn{
    kWeakSelf(self);
    [HttpApiShopBusiness settleIn:^(int code, NSString *strMsg, AppMerchantAgreementDTOModel *model) {
        if (code == 1) {
            // 状态 0:没有申请 1:审核中 2.审核通过 3.审核拒绝 4.店铺被冻结
            if (model.status>0) {
                
                [RouteManager routeForName:RN_Shopping_ShopContentVC  currentC:weakself parameters:@{@"status":@(model.status),@"remake":model.remake}];
            }else{
                
                [RouteManager routeForName:RN_Shopping_OfficialShopVC
                                  currentC:weakself
                                parameters:@{ @"id":@(weakself.mineCenterModel.userInfo.userId),@"postExcerpt":model.postExcerpt,@"postTitle":model.postTitle}];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}
#pragma mark - MineHeaderViewDelegate
- (void)MineHeaderView:(MineHeaderView *)headerView userModel:(ApiUserInfoModel *)model{
    [RouteManager routeForName:RN_user_userInfoVC  currentC:self parameters:@{@"id":@(model.userId)}];
}

- (void)MineHeaderView:(MineHeaderView *)headerView funcType:(NSInteger)funcType userModel:(ApiUserInfoModel *)model {
    
    switch (funcType) {
        case 1:
            [RouteManager routeForName:RN_User_UserRelationList currentC:self parameters:@{@"navTitle":kLocalizationMsg(@"我的关注"), @"type":@(4)}];
            break;
        case 2:
            [RouteManager routeForName:RN_User_UserRelationList currentC:self parameters:@{@"navTitle":kLocalizationMsg(@"我的粉丝"), @"type":@(3)}];
            break;
        case 3:
        {
            
        }
            break;
        case 4:{
            if (self.mineCenterModel.nobleExpireDay > 0) {
                [RouteManager routeForName:RN_center_lookMeMore  currentC:self parameters:@{@"id":@(model.userId),@"title":kLocalizationMsg(@"谁看过我")}];
            }else{
                if (self.mineCenterModel.isVipSee) {
                    [RouteManager routeForName:RN_center_lookMeMore  currentC:self parameters:@{@"id":@(model.userId),@"title":kLocalizationMsg(@"谁看过我")}];
                }else{
                    [LookeMeTipView showLookeMeTipViewCallBack:^(BOOL isClose) {
                        if (!isClose) {
                            [RouteManager routeForName:RN_User_buyVIP currentC:self parameters:nil];
                        }
                    }];
                    
                }
            }
            
        }
            break;
        case 6:{ ///我的剧集
            [RouteManager routeForName:RN_Television_MineTelevision currentC:self];
        }
            break;
        default:
            break;
    }
}


#pragma mark - collection
- (void)addCategoryView{
    
    for (int i = 0; i < 3; i++) {
        NSDictionary *dic;
        NSString *title;
        if (i == 0) {
            title = [NSString stringWithFormat:kLocalizationMsg(@"作品 %d"),0];
            dic = @{@"title":title,@"type":@0};
            
        }else if (i == 1){
            title = [NSString stringWithFormat:kLocalizationMsg(@"喜欢 %d"),0];
            dic = @{@"title":title,@"type":@1};
            
        }else if (i == 2){
            title = [NSString stringWithFormat:kLocalizationMsg(@"购买 %d"),0];
            dic = @{@"title":title,@"type":@2};
        }
        [self.titles addObject:title];
        [self.typeArr addObject:dic];
    }
    //线
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = kRGB_COLOR(@"#9A58FF");
    lineView.verticalMargin = 4;
    lineView.indicatorWidth = 2*kScreenWidth/(self.titles.count*3.0);
    //标题
    JXCategoryTitleView *titleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    titleView.delegate = self;
    titleView.titleDataSource = self;
    titleView.titles = self.titles;
    titleView.titleColorGradientEnabled = NO;
    titleView.titleLabelAnchorPointStyle = JXCategoryTitleLabelAnchorPointStyleBottom;
    titleView.averageCellSpacingEnabled = YES;
    titleView.indicators = @[lineView];
    titleView.backgroundColor = [UIColor whiteColor];
    titleView.titleFont = [UIFont systemFontOfSize:14];
    titleView.titleSelectedFont = [UIFont systemFontOfSize:14];
    titleView.cellSpacing = 5;
    titleView.titleColor = kRGB_COLOR(@"#999999");
    titleView.titleSelectedColor = kRGB_COLOR(@"#333333");
    
    self.titleView = titleView;
    [self.view addSubview:self.titleView];
    self.selectedIndex = 0;
    [self.titleView setDefaultSelectedIndex:self.selectedIndex];
    self.titleView.listContainer.contentScrollView.scrollEnabled  = YES;
    
    
    self.pagingView = [[JXPagerView alloc] initWithDelegate:self];
    self.pagingView.frame = CGRectMake(0, 0, kScreenWidth,kScreenHeight-kTabBarHeight);
    self.pagingView.listContainerView.backgroundColor = [UIColor whiteColor];
    self.pagingView.defaultSelectedIndex = self.selectedIndex;
    self.pagingView.pinSectionHeaderVerticalOffset = kStatusBarHeight;
    [self.view addSubview:self.pagingView];
    kWeakSelf(self);
    self.pagingView.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadData:YES];
    }];
    self.titleView.listContainer = (id<JXCategoryViewListContainer>)self.pagingView.listContainerView;
}


#pragma mark - JXPagerViewDelegate
- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.mainHeaderView;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return [self getMianHeaderheight];
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return 50;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.titleView;
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    return self.titles.count;
}

- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    NSDictionary *dict = self.typeArr[index];
    int type = [dict[@"type"] intValue];
    CGFloat sv_width = (kScreenWidth -24-6)/3.0;
    CGFloat sv_height = 160*sv_width/118.0;
    UICollectionViewFlowLayout *waterfallLayout = [[UICollectionViewFlowLayout alloc] init];
    waterfallLayout.minimumLineSpacing = 4;
    waterfallLayout.minimumInteritemSpacing = 3;
    waterfallLayout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 12);
    waterfallLayout.itemSize = CGSizeMake(sv_width, sv_height);
    ShortVideoCollectionView *myCollete = [[ShortVideoCollectionView alloc]initWithFrame:CGRectMake(12, 0, kScreenWidth-24, 0) collectionViewLayout:waterfallLayout];
    myCollete.showsVerticalScrollIndicator = NO;
    myCollete.scrollDelegate = self;
    myCollete.tag = index;
    myCollete.type = type;
    return myCollete;
}

#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    self.selectedIndex = index;
}
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    self.selectedIndex = index;
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
    self.selectedIndex = index;
}

- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    
}
#pragma mark - JXCategoryTitleViewDataSource
- (CGFloat)categoryTitleView:(JXCategoryTitleView *)titleView widthForTitle:(NSString *)title{
    CGSize size = [title boundingRectWithSize:CGSizeMake(kScreenWidth-70, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    return size.width*1.0+3;
    
}

#pragma mark - ShortVideoCollectionViewDalegate

- (void)shortVideoCollectionView:(ShortVideoCollectionView *)shortVideoCollection didSelected:(NSInteger)index type:(int)type{
    NSDictionary *prams = @{
        @"dataType":@(2),
        @"type":@(type),
        @"index":@(index)
    };
    [RouteManager routeForName:RN_shortVideo_play_List currentC:self parameters:prams];
}
@end




