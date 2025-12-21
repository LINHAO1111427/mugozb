//
//  MPAudioCloseInfoShowView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/28.
//  Copyright © 2020 . All rights reserved.
//

#import "MPAudioCloseInfoShowView.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <LibProjModel/ApiCloseLiveModel.h>
#import <LiveCommon/LiveManager.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjBase/LibProjBase.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LiveCommon/MPLiveCloseInterface.h>
#import <LibProjModel/HttpApiUserController.h>


@interface MPAudioCloseInfoShowView ()<MPLiveCloseInterface>

@property (nonatomic, strong)ApiCloseLiveModel *closeModel;
@property (nonatomic, weak)UIButton *followBtn; ///关注btn

@end

@implementation MPAudioCloseInfoShowView

+ (void)showInView:(UIView *)superV isAnchor:(BOOL)isAnchor closeInfo:(ApiCloseLiveModel *)closeModel{
    BOOL hasView = NO;
    for (UIView *subV in superV.subviews) {
        if ([subV isKindOfClass:[MPAudioCloseInfoShowView class]]) {
            hasView = YES;
        }
    }
    if (!hasView) {
        MPAudioCloseInfoShowView *showV = [[MPAudioCloseInfoShowView alloc] initWithFrame:superV.bounds];
        showV.closeModel = closeModel;
        [showV createView:isAnchor];
        [superV addSubview:showV];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

- (void)createView:(BOOL)isAnchor{
        
    UIImageView *anchorImg = [[UIImageView alloc] init];
    
    [anchorImg sd_setImageWithURL:[NSURL URLWithString:[LiveManager liveInfo].roomModel.liveThumb] placeholderImage:[ProjConfig getDefaultImage]];
    anchorImg.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:anchorImg];
    [anchorImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    ///毛玻璃效果
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectV = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectV.alpha = 0.5;
    [self addSubview:effectV];
    [effectV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    ///用户头像
    UIImageView *userIcon = [[UIImageView alloc] init];
    [userIcon sd_setImageWithURL:[NSURL URLWithString:[LiveManager liveInfo].anchorIcon] placeholderImage:[ProjConfig getDefaultImage]];
    userIcon.contentMode = UIViewContentModeScaleAspectFill;
    userIcon.layer.masksToBounds = YES;
    [self addSubview:userIcon];
    
    ///用户名称
    UILabel *userNameL = [[UILabel alloc] init];
    userNameL.textColor = [UIColor whiteColor];
    userNameL.text = [LiveManager liveInfo].anchorName;
    userNameL.font = [UIFont systemFontOfSize:17];
    [self addSubview:userNameL];
    
    ///是否关注
    UIButton *btn = [UIButton buttonWithType:0];
    btn.layer.masksToBounds = YES;
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.layer.borderWidth = 1.0;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(followBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _followBtn = btn;


    ///直播标题
    UILabel *titleL = [[UILabel alloc] init];
    titleL.textColor = [UIColor whiteColor];
    titleL.font = [UIFont systemFontOfSize:20];
    titleL.text = kLocalizationMsg(@"本场直播已结束");
    [self addSubview:titleL];
    
    ///
    UIView *infoView = [[UIView alloc] init];
    [self addSubview:infoView];
    
    ///返回按钮
    UIButton *backBtn = [[UIButton alloc] init];
    backBtn.layer.masksToBounds = YES;
    backBtn.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
    backBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    backBtn.layer.borderWidth = 1.0;
    [backBtn setTitle:kLocalizationMsg(@"返回首页") forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(docancle) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    
    [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.centerX.equalTo(self);
        make.top.equalTo(self).mas_offset(10+kNavBarHeight);
        make.bottom.equalTo(userNameL.mas_top).mas_offset(-15);
    }];
    [userNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(userIcon);
        make.bottom.equalTo(btn.mas_top).mas_offset(-25);
    }];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(userNameL);
        make.size.mas_equalTo(CGSizeMake(90, 30));
        make.bottom.equalTo(titleL.mas_top).mas_offset(-50);
    }];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(userNameL);
        make.bottom.equalTo(infoView.mas_top).mas_offset(-30);
    }];
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(30);
        make.right.equalTo(self).mas_offset(-30);
        make.height.mas_equalTo(isAnchor?160:90);
    }];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(260, 40));
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).mas_offset(-110);
    }];
    
    if (isAnchor) {
        btn.hidden = YES;
        [self createAnchorInfoView:infoView];
        [btn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(titleL.mas_top).mas_offset(-10);
        }];
    }else{
        btn.hidden = NO;
        [self showFollowBtnIsAttention];
        [self createAudienceInfoView:infoView];
    }

    
    [userIcon layoutIfNeeded];
    userIcon.layer.cornerRadius = userIcon.height/2.0;
    [backBtn layoutIfNeeded];
    backBtn.layer.cornerRadius = backBtn.height/2.0;
    [btn layoutIfNeeded];
    btn.layer.cornerRadius = btn.height/2.0;
}


- (void)createAudienceInfoView:(UIView *)bgView{
    UIView *topLine = [[UIView alloc] init];
    topLine.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:topLine];
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:bottomLine];
    
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(bgView);
        make.height.mas_equalTo(0.5);
    }];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(bgView);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *firstV = [self itemView:[NSString stringWithFormat:@"%d",_closeModel.nums] title:kLocalizationMsg(@"观看人数")];
    [bgView addSubview:firstV];
    UIView *secondV = [self itemView:[NSString stringWithFormat:@"%d",_closeModel.addFollow] title:kLocalizationMsg(@"新增关注")];
    [bgView addSubview:secondV];
    UIView *thirdV = [self itemView:[NSString changeShowTimeForSecond:_closeModel.duration] title:kLocalizationMsg(@"直播时长")];
    [bgView addSubview:thirdV];
    
    [firstV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(bgView);
        make.right.equalTo(secondV.mas_left);
        make.width.equalTo(bgView).multipliedBy(1.0/3.0);
    }];
    [secondV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(bgView);
        make.right.equalTo(thirdV.mas_left);
        make.width.height.equalTo(firstV);
    }];
    [thirdV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(bgView);
        make.width.height.equalTo(firstV);
    }];
}


- (void)createAnchorInfoView:(UIView *)bgView{
    
    UIView *topLine = [[UIView alloc] init];
    topLine.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:topLine];
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:bottomLine];
    
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(bgView);
        make.height.mas_equalTo(0.5);
    }];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(bgView);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *firstV = [self itemView:[NSString stringWithFormat:@"%d",_closeModel.nums] title:kLocalizationMsg(@"观看人数")];
    [bgView addSubview:firstV];
    UIView *secondV = [self itemView:[NSString stringWithFormat:@"%d",_closeModel.addFollow] title:kLocalizationMsg(@"新增关注")];
    [bgView addSubview:secondV];
    UIView *thirdV = [self itemView:[NSString changeShowTimeForSecond:_closeModel.duration] title:kLocalizationMsg(@"直播时长")];
    [bgView addSubview:thirdV];
    UIView *fourthV = [self itemView:[NSString stringWithFormat:@"%d",_closeModel.addFansGroup] title:kLocalizationMsg(@"加入粉丝团")];
    [bgView addSubview:fourthV];
    UIView *fifthV = [self itemView:[NSString stringWithFormat:@"%0.0lf",_closeModel.votes] title:kLocalizationMsg(@"本场收益")];
    [bgView addSubview:fifthV];
    UIView *sixthV = [self itemView:[NSString stringWithFormat:@"%d",_closeModel.rewardNumber] title:kLocalizationMsg(@"打赏人数")];
    [bgView addSubview:sixthV];
    
    [firstV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(bgView);
        make.right.equalTo(secondV.mas_left);
        make.bottom.equalTo(fourthV.mas_top);
        make.width.equalTo(bgView).multipliedBy(1.0/3.0);
        make.height.equalTo(bgView).multipliedBy(0.5);
    }];
    [secondV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView);
        make.right.equalTo(thirdV.mas_left);
        make.width.height.equalTo(firstV);
        make.bottom.equalTo(fifthV.mas_top);
    }];
    [thirdV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(bgView);
        make.bottom.equalTo(sixthV.mas_top);
        make.width.height.equalTo(firstV);
    }];
    [fourthV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(firstV);
        make.left.bottom.equalTo(bgView);
        make.right.equalTo(fifthV.mas_left);
    }];
    [fifthV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(firstV);
        make.bottom.equalTo(bgView);
        make.right.equalTo(sixthV.mas_left);
    }];
    [sixthV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(firstV);
        make.bottom.equalTo(bgView);
        make.right.equalTo(bgView);
    }];
}

- (UIView *)itemView:(NSString *)showStr title:(NSString *)title{
    UIView *bgV = [[UIView alloc] init];
    
    UIView *centerV = [[UIView alloc] init];
    [bgV addSubview:centerV];
    [centerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bgV);
    }];
    ///数据显示
    UILabel *numL = [[UILabel alloc] init];
    numL.textAlignment = NSTextAlignmentCenter;
    numL.textColor = [UIColor whiteColor];
    numL.font = [UIFont systemFontOfSize:15];
    numL.text = showStr.length?showStr:@"";
    [centerV addSubview:numL];
    
    ///直播标题
    UILabel *titleL = [[UILabel alloc] init];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.textColor = [UIColor whiteColor];
    titleL.font = [UIFont systemFontOfSize:13];
    titleL.text = title;
    [centerV addSubview:titleL];
    
    
    [numL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(centerV);
        make.bottom.equalTo(titleL.mas_top).mas_offset(-12);
    }];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(centerV);
    }];

    return bgV;
}


- (void)docancle{
    [LiveComponentMsgMgr sendMsg:LM_ExitRoom msgDic:nil];
}


- (void)showFollowBtnIsAttention{
    if ([LiveManager liveInfo].roomModel.isFollow == 0) {
        _followBtn.backgroundColor = kRGB_COLOR(@"#DD85FD");
        _followBtn.layer.borderColor = kRGB_COLOR(@"#DD85FD").CGColor;
        [_followBtn setTitle:kLocalizationMsg(@"+ 关注") forState:UIControlStateNormal];
    }else{
        [_followBtn setTitle:kLocalizationMsg(@"已关注") forState:UIControlStateNormal];
        _followBtn.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
        _followBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    }
}


- (void)followBtnClick{
    kWeakSelf(self);
    if ([LiveManager liveInfo].roomModel.isFollow == 0) {
        [HttpApiUserController setAtten:1 touid:[LiveManager liveInfo].anchorId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                [LiveManager liveInfo].roomModel.isFollow = 1;
                [weakself showFollowBtnIsAttention];
            }
        }];
    }
}

@end
