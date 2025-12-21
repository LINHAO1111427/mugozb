//
//  RestAnchorInfoView.m
//  HomePage
//
//  Created by klc_sl on 2021/2/25.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "RestAnchorInfoView.h"
#import <SDWebImage.h>
#import <LibProjModel/AppHomeHallDTOModel.h>
#import <LibProjModel/HttpApiUserController.h>

@interface RestAnchorInfoView ()

@property (nonatomic, strong) UIImageView *bgImgV; ///主播背景图

@property (nonatomic, strong) UIView *headBgV;  ///用户头像视图

@property (nonatomic, weak) UILabel *stateL;  ///用户状态

@property (nonatomic, weak) UILabel *usernameL; ///用户名称

@property (nonatomic, weak) UIImageView *userIconV; ///主播头像

@property (nonatomic, weak) UIButton *attenBtn; ///关注按钮

@end

@implementation RestAnchorInfoView

- (UIImageView *)bgImgV{
    if (!_bgImgV) {
        _bgImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _bgImgV.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_bgImgV];
        
        UIVisualEffectView *visualV = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        visualV.frame = _bgImgV.bounds;
        [_bgImgV addSubview:visualV];
    }
    return _bgImgV;
}

- (UIView *)headBgV{
    if (!_headBgV) {
        _headBgV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
        _headBgV.backgroundColor = [UIColor clearColor];
        [self addSubview:_headBgV];
        
        ///中心视图
        UIView *centerV = [[UIView alloc] init];
        [_headBgV addSubview:centerV];
        [centerV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_headBgV);
            make.centerY.equalTo(_headBgV).offset(20);
        }];
        
        UILabel *stateL = [[UILabel alloc] init];
        stateL.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        stateL.textColor = [UIColor whiteColor];
        [centerV addSubview:stateL];
        _stateL = stateL;
        [stateL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(centerV);
            make.top.equalTo(centerV);
            make.height.mas_equalTo(23);
        }];
        
        UIImageView *userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        userIcon.layer.borderColor = kRGBA_COLOR(@"#ffffff", 1.0).CGColor;
        userIcon.layer.borderWidth = 1.0;
        userIcon.layer.masksToBounds = YES;
        userIcon.layer.cornerRadius = 37.5;
        userIcon.contentMode = UIViewContentModeScaleAspectFill;
        [centerV addSubview:userIcon];
        _userIconV = userIcon;
        [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(centerV);
            make.left.right.equalTo(centerV);
            make.top.equalTo(stateL.mas_bottom).offset(15);
            make.size.mas_equalTo(CGSizeMake(75, 75));
        }];
        
        UILabel *userNameL = [[UILabel alloc] init];
        userNameL.font = [UIFont systemFontOfSize:14];
        userNameL.textColor = [UIColor whiteColor];
        [centerV addSubview:userNameL];
        _usernameL = userNameL;
        [userNameL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(centerV);
            make.top.equalTo(userIcon.mas_bottom).offset(15);
            make.height.mas_equalTo(20);
        }];
        
        UIButton *attenBtn = [UIButton buttonWithType:0];
        [attenBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg_pink"] forState:UIControlStateNormal];
        attenBtn.layer.masksToBounds = YES;
        attenBtn.layer.cornerRadius = 16;
        [attenBtn setTitle:kLocalizationMsg(@"关注Ta") forState:UIControlStateNormal];
        attenBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [attenBtn addTarget:self action:@selector(attenBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [centerV addSubview:attenBtn];
        _attenBtn = attenBtn;
        [attenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 32));
            make.top.equalTo(userNameL.mas_bottom).offset(30);
            make.centerX.equalTo(centerV);
            make.bottom.equalTo(centerV);
        }];
    }
    return _headBgV;
}

- (UIView *)noDataView{
    if (!_noDataView) {
        _noDataView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenWidth, kScreenWidth, 60)];
        _noDataView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_noDataView];
        UILabel *titleL = [[UILabel alloc] init];
        titleL.font = [UIFont systemFontOfSize:13];
        titleL.textColor = kRGBA_COLOR(@"#666666", 1.0);
        titleL.text = kLocalizationMsg(@"主播在休息中，去其他直播间看看吧");
        [_noDataView addSubview:titleL];
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_noDataView);
            make.centerY.equalTo(_noDataView).offset(5);
        }];
    }
    return _noDataView;
}


- (void)setDtoModel:(AppHomeHallDTOModel *)dtoModel{
    _dtoModel = dtoModel;
    [self addSubview:self.bgImgV];
    [self addSubview:self.headBgV];
    
    [self.bgImgV sd_setImageWithURL:[NSURL URLWithString:dtoModel.headImg]];
    [self.userIconV sd_setImageWithURL:[NSURL URLWithString:dtoModel.headImg]];
    self.stateL.text = kLocalizationMsg(@"主播休息中");
    self.usernameL.text = dtoModel.username;
    
    if (dtoModel.userId == [ProjConfig userId]) {
        self.attenBtn.hidden = YES;
    }else{
        [self getUserAttenData];
    }
}

- (void)getUserAttenData{
    kWeakSelf(self);
    [HttpApiUserController getUserInfoRelation:_dtoModel.userId callback:^(int code, NSString *strMsg, UserInfoRelationVO2Model *model) {
        if (code == 1 && model.isAttentionUser == 1) {
            weakself.attenBtn.hidden = YES;
        }
    }];
}

- (void)attenBtnClick{
    if (_dtoModel.userId > 0) {
        kWeakSelf(self);
        [HttpApiUserController setAtten:1 touid:_dtoModel.userId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                weakself.attenBtn.hidden = YES;
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }
}

@end
