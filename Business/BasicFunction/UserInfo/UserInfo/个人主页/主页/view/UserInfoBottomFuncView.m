//
//  UserInfoBottomFuncView.m
//  UserInfo
//
//  Created by klc_sl on 2021/3/5.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "UserInfoBottomFuncView.h"

#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/ApiGiftSenderModel.h>
#import <LibProjModel/UserInfoHomeVOModel.h>
#import <LibProjView/FansGroupShowView.h>
#import <LibProjView/ChoiceGiftView.h>
#import <LibProjView/O2OCallTypeSelectedView.h>

@interface UserInfoBottomFuncView ()

@property (nonatomic, assign) BOOL showTips;
@property (nonatomic, strong) UIImageView *likeTipV;
@property (nonatomic, strong) UIImageView *userIconV;
@property (nonatomic, weak) UIButton *attenBtn; ///关注

@property (nonatomic, copy)NSArray *funcList;

@end

@implementation UserInfoBottomFuncView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _funcList = [[ProjConfig shareInstence].businessConfig getUserInfoBottomFunctionArray];
        [self addBottomView];
        
    }
    return self;
}

- (void)addBottomView{
    //按钮相关
    self.backgroundColor = [UIColor whiteColor];
    [self shadowPathWith:[UIColor blackColor] shadowOpacity:0.6 shadowRadius:4 shadowSide:KLCShadowPathTop shadowPathWidth:1];
    
    UIStackView *stackV = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height-kSafeAreaBottom)];
    stackV.alignment = UIStackViewAlignmentCenter;
    stackV.distribution = UIStackViewDistributionEqualSpacing;
    [self addSubview:stackV];
    
    ///占位UI
    UIView *space1V = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    [stackV addSubview:space1V];
    [stackV addArrangedSubview:space1V];
    
    for (NSDictionary *subDict in _funcList) {
        CGFloat viewW = 50;
        UIButton *funcBtn = [UIButton buttonWithType:0];
        [funcBtn addTarget:self action:@selector(bottomFuncBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        funcBtn.tag = 5790+[subDict[@"type"] intValue];
        [funcBtn setImage:[UIImage imageNamed:subDict[@"imgStr"]] forState:UIControlStateNormal];
        CGRect viewFrame = CGRectMake(0, 0, viewW, viewW);
        if ([subDict[@"bigPic"] boolValue]) {  ///如果是大btn
            viewFrame = CGRectMake(0, 0, kScreenWidth-100-viewW*(_funcList.count-1), 40);
            [funcBtn setTitle:[NSString stringWithFormat:@"  %@",subDict[@"title"]] forState:UIControlStateNormal];
            [funcBtn setBackgroundImage:[UIImage createImageSize:viewFrame.size gradientColors:@[kRGB_COLOR(@"#FF54A0"),kRGB_COLOR(@"#FF6CF6")] percentage:@[@0.3,@1.0] gradientType:GradientFromTopToBottom] forState:UIControlStateNormal];
            funcBtn.layer.cornerRadius = 20;
            funcBtn.clipsToBounds = YES;
            funcBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        }
        funcBtn.frame = viewFrame;
        [stackV addSubview:funcBtn];
        [stackV addArrangedSubview:funcBtn];
        
        if ([subDict[@"type"] intValue] == 204) {
            self.attenBtn = funcBtn;
        }
    }
    
    UIView *space2V = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    [stackV addSubview:space2V];
    [stackV addArrangedSubview:space2V];
    
    
}

- (UIImageView *)likeTipV{
    if (!_likeTipV) {
    //    //提示相关
        CGFloat scale = 127/492.0;
        CGFloat tipW = kScreenWidth*492/750.0;
        CGFloat tipH = tipW*scale;
        UIImageView *likeTipV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-15-tipW, self.y-tipH,tipW, tipH)];
        likeTipV.backgroundColor = [UIColor clearColor];
        likeTipV.image = [UIImage imageNamed:@"icon_userinfo_like_tip"];
        likeTipV.hidden = YES;
        self.likeTipV = likeTipV;
        [self addSubview:likeTipV];

        UIImageView *avaterImageV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 30, 30)];
        avaterImageV.layer.cornerRadius = 15;
        avaterImageV.centerY = tipH/2.0-5;
        avaterImageV.clipsToBounds = YES;

        [likeTipV addSubview:avaterImageV];
        _userIconV = avaterImageV;

        UILabel *tipL = [[UILabel alloc]initWithFrame:CGRectMake(avaterImageV.maxX+10, 0, tipW-(avaterImageV.maxX+20), 40)];
        tipL.textColor = kRGB_COLOR(@"#333333");
        tipL.font = [UIFont systemFontOfSize:13];
        tipL.numberOfLines = 0;
        tipL.centerY = avaterImageV.centerY;
        tipL.textAlignment = NSTextAlignmentLeft;
        tipL.text = kLocalizationMsg(@"看我辣么久，你一定喜欢我吧？");
        [likeTipV addSubview:tipL];
    }
    return _likeTipV;
}


- (void)setHomeModel:(UserInfoHomeVOModel *)homeModel {
    _homeModel = homeModel;
    if (!homeModel.isAttentionUser && homeModel.userInfo.userId != [ProjConfig userId]) {
        if (self.likeTipV && !self.showTips) {
            self.showTips = YES;
            self.likeTipV.hidden = NO;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.likeTipV.hidden = YES;
                [self.likeTipV removeFromSuperview];
            });
        }
    }
    [_userIconV sd_setImageWithURL:[NSURL URLWithString:homeModel.userInfo.avatar] placeholderImage:[ProjConfig getAppIcon]];
    
    
    UIImage *attenImg;
    if (self.homeModel.isAttentionUser == 1) {
        if ([[ProjConfig shareInstence].baseConfig isContainFansGroup]) {
            attenImg = [UIImage imageNamed:@"icon_userinfo_attent_selected"];
        }else{
            UILabel *textL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 116, 116)];
            textL.text = kLocalizationMsg(@"已关注");
            textL.font = [UIFont systemFontOfSize:25];
            textL.textAlignment = NSTextAlignmentCenter;
            textL.textColor = [UIColor grayColor];
            attenImg = [UIImage imageConvertFromView:textL];
        }
    }else{
        attenImg = [UIImage imageNamed:@"icon_userinfo_attent_normal"];
    }
    [self.attenBtn setImage:attenImg forState:UIControlStateNormal];
}



#pragma mark 点击事件

- (void)bottomFuncBtnClick:(UIButton *)btn{
    
    if (![ProjConfig isUserLogin]) {
        [RouteManager routeForName:RN_login_ShowLoginVC currentC:[ProjConfig currentVC]];
        return;
    }
    
    NSInteger type = btn.tag - 5790;
    switch (type) {
        case 201: ///私信
        {
            [RouteManager routeForName:RN_Message_ConversationChatVC currentC:[ProjConfig currentVC] parameters:@{@"chatType":@"0",@"msgSendId":@(self.homeModel.userInfo.userId)}];
        }
            break;
        case 202: ///守护
        {
            [RouteManager routeForName:RN_center_userGuard currentC:[ProjConfig currentVC] parameters:@{@"userId":@(self.homeModel.userInfo.userId)}];
        }
            break;
        case 203: ///礼物
        {
            ApiUserInfoModel *userInfo = self.homeModel.userInfo;
            GiftUserModel *gift = [[GiftUserModel alloc]init];
            gift.userId = userInfo.userId;
            gift.userName = userInfo.username;
            gift.userIcon = userInfo.avatar;
            [ChoiceGiftView showGift:10 users:@[gift] hasContinue:NO sendSuccess:^(NSArray<ApiGiftSenderModel *> * _Nonnull giftModelList) {
                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"成功赠送礼物")];
            }];
        }
            break;
        case 204: ///关注
        {
            
            if (self.homeModel.isAttentionUser) {
                if ([[ProjConfig shareInstence].baseConfig isContainFansGroup]) {
                    //粉丝团
                    ApiUserInfoModel *userInfo = self.homeModel.userInfo;
                    [FansGroupShowView showFansWith:userInfo.userId hasBgColor:YES showUserInfo:^(int64_t userId) {
                        if (userId > 0) {
                            [RouteManager routeForName:RN_user_userInfoVC currentC:[ProjConfig currentVC] parameters:@{@"id":@(userId)}];
                        }
                    }];
                }else{
                    [self attentUser:NO];
                }
            }else{
                [self attentUser:YES];
            }
        }
            break;
        case 211: ///视频
        {
            [self O2OConnecte:YES];
        }
            break;
        case 212: ///语音
        {
            [self O2OConnecte:NO];
        }
            break;
        case 210: ///视频+语音
        {
            ApiUserInfoModel *userInfo = self.homeModel.userInfo;
            kWeakSelf(self);
            O2OCallTypeParam *param = [[O2OCallTypeParam alloc] init];
            param.username = userInfo.username;
            param.voiceCoin = userInfo.voiceCoin;
            param.videoCoin = userInfo.videoCoin;
            param.callUserRole = userInfo.role;
            [O2OCallTypeSelectedView showCallTypeViewWith:param callBack:^(NSInteger type, O2OCallTypeSelectedView * _Nonnull callView) {
                [callView removeFromSuperview];
                callView = nil;
                if (type == 1) {// 语音
                     [weakself O2OConnecte:NO];
                }else if(type == 2){//视频
                     [weakself O2OConnecte:YES];
                }
            }];
        }
            break;
        default:
            break;
    }
}


- (void)O2OConnecte:(BOOL)isVideo{
    NSMutableDictionary *muDict = [[NSMutableDictionary alloc] initWithCapacity:1];
    [muDict setObject:@(self.homeModel.userInfo.userId) forKey:@"userId"];
    if (isVideo) {
        [muDict setObject:@(YES) forKey:@"isVideo"];
    } else {
        [muDict setObject:@(NO) forKey:@"isVideo"];
    }
    [RouteManager routeForName:RN_live_LaunchOneLive currentC:[ProjConfig currentVC] parameters:muDict];
}

- (void)attentUser:(BOOL)isAtten{
    if (self.attenUserBtnClick) {
        self.attenUserBtnClick(isAtten);
    }
}

@end
