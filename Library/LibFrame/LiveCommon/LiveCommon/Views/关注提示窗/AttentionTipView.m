//
//  AttentionTipView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/4/24.
//  Copyright © 2020 . All rights reserved.
//

#import "AttentionTipView.h"
#import <LiveCommon/LiveManager.h>
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/HttpApiUserController.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>

@interface AttentionTipView ()

@end

@implementation AttentionTipView

+ (void)showAttentionTip:(UIView *)superView{
    if ([LiveManager liveInfo].liveType != LiveTypeForOneToOne) {   ///多人视频
        BOOL hasSelf = NO;
        for (UIView *subV in superView.subviews) {
            if ([subV isKindOfClass:[AttentionTipView class]]) {
                hasSelf = YES;
            }
        }
        if (!hasSelf && [LiveManager liveInfo].roomModel.isFollow == 0 && [LiveManager liveInfo].anchorId != [KLCUserInfo getUserId]) {
            AttentionTipView *tip = [[AttentionTipView alloc] initWithFrame:CGRectMake(12, 0, kScreenWidth-24, 80)];
            [superView addSubview:tip];
            [tip createUI];
        }
    }
}



- (void)createUI{

    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 8.0;
    self.alpha = 0;
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    
    UIImageView *icon = [[UIImageView alloc] init];
    [icon sd_setImageWithURL:[NSURL URLWithString:[LiveManager liveInfo].anchorIcon] placeholderImage:[ProjConfig getDefaultImage]];
    icon.layer.masksToBounds = YES;
    [self addSubview:icon];
    
    UIView *centerV = [[UIView alloc] init];
    [self addSubview:centerV];
    
    UIButton *attentionBtn = [UIButton buttonWithType:0];
    attentionBtn.layer.masksToBounds = YES;
    [attentionBtn setBackgroundImage:[UIImage imageNamed:@"live_banner_purple"] forState:UIControlStateNormal];
    [attentionBtn setTitle:kLocalizationMsg(@"马上关注") forState:UIControlStateNormal];
    attentionBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [attentionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    attentionBtn.layer.masksToBounds = YES;
    [attentionBtn addTarget:self action:@selector(attentionBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:attentionBtn];
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.font = [UIFont systemFontOfSize:16];
    titleL.textColor = [UIColor blackColor];
    titleL.text = [LiveManager liveInfo].anchorName;
    [centerV addSubview:titleL];
    
    UILabel *contentL = [[UILabel alloc] init];
    contentL.font = [UIFont systemFontOfSize:13];
    contentL.textColor = [UIColor darkGrayColor];
    contentL.text = kLocalizationMsg(@"关注主播下次不迷路～");
    [centerV addSubview:contentL];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).mas_offset(20);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).mas_offset(-20);
        make.size.mas_equalTo(CGSizeMake(88, 30));
    }];
    
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(centerV);
        make.bottom.equalTo(contentL.mas_top).mas_offset(-10);
    }];
    [contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(centerV);
    }];
    
    [centerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).mas_offset(10);
        make.right.equalTo(attentionBtn.mas_left).mas_offset(-10);
        make.centerY.equalTo(self);
    }];
    
    [icon layoutIfNeeded];
    icon.layer.cornerRadius = icon.height/2.0;
    
    [attentionBtn layoutIfNeeded];
    attentionBtn.layer.cornerRadius = attentionBtn.height/2.0;
    
    self.y = kScreenHeight - self.height-kSafeAreaBottom-60-40;
    
    kWeakSelf(self);
    [UIView animateWithDuration:0.3 animations:^{
        weakself.alpha = 1.0;
        CGRect rc = weakself.frame;
        rc.origin.y = rc.origin.y+40;
        weakself.frame = rc;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself dismissView];
        });
    }];

    [self klc_whenTapped:^{
        [weakself dismissView];
    }];
}


- (void)dismissView{
    [self removeFromSuperview];
}

///关注按钮
- (void)attentionBtnClick {
    kWeakSelf(self);
    [HttpApiUserController setAtten:1 touid:[LiveManager liveInfo].anchorId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [LiveComponentMsgMgr sendMsg:LM_AttentionAnchor msgDic:nil];
            [weakself dismissView];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

@end
