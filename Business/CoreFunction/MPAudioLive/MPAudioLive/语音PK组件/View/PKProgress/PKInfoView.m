//
//  PKInfoView.m
//  MPAudioLive
//
//  Created by klc on 2020/6/15.
//  Copyright © 2020 klc. All rights reserved.
//

#import "PKInfoView.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import "PkProgressView.h"
#import "PkRankView.h"
#import <LibProjBase/LibProjBase.h>
#import "PkStartView.h"
#import "AudioPkWinView.h"
#import <LibProjView/ForceAlertController.h>
#import <LibProjModel/HttpApiHttpVoice.h>
#import <LibProjModel/ApiPkResultRoomModel.h>

@interface PKInfoView ()

@property(nonatomic, weak) UILabel *titleLb;

/// pk 进度条
@property(nonatomic, weak) PkProgressView *pkProgressView;

/// pk 排行榜送礼榜
@property(nonatomic, weak) PkRankView *pkRankView;


@property (nonatomic, weak) UILabel *timeL;


@property (nonatomic, weak)UIImageView *pkProgressIcon;

// 主播退出PK按钮
@property (nonatomic, weak) UIButton *exitPkBtn;

/// 倒计时时间
@property(nonatomic, copy) TimerBlock *timer;


@property (nonatomic, assign) LiveInfo_PKType pkType;

///设置当前PK状态
@property (nonatomic, assign) PKProgressStatus currentPKStatus;

///输赢皇冠图标
@property (nonatomic, weak)UIImageView *winImg;
@property (nonatomic, weak)UIImageView *loseImg;


///中途退出PK
@property (nonatomic, copy)void(^quitPKBlock)(PKProgressStatus, NSArray * _Nullable);



@end

///pk信息显示View
@implementation PKInfoView

#pragma mark - 创建视图 -
- (void)dealloc
{
    [_timer stopTimer];
    _timer = nil;
}

- (instancetype)initWithFrame:(CGRect)frame PKType:(LiveInfo_PKType)type{
    if (self = [super initWithFrame:frame]) {
        _pkType = type;
    }
    return self;
}


///创建主题
- (UILabel *)titleLb{
    if (!_titleLb) {
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = kRGB_COLOR(@"#925EFF");
        bgView.layer.masksToBounds = YES;
        [self addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.mas_top).mas_offset(-13);
            make.height.mas_equalTo(24);
        }];

        UIImageView *arrowImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pk_title_arrow"]];
        arrowImg.contentMode = UIViewContentModeScaleAspectFit;
        [bgView addSubview:arrowImg];
        [bgView sendSubviewToBack:arrowImg];
        [arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView.mas_bottom).mas_offset(-1);
            make.centerX.equalTo(bgView);
            make.size.mas_equalTo(CGSizeMake(11, 5));
        }];
        
        UILabel *textLb = [[UILabel alloc] init];
        textLb.font = [UIFont systemFontOfSize:12];
        textLb.textColor = [UIColor whiteColor];
        [bgView addSubview:textLb];
        _titleLb = textLb;
        [textLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(bgView);
            make.left.equalTo(bgView).mas_offset(15);
            make.right.equalTo(bgView).mas_offset(-15);
        }];
        
        [bgView layoutIfNeeded];
        bgView.layer.cornerRadius = bgView.height/2.0;
    }
    return _titleLb;
}

///进度条
- (PkProgressView *)pkProgressView{
    if (!_pkProgressView) {
        PkProgressView *Process = [[PkProgressView alloc] init];
        [self addSubview:Process];
        _pkProgressView = Process;
        [Process mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_bottom).mas_offset(0.5);
            make.left.right.equalTo(self);
            make.height.mas_equalTo(20);
        }];
    }
    return _pkProgressView;
}

- (PkRankView *)pkRankView{
    if (!_pkRankView) {
        PkRankView *rank = [[PkRankView alloc] init];
        [self addSubview:rank];
        _pkRankView = rank;
        [rank mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_bottom).offset(25);
            make.left.equalTo(self).offset(19);
            make.right.equalTo(self).offset(-19);
            make.height.mas_equalTo(38);
        }];
    }
    return _pkRankView;
}

- (UIImageView *)pkProgressIcon{
    if (!_pkProgressIcon) {
        UIImageView *icon = [[UIImageView alloc] init];
        icon.contentMode = UIViewContentModeScaleAspectFill;
        icon.userInteractionEnabled = YES;
        kWeakSelf(self);
        if ([LiveManager liveInfo].roomRole == RoomRoleForAnchor) {
            [icon klc_whenTapped:^{
                [weakself pkIconClick];
            }];
        }
        [self addSubview:icon];
        _pkProgressIcon = icon;
        if ([LiveManager liveInfo].roomRole == RoomRoleForAnchor) {
            [self createExitPkBtn];
            [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(47, 22));
                make.centerX.equalTo(self);
                make.centerY.equalTo(self).offset(-15);
            }];
        } else {
            [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(47, 22));
                make.centerX.equalTo(self);
                make.centerY.equalTo(self);
            }];
        }
        [icon layoutIfNeeded];
    }
    return _pkProgressIcon;
}

// 主播退出PK按钮
- (void)createExitPkBtn {
    UIButton *exitPkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    exitPkBtn.clipsToBounds = YES;
    exitPkBtn.layer.cornerRadius = 11;
    exitPkBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [exitPkBtn setTitle:kLocalizationMsg(@"退出") forState:UIControlStateNormal];
    [exitPkBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [exitPkBtn setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
    [exitPkBtn addTarget:self action:@selector(pkIconClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:exitPkBtn];
    
    [exitPkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 22));
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(15);
    }];
}

- (UILabel *)timeL{
    if (!_timeL) {
        UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"voice_Pk_timeBg"]];
        bgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(85, 20));
        }];
        
        UILabel *timeLab = [[UILabel alloc] init];
        timeLab.font = [UIFont systemFontOfSize:12];
        timeLab.textColor = kRGB_COLOR(@"#FBE99A");
        timeLab.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:timeLab];
        _timeL = timeLab;
        [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(bgView);
        }];
    }
    return _timeL;
}

///是否为左侧赢
- (void)showWinResult:(BOOL)leftWin{
    
    UIImageView *leftImgV = [[UIImageView alloc] init];
    leftImgV.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:leftImgV];
    _winImg = leftImgV;
    
    UIImageView *rightImgV = [[UIImageView alloc] init];
    rightImgV.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:rightImgV];
    _loseImg = rightImgV;
    
    CGFloat space = (self.width-71-71-self.pkProgressIcon.width-24)/4.0;
    [leftImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).mas_offset(-10);
        make.size.mas_equalTo(CGSizeMake(71, 30));
        make.left.equalTo(self).mas_offset(space+12);
    }];

    [rightImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(leftImgV);
        make.size.mas_equalTo(CGSizeMake(71, 30));
        make.right.equalTo(self).mas_offset(-(space+12));
    }];
    
    [rightImgV layoutIfNeeded];
    [leftImgV layoutIfNeeded];
    
    leftImgV.image = [UIImage imageNamed:leftWin?@"mg_pkWin_shengli":@"mg_voice_pk_shibai"];
    rightImgV.image = [UIImage imageNamed:leftWin?@"mg_voice_pk_shibai":@"mg_pkWin_shengli"];
}



#pragma mark - action -


- (void)updateMyGiftRank:(NSArray *)myItems enemyGiftRank:(NSArray *)enemyItems{
    [self.pkRankView changeGiftRank:myItems other:enemyItems];
}

- (void)showStartAmination{
    [PkStartView startWithSuperView:self];
}

- (void)reStartView{
    
    [_pkRankView changeGiftRank:@[] other:@[]];
    [_pkProgressView updateMyTotal:0 enemyTotal:0];
    
    [_loseImg removeFromSuperview];
    _loseImg = nil;
    [_winImg removeFromSuperview];
    _winImg = nil;
    
    [_timer stopTimer];
    _timer = nil;
}

- (TimerBlock *)timer{
    if (!_timer) {
        _timer = [[TimerBlock alloc] init];
    }
    return _timer;
}
///点击中间按钮 可退出
- (void)pkIconClick{
    kWeakSelf(self);
    ForceAlertController *alertVC = [ForceAlertController alertTitle:kLocalizationMsg(@"提示") message:kLocalizationMsg(@"是否确认退出PK？")];
    [alertVC addOptions:kLocalizationMsg(@"退出") textColor:ForceAlert_BlackColor clickHandle:nil];
    [alertVC addOptions:kLocalizationMsg(@"确定") textColor:ForceAlert_NormalColor clickHandle:^{
        ///取消PK
        [HttpApiHttpVoice quitPK:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                if(weakself.quitPKBlock){
                    weakself.quitPKBlock(weakself.currentPKStatus, NULL);
                }
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }];
    [[ProjConfig currentVC] presentViewController:alertVC animated:YES completion:nil];
}


- (void)showPKTitle:(NSString *)title{
    if (title.length > 0) {
        self.titleLb.hidden = NO;
        self.titleLb.text = title;
        self.titleLb.superview.hidden = NO;
    }else{
        self.titleLb.superview.hidden = YES;
        self.titleLb.hidden = YES;
        self.titleLb.text = @"";
    }
}


- (void)quitPK:(void (^)(PKProgressStatus, NSArray * _Nullable))quit{
    _quitPKBlock = quit;
}


- (void)updateMyTotal:(double)myTotal enemyTotal:(double)enemyTotal {
    [self.pkProgressView updateMyTotal:myTotal enemyTotal:enemyTotal];
    self.pkRankView.hidden = NO;
}


- (void)changePKStatus:(PKProgressStatus)pkStatus time:(int64_t)time {
    _currentPKStatus = pkStatus;
    
    switch (pkStatus) {
        case PKProgressForLoading: ///倒计时
        {
            [self reStartView];
            self.pkProgressIcon.image = [UIImage imageNamed:@"mg_PK_loading"];
        }
            break;
        case PKProgressForStart: ///开始
        {
            self.pkProgressIcon.image = [UIImage imageNamed:@"voice_pk_icon"];
        }
            break;
        case PKProgressForEnd:   ///结果。 （胜负。平局）
        {        }
            break;
        case PKProgressForStop:  ///PK终止
        {        }
            break;
        default:
            break;
    }
    
    kWeakSelf(self);
    [self.timer stopTimer];
    [self.timer startTimerForTotalTime:time IntervalTime:1.0 progress:^(CGFloat progress) {
        weakself.timeL.text = [NSString changeShowTimeForSecond:time-progress];
    } finish:^{
        weakself.timeL.text = @"00:00";
        if (pkStatus != PKProgressForStop) {
        }else{
            if (weakself.quitPKBlock) {
                weakself.quitPKBlock(weakself.currentPKStatus,NULL);
            }
        }
    }];
    
}

- (void)showPKResult:(ApiPkResultRoomModel *)pkResult assistans:(NSArray *)assistans{
    
    //    [self changePKStatus:PKProgressForEnd time:pkResult.processEndTime];
    
    kWeakSelf(self);
    if (pkResult.isWin == 0) {  ///平局
        self.pkProgressIcon.image = [UIImage imageNamed:@"mg_voice_pk_pingju"];
    }else{
        self.pkProgressIcon.image = [UIImage imageNamed:@"mg_voice_pk_chengfa"];
        
        if (_pkType == LivePKTypeForRoom) { ///房间PK
            [AudioPkWinView showRoomResult:((pkResult.isWin==1)?NO:YES)];
            [self showWinResult:((pkResult.isWin==1)?YES:NO)];
        }else{ ///其他PK
            [AudioPkWinView showWinData:pkResult.winUserAvatar username:pkResult.winUserName];
            [self showWinResult:((pkResult.isWin==1)?YES:NO)];
        }
    }
    _currentPKStatus = PKProgressForEnd;
    int64_t time = pkResult.punishTime;
    [self.timer stopTimer];
    [self.timer startTimerForTotalTime:time IntervalTime:1.0 progress:^(CGFloat progress) {
        weakself.timeL.text = [NSString changeShowTimeForSecond:time-progress];
    } finish:^{
        weakself.currentPKStatus = PKProgressForStop;
        weakself.timeL.text = @"00:00";
        if (weakself.quitPKBlock) {
            weakself.quitPKBlock(PKProgressForStop,assistans);
        }
    }];
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitV = [super hitTest:point withEvent:event];
    if (hitV == self) {
        return nil;
    }
    return hitV;
}


@end
