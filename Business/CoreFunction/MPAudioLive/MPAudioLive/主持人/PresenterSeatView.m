//
//  PresenterSeatView.m
//  OTMLive
//
//  Created by klc_sl on 2020/5/11.
//  Copyright © 2020 . All rights reserved.
//

#import "PresenterSeatView.h"
#import <AVFoundation/AVFoundation.h>
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <LibProjModel/ApiUsersVoiceAssistanModel.h>
#import <LibProjView/SoundWaveView.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjBase/ProjectCache.h>
#import "EmojiPlayView.h"
#import <LibProjModel/AppStrickerVOModel.h>
#import <AgoraExtension/AgoraExtManager.h>

@interface PresenterSeatView ()

@property (nonatomic, weak) SoundWaveView *voiceAnimation;

@property (nonatomic, copy) UIColor *voiceColor;

@property (nonatomic, assign) int64_t currentUid;

@property (nonatomic, weak) EmojiPlayView *emojiView;

@property (nonatomic, assign) CGFloat proportionNum;  ///头像占比数

@property (nonatomic, weak)UIImageView *micImgV;

@property (nonatomic, weak)UILabel *userNameL;

@property (nonatomic, weak)UILabel *hotL;

@property (nonatomic, weak)KlcAvatarView *avaterV;


@end

@implementation PresenterSeatView

- (void)dealloc
{
    [_voiceAnimation stopAnimation];
    [_voiceAnimation removeFromSuperview];
    _voiceAnimation = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _proportionNum = 0.70;
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    UIView *centerV = [[UIView alloc] init];
    [self addSubview:centerV];
    
    KlcAvatarView *avaterV = [[KlcAvatarView alloc] init];
    avaterV.userInteractionEnabled = YES;
    avaterV.userIcon.image = [UIImage imageNamed:@"mg_audio_mai"];
    [avaterV addTarget:self action:@selector(userAvaterBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [centerV addSubview:avaterV];
    _avaterV = avaterV;
    
    UIImageView *mic = [[UIImageView alloc] init];
    mic.contentMode = UIViewContentModeScaleAspectFit;
    mic.image = [UIImage imageNamed:@"audio_closeMic_red"];
    mic.hidden = YES;
    [centerV addSubview:mic];
    _micImgV = mic;
    
    UILabel *nameL = [[UILabel alloc] init];
    nameL.font = [UIFont systemFontOfSize:12];
    nameL.textColor = [UIColor whiteColor];
    nameL.textAlignment = NSTextAlignmentCenter;
    [centerV addSubview:nameL];
    _userNameL = nameL;
    
    UILabel *hotL = [[UILabel alloc] init];
    hotL.font = [UIFont systemFontOfSize:10];
    hotL.textColor = [UIColor whiteColor];
    [centerV addSubview:hotL];
    _hotL = hotL;
    
    EmojiPlayView *emojiView = [[EmojiPlayView alloc] init];
    emojiView.userInteractionEnabled = NO;
    [centerV addSubview:emojiView];
    _emojiView = emojiView;
    
    [centerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self);
        make.left.right.equalTo(self);
    }];
    
    [avaterV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerV);
        make.centerX.equalTo(centerV);
        make.height.equalTo(self.mas_height).multipliedBy(_proportionNum);
        make.width.equalTo(avaterV.mas_height);
        make.bottom.equalTo(nameL.mas_top).mas_offset(-5);
    }];
    
    [mic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.bottom.equalTo(avaterV).mas_offset(7);
        make.centerX.equalTo(avaterV).mas_offset(0);
    }];
    
    [hotL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(avaterV);
        make.bottom.equalTo(centerV);
        make.top.equalTo(nameL.mas_bottom).mas_offset(2);
    }];
    
    [nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(avaterV);
        make.left.right.equalTo(nameL.superview);
    }];
    
    [emojiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(avaterV);
        make.height.width.equalTo(avaterV).multipliedBy(1.3);
    }];
    
    [avaterV layoutIfNeeded];
    [mic layoutIfNeeded];
    
    [_avaterV.userIcon layoutIfNeeded];
    _avaterV.userIcon.layer.cornerRadius = self.height*_proportionNum/2.0;
    
}
- (void)playEmoj{
    if (self.seatModel.status) { ///有人
        if (self.seatModel.appStrickerVO.gifUrl.length > 0) {
            [self.emojiView stopAnimation];
            [self.emojiView playAnimation:self.seatModel.appStrickerVO.gifUrl playTime:self.seatModel.appStrickerVO.gifDuration];
        }
    }else{  ///无人
        [_emojiView stopAnimation];
         
    }
    
}
- (void)reloadShowInfo{
    
   // NSLog(@"过滤文字麦位%d   %@"),self.seatModel.no, self.seatModel.status?kLocalizationMsg(@"有人"):kLocalizationMsg(@"无人"));
    
    if (self.seatModel.status) { ///有人
        self.userNameL.text = self.seatModel.userName;
        [self.avaterV showUserIconUrl:self.seatModel.avatar vipBorderUrl:self.seatModel.avatarFrame];
        self.hotL.attributedText = [[NSString stringWithFormat:@"%.0lf",self.seatModel.coin] attachmentForImage:[UIImage imageNamed:@"mg_audio_hot"] bounds:CGRectMake(0, -0.6, 7, 9) before:YES];
        
        NSString *colorHex = self.seatModel.sex == 2?@"#FF5EC6":@"#00AAEE";
        ///性别1男2女3其他
        Class<MPLiveInterface> cls = [LiveManager liveInfo].mpViewConfig;
        if ([cls respondsToSelector:@selector(soundWaveColor:)]) {
            colorHex = [cls soundWaveColor:_seatModel.sex];
        }
        self.voiceAnimation.broadColorRGB = kRGB_COLOR(colorHex);
        
        _currentUid = self.seatModel.uid;
        [_avaterV showUserIconUrl:self.seatModel.avatar vipBorderUrl:self.seatModel.avatarFrame];
        _micImgV.hidden = self.seatModel.onOffState?YES:NO;
        
        kWeakSelf(self);
        [[AgoraExtManager mpAudio] anchorId:self.seatModel.uid volume:^(NSUInteger num) {
            if (num >2) {
                [weakself.voiceAnimation starAnimation];
            }else{
                [weakself.voiceAnimation stopAnimation];
            }
        }];
        
    }else{  ///无人
        
        self.userNameL.text = self.seatModel.assistanName;
        [self.avaterV showUserIconUrl:@"" vipBorderUrl:nil];
        self.hotL.attributedText = [@"0" attachmentForImage:[UIImage imageNamed:@"mg_audio_hot"] bounds:CGRectMake(0, -0.6, 7, 9) before:YES];
        
        [_avaterV showUserIconUrl:nil vipBorderUrl:nil];
        _avaterV.userIcon.image = [UIImage imageNamed:self.seatModel.retireState?@"mg_audio_mai":@"mg_audio_suo"];
        
        [_voiceAnimation stopAnimation];
        [_voiceAnimation removeFromSuperview];
        _currentUid = 0;
        _micImgV.hidden = YES;
        [_emojiView stopAnimation];
        
        [[AgoraExtManager mpAudio] anchorId:0 volume:nil];
        
    }
    
}


- (SoundWaveView *)voiceAnimation{
    if (!_voiceAnimation) {
        SoundWaveView *animationView = [[SoundWaveView alloc] init];
        [_avaterV.superview addSubview:animationView];
        [_avaterV.superview sendSubviewToBack:animationView];
        animationView.userInteractionEnabled = NO;
        _voiceAnimation = animationView;

        [animationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_avaterV);
            make.height.width.equalTo(_avaterV).multipliedBy(1.30);
        }];
            
        [animationView layoutIfNeeded];
    }
    return _voiceAnimation;
}

- (void)userAvaterBtnClick{
    if (self.userIconClick) {
        self.userIconClick();
    }
}



@end
