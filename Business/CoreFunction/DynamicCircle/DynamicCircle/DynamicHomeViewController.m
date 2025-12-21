//
//  DynamicHomeViewController.m
//  DynamicCircle
//
//  Created by KLC on 2020/7/1.
//  Copyright © 2020 . All rights reserved.
//

#import "DynamicHomeViewController.h"
 
#import "DynamicMainViewController.h"

#import <LibTools/LibTools.h>
#import <LibTools/SVProgressHUD.h>

#import <LibProjBase/LibProjBase.h>
#import <LibProjView/CustomPopUpAlert.h>
#import <LibProjView/OnlineUserVC.h>

#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/HttpApiUserController.h>
#import <LibProjModel/HttpApiAnchorController.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/AdminLiveConfigModel.h>

#import "JXCategoryView.h"
#import <JXCategoryView/JXCategoryTitleView.h>
#import <JXCategoryView/JXCategoryIndicatorLineView.h>
#import <LibProjView/FunctionSelectManager.h>

@interface DynamicHomeViewController ()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate,JXCategoryTitleViewDataSource>

@property (nonatomic, weak)JXCategoryTitleView *titleView;

@property(nonatomic, copy)NSArray* typeArr;//功能类型


@end

@implementation DynamicHomeViewController

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action{
    return [[UIBarButtonItem alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    
    _typeArr = [[ProjConfig shareInstence].businessConfig getSquareClassfiyArray];
    
    if ([ProjConfig getAppType] != 4) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[BaseNavBarItem navItemImageName:@"icon_nav_dynamic_publish" clickHandle:^{
            [self dynamicAddBtnClick];
        }]];
    }

    [self addCategoryView];
}

-(BOOL)firstColor:(UIColor*)firstColor secondColor:(UIColor*)secondColor{
    if (CGColorEqualToColor(firstColor.CGColor, secondColor.CGColor)){
        return YES;
    } else {
        return NO;
    }
}

- (void)addCategoryView{
    [self.titleView removeAllSubViews];
    [self.titleView removeFromSuperview];
    self.titleView = nil;
    
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    //子控制器列表
    for (NSDictionary *dic in self.typeArr) {
        [titles addObject:dic[@"title"]];
    }
    
    CGFloat rightWith = 70;
    JXCategoryTitleView *titleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth-rightWith, kNavBarHeight-kStatusBarHeight-5)];
    titleView.delegate = self;
    titleView.contentEdgeInsetLeft = 10;
    titleView.contentEdgeInsetRight = 10;
    titleView.titles = titles;
    titleView.titleColorGradientEnabled = NO;
    titleView.averageCellSpacingEnabled = NO;
    titleView.titleColorGradientEnabled = YES;
    titleView.titleLabelZoomEnabled = YES;
    titleView.titleLabelZoomScale = 1.2;
    titleView.backgroundColor = [UIColor clearColor];
    titleView.titleFont = [UIFont systemFontOfSize:kTitleViewTitleFont];
    titleView.titleSelectedFont = [UIFont systemFontOfSize:kTitleViewTitleSelectedFont];
    titleView.cellSpacing = 20;
    titleView.titleColor = [ProjConfig projNavTitleColor];
    titleView.titleSelectedColor = [ProjConfig projNavTitleColor];
    [self.navigationController.navigationBar addSubview:titleView];
    [titleView setDefaultSelectedIndex:(NSInteger)self.homeDefaultSelectedIndex];
    self.titleView = titleView;
    
    if (titles.count > 1) {
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorColor = [ProjConfig normalColors];
        lineView.indicatorWidth = 16.0;
        titleView.indicators = @[lineView];
    }
    
    JXCategoryListContainerView *listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    listContainerView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight-kTabBarHeight);
    [self.view addSubview:listContainerView];
    self.titleView.listContainer = listContainerView;
    
    [self.titleView reloadData];
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

#pragma mark - JXCategoryListContainerViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    
    NSDictionary *dict = self.typeArr[index];
    int type = [dict[@"type"] intValue];
    
    switch (type) {// 附近的人
        case 0:{
            OnlineUserVC *list = [[OnlineUserVC alloc] init];
            return list;
        }
        case 1:{//动态
            DynamicMainViewController *dynamicVc = [[DynamicMainViewController alloc]init];
            return dynamicVc;
        }
            break;
        default:{
            DynamicMainViewController *dynamicVc = [[DynamicMainViewController alloc]init];
            return dynamicVc;
        }
            break;
    }
    
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.typeArr.count;
}

#pragma mark - 发动态
- (void)dynamicAddBtnClick{
    [FunctionSelectManager pushViewControllerForType:MainFunctionForDynamic];
}

@end
