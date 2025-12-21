//
//  LiveMainViewController.m
//  TCDemo
//
//  Created by klc_tqd on 2019/8/26.
//  Copyright © 2019 CH. All rights reserved.
//

#import "HomeMainViewController.h"

#import <LibProjModel/HomeDtoModel.h>
#import <LibProjModel/HttpApiHome.h>
#import <LibProjModel/AppUserDtoModel.h>
#import <LibProjModel/HttpApiPublicLive.h>
#import <LibProjModel/AppLiveChannelModel.h>

#import <HomePage/HomeNearbyViewController.h>
#import <HomePage/HomeRecommendViewController.h>
#import <HomePage/HomeLiveVideoViewController.h>
#import <Shopping/HomeLiveShoppingViewController.h>

#import <HomePage/UserAttentionLiveVC.h>
 
#import <LibProjView/CitySelecteView.h>
#import <LibProjBase/LibProjBase.h>

#import "JXCategoryView.h"

#import <LibProjModel/HttpApiApiRechargeRules.h>
#import <LibProjModel/HttpApiOperationController.h>
#import <LibProjView/FirstRechargeRewardView.h>
 
@interface HomeMainViewController ()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate,JXCategoryTitleViewDataSource>

@property(nonatomic,strong)CitySelecteView *cityView;

///之前点的index标题
@property (nonatomic, assign) NSInteger beforeSelectIndex;

@property (nonatomic, weak)JXCategoryTitleImageView *titleImageV;

@property (nonatomic, strong)UIButton *firstRechargeTipBtn;//首充奖励

@end

@implementation HomeMainViewController

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action{
    return [[UIBarButtonItem alloc] init];
}

 
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCategoryView];
    
    UIBarButtonItem *publish = [[UIBarButtonItem alloc] initWithCustomView:[BaseNavBarItem navItemImageName:@"icon_nav_live_publish" clickHandle:^{
        [ProjConfig showSuspenPublish];
    }]];
    self.navigationItem.rightBarButtonItems = @[publish];
    
}

- (BOOL)isCotain1v1{
    NSString *appTypeStr = [NSString stringWithFormat:@"%d",[ProjConfig getAppType]];
    if ([appTypeStr containsString:@"2"]) {
        return YES;
    }
    return NO;
}
 
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self firstRechargeUpdte];
}

- (void)addCategoryView{
    [self.titleImageV removeAllSubViews];
    [self.titleImageV removeFromSuperview];
    self.titleImageV = nil;
    //子控制器列表
    
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    NSMutableArray *defaultImageN = [[NSMutableArray alloc] init];
    NSMutableArray *selectImageN = [[NSMutableArray alloc] init];
    NSMutableArray *typeArr = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in self.typeArr) {
        [titles addObject:dic[@"title"]];
        [defaultImageN addObject:@""];
        if ([dic[@"homeType"] intValue] == 9) {
            [selectImageN addObject:@"map_location_down"];
            [typeArr addObject:@(JXCategoryTitleImageType_RightImage)];
        }else{
            [selectImageN addObject:@""];
            [typeArr addObject:@(JXCategoryTitleImageType_OnlyTitle)];
        }
        
    }
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = [ProjConfig projNavTitleColor];
    lineView.indicatorWidth = 16.0;
    
    
    
    CGFloat rightWith = 120;
    JXCategoryTitleImageView *titleImageV = [[JXCategoryTitleImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-rightWith, kNavBarHeight-kStatusBarHeight-5)];
    titleImageV.delegate = self;
    titleImageV.titles = titles;
    titleImageV.titleLabelZoomEnabled = YES;
    titleImageV.titleLabelZoomScale = 1.2;
    titleImageV.contentEdgeInsetLeft = 15;
    titleImageV.contentEdgeInsetRight = 15;
    titleImageV.imageNames = defaultImageN;
    titleImageV.selectedImageNames = selectImageN;
    titleImageV.averageCellSpacingEnabled = NO;
    titleImageV.indicators = @[lineView];
    titleImageV.backgroundColor = [UIColor clearColor];
    titleImageV.titleFont = [UIFont systemFontOfSize:kTitleViewTitleFont];
    titleImageV.titleSelectedFont = [UIFont systemFontOfSize:kTitleViewTitleSelectedFont];
    titleImageV.cellSpacing = 15;
    titleImageV.titleColor = [ProjConfig projNavTitleColor];
    titleImageV.titleSelectedColor = [ProjConfig projNavTitleColor];
    [titleImageV setDefaultSelectedIndex:self.homeDefaultSelectedIndex];
    titleImageV.titleImageSpacing = 2;
    titleImageV.imageTypes = typeArr;
    titleImageV.imageSize = CGSizeMake(10, 10);
    self.titleImageV = titleImageV;
    
    
    JXCategoryListContainerView *listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    listContainerView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self.view addSubview:listContainerView];
    self.titleImageV.listContainer = listContainerView;
    [listContainerView reloadData];
    [self.navigationController.navigationBar addSubview:self.titleImageV];

}
 
- (void)citySelected:(UIGestureRecognizer *)gesture{
    
    NSDictionary *dict = self.typeArr[self.titleImageV.selectedIndex];
    
    if ([dict[@"homeType"] intValue] == 9) {
        if (!self.cityView) {
            self.cityView = [[CitySelecteView alloc]init];
        }
        kWeakSelf(self);
        [self.cityView showInView:[UIApplication sharedApplication].keyWindow withType:CitySelecteTypeNearby callBack:^(BOOL cancel, NSString * _Nonnull city, NSString * _Nonnull gender, NSArray * _Nonnull tags) {
            if (!cancel) {
                [weakself loadChildView:city];
            }
            weakself.cityView = nil;
        }];
        
    }
}
- (void)loadChildView:(NSString *)city{
    if ([self.childViewControllers.firstObject isKindOfClass:NSClassFromString(@"JXCategoryListContainerViewController")]) {
        NSArray *arr = self.childViewControllers.firstObject.childViewControllers;
        for (UIViewController *vc in arr) {
            if ([vc isKindOfClass:[HomeNearbyViewController class]]) {
                HomeNearbyViewController *nearbyVc = (HomeNearbyViewController *)vc;
                nearbyVc.address = city;
                [nearbyVc loadData:YES];
                break;
            }
        }
    }
}

#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    NSDictionary *dict = self.typeArr[index];
    if ([dict[@"homeType"] intValue] == 9 && index == _beforeSelectIndex) {
        [self citySelected:nil];
    }else{
    }
}

- (BOOL)categoryView:(JXCategoryBaseView *)categoryView canClickItemAtIndex:(NSInteger)index{
    _beforeSelectIndex = categoryView.selectedIndex;
    return YES;
}


#pragma mark - JXCategoryListContainerViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    
    NSDictionary *dict = self.typeArr[index];
    int homeType = [dict[@"homeType"] intValue];
    switch (homeType) {
        case 0:{//推荐热门
            HomeRecommendViewController *recommendVc = [[HomeRecommendViewController alloc]init];
            return recommendVc;
        }
            break;
        case 16:{ ///关注
            UserAttentionLiveVC *attenVC = [[UserAttentionLiveVC alloc] init];
            return attenVC;
        }
            break;
        case 1:{//视频直播
            HomeLiveVideoViewController *liveVideoVc = [[HomeLiveVideoViewController alloc]init];
            liveVideoVc.liveType = 1;
            return liveVideoVc;
        }
            break;
        case 2:{  //语音
            HomeLiveVideoViewController *liveVideoVc = [[HomeLiveVideoViewController alloc]init];
            liveVideoVc.liveType = 2;
            return liveVideoVc;
        }
            break;
        case 4:{//直播购物
            HomeLiveShoppingViewController *shoppingVc = [[HomeLiveShoppingViewController alloc] init];
            return shoppingVc;
        }
            break;
        case 9:{//附近
            HomeNearbyViewController *nearBy = [[HomeNearbyViewController alloc]init];
            NSString *city = [[NSUserDefaults standardUserDefaults]objectForKey:@"location_city"];
            nearBy.address = city;
            return nearBy;
        }
            break;
        default:{
            HomeRecommendViewController *recommendVc = [[HomeRecommendViewController alloc]init];
            return recommendVc;
        }
            break;
    }
   
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.typeArr.count;
}


//首充奖励
- (void)firstRechargeUpdte{
    [self.firstRechargeTipBtn removeFromSuperview];
    self.firstRechargeTipBtn = nil;
    kWeakSelf(self);
    [HttpApiApiRechargeRules rulesList:^(int code, NSString *strMsg, RechargeCenterVOModel *model) {
        if (code == 1 && model) {
            if (model.isFirstRecharge == 0) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakself showRechargeView];
                });
            }
        }
    }];
}

- (void)showRechargeView{
    CGFloat y = kScreenHeight-(148+kSafeAreaBottom+53+30)-74;
    UIButton *firstRechargeTipBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-64, y, 64, 64)];
    firstRechargeTipBtn.backgroundColor = [UIColor clearColor];
    [firstRechargeTipBtn setBackgroundImage:[UIImage imageNamed:@"first_recharge_btn_bg"] forState:UIControlStateNormal];
    [firstRechargeTipBtn addTarget:self action:@selector(firstRechargeTipBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.firstRechargeTipBtn = firstRechargeTipBtn;
    [self.view addSubview:firstRechargeTipBtn];
}
 

- (void)firstRechargeTipBtnClick:(UIButton *)btn{
    kWeakSelf(self);
    [HttpApiOperationController firstRechargeGift:^(int code, NSString *strMsg, NSArray<RechargeGiftVOModel *> *arr) {
        if (code == 1 && arr.count > 0) {
            [FirstRechargeRewardView mainPageShowRechargeReward:arr];
        }else{
            [RouteManager routeForName:RN_center_myAccountAC currentC:weakself];
        }
    }];
}


@end
