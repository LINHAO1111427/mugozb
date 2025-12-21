//
//  FansGroupShowView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/25.
//  Copyright © 2020 . All rights reserved.
//

#import "FansGroupShowView.h"

#import <LibTools/LibTools.h>

#import <LibProjBase/LibProjBase.h>

#import <LibProjView/TipAlertView.h>
#import <LibProjView/KlcAvatarView.h>
#import <LibProjView/FunctionSheetBaseView.h>

#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/HttpApiAnchorController.h>
#import <LibProjModel/AppUserAvatarModel.h>

#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>

#import "FansGroupListView.h"
#import "FansGroupItemCell.h"


@interface FansGroupShowView ()
@property (nonatomic, copy)void (^userCallBack)(int64_t);

@property (nonatomic, assign)int64_t userId;

@property (nonatomic, strong)FansInfoDtoModel *dtoModel;  ///粉丝团信息

@property (nonatomic, weak)UIButton *fansGroupBtn; ///粉丝团成员

@property (nonatomic, weak)UIButton *sureBtn;  //确认按钮

@property (nonatomic, weak)KlcAvatarView *userIcon;  //确认按钮

@property (nonatomic, weak)UILabel *joinTextL; ///加入文字

@property (nonatomic, weak)UILabel *joinCoinL; ///加入金币值

@property (nonatomic, weak)UILabel *fansGroupNameL; ///粉丝团名称

@property (nonatomic, weak)UILabel *fanNumL; ///粉丝团人数

@property (nonatomic, assign)double joinCoin;

@end

@implementation FansGroupShowView

+ (void)showFansWith:(int64_t)userId hasBgColor:(BOOL)haBgColor showUserInfo:(void (^)(int64_t))userBack {
    FansGroupShowView *fans = [[FansGroupShowView alloc] init];
    fans.userId = userId;
    fans.userCallBack = userBack;
    [fans createView:haBgColor];
    [fans loadViewData];
}


- (void)createView:(BOOL)haBgColor{
    self.frame = CGRectMake(0, 0, kScreenWidth, 420);
    self.backgroundColor = [UIColor whiteColor];
    ///用户视图
    UIView *headerBgV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 60)];
    [self addSubview:headerBgV];
    
    ///用户头像
    KlcAvatarView *userIcon = [[KlcAvatarView alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
    userIcon.layer.masksToBounds = YES;
    userIcon.layer.cornerRadius = 20;
    [headerBgV addSubview:userIcon];
    _userIcon = userIcon;
    
    ///粉丝头像显示
    UIButton *fansGroupBtn = [UIButton buttonWithType:0];
    fansGroupBtn.backgroundColor = [UIColor clearColor];
    [fansGroupBtn addTarget:self action:@selector(fansGroupBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headerBgV addSubview:fansGroupBtn];
    _fansGroupBtn = fansGroupBtn;
    [fansGroupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(25);
        make.top.equalTo(headerBgV).mas_equalTo(26);
        make.right.equalTo(headerBgV).mas_offset(-15);
    }];
    [fansGroupBtn layoutIfNeeded];
    ///箭头
    UIButton *arrowBtn = [UIButton buttonWithType:0];
    arrowBtn.userInteractionEnabled = NO;
    arrowBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [arrowBtn setImage:[UIImage imageNamed:@"mineCenter_gray_more"] forState:UIControlStateNormal];
    [fansGroupBtn addSubview:arrowBtn];
    [arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(7, 12));
        make.centerY.equalTo(fansGroupBtn);
        make.right.equalTo(fansGroupBtn);
    }];
    ///粉丝团名称
    UILabel *fansGroupNameL = [[UILabel alloc] initWithFrame:CGRectMake(userIcon.maxX+10, userIcon.y, 180, 23)];
    fansGroupNameL.textColor = kRGB_COLOR(@"#333333");
    fansGroupNameL.font = [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
    [headerBgV addSubview:fansGroupNameL];
    _fansGroupNameL = fansGroupNameL;
    ///粉丝人数
    UILabel *fanNumL = [[UILabel alloc] initWithFrame:CGRectMake(fansGroupNameL.x, fansGroupNameL.maxY, fansGroupNameL.width, 20)];
    fanNumL.textColor = kRGB_COLOR(@"#999999");
    fanNumL.font = [UIFont systemFontOfSize:13];
    fanNumL.text = kLocalizationMsg(@"亲密粉丝");
    [headerBgV addSubview:fanNumL];
    _fanNumL = fanNumL;
    
    ///内容
    NSMutableArray *items = [[NSMutableArray alloc] init];
    [items addObject:@{@"title":kLocalizationMsg(@"粉丝团专属进场标识"),@"subTitle":kLocalizationMsg(@"入团即可开启"),@"icon":@"fans_join_jcbsbg",@"startColor":kRGBA_COLOR(@"#FC7ED4", 1.0),@"endColor":kRGBA_COLOR(@"#FC66FF", 1.0)}];
    [items addObject:@{@"title":kLocalizationMsg(@"粉丝团专属弹幕"),@"subTitle":kLocalizationMsg(@"主播一眼看到 即时互动"),@"icon":@"fans_join_zsdmbg",@"startColor":kRGBA_COLOR(@"#30E9FF", 1.0),@"endColor":kRGBA_COLOR(@"#38CCFF", 1.0)}];
    if ([[ProjConfig shareInstence].baseConfig hasFansIMGroup]) {
        [items addObject:@{@"title":kLocalizationMsg(@"粉丝团专属群"),@"subTitle":kLocalizationMsg(@"直播结束继续畅聊"),@"icon":@"fans_join_zsqlbg",@"startColor":kRGBA_COLOR(@"#FED14E", 1.0),@"endColor":kRGBA_COLOR(@"#FFA952", 1.0)}];
    }
    
    UIView *contentBgV = [[UIView alloc] initWithFrame:CGRectMake(0, headerBgV.maxY, self.width, 280)];
    contentBgV.userInteractionEnabled = NO;
    [self addSubview:contentBgV];
    
    for (int i = 0; i < items.count; i++) {
        NSDictionary *subItem = items[i];
        UIView *itemBgV = [[UIView alloc] init];
        itemBgV.frame = CGRectMake(15, 20+i*(70+15), self.width-30, 70);
        itemBgV.layer.shadowColor = [UIColor colorWithRed:252/255.0 green:124/255.0 blue:215/255.0 alpha:0.5].CGColor;
        itemBgV.layer.shadowOffset = CGSizeMake(0,2);
        itemBgV.layer.shadowRadius = 10;
        itemBgV.layer.shadowOpacity = 1;
        [contentBgV addSubview:itemBgV];
        
        ///带颜色的背景
        UIView *colorBgV = [[UIView alloc] initWithFrame:itemBgV.bounds];
        colorBgV.layer.cornerRadius = 10;
        colorBgV.layer.masksToBounds = YES;
        [itemBgV addSubview:colorBgV];
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = colorBgV.bounds;
        gl.startPoint = CGPointMake(0.00, 0.50);
        gl.endPoint = CGPointMake(1.00, 0.50);
        UIColor *startColor = (UIColor *)subItem[@"startColor"];
        UIColor *endColor = (UIColor *)subItem[@"endColor"];
        gl.colors = @[
            (__bridge id)startColor.CGColor,
            (__bridge id)endColor.CGColor,
        ];
        gl.locations = @[@(0),@(1.0f)];
        [colorBgV.layer addSublayer:gl];
        
        UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(20, 14, 150, 21)];
        titleL.text = subItem[@"title"];
        titleL.textColor = [UIColor whiteColor];
        titleL.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
        [itemBgV addSubview:titleL];
        
        UILabel *subTitleL = [[UILabel alloc] initWithFrame:CGRectMake(20, titleL.maxY+5, titleL.width, 17)];
        subTitleL.text = subItem[@"subTitle"];
        subTitleL.textColor = [UIColor whiteColor];
        subTitleL.font = [UIFont systemFontOfSize:12];
        [itemBgV addSubview:subTitleL];
        
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(itemBgV.width-90-20, -15, 90, 90)];
        imgV.image = [UIImage imageNamed:subItem[@"icon"]];
        [itemBgV addSubview:imgV];
    }
    
    ///底部视图
    UIView *bottomV = [[UIView alloc] initWithFrame:CGRectMake(0, contentBgV.maxY+10, self.width, 50)];
    bottomV.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomV];
    [self sendSubviewToBack:bottomV];
    
    ///加入粉丝团按钮
    UIButton *sureBtn = [UIButton buttonWithType:0];
    sureBtn.frame = CGRectMake(bottomV.width-140-15, 0, 140, 40);
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg_pink"] forState:UIControlStateNormal];
    [sureBtn setTitle:kLocalizationMsg(@"立即加入") forState:UIControlStateNormal];
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 20;
    [sureBtn addTarget:self action:@selector(joinFans) forControlEvents:UIControlEventTouchUpInside];
    [bottomV addSubview:sureBtn];
    _sureBtn = sureBtn;
    
    UILabel *joinTextL = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 150, 20)];
    joinTextL.text = kLocalizationMsg(@"立即加入粉丝团");
    joinTextL.textColor = kRGB_COLOR(@"#333333");
    joinTextL.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    [bottomV addSubview:joinTextL];
    _joinTextL = joinTextL;
    
    UILabel *joinCoinL = [[UILabel alloc] initWithFrame:CGRectMake(15, joinTextL.maxY+5, 150, 20)];
    joinCoinL.textColor = kRGB_COLOR(@"#999999");
    joinCoinL.font = [UIFont systemFontOfSize:14];
    [bottomV addSubview:joinCoinL];
    _joinCoinL = joinCoinL;
    
    [FunctionSheetBaseView showView:self cover:haBgColor];
}


- (void)loadViewData{
    kWeakSelf(self);
    [HttpApiAnchorController liveFansTeamInfo:self.userId callback:^(int code, NSString *strMsg, FansInfoDtoModel *model) {
        if (code == 1) {
            [weakself showView:model];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

///显示信息
- (void)showView:(FansInfoDtoModel *)infoModel{
    _dtoModel = infoModel;
    
    [self.userIcon showUserIconUrl:infoModel.fansTeamAvatar vipBorderUrl:@""];
    _fansGroupNameL.text = infoModel.fansTeamName;
    _fanNumL.text = [NSString stringWithFormat:kLocalizationMsg(@"亲密粉丝%d人"),infoModel.fansNum];
    if (infoModel.isMember) { ///是粉丝团成员
        [_joinCoinL removeFromSuperview];
        _joinTextL.centerY = _sureBtn.centerY;
        _joinTextL.attributedText = [kLocalizationMsg(@"您已是粉丝团成员") attachmentForImage:[UIImage imageNamed:@"fans_group_pink"] bounds:CGRectMake(0, -10, 30, 30) before:YES];
        if ([[ProjConfig shareInstence].baseConfig hasFansIMGroup]) {
            [_sureBtn setTitle:kLocalizationMsg(@"进入群聊") forState:UIControlStateNormal];
        }else{
            [_sureBtn removeTarget:self action:@selector(joinFans) forControlEvents:UIControlEventTouchUpInside];
            [_sureBtn setTitle:kLocalizationMsg(@"确定") forState:UIControlStateNormal];
            [_sureBtn addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
        }
    }else{
        _joinCoinL.attributedText = [[NSString stringWithFormat:@"%.1f",infoModel.coin] attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -2, 13, 13) before:YES];
        _joinCoin = infoModel.coin;
        [_sureBtn setTitle:kLocalizationMsg(@"立即加入") forState:UIControlStateNormal];
    }
    ///粉丝头像
    NSInteger count = infoModel.avatars.count>3?3:infoModel.avatars.count;
    CGFloat avatarW = (count-1)*15 + 25;
    [_fansGroupBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(17+avatarW);
    }];
    [_fansGroupBtn layoutIfNeeded];
    for (int i = 0; i<count; i++) {
        AppUserAvatarModel *avatarModel = infoModel.avatars[i];
        UIImageView *userImgV = [[UIImageView alloc] initWithFrame:CGRectMake(i*15, 0, 25, 25)];
        userImgV.layer.masksToBounds = YES;
        userImgV.layer.cornerRadius = 12.5;
        [userImgV sd_setImageWithURL:[NSURL URLWithString:avatarModel.userAvatar] placeholderImage:[ProjConfig getDefaultImage]];
        [_fansGroupBtn addSubview:userImgV];
    }
}

- (void)dismissView{
    [FunctionSheetBaseView deletePopView:self];
}

- (void)joinFans{
    if (_dtoModel.isMember) {
        ///进入群聊
        if (_dtoModel.groupId > 0) {
            NSString *nameStr = [NSString stringWithFormat:@"%@(%d)",_dtoModel.fansTeamName, _dtoModel.fansNum];
            [RouteManager routeForName:RN_Message_ConversationChatVC currentC:[ProjConfig currentVC] parameters:@{@"chatType":@"3",@"msgSendId":@(_dtoModel.groupId),@"navTitle":nameStr}];
        }else{
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:kLocalizationMsg(@"%@暂没有聊天群"),_dtoModel.fansTeamName]];
        }
    }else{
        kWeakSelf(self);
        [HttpApiAnchorController joinFansTeam:self.userId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                [SVProgressHUD showInfoWithStatus:strMsg];
                [FunctionSheetBaseView deletePopView:weakself];
            }else if (code == 2){ ///未配置入团费用
                [SVProgressHUD showInfoWithStatus:strMsg];
            }else if (code == -1){ ///金币不足
                [weakself showRechangeAlert:strMsg];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }
}

- (void)showRechangeAlert:(NSString *)str{
    kWeakSelf(self);
    [FunctionSheetBaseView deletePopView:weakself];
    [TipAlertView showTitle:str subTitle:^(UILabel * _Nonnull subTitleL) {
        subTitleL.text = kLocalizationMsg(@"先去充值吧!");
    } sureBtnTitle:kLocalizationMsg(@"立即充值") btnClick:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [RouteManager routeForName:RN_center_myAccountAC currentC:[ProjConfig currentVC]];
        });
    } cancel:nil];
    
}

- (void)fansGroupBtnClick{
    kWeakSelf(self);
    [FansGroupListView showList:_dtoModel userId:self.userId callBack:^(BOOL showUserInfo, int64_t userId) {
        if (showUserInfo && weakself.userCallBack) {
            weakself.userCallBack(userId);
        }
    }];
}

@end
