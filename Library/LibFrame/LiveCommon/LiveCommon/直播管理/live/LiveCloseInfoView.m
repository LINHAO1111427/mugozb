//
//  LiveCloseInfoView.m
//  HomePage
//
//  Created by klc_sl on 2021/2/25.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "LiveCloseInfoView.h"
#import <SDWebImage.h>
#import <LibProjModel/HttpApiUserController.h>
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <LibProjModel/AppHomeHallDTOModel.h>

@interface LiveCloseInfoView ()

@property (nonatomic, strong) UIImageView *bgImgV; ///主播背景图

@property (nonatomic, strong) UIView *headBgV;  ///用户头像视图

@property (nonatomic, weak) UILabel *stateL;  ///用户状态

@property (nonatomic, weak) UILabel *usernameL; ///用户名称

@property (nonatomic, weak) UIImageView *userIconV; ///主播头像
///

@end

@implementation LiveCloseInfoView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgImgV];
        [self addSubview:self.headBgV];
        
        ///关闭关闭
        UIButton *closeBtn = [UIButton buttonWithType:0];
        CGFloat contentInset = (liveHeaderBannerH - 16)/2.0;
        closeBtn.frame = CGRectMake(kScreenWidth-liveHeaderBannerH-(12-contentInset), liveHeaderBannerY, liveHeaderBannerH, liveHeaderBannerH);
        [closeBtn setImage:[UIImage imageNamed:@"live_guanbi_white"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [closeBtn setImageEdgeInsets:UIEdgeInsetsMake(contentInset, contentInset, contentInset, contentInset)];
        [self addSubview:closeBtn];
        
    }
    return self;
}

- (UIImageView *)bgImgV{
    if (!_bgImgV) {
        _bgImgV = [[UIImageView alloc] init];
        _bgImgV.contentMode = UIViewContentModeScaleAspectFill;
        _bgImgV.clipsToBounds = YES;
        [self addSubview:_bgImgV];
        [_bgImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        UIVisualEffectView *visualV = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        visualV.frame = _bgImgV.bounds;
        [_bgImgV addSubview:visualV];
        [visualV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_bgImgV);
        }];
    }
    return _bgImgV;
}

- (UIView *)headBgV{
    if (!_headBgV) {
        _headBgV = [[UIView alloc] init];
        _headBgV.backgroundColor = [UIColor clearColor];
        [self addSubview:_headBgV];
        [_headBgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        ///中心视图
        UIView *centerV = [[UIView alloc] init];
        [_headBgV addSubview:centerV];
        [centerV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_headBgV);
            make.centerY.equalTo(_headBgV).inset(kNavBarHeight+70);
        }];
        
        UIImageView *userIcon = [[UIImageView alloc] init];
        userIcon.layer.borderColor = kRGBA_COLOR(@"#ffffff", 1.0).CGColor;
        userIcon.layer.borderWidth = 1.0;
        userIcon.layer.masksToBounds = YES;
        userIcon.layer.cornerRadius = 37.5;
        userIcon.contentMode = UIViewContentModeScaleAspectFill;
        [centerV addSubview:userIcon];
        _userIconV = userIcon;
        [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(centerV);
            make.top.equalTo(centerV);
            make.size.mas_equalTo(CGSizeMake(75, 75));
            make.left.right.equalTo(centerV);
        }];
        
        UILabel *userNameL = [[UILabel alloc] init];
        userNameL.font = [UIFont systemFontOfSize:14];
        userNameL.textColor = [UIColor whiteColor];
        [centerV addSubview:userNameL];
        _usernameL = userNameL;
        [userNameL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(centerV);
            make.top.equalTo(userIcon.mas_bottom).inset(15);
            make.height.mas_equalTo(20);
        }];
        
        UILabel *stateL = [[UILabel alloc] init];
        stateL.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        stateL.textColor = [UIColor whiteColor];
        [centerV addSubview:stateL];
        _stateL = stateL;
        [stateL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(centerV);
            make.top.equalTo(userNameL.mas_bottom).inset(50);
            make.height.mas_equalTo(23);
            make.bottom.equalTo(centerV);
        }];
    }
    return _headBgV;
}

- (void)closeBtnClick:(UIButton *)btn{
    self.closeBtnClick?self.closeBtnClick():nil;
}

- (void)setDtoModel:(AppHomeHallDTOModel *)dtoModel{
    _dtoModel = dtoModel;
    
    [self.bgImgV sd_setImageWithURL:[NSURL URLWithString:dtoModel.headImg]];
    [self.userIconV sd_setImageWithURL:[NSURL URLWithString:dtoModel.headImg]];
    self.stateL.text = kLocalizationMsg(@"主播休息中,去其他直播间看看吧");
    self.usernameL.text = dtoModel.username;
}


@end
