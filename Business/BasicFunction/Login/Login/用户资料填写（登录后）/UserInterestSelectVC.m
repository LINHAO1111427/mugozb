//
//  UserInterestSelectVC.m
//  Login
//
//  Created by klc_sl on 2021/2/24.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "UserInterestSelectVC.h"
#import "UsermarkSelectedView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/BaseNavBarItem.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/HttpApiUserController.h>
#import <LibProjModel/TabInfoDtoModel.h>
#import <LibProjModel/UserInterestTabVOModel.h>
#import <LibProjBase/LibProjBase.h>

@interface UserInterestSelectVC ()

@property(nonatomic,strong)NSArray *markArray;
@property(nonatomic,strong)NSMutableArray *myMarkArr;

@end

@implementation UserInterestSelectVC

- (NSMutableArray *)myMarkArr{
    if (!_myMarkArr) {
        _myMarkArr = [NSMutableArray array];
    }
    return _myMarkArr;
}
- (NSArray *)markArray{
    if (!_markArray) {
        _markArray = [NSArray array];
    }
    return _markArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = kLocalizationMsg(@"选择你的兴趣");
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[BaseNavBarItem navItemTitle:kLocalizationMsg(@"跳过") bgColor:[UIColor clearColor] textColor:kRGBA_COLOR(@"333333", 1.0) clickHandle:^{
        [self ignoreBtnClick];
    }]];
    [self loadData];
}



- (void)loadData{
    [HttpApiUserController allTabs:^(int code, NSString *strMsg, NSArray<TabTypeDtoModel *> *arr) {
        if (code == 1) {
            self.markArray = arr;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self viewSetUp];
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


- (void)viewSetUp{
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1.0)];
    line.backgroundColor = kRGB_COLOR(@"#DEDEDE");
    [self.view addSubview:line];
    
    CGFloat bottomY = 0;
    
    UIButton *startBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, kScreenHeight-kSafeAreaBottom-kNavBarHeight-55, kScreenWidth-30, 40)];
    [startBtn addTarget:self action:@selector(startBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    startBtn.centerX = self.view.centerX;
    startBtn.layer.cornerRadius = 20;
    startBtn.layer.masksToBounds = YES;
    [self.view addSubview:startBtn];
    
    if ([KLCUserInfo getGender] == 1 || [ProjConfig getAppType] == 4) { ///男 不认证
        [startBtn setTitle:kLocalizationMsg(@"选好了，开始探索") forState:UIControlStateNormal];
        [startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg_pink"] forState:UIControlStateNormal];
        bottomY = startBtn.y;
        
    }else{ ///女 认证
        [startBtn setTitle:kLocalizationMsg(@"暂不认证，进入首页") forState:UIControlStateNormal];
        [startBtn setTitleColor:kRGBA_COLOR(@"#666666", 1.0) forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageWithColor:kRGBA_COLOR(@"#F4F4F4", 1.0)] forState:UIControlStateNormal];

        UIButton *userAuthBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, startBtn.y-15-40, kScreenWidth-30, 40)];
        [userAuthBtn addTarget:self action:@selector(userAuthBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        userAuthBtn.centerX = self.view.centerX;
        userAuthBtn.layer.cornerRadius = 20;
        userAuthBtn.layer.masksToBounds = YES;
        [userAuthBtn setTitle:kLocalizationMsg(@"认证主播，开始赚钱") forState:UIControlStateNormal];
        [userAuthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [userAuthBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg_pink"] forState:UIControlStateNormal];
        [self.view addSubview:userAuthBtn];
        
        bottomY = userAuthBtn.y;
    }

    UIScrollView *scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(15, 10, kScreenWidth-30, bottomY-20-line.maxY)];
    scrollview.backgroundColor = [UIColor clearColor];
    scrollview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollview];
    
    CGFloat rowH = 20;
    
    for (int i = 0; i < self.markArray.count; i++) {
        TabTypeDtoModel *model = self.markArray[i];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, rowH, kScreenWidth-40, 20)];
        titleLabel.textColor = kRGB_COLOR(@"#333333");
        titleLabel.font  =[UIFont systemFontOfSize:14];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.text = model.name;
        [scrollview addSubview:titleLabel];
        
        CGFloat lineMaxX = 0; //横X点
        CGFloat lineMaxY = titleLabel.maxY+15;  ///横Y点
        for (int j = 0; j < model.tabInfoList.count; j++) {
            
            TabInfoDtoModel *tabModel = model.tabInfoList[j];
            CGFloat btnHeight = 40;

            CGSize textSize = [tabModel.name.length>0?tabModel.name:@" " sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
            CGFloat width = textSize.width+26;
            
            if ((lineMaxX + width) > scrollview.width) {
                lineMaxX = 0;
                lineMaxY += (btnHeight+5);
            }
        
            kWeakSelf(self);
            UsermarkSelectedView *maskSelectView = [[UsermarkSelectedView alloc]initWithFrame:CGRectMake(lineMaxX, lineMaxY, width, btnHeight) callBlock:^(TabInfoDtoModel * _Nonnull model, BOOL selected) {
                if (selected) {
                    [weakself.myMarkArr addObject:model];
                }else{
                    TabInfoDtoModel *mod;
                    BOOL isCotain = NO;
                    for (TabInfoDtoModel *modsub in weakself.myMarkArr) {
                        if (modsub.id_field == model.id_field) {
                            mod = modsub;
                            isCotain = YES;
                            break;
                        }
                    }
                    if (isCotain) {
                        [weakself.myMarkArr removeObject:mod];
                    }
                }
            }];

            maskSelectView.tabModel = tabModel;
            maskSelectView.selected = NO;
            [scrollview addSubview:maskSelectView];
            
            lineMaxX += (width+15);

            rowH = (maskSelectView.maxY+20);
        }
    }
    scrollview.contentSize = CGSizeMake(kScreenWidth-40,rowH);

}


///开始进入主页
- (void)startBtnClick:(UIButton *)btn{
    [self addUserLabs];
    [self joinMainViewController];
}

///主播认证
- (void)userAuthBtnClick:(UIButton *)btn{
    [self addUserLabs];
    [RouteManager routeForName:RN_center_anchorAuthAC currentC:self];
}

/// 跳过
- (void)ignoreBtnClick{
    [self joinMainViewController];
}

///进入主页
- (void)joinMainViewController{
    [[ProjConfig shareInstence].baseConfig showHomeMainVC];
}

- (void)addUserLabs{
    if (self.myMarkArr.count > 0) {
        NSString *requestStr = @"";
        for (int i = 0; i < self.myMarkArr.count; i++) {
            TabInfoDtoModel *detailModel = self.myMarkArr[i];
            if (i == 0) {
                requestStr = [NSString stringWithFormat:@"%lld:%@",detailModel.id_field,detailModel.name];
            }else{
                requestStr = [NSString stringWithFormat:@"%@,%lld:%@",requestStr,detailModel.id_field,detailModel.name];
            }
        }
       // NSLog(@"过滤文字request == %@"),requestStr);
        [HttpApiUserController updateInterest:requestStr callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                [SVProgressHUD showSuccessWithStatus:strMsg];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }
    }


@end
