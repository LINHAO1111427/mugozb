//
//  UserInfoMainVC.m
//  UserInfo
//
//  Created by ssssssss on 2020/12/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "UserInfoMainVC.h"

#import "UserInfoNavBar.h"
#import "UserInfoHeaderView.h"
#import "UserInfomationTable.h"
#import "UserInfoPraisedTable.h"
#import "UserInfoShortVideoTable.h"

#import <JXCategoryView/JXCategoryView.h>

#import <LibProjModel/ApiUserInfoModel.h>
#import <JXPagingView/JXPagerView.h>
#import <LibProjView/GiftUserModel.h>

#import "UserInfoBottomFuncView.h"
#import <LibProjView/DynamicClassfiyListVC.h>

@interface UserInfoMainVC ()<UIScrollViewDelegate,JXCategoryViewDelegate,JXCategoryTitleViewDataSource,JXPagerViewDelegate,UIGestureRecognizerDelegate>
 
@property (nonatomic,strong) UserInfoHomeVOModel *homeModel;
@property (nonatomic,strong) UserInfoNavBar *userInfoNavBar;// 导航栏
@property (nonatomic,strong) UserInfoHeaderView *mainHeaderView;//主header
@property (nonatomic,strong) UserInfoBottomFuncView *bottomV;

//子控制器表
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong) JXCategoryTitleView *titleView;
@property (nonatomic, strong) JXPagerView *pagingView;
@property (nonatomic, strong) NSArray *typeArray;


@end

@implementation UserInfoMainVC
- (instancetype)init{
    self = [super init];
    if (self) {
        _typeArray = [[ProjConfig shareInstence].businessConfig getUserInfoClassfiyArray];
    }
    return self;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_mainHeaderView stopScroll];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getUserInfoData];//获取个人信息
}


- (void)createBaseView{
    //自定义导航栏
    kWeakSelf(self);
    UserInfoNavBar *navBar = [[UserInfoNavBar alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavBarHeight) superVc:self];
    navBar.navUserAvaterBtnClick = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself.pagingView.mainTableView setContentOffset:CGPointZero animated:YES];
        });
    };
    navBar.navAttenUserBtnClick = ^(BOOL isAtten) {
        [weakself userAtten:isAtten];
    };
    [self.view addSubview:navBar];
    self.userInfoNavBar = navBar;
    
    // 设置头部
    UserInfoHeaderView *mainHeaderView = [[UserInfoHeaderView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenWidth+120)];
    mainHeaderView.superVc = self;
    mainHeaderView.attenUserBtnClick = ^(BOOL isAtten) {
        [weakself userAtten:isAtten];
    };
    mainHeaderView.reloadHeightBlock = ^{
        [weakself.pagingView reloadData];
    };
    mainHeaderView.backgroundColor = [UIColor whiteColor];
    self.mainHeaderView = mainHeaderView;
    //列表
    [self addCategoryTitleView];
    
    [self.view bringSubviewToFront:self.userInfoNavBar];
    
    //底部
    if (self.userId != [ProjConfig userId]) {
        _bottomV = [[UserInfoBottomFuncView alloc] initWithFrame:CGRectMake(0,kScreenHeight-kSafeAreaBottom-70, kScreenWidth, 70+kSafeAreaBottom)];
        _bottomV.attenUserBtnClick = ^(BOOL isAtten) {
            [weakself userAtten:isAtten];
        };
        [self.view addSubview:_bottomV];
        _bottomV.homeModel = self.homeModel;
    }
}

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    [super viewDidLoad];
    
    [self createBaseView];
}


- (void)addCategoryTitleView{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in self.typeArray) {
        NSString *title = dic[@"title"];
        [array addObject:title];
    }
    //线
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = [ProjConfig normalColors];
    lineView.verticalMargin = 0;
    lineView.indicatorWidth = 10;
    
    //标题
    JXCategoryTitleView *titleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(15, 0,kScreenWidth-30, 40)];
    titleView.delegate = self;
    titleView.titleDataSource = self;
    titleView.titles = array;
    titleView.titleColorGradientEnabled = NO;
    titleView.titleLabelAnchorPointStyle = JXCategoryTitleLabelAnchorPointStyleBottom;
    titleView.titleLabelZoomEnabled = YES;
    titleView.averageCellSpacingEnabled = NO;
    titleView.titleLabelZoomScale = 1.2;
    titleView.indicators = @[lineView];
    titleView.backgroundColor = [UIColor whiteColor];
    titleView.titleFont = [UIFont boldSystemFontOfSize:17];
    titleView.titleSelectedFont = [UIFont boldSystemFontOfSize:17];
    titleView.cellSpacing = 30;
    titleView.titleColor = kRGB_COLOR(@"#666666");
    titleView.titleSelectedColor = kRGB_COLOR(@"#333333");
    titleView.contentEdgeInsetLeft =  20;
    titleView.contentEdgeInsetRight = 20;
    self.titleView = titleView;
    [self.view addSubview:titleView];
    
    NSInteger selectedIndex = 0;
    
    [self.titleView setDefaultSelectedIndex:selectedIndex];
    self.titleView.listContainer.contentScrollView.scrollEnabled  = YES;
    
    self.pagingView = [[JXPagerView alloc] initWithDelegate:self];
    CGFloat height;
    if (self.userId != [ProjConfig userId]) {
        height = kScreenHeight-kSafeAreaBottom-70;
    }else{
        height = kScreenHeight;
    }
    self.pagingView.frame = CGRectMake(0, 0, kScreenWidth,height);
    self.pagingView.listContainerView.backgroundColor = [UIColor whiteColor];
    self.pagingView.defaultSelectedIndex = selectedIndex;
    self.pagingView.pinSectionHeaderVerticalOffset = kNavBarHeight;
    [self.view addSubview:self.pagingView];
//    self.pagingView.mainTableView.bounces = NO;
    self.titleView.listContainer = (id<JXCategoryViewListContainer>)self.pagingView.listContainerView;
}


#pragma mark - 加载数据
//获取数据
- (void)getUserInfoData{
    [self.mainHeaderView.familyInfoV reloadShowData:self.userId];
    
    kWeakSelf(self);
    [HttpApiUserController getUserInfoHome:self.userId callback:^(int code, NSString *strMsg, UserInfoHomeVOModel *model) {
        if (code == 1) {
            weakself.homeModel = model;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself updateUI];
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakself.mainHeaderView.homeModel = model;
                weakself.userInfoNavBar.homeModel = model;
                weakself.bottomV.homeModel = model;
                [weakself.titleView reloadData];
                [weakself.pagingView.listContainerView reloadData];
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (void)userAtten:(BOOL)isAtten{
    
    if (![ProjConfig isUserLogin]) {
        [RouteManager routeForName:RN_login_ShowLoginVC currentC:self];
        return;
    }
    
    kWeakSelf(self);
    [HttpApiUserController setAtten:isAtten?1:0 touid:self.homeModel.userInfo.userId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            weakself.homeModel.isAttentionUser = isAtten;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakself.mainHeaderView.homeModel =  weakself.homeModel;
                weakself.userInfoNavBar.homeModel =  weakself.homeModel;
                weakself.bottomV.homeModel = weakself.homeModel;
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


- (void)updateUI{
    [self.pagingView reloadData];
}



#pragma mark - JXPagerViewDelegate
- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.mainHeaderView;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return self.mainHeaderView.height;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return 50;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.titleView;
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    return self.typeArray.count;
}

- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index{
    NSDictionary *dic = self.typeArray[index];
    NSInteger tag = [dic[@"id"] integerValue];
    switch (tag) {
        case 0:{//资料
            kWeakSelf(self);
            UserInfomationTable *materialVc = [[UserInfomationTable alloc]initWithUserId:self.userId];
            materialVc.dynamicBtnClick = ^{
                for (int i = 0; i<self.typeArray.count; i++) {
                    NSDictionary *subDic = self.typeArray[i];
                    if ([subDic[@"id"] integerValue] == 2) {
                        [weakself.titleView selectItemAtIndex:i];
                    }
                }
            };
            return materialVc;
            
        }   break;
        case 1:{//视频
            UserInfoShortVideoTable *shortVideoVc = [[UserInfoShortVideoTable alloc]init];
            shortVideoVc.userModel = self.homeModel.userInfo;
            return shortVideoVc;
        }   break;
        case 2:{//动态
            DynamicClassfiyListVC *dynamicVc = [[DynamicClassfiyListVC alloc] init];
            dynamicVc.type = 0;
            dynamicVc.userId = self.homeModel.userInfo.userId;
            return dynamicVc;
        }   break;
        case 3:{//评价
            UserInfoPraisedTable *praisedVc = [[UserInfoPraisedTable alloc]init];
            praisedVc.userModel = self.homeModel.userInfo;
            return praisedVc;
        }break;
        default:{
            return nil;
        }  break;
    }
}

- (void)pagerView:(JXPagerView *)pagerView mainTableViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.pagingView.mainTableView) {
        CGFloat offsetY = scrollView.contentOffset.y;
        // 修改导航栏透明度
    //    self.userInfoNavBar.backgroundColor = [UIColor colorWithWhite:1 alpha:offsetY/tableHeaderViewHeight];
        // 修改组头悬停位置
        if (offsetY >=(_mainHeaderView.headerInfoPointY-kNavBarHeight+10)) {
            if (!self.userInfoNavBar.isScrollOut) {
                self.userInfoNavBar.backgroundColor = [UIColor whiteColor];
                self.userInfoNavBar.isScrollOut = YES;
            }
            self.pagingView.mainTableView.contentInset = UIEdgeInsetsMake(kNavBarHeight, 0, 0, 0);
        } else {
            if (self.userInfoNavBar.isScrollOut) {
                self.userInfoNavBar.backgroundColor = [UIColor clearColor];
                self.userInfoNavBar.isScrollOut = NO;
            }
            self.pagingView.mainTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }
    }
}


#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

#pragma mark - JXCategoryTitleViewDataSource
- (CGFloat)categoryTitleView:(JXCategoryTitleView *)titleView widthForTitle:(NSString *)title{
    CGSize size = [title boundingRectWithSize:CGSizeMake(kScreenWidth-70, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    return size.width*1.0+3;
}


@end
