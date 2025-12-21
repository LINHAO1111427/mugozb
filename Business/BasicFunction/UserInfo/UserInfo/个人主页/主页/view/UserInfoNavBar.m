//
//  UserInfoNavBar.m
//  UserInfo
//
//  Created by ssssssss on 2020/12/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "UserInfoNavBar.h"
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjView/KlcAvatarView.h>
#import <LibProjView/LiveShareView.h>

@interface UserInfoNavBar()
@property (nonatomic, weak)UIViewController *superVc;
@property (nonatomic, strong)UIButton *backBtn;
@property (nonatomic, strong)KlcAvatarView *avterBtn;
@property (nonatomic, strong)UIButton *rightBtn;
@property (nonatomic, strong)UIView *userStatusPoint;
@end
@implementation UserInfoNavBar

- (instancetype)initWithFrame:(CGRect)frame superVc:(UIViewController *)superVc{
    self = [super initWithFrame:frame];
    if (self) {
        self.superVc = superVc;
        [self createUI];
    }
    return self;
}
- (void)setIsScrollOut:(BOOL)isScrollOut{
    _isScrollOut = isScrollOut;
    self.avterBtn.hidden = !isScrollOut;
    self.userStatusPoint.hidden = !isScrollOut;
    NSString *rightImageStr;
    NSString *backImageStr;
    if (self.isScrollOut) {
        backImageStr = @"main_navbar_back_black";
        rightImageStr = @"icon_userinfo_more_gray";
        [self.rightBtn setTitleColor:kRGB_COLOR(@"#666666") forState:UIControlStateNormal];
    }else{
        backImageStr = @"main_navbar_back";
        rightImageStr = @"icon_userinfo_more_white";
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    [self.backBtn setImage:[UIImage imageNamed:backImageStr] forState:UIControlStateNormal];
    if (self.homeModel.userInfo.userId != [ProjConfig userId]) {
        [self.rightBtn setImage:[UIImage imageNamed:rightImageStr] forState:UIControlStateNormal];
    }
}
- (void)setHomeModel:(UserInfoHomeVOModel *)homeModel {
    _homeModel = homeModel;
    
    ApiUserInfoModel *userInfo = homeModel.userInfo;
    [self.avterBtn showUserIconUrl:userInfo.avatar vipBorderUrl:userInfo.nobleAvatarFrame];
    NSString *rightImageStr;
    if (self.isScrollOut) {
        rightImageStr = @"icon_userinfo_more_gray";
        [self.rightBtn setTitleColor:kRGB_COLOR(@"#666666") forState:UIControlStateNormal];
    }else{
        rightImageStr = @"icon_userinfo_more_white";
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    if (userInfo.userId == [ProjConfig userId]) {//自己
        [self.rightBtn setImage:nil forState:UIControlStateNormal];
        [self.rightBtn setTitle:kLocalizationMsg(@"编辑") forState:UIControlStateNormal];
    }else{
        [self.rightBtn setImage:[UIImage imageNamed:rightImageStr] forState:UIControlStateNormal];
        [self.rightBtn setTitle:@"" forState:UIControlStateNormal];
    }
    //0:离线 1:忙碌 2:在线 3:通话中 4:看直播 5:匹配中 6:直播中 7:离开
    switch (homeModel.showStatus) {
        case 0:
        case 4:
        case 5:
        case 6:
        case 7:
            self.userStatusPoint.backgroundColor = [UIColor grayColor];
            break;
        case 1:
            self.userStatusPoint.backgroundColor = [UIColor redColor];
            break;
        case 2:
            self.userStatusPoint.backgroundColor = [UIColor greenColor];
            break;
        case 3:
            self.userStatusPoint.backgroundColor = [UIColor purpleColor];
            break;
        default:
            self.userStatusPoint.backgroundColor = [UIColor redColor];
            break;
    }
}
 
 
- (void)createUI{
    self.backgroundColor = [UIColor clearColor];
    CGFloat y = (kNavBarHeight-kStatusBarHeight-36)/2.0+kStatusBarHeight;
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(8, y, 36, 36)];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setImage:[UIImage imageNamed:@"main_navbar_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.backBtn = backBtn;
    [self addSubview:backBtn];
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-50, 0, 40, 40)];
    rightBtn.backgroundColor = [UIColor clearColor];
    rightBtn.centerY = backBtn.centerY;
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightBtn setImage:[UIImage imageNamed:@"icon_userinfo_more_gray"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    self.rightBtn = rightBtn;
    [self addSubview:rightBtn];
    
    KlcAvatarView *avterBtn = [[KlcAvatarView alloc] initWithFrame:CGRectMake(kScreenWidth-50, 0, 40, 40)];
    avterBtn.hidden = YES;
    avterBtn.centerX = kScreenWidth/2.0;
    avterBtn.centerY = backBtn.centerY;
    [avterBtn addTarget:self action:@selector(avterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.avterBtn = avterBtn;
    [self addSubview:avterBtn];
    
    UIView *point = [[UIView alloc]initWithFrame:CGRectMake(avterBtn.maxX-10, avterBtn.maxY-10, 10, 10)];
    point.hidden = YES;
    point.layer.cornerRadius = 5;
    point.clipsToBounds = YES;
    self.userStatusPoint = point;
    [self addSubview:point];
}
#pragma mark - 按钮
- (void)backBtnClick:(UIButton *)btn{
    if (self.superVc) {
        [self.superVc.navigationController popViewControllerAnimated:YES];
    }
}

- (void)rightBtnClick:(UIButton *)btn{
    if (self.superVc) {
        if (self.homeModel.userInfo.userId == [ProjConfig userId]) {
            [RouteManager routeForName:RN_center_editProfile  currentC:self.superVc];
        }else{
            kWeakSelf(self);
            
            ShareFunctionItem *reportFunctionItem = [ShareFunctionItem shareIcon:[UIImage imageNamed:@"icon_more_report"] name:kLocalizationMsg(@"举报") clickBlock:^{
                [RouteManager routeForName:RN_base_userReportVC currentC:weakself.superVc parameters:@{@"id":@(weakself.homeModel.userInfo.userId)}];
            }];
        
            ShareFunctionItem *shieldFunctionItem = [ShareFunctionItem shareIcon:[UIImage imageNamed:@"icon_more_shield"] name:kLocalizationMsg(@"拉黑") clickBlock:^{
                [weakself shieldUser];
            }];
            
            ShareFunctionItem *remarkFunctionItem = [ShareFunctionItem shareIcon:[UIImage imageNamed:@"icon_more_remark"] name:kLocalizationMsg(@"备注") clickBlock:^{
                [RouteManager routeForName:RN_user_setUserRemark currentC:weakself.superVc parameters:@{@"id":@(weakself.homeModel.userInfo.userId),@"remark":weakself.homeModel.userInfo.username.length > 0?weakself.homeModel.userInfo.username:@""}];
            }];
            
            NSMutableArray *funcItem = [[NSMutableArray alloc] init];
            [funcItem addObject:reportFunctionItem];
            [funcItem addObject:shieldFunctionItem];
            if (self.homeModel.userInfo.userId != [ProjConfig userId]) {
                [funcItem addObject:remarkFunctionItem];
            }
            if (self.homeModel.isAttentionUser) {
                //取消关注
                ShareFunctionItem *cancelAttentFunctionItem = [ShareFunctionItem shareIcon:[UIImage imageNamed:@"icon_userinfo_attent_cancel"] name:kLocalizationMsg(@"取消关注") clickBlock:^{
                    [weakself cancelAttent];
                }];
                [funcItem addObject:cancelAttentFunctionItem];
            }
            
            [LiveShareView showShareViewForType:3 shareId:0 moreFunction:funcItem];
        }
    }
}

- (void)shieldUser{
    [HttpApiUserController usersBlack:self.homeModel.userInfo.userId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [[ProjConfig currentVC].navigationController popViewControllerAnimated:YES];
        }
        [SVProgressHUD showInfoWithStatus:strMsg];
    }];
}

- (void)cancelAttent{
    if (self.navAttenUserBtnClick) {
        self.navAttenUserBtnClick(NO);
    }
}

- (void)avterBtnClick:(UIButton *)btn{
    self.isScrollOut = NO;
    if (self.navUserAvaterBtnClick) {
        self.navUserAvaterBtnClick();
    }
}

@end
