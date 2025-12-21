//
//  InviteUserView.m
//  LiveCommon
//
//  Created by admin on 2020/5/15.
//  Copyright © 2020 . All rights reserved.
//

#import "InviteUserView.h"
#import <LibProjBase/PopupTool.h>
#import <LibProjBase/LibProjBase.h>
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjView/KlcAvatarView.h>

@interface InviteUserView ()

@property (nonatomic, copy)void(^refuseHandle)(void);
@property (nonatomic, copy)void(^agreeHandle)(void);

@property (nonatomic, weak)UIButton *cancelBtn;
@property (nonatomic, weak)UIButton *sureBtn;
@property (nonatomic, weak)UILabel *contentLab;

@end

@implementation InviteUserView


+ (instancetype)inviteUserInfoShow:(ApiUserInfoModel *)userModel userCurrentRole:(int)role{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    InviteUserView *selfV = (InviteUserView *)[PopupTool getPopupViewForClass:[self class]];
    if (!selfV) {
        InviteUserView *inviteV = [[InviteUserView alloc] init];
        [inviteV createUI:userModel role:role];
        [[PopupTool share] createPopupViewWithLinkView:inviteV allowTapOutside:NO];
        [inviteV showInvite];
        selfV = inviteV;
    }
    return selfV;
}

- (void)setSureBtnTitle:(NSString *)sureTitle cancelBtnTitle:(NSString *)cancelTitle content:(NSString *)content{
    [_cancelBtn setTitle:cancelTitle forState:UIControlStateNormal];
    [_sureBtn setTitle:sureTitle forState:UIControlStateNormal];
    _contentLab.text = content;
}

- (void)createUI:(ApiUserInfoModel *)userInfoModel role:(int)role{
    self.frame = CGRectMake(6, kScreenHeight, kScreenWidth-12, 145);
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 8;
    self.layer.borderWidth = 3.0;
    self.layer.borderColor = [ProjConfig normalColors].CGColor;
    
    
    UIButton *deleteBtn = [UIButton buttonWithType:0];
    deleteBtn.frame = CGRectMake(self.width-40, 0, 40, 40);
    [deleteBtn setImageEdgeInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    [deleteBtn setImage:[UIImage imageNamed:@"live_guanbi_gray"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteBtn];
    
    
    ///取消btn
    UIButton *cancelBtn = [UIButton buttonWithType:0];
    cancelBtn.frame = CGRectMake(44, self.height-20-34, 100, 34);
    [cancelBtn setTitle:kLocalizationMsg(@"忽略") forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setBackgroundColor:kRGB_COLOR(@"#DDDDDD")];
    [self addSubview:cancelBtn];
    _cancelBtn = cancelBtn;
    cancelBtn.layer.masksToBounds =YES;
    cancelBtn.layer.cornerRadius = cancelBtn.height/2.0;
    
    ///确认btn
    UIButton *sureBtn = [UIButton buttonWithType:0];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"live_btn_blue"] forState:UIControlStateNormal];
    [sureBtn setTitle:kLocalizationMsg(@"同意") forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.frame = CGRectMake(self.width-44-100, cancelBtn.y, 100, 34);
    [self addSubview:sureBtn];
    _sureBtn = sureBtn;
    sureBtn.layer.masksToBounds =YES;
    sureBtn.layer.cornerRadius = sureBtn.height/2.0;
    
    
    //用户信息背景
    UIView *userInfoBgV = [[UIView alloc] init];
    [self addSubview:userInfoBgV];
    
    ///用户名称背景
    UIView *centerBgV = [[UIView alloc] init];
    [userInfoBgV addSubview:centerBgV];
    
    ///用户头像
    KlcAvatarView *userIcon = [[KlcAvatarView alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    [userIcon showUserIconUrl:userInfoModel.avatar vipBorderUrl:userInfoModel.nobleAvatarFrame];
    [userInfoBgV addSubview:userIcon];
    
    [centerBgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(userIcon);
        make.left.equalTo(userIcon.mas_right).mas_offset(10);
        make.right.equalTo(userInfoBgV);
    }];
    
    [userInfoBgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(userIcon.height);
        make.bottom.equalTo(cancelBtn.mas_top).mas_offset(-20);
        make.centerX.equalTo(self);
    }];
    
    
    ///==================用户信息==================
    NSString *userName = userInfoModel.username.length>0?userInfoModel.username:@" ";
    int fontsize = 15;
    UILabel *nameL = [[UILabel alloc] init];
    nameL.text = userName;
    nameL.font = [UIFont systemFontOfSize:fontsize];
    nameL.textColor = [UIColor blackColor];
    [centerBgV addSubview:nameL];
    ///用户详情
    UILabel *contentL = [[UILabel alloc] init];
    contentL.text = kLocalizationMsg(@"邀请...");
    contentL.font = [UIFont systemFontOfSize:fontsize];
    contentL.textColor = kRGB_COLOR(@"#666666");
    [centerBgV addSubview:contentL];
    _contentLab = contentL;
    ///图标背景视图
    UIView *iconBgView = [[UIView alloc] init];
    [centerBgV addSubview:iconBgView];
    [nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(centerBgV);
        make.height.mas_equalTo(15);
        make.bottom.equalTo(contentL.mas_top).mas_offset(-12);
        make.right.equalTo(iconBgView.mas_left).mas_offset(-5);
    }];
    [contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(centerBgV);
        make.height.mas_equalTo(15);
        make.right.equalTo(contentL.superview);
    }];
    
    ////占位View
    UIView *rightV = nameL;
    ///用户等级
    if (role) { ///主播
        if (userInfoModel.anchorGradeImg.length>0) {
            UIImageView *userLevelImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 15)];
            userLevelImgV.contentMode = UIViewContentModeScaleAspectFit;
            [userLevelImgV sd_setImageWithURL:[NSURL URLWithString:userInfoModel.anchorGradeImg]];
            [iconBgView addSubview:userLevelImgV];
            rightV = userLevelImgV;
        }
    }else{  ///用户
        if (userInfoModel.userGradeImg.length>0) {
            UIImageView *userLevelImgV = [[UIImageView alloc] initWithFrame:CGRectMake(rightV.maxX+5, 0, 30, 15)];
            userLevelImgV.contentMode = UIViewContentModeScaleAspectFit;
            [userLevelImgV sd_setImageWithURL:[NSURL URLWithString:userInfoModel.userGradeImg]];
            [iconBgView addSubview:userLevelImgV];
            rightV = userLevelImgV;
        }
    }
    ///财富等级
    if (userInfoModel.wealthGradeImg.length>0) {
        UIImageView *wealthImgV = [[UIImageView alloc] initWithFrame:CGRectMake(rightV.maxX+5, 0, 30, 15)];
        wealthImgV.contentMode = UIViewContentModeScaleAspectFit;
        [wealthImgV sd_setImageWithURL:[NSURL URLWithString:userInfoModel.wealthGradeImg]];
        [iconBgView addSubview:wealthImgV];
        rightV = wealthImgV;
    }
    [iconBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameL);
        make.size.mas_equalTo(CGSizeMake(rightV.maxX, 15));
        make.right.equalTo(iconBgView.superview);
    }];
}


- (void)showInvite{
    kWeakSelf(self);
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rc = weakself.frame;
        rc.origin.y = kScreenHeight-kSafeAreaBottom-70-rc.size.height;
        weakself.frame = rc;
    }];
}


- (void)cancelBtnClick{
    if (_refuseHandle) {
        _refuseHandle();
    }
    [self cancelDismiss];
}

- (void)sureBtnClick{
    if (_agreeHandle) {
        _agreeHandle();
    }
    [self agreeDismiss];
}


- (void)clickRefuseBtn:(void(^)(void))refuse{
    _refuseHandle = refuse;
}

- (void)clickAgreeBtn:(void(^)(void))agree{
    _agreeHandle = agree;
}


- (void)agreeDismiss{
    [[PopupTool share] closePopupView:self];
}

- (void)cancelDismiss{
    kWeakSelf(self);
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rc = weakself.frame;
        rc.origin.y = kScreenHeight;
        weakself.frame = rc;
    } completion:^(BOOL finished) {
        [[PopupTool share] closePopupView:weakself];
    }];
}

@end
