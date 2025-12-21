//
//  AnchorHeaderView.m
//  LiveCommon
//
//  Created by klc on 2020/5/22.
//  Copyright © 2020 . All rights reserved.
//

#import "AnchorHeaderView.h"
#import <Masonry/Masonry.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LibTools/LibTools.h>
#import <LibProjModel/HttpApiUserController.h>
#import <LiveCommon/LiveManager.h>
#import <LibTools/LiveMacros.h>

@interface AnchorHeaderView ()

@property (nonatomic, weak) UIButton *followBtn; /// 关注

@end

@implementation AnchorHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self createUI];
        
    }
    return self;
}

- (void)createUI{
    UIImageView *headerBgV= [[UIImageView alloc] init];
    headerBgV.layer.masksToBounds = YES;
    [headerBgV setImage:[UIImage imageNamed:@"live_user_headerBg"]];
    headerBgV.userInteractionEnabled = YES;
    [self addSubview:headerBgV];
    
    // 头像
    UIButton *userIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    userIconBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    userIconBtn.layer.masksToBounds = YES;
    [headerBgV addSubview:userIconBtn];
    _iconBtn = userIconBtn;
    [userIconBtn addTarget:self action:@selector(clickAnchorIcon:) forControlEvents:UIControlEventTouchUpInside];
    
    ///名称头像居中
    UIView *centerV = [[UIView alloc] init];
    [headerBgV addSubview:centerV];
    
    // 主播名
    UILabel *nameLabel = [[UILabel alloc] init];
    [nameLabel setFont:[UIFont systemFontOfSize:12]];
    [nameLabel setTextColor:[UIColor whiteColor]];
    [nameLabel setText:kLocalizationMsg(@"昵称")];
    [centerV addSubview:nameLabel];
    _nameL = nameLabel;
    
    // 关注按钮
    UIButton *followBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [followBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [followBtn setImage:[UIImage imageNamed:@"live_guanzhu"] forState:UIControlStateNormal];
    [followBtn.layer setMasksToBounds:YES];
    [followBtn addTarget:self action:@selector(clickFollowBtn:) forControlEvents:UIControlEventTouchUpInside];
    [headerBgV addSubview:followBtn];
    _followBtn = followBtn;
    _followBtn.selected = NO;
    
    [headerBgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(liveHeaderBannerW, liveHeaderBannerH));
        make.top.left.equalTo(self);
    }];
    
    [userIconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerBgV.mas_left).mas_offset(3);
        make.right.equalTo(centerV.mas_left).mas_offset(-3);
        make.top.equalTo(headerBgV).offset(3);
        make.bottom.equalTo(headerBgV).offset(-3);
        make.width.equalTo(userIconBtn.mas_height);
    }];
    
    [centerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerBgV);
        make.right.equalTo(followBtn.mas_left).mas_offset(-1);
    }];
    
    [followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerBgV.mas_right).mas_offset(-5);
        make.top.equalTo(headerBgV).offset(5);
        make.bottom.equalTo(headerBgV).offset(-5);
        make.width.equalTo(followBtn.mas_height);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(centerV);
        make.right.equalTo(centerV);
        make.bottom.equalTo(centerV);
        make.height.mas_equalTo(12);
    }];
    
    
    [headerBgV layoutIfNeeded];
    headerBgV.layer.cornerRadius = headerBgV.frame.size.height / 2.0;
    
    [userIconBtn layoutIfNeeded];
    userIconBtn.layer.cornerRadius = userIconBtn.frame.size.height / 2.0;
    
    [followBtn layoutIfNeeded];
    followBtn.layer.cornerRadius = followBtn.frame.size.height / 2.0;
}



// MARK: - Action

- (void)anchorSelfShowFollowBtn:(BOOL)isShow{
    if (isShow) { //显示
        _followBtn.hidden = NO;
        [_followBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(_followBtn.superview).inset(5);
            make.width.equalTo(_followBtn.mas_height);
        }];
    }
    else{   //不显示
        _followBtn.hidden = YES;
        [_followBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(_followBtn.superview).inset(5);
            make.width.mas_equalTo(0);
        }];
    }
}

///是否关注

- (void)attentionAnchor:(BOOL)isAtten{
    _followBtn.selected = isAtten;
    [_followBtn setImage:[UIImage imageNamed:isAtten?@"live_fensituan_white":@"live_guanzhu"] forState:UIControlStateNormal];
}



// MARK: 点击主播头像
- (void)clickAnchorIcon:(UIButton *)sender{
   // NSLog(@"过滤文字%s"),__func__);
    [LiveComponentMsgMgr sendMsg:LM_ShowUserInfo msgDic:@{@"userID":@([LiveManager liveInfo].anchorId)}];
}


// MARK: 关注被点击
- (void)clickFollowBtn:(UIButton *)sender{
    if (_followBtn.selected) {
        [LiveComponentMsgMgr sendMsg:LM_JoinFans msgDic:nil];
    }else{
        kWeakSelf(self);
        [HttpApiUserController setAtten:1 touid:[LiveManager liveInfo].anchorId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                [LiveManager liveInfo].roomModel.isFollow = 1;
                weakself.followBtn.selected = YES;
                [weakself.followBtn setImage:[UIImage imageNamed:@"live_fensituan_white"] forState:UIControlStateNormal];
            }
        }];
    }
}


@end
