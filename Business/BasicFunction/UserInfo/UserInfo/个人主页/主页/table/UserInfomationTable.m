//
//  UserInfomationTable.m
//  UserInfo
//
//  Created by ssssssss on 2020/12/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "UserInfomationTable.h"
#import <LibProjModel/AppMedalModel.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/GiftWallDtoModel.h>
#import <LibProjModel/GuardUserVOModel.h>
#import <LibProjModel/UserInterestTabVOModel.h>
#import <LibProjModel/HttpApiMedal.h>
#import <LibProjModel/HttpApiGuard.h>
#import <LibProjModel/HttpApiDynamicController.h>

@interface UserInfomationTable ()<UIScrollViewDelegate>

@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);

@property (nonatomic, strong)UIScrollView *scrollView;

@property (nonatomic, assign)int64_t userId;

@property(nonatomic,strong)NSArray *viewArr;// 显示的内容

@property (nonatomic, weak)UIView *userInfoView;
@property (nonatomic, weak)UIView *medalInfoView;
@property (nonatomic, weak)UIView *guardInfoView;
@property (nonatomic, weak)UIView *giftInfoView;
@property (nonatomic, weak)UIView *dynamicInfoView;

@end

@implementation UserInfomationTable

- (instancetype)initWithUserId:(int64_t)userId {
    self = [super init];
    if (self) {
        _viewArr = [[ProjConfig shareInstence].businessConfig getUserInfoContentArray];
        self.userId = userId;
        [self getUserInfoDetailList];
        [self getGuardList];
        [self getDynamicList];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        [self.view addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _scrollView;
}

- (UIView *)getBaseItemView{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.01)];
    bgView.layer.masksToBounds = YES;
    [self.scrollView addSubview:bgView];
    return bgView;
}

- (void)getGuardList{//获取守护列表
    kWeakSelf(self);
    [HttpApiGuard getMyGuardList:0 pageSize:10 queryType:1 type:2 userId:self.userId callback:^(int code, NSString *strMsg, NSArray<GuardUserVOModel *> *arr) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself showGuardItems:arr];
            [weakself updateContentUI];
        });
    }];
}


- (void)getUserInfoDetailList{ ///获得勋章墙
    kWeakSelf(self);
    [HttpApiUserController getUserInfo2:self.userId callback:^(int code, NSString *strMsg, UserInfo2VOModel *model) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself showUserInfo:model];
            [weakself showMedalItems:model.medalWall];
            [weakself showGiftItems:model.giftWall];
            
            [weakself updateContentUI];
        });
    }];
}

- (void)getDynamicList{ ///查看该用户发布的动态
    kWeakSelf(self);
    [HttpApiDynamicController getNoTextDynamicCircle:self.userId callback:^(int code, NSString *strMsg, NSArray<MyInfoDynamicCircleModel *> *arr) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself showDynamicitems:arr];
            [weakself updateContentUI];
        });
    }];
}

///显示用户信息
- (void)showUserInfo:(UserInfo2VOModel *)voModel{
    
    ApiUserInfoModel *userInfoModel = voModel.userInfo;

    if (![self isContain:0] && ![self isContain:1]) {
        return;
    }
    
    (!self.userInfoView)?(self.userInfoView = [self getBaseItemView]):nil;
    [self.userInfoView removeAllSubViews];

    CGFloat y = 20;
    if ([self isContain:0]) {//个人信息
        CGFloat width = (kScreenWidth-40-20)/3.0;
        {// ID
            UILabel *idnameL = [[UILabel alloc]initWithFrame:CGRectMake(20, y, width, 20)];
            
            idnameL.textAlignment = NSTextAlignmentLeft;
            idnameL.font = [UIFont systemFontOfSize:14];
            
            if (userInfoModel.goodnum.length > 0) {
                NSString *showText = [NSString stringWithFormat:@" %@",userInfoModel.goodnum];
                idnameL.attributedText = [showText attachmentForImage:[UIImage imageNamed:@"icon_userinfo_liang"] bounds:CGRectMake(0, -3, 17, 17) before:YES];
                idnameL.textColor = kRGB_COLOR(@"#FF841A");
            }else{
                NSString *showText = [NSString stringWithFormat:@" %lld",userInfoModel.userId];
                idnameL.attributedText = [showText attachmentForImage:[UIImage imageNamed:@"icon_userinfo_id"] bounds:CGRectMake(0, -3, 17, 17) before:YES];
                idnameL.textColor = kRGB_COLOR(@"#333333");
            }
            [self.userInfoView addSubview:idnameL];
            
            UIButton *copyBtn = [[UIButton alloc]initWithFrame:CGRectMake(idnameL.maxX+10, y, 40, 20)];
            copyBtn.backgroundColor = kRGB_COLOR(@"#F6F6F6");
            [copyBtn setTitle:kLocalizationMsg(@"复制") forState:UIControlStateNormal];
            copyBtn.titleLabel.font = [UIFont systemFontOfSize:10];
            [copyBtn setTitleColor:kRGB_COLOR(@"#999999") forState:UIControlStateNormal];
            copyBtn.layer.cornerRadius = 10;
            copyBtn.clipsToBounds = YES;
            [self.userInfoView addSubview:copyBtn];
            kWeakSelf(self);
            [copyBtn klc_whenTapped:^{
                NSString *url = [NSString stringWithFormat:@"%lld",weakself.userId];
                if (userInfoModel.goodnum.length > 0) {
                    url = userInfoModel.goodnum;
                }
                UIPasteboard *paste = [UIPasteboard generalPasteboard];
                paste.string = url;
                if (url.length == 0 || url == nil || url == NULL) {
                    [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"复制失败")];
                }else{
                    [SVProgressHUD showSuccessWithStatus:kLocalizationMsg(@"复制成功")];
                }
            }];
            
            y += 35;
        }
        
        {//星座 职业
            UILabel *constellationL = [[UILabel alloc]initWithFrame:CGRectMake(20, y, width, 20)];
            constellationL.textColor = kRGB_COLOR(@"#333333");
            constellationL.textAlignment = NSTextAlignmentLeft;
            constellationL.font = [UIFont systemFontOfSize:14];
            NSString *constellationText = [NSString stringWithFormat:@" %@",userInfoModel.constellation.length>0?userInfoModel.constellation : kLocalizationMsg(@"未知")];
            constellationL.attributedText = [constellationText attachmentForImage:[UIImage imageNamed:@"icon_userinfo_constellation"] bounds:CGRectMake(0, -3, 17, 17) before:YES];
            [self.userInfoView addSubview:constellationL];
            
            UILabel *vocationL = [[UILabel alloc]initWithFrame:CGRectMake(constellationL.maxX+10, y, width, 20)];
            vocationL.textColor = kRGB_COLOR(@"#333333");
            vocationL.textAlignment = NSTextAlignmentLeft;
            vocationL.font = [UIFont systemFontOfSize:14];
            NSString *vocationText = [NSString stringWithFormat:@" %@",userInfoModel.vocation.length>0?userInfoModel.vocation:kLocalizationMsg(@"保密")];
            vocationL.attributedText = [vocationText attachmentForImage:[UIImage imageNamed:@"icon_userinfo_vocation"] bounds:CGRectMake(0, -3, 17, 17) before:YES];
            [self.userInfoView addSubview:vocationL];
            y += 35;
        }
        
        {//身高体重三围
            UILabel *heightL = [[UILabel alloc]initWithFrame:CGRectMake(20, y, width, 20)];
            heightL.textColor = kRGB_COLOR(@"#333333");
            heightL.textAlignment = NSTextAlignmentLeft;
            heightL.font = [UIFont systemFontOfSize:14];
            NSString *heightText = userInfoModel.height?[NSString stringWithFormat:@" %dcm",userInfoModel.height]:[NSString stringWithFormat:kLocalizationMsg(@" 未设置")];
            heightL.attributedText = [heightText attachmentForImage:[UIImage imageNamed:@"icon_userinfo_height"] bounds:CGRectMake(0, -3, 17, 17) before:YES];
            [self.userInfoView addSubview:heightL];

            UILabel *weightL = [[UILabel alloc]initWithFrame:CGRectMake(heightL.maxX+10, y, width, 20)];
            weightL.textColor = kRGB_COLOR(@"#333333");
            weightL.textAlignment = NSTextAlignmentLeft;
            weightL.font = [UIFont systemFontOfSize:14];
            NSString *weightText = userInfoModel.weight>0?[NSString stringWithFormat:@" %0.0lfkg",userInfoModel.weight]:[NSString stringWithFormat:kLocalizationMsg(@" 未设置")];
            weightL.attributedText = [weightText attachmentForImage:[UIImage imageNamed:@"icon_userinfo_weight"] bounds:CGRectMake(0, -3, 17, 17) before:YES];
            [self.userInfoView addSubview:weightL];
            
            if (userInfoModel.sex == 2) {
                UILabel *sanweiL = [[UILabel alloc]initWithFrame:CGRectMake(weightL.maxX+10, y, width, 20)];
                sanweiL.textColor = kRGB_COLOR(@"#333333");
                sanweiL.textAlignment = NSTextAlignmentLeft;
                sanweiL.font = [UIFont systemFontOfSize:14];
                NSString *sanwei = userInfoModel.sanwei;
                if (sanwei.length > 0) {
                    NSArray *arr = [sanwei componentsSeparatedByString:@","];
                    NSMutableString *sanweiStr = [NSMutableString string];
                    for (NSString *str in arr) {
                        [sanweiStr appendFormat:@" %@",str];
                    }
                    sanwei = [sanweiStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                }else{
                    sanwei = kLocalizationMsg(@"未设置");
                }
                NSString *weightText = [NSString stringWithFormat:@" %@",sanwei];
                sanweiL.attributedText = [weightText attachmentForImage:[UIImage imageNamed:@"icon_userinfo_sanwei"] bounds:CGRectMake(0, -3, 17, 17) before:YES];
                [self.userInfoView addSubview:sanweiL];
            }
            
            y += 35;
        }
    }
    if ([self isContain:1]) {//标签
        y += 10;
        if (voModel.myInterestList.count > 0) {
            CGFloat x = 20;
            int row = 0;
            for (int i = 0; i < voModel.myInterestList.count; i++) {
                UserInterestTabVOModel *model = voModel.myInterestList[i];
                CGSize size = [model.name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
                CGFloat space = 10;
                CGFloat viewW = size.width+30;
                
                if (x+viewW > kScreenWidth-40) {
                    row ++;
                    x = 20;
                }
    
                UILabel *tabL = [[UILabel alloc]initWithFrame:CGRectMake(x, y+row *40, viewW, 30)];
                tabL.layer.cornerRadius = 15;
                tabL.clipsToBounds = YES;
                tabL.text = model.name;
                tabL.textAlignment = NSTextAlignmentCenter;
                tabL.backgroundColor = kRGBA_COLOR(model.fontColor, 0.2);
                tabL.textColor =  kRGB_COLOR(model.fontColor);
                tabL.font = [UIFont systemFontOfSize:13];
                [self.userInfoView addSubview:tabL];
                x += (viewW+space);
            }
            y += (row+1)*40;
        }
        y += 10;
    }
    
    self.userInfoView.height = y;
}


///显示勋章墙
- (void)showMedalItems:(NSArray *)items{
    
    if (![self isContain:2]) {//勋章墙
        return;
    }
    (!self.medalInfoView)?(self.medalInfoView = [self getBaseItemView]):nil;
    [self.medalInfoView removeAllSubViews];
    
    CGFloat y = 0;
    kWeakSelf(self);
    UIView *medalView = [self headerView:y title:kLocalizationMsg(@"勋章墙") hasArrow:YES btnClick:^{
        [weakself medalBtnClick:nil];
    }];
    [self.medalInfoView addSubview:medalView];
    y += medalView.height;
    y += 10;
    
    if (items.count > 0) {
        CGFloat medalMargin = (kScreenWidth-40-240)/2.0;
        for (int i = 0; i < items.count; i++) {
            AppMedalModel *model = items[i];
            UIImageView *medalImagV = [[UIImageView alloc] initWithFrame:CGRectMake(20+i*(80+medalMargin),y, 80, 80)];
            [medalImagV sd_setImageWithURL:[NSURL URLWithString:model.medalLogo] placeholderImage:PlaholderImage];
            medalImagV.contentMode = UIViewContentModeScaleAspectFit;
            [self.medalInfoView addSubview:medalImagV];
            UILabel *medalL = [[UILabel alloc]initWithFrame:CGRectMake(0, medalImagV.maxY, 80, 20)];
            medalL.textColor = kRGB_COLOR(@"#666666");
            medalL.font = [UIFont systemFontOfSize:12];
            medalL.centerX = medalImagV.centerX;
            medalL.text = model.name;
            medalL.textAlignment = NSTextAlignmentCenter;
            [self.medalInfoView addSubview:medalL];
        }
        y += 100;
    }else{
        UIView *noDataView = [self createNodataView:y image:@"icon_userinfo_no_medal" showText:kLocalizationMsg(@"暂时没有获得勋章哦～")];
        [self.medalInfoView addSubview:noDataView];
        y += noDataView.height;
    }
    
    ///勋章墙按钮
    UIButton *showMedalBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, medalView.maxY, kScreenWidth, y-medalView.maxY)];
    [showMedalBtn addTarget:self action:@selector(medalBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.medalInfoView addSubview:showMedalBtn];
    y += 20;
    
    self.medalInfoView.height = y;
}

///显示用户发过的动态
- (void)showDynamicitems:(NSArray<MyInfoDynamicCircleModel *> *)items{
    if (![self isContain:5]) {///动态
        return;
    }
    (!self.dynamicInfoView)?(self.dynamicInfoView = [self getBaseItemView]):nil;
    [self.dynamicInfoView removeAllSubViews];
    
    CGFloat y = 0;
    kWeakSelf(self);
    UIView *medalView = [self headerView:y title:kLocalizationMsg(@"最新动态") hasArrow:YES btnClick:^{
        [weakself dynamicBtnClick:nil];
    }];
    [self.dynamicInfoView addSubview:medalView];
    y += medalView.height;
    y += 10;
    
    if (items.count > 0) {
        UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(20, y, kScreenWidth-40, 80)];
        [self.dynamicInfoView addSubview:scrollV];
        for (int i = 0; i < (items.count > 10?10:items.count); i++) {
            UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(i*(scrollV.height+10), 0, scrollV.height, scrollV.height)];
            imgV.contentMode = UIViewContentModeScaleAspectFill;
            imgV.layer.masksToBounds = YES;
            imgV.layer.cornerRadius = 5;
            [scrollV addSubview:imgV];
            MyInfoDynamicCircleModel *model = items[i];
            [imgV sd_setImageWithURL:[NSURL URLWithString:model.dynamicThumb] placeholderImage:PlaholderImage];
            
            scrollV.contentSize = CGSizeMake(imgV.maxY, 0);
        }
        y += 100;
    }else{
        UIView *noDataView = [self createNodataView:y image:@"icon_userinfo_no_medal" showText:kLocalizationMsg(@"暂时没有动态哦～")];
        [self.dynamicInfoView addSubview:noDataView];
        y += noDataView.height;
    }
    
    ///勋章墙按钮
    UIButton *showDynamicBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, medalView.maxY, kScreenWidth, y-medalView.maxY)];
    [showDynamicBtn addTarget:self action:@selector(dynamicBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.dynamicInfoView addSubview:showDynamicBtn];
    y += 20;
    self.dynamicInfoView.height = y;
}


///显示守护view
- (void)showGuardItems:(NSArray *)items{
    
    if (![self isContain:3]) {///守护
        return;
    }
    (!self.guardInfoView)?(self.guardInfoView = [self getBaseItemView]):nil;
    [self.guardInfoView removeAllSubViews];
    
    CGFloat y = 0;
    CGFloat pt = kScreenWidth/375.0;
    
    kWeakSelf(self);
    UIView *guardView = [self headerView:y title:kLocalizationMsg(@"Ta的守护") hasArrow:YES btnClick:^{
        [weakself guardBtnlick:nil];
    }];
    [self.guardInfoView addSubview:guardView];
    y += guardView.height;
    y += 10;
    
    CGFloat scale = 500/750.0;
    CGFloat viewHeight = kScreenWidth*scale;
    CGFloat itemH = viewHeight-40;
    CGFloat itemW = 300*itemH/340.0;
    NSInteger num = items.count;
    CGFloat margin = (itemH-20-60-50*pt)/2.0;
    if (items.count > 0) {
        for (int i = 0; i < num; i++) {
            
            GuardUserVOModel *model = items[i];
            
            UIView *contentV = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-2*itemW+20)/2.0+i*itemW, y, itemW-20, itemH-20)];
            contentV.backgroundColor = kRGB_COLOR(@"#FFF4F4");
            contentV.clipsToBounds = YES;
            contentV.layer.cornerRadius = 12;
            [self.guardInfoView addSubview:contentV];
            
            // 三角
            UIImageView *triangleView = [[UIImageView alloc]initWithFrame:CGRectMake((itemW-20)/2.0, 0, (itemW-20)/2.0, 0.5*(itemW-20)*110/150.0)];
            triangleView.image = [UIImage imageNamed:@"icon_guard_triang"];
            [contentV addSubview:triangleView];
            
            UILabel *rightUpL = [[UILabel alloc]initWithFrame:CGRectMake((itemW-20)/2.0-3, 5, (itemW-20)/2.0, 20)];
            rightUpL.textAlignment = NSTextAlignmentRight;
            rightUpL.font = [UIFont systemFontOfSize:10];
            rightUpL.textColor = [UIColor whiteColor];
            rightUpL.text = kLocalizationMsg(@"守护Ta ");
            [contentV addSubview:rightUpL];
            
            UIImageView *rightImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, margin, 50*pt, 50*pt)];
            rightImageV.centerX = (itemW-20)/2.0+15;
            rightImageV.layer.cornerRadius = 25*pt;
            rightImageV.clipsToBounds = YES;
            rightImageV.layer.borderWidth = 1.0;
            rightImageV.layer.borderColor = [UIColor whiteColor].CGColor;
            [rightImageV sd_setImageWithURL:[NSURL URLWithString:model.anchorIdImg] placeholderImage:[ProjConfig getAppIcon]];
            [contentV addSubview:rightImageV];
            
            UIImageView *leftImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, margin, 50*pt, 50*pt)];
            leftImageV.centerX = (itemW-20)/2.0-15;
            leftImageV.layer.cornerRadius = 25*pt;
            leftImageV.clipsToBounds = YES;
            leftImageV.layer.borderWidth = 1.0;
            [leftImageV sd_setImageWithURL:[NSURL URLWithString:model.userHeadImg] placeholderImage:[ProjConfig getAppIcon]];
            leftImageV.layer.borderColor = [UIColor whiteColor].CGColor;
            [contentV addSubview:leftImageV];
            
            
            UIImageView *connectImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, rightImageV.maxY-35*pt, 50*pt, 50*pt)];
            connectImageV.contentMode = UIViewContentModeScaleAspectFit;
            connectImageV.centerX = (itemW-20)/2.0;
            connectImageV.image = [UIImage imageNamed:@"icon_mine_guard_normal"];
            [contentV addSubview:connectImageV];
            
            UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(0, leftImageV.maxY+10, itemW-20, 20)];
            nameL.textColor = kRGB_COLOR(@"#333333");
            nameL.font = [UIFont systemFontOfSize:14];
            nameL.textAlignment = NSTextAlignmentCenter;
            nameL.text = model.username;
            [contentV addSubview:nameL];
            
            UILabel *dayL = [[UILabel alloc]initWithFrame:CGRectMake(0, nameL.maxY, itemW-20, 30)];
            dayL.textColor = model.isOverdue?kRGB_COLOR(@"#666666"):kRGB_COLOR(@"#FC4B5C");
            dayL.font = [UIFont boldSystemFontOfSize:25];
            dayL.textAlignment = NSTextAlignmentCenter;
            NSString *dayStr = [NSString stringWithFormat:kLocalizationMsg(@"%lld天"),model.guardDay];
            NSMutableAttributedString *dayAtt = [[NSMutableAttributedString alloc]initWithString:dayStr];
            [dayAtt addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} range:[dayStr rangeOfString:kLocalizationMsg(@"天")]];
            dayL.attributedText = dayAtt;
            [contentV addSubview:dayL];
        }
        y += itemH;
    }else{
        UIView *noDataView = [self createNodataView:y image:@"icon_userinfo_no_guard" showText:kLocalizationMsg(@"Ta还没有守护哦～")];
        [self.guardInfoView addSubview:noDataView];
        y += noDataView.height;
    }
    
    ///守护墙按钮
    UIButton *guardWallBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, guardView.maxY, kScreenWidth, y-guardView.maxY)];
    [guardWallBtn addTarget:self action:@selector(guardBtnlick:) forControlEvents:UIControlEventTouchUpInside];
    [self.guardInfoView addSubview:guardWallBtn];
    y += 20;
    self.guardInfoView.height = y;
}

///显示礼物View
- (void)showGiftItems:(NSArray *)items{
    if (![self isContain:4]) {///礼物
        return;
    }

    (!self.giftInfoView)?(self.giftInfoView = [self getBaseItemView]):nil;
    [self.giftInfoView removeAllSubViews];
    
    CGFloat y = 0;
    UIView *giftHeaderV = [self headerView:y title:kLocalizationMsg(@"礼物墙") hasArrow:NO btnClick:nil];
    [self.giftInfoView addSubview:giftHeaderV];
    y += giftHeaderV.height;
    y += 10;
    
    NSInteger num = items.count;
    if (num > 0) {
        CGFloat width = (kScreenWidth-40-30)/4.0;
        CGFloat height = width+40;
        NSInteger totalNum = 0;
        CGFloat giftViewMaxY = 0;
        for (int i = 0; i < num; i++) {
            GiftWallDtoModel *model = items[i];
            NSInteger row = i / 4;
            NSInteger col = i % 4;
            totalNum += model.totalNum;
            UIView *giftView = [[UIView alloc]initWithFrame:CGRectMake(20+col*(width+10), y+row*(height +10), width, height)];
            giftView.backgroundColor = [UIColor clearColor];
            [self.giftInfoView addSubview:giftView];
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, width)];
            [imageV sd_setImageWithURL:[NSURL URLWithString:model.gifticon] placeholderImage:PlaholderImage];
            [giftView addSubview:imageV];
            UILabel *giftNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, width, width, 20)];
            giftNameLabel.textColor =kRGB_COLOR(@"#333333");
            giftNameLabel.font = [UIFont systemFontOfSize:14];
            giftNameLabel.textAlignment= NSTextAlignmentCenter;
            giftNameLabel.text = model.giftname;
            [giftView addSubview:giftNameLabel];
            UILabel *countL = [[UILabel alloc]initWithFrame:CGRectMake(0, width+20, width, 20)];
            countL.textColor =kRGB_COLOR(@"#999999");
            countL.font = [UIFont systemFontOfSize:14];
            countL.textAlignment= NSTextAlignmentCenter;
            countL.text = [NSString stringWithFormat:@"x%d",model.totalNum];
            [giftView addSubview:countL];
            giftViewMaxY = giftView.maxY;
        }
        y += giftViewMaxY;
    }else{
        UIView *noDataView = [self createNodataView:y image:@"icon_userinfo_no_gift" showText:kLocalizationMsg(@"Ta还没有收到礼物哦～")];
        [self.giftInfoView addSubview:noDataView];
        y += noDataView.height;
    }
    y += 20;
    self.giftInfoView.height = y;
}

///分类标题
- (UIView *)headerView:(CGFloat)pointY title:(NSString *)title hasArrow:(BOOL)has btnClick:(void(^)(void))btnClick{
    
    UIView *headerBgView = [[UIView alloc]initWithFrame:CGRectMake(0, pointY, kScreenWidth, 55)];
    headerBgView.backgroundColor = [UIColor clearColor];
    
    //线
    UIView *contentLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
    contentLine.backgroundColor = kRGB_COLOR(@"#F6F6F6");
    [headerBgView addSubview:contentLine];
    
    UILabel *guardTitleL = [[UILabel alloc]initWithFrame:CGRectMake(20, contentLine.maxY+10, 80, 20)];
    guardTitleL.centerY = headerBgView.height/2.0;
    guardTitleL.textColor = kRGB_COLOR(@"#333333");
    guardTitleL.font = [UIFont boldSystemFontOfSize:17];
    guardTitleL.textAlignment = NSTextAlignmentLeft;
    guardTitleL.text = title;
    [headerBgView addSubview:guardTitleL];
    
    if (has) {
        UIImageView *moreImageV = [[UIImageView alloc]initWithFrame:CGRectMake(headerBgView.width-20-8, contentLine.maxY+12, 8, 16)];
        moreImageV.image = [UIImage imageNamed:@"mineCenter_gray_more"];
        moreImageV.centerY = guardTitleL.centerY;
        [headerBgView addSubview:moreImageV];
    }
    
    UIButton *arrowBtn = [[UIButton alloc]initWithFrame:headerBgView.bounds];
    arrowBtn.backgroundColor = [UIColor clearColor];
    [headerBgView addSubview:arrowBtn];
    [arrowBtn klc_whenTapped:^{
        if (btnClick) {
            btnClick();
        }
    }];
    return headerBgView;
}

///无数据UI
- (UIView *)createNodataView:(CGFloat)pointY image:(NSString *)image showText:(NSString *)text{
    
    CGFloat pt = kScreenWidth/375.0;
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, pointY, kScreenWidth, 100)];

    UIImageView *noMedalImageV = [[UIImageView alloc]initWithFrame:CGRectMake(45*pt, 0, 80, 80)];
    noMedalImageV.contentMode = UIViewContentModeScaleAspectFit;
    noMedalImageV.image = [UIImage imageNamed:image];
    [contentView addSubview:noMedalImageV];
    noMedalImageV.centerY = contentView.height/2.0;
    
    UILabel *tipL = [[UILabel alloc]initWithFrame:CGRectMake(noMedalImageV.maxX+10, 0, kScreenWidth-80-90*pt, 40)];
    tipL.centerY = noMedalImageV.centerY;
    tipL.font = [UIFont systemFontOfSize:14];
    tipL.textAlignment = NSTextAlignmentCenter;
    tipL.textColor = kRGBA_COLOR(@"#666666", 1.0);
    tipL.text = text;
    [contentView addSubview:tipL];
    
    return contentView;
}


- (void)updateContentUI{
    CGFloat y = 0;
    BOOL hasUserInfo = NO; ///是否计算过userinfoView的高度
    for (NSDictionary *dic in self.viewArr) {
        switch ([dic[@"id"] intValue]) {
            case 0:  ///个人信息
            case 1: { ///标签
                if (self.userInfoView && hasUserInfo == NO) {
                    hasUserInfo = YES;
                    self.userInfoView.y = y;
                    y = self.userInfoView.maxY;
                }
            }   break;
            case 2: {  ///勋章墙
                if (self.medalInfoView) {
                    self.medalInfoView.y = y;
                    y = self.medalInfoView.maxY;
                }
            }   break;
            case 3: {  ///守护
                if (self.guardInfoView) {
                    self.guardInfoView.y = y;
                    y = self.guardInfoView.maxY;
                }
            }   break;
            case 4: {  ///礼物墙
                if (self.giftInfoView) {
                    self.giftInfoView.y = y;
                    y = self.giftInfoView.maxY;
                }
            }   break;
            case 5: {  ///动态
                if (self.dynamicInfoView) {
                    self.dynamicInfoView.y = y;
                    y = self.dynamicInfoView.maxY;
                }
            }   break;
            default:
                break;
        }
    }
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, y+10);
}

- (void)dynamicBtnClick:(UIButton *)btn{
    if (self.dynamicBtnClick) {
        self.dynamicBtnClick();
    }
}

- (void)guardBtnlick:(UIButton *)btn{
    [RouteManager routeForName:RN_center_userGuard currentC:self parameters:@{@"userId":@(self.userId)}];
}
- (void)medalBtnClick:(UIButton *)btn{
    [RouteManager routeForName:RN_center_allMedalWall currentC:self parameters:@{@"userId":@(self.userId)}];
}

- (BOOL)isContain:(int)type{
    for (NSDictionary *dic in self.viewArr) {
        int idx = [dic[@"id"] intValue];
        if (type == idx) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - JXPagerViewListViewDelegate
- (UIView *)listView{
    return self.view;
}

- (UIScrollView *)listScrollView {
    return self.scrollView;
}

- (void)listScrollViewWillResetContentOffset{
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (void)listDidAppear{
    
}

- (void)listDidDisappear{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.scrollCallback(scrollView);
}

@end
