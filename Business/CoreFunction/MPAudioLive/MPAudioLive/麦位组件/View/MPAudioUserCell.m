//
//  MPAudioUserCell.m
//  OTMLive
//
//  Created by klc_sl on 2020/5/11.
//  Copyright © 2020 . All rights reserved.
//

#import "MPAudioUserCell.h"
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
#import <LibProjView/KlcAvatarView.h>

@interface MPAudioUserCell ()

@property (nonatomic, weak) UIImageView *micImgV;

@property (nonatomic, weak) SoundWaveView *voiceAnimation;

@property (nonatomic, weak) KlcAvatarView *avaterV;

@property (nonatomic, copy) UIColor *voiceColor;

@property (nonatomic, assign) int64_t currentUid;

@property (nonatomic, weak) EmojiPlayView *emojiView;

@property (nonatomic, assign)CGFloat proportionNum;  ///头像占比数

@end

@implementation MPAudioUserCell

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
        [self alertPermissions];
        [self createUI];
    }
    return self;
}

- (void)speakIng:(NSUInteger)volume uid:(int64_t)uid{

    ///麦位上有人，并且这个人是自己
    if (_seatModel.status) {
        if (_seatModel.uid == uid) {
            if (volume > 2) {
                [_voiceAnimation starAnimation];
            }else{
                [_voiceAnimation stopAnimation];
            }
        }
    }else{
        [_voiceAnimation stopAnimation];
    }
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    
}


- (void)alertPermissions{
    //弹出麦克风权限
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
    }];
}

- (void)createUI{
    
    UIView *centerV = [[UIView alloc] init];
    centerV.userInteractionEnabled = NO;
    [self.contentView addSubview:centerV];
    
    KlcAvatarView *avaterV = [[KlcAvatarView alloc] init];
    avaterV.userIcon.image = [UIImage imageNamed:@"mg_audio_mai"];
    avaterV.contentMode = UIViewContentModeScaleToFill;
    [centerV addSubview:avaterV];
    _avaterV = avaterV;
    
    UIImageView *mic = [[UIImageView alloc] init];
    mic.contentMode = UIViewContentModeScaleAspectFit;
    mic.image = [UIImage imageNamed:@"audio_closeMic_red"];
    mic.hidden = YES;
    [centerV addSubview:mic];
    _micImgV = mic;
    
    UILabel *nameL = [[UILabel alloc] init];
    nameL.font = [UIFont systemFontOfSize:10];
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
    [centerV addSubview:emojiView];
    _emojiView = emojiView;
    
    
    [centerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.left.equalTo(self);
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
}


- (void)setSeatModel:(ApiUsersVoiceAssistanModel *)seatModel {
    _seatModel = seatModel;
    
    [_avaterV.userIcon layoutIfNeeded];
    _avaterV.userIcon.layer.cornerRadius = self.height*_proportionNum/2.0;
    
   // NSLog(@"过滤文字%d   %@"),seatModel.no, seatModel.status?kLocalizationMsg(@"有人"):kLocalizationMsg(@"无人"));
    
    if (seatModel.status) { ///有人
        
        NSString *colorHex = seatModel.sex == 2?@"#FF5EC6":@"#00AAEE";
        ///性别1男2女3其他
        Class<MPLiveInterface> cls = [LiveManager liveInfo].mpViewConfig;
        if ([cls respondsToSelector:@selector(soundWaveColor:)]) {
            colorHex = [cls soundWaveColor:_seatModel.sex];
        }
        self.voiceAnimation.broadColorRGB = kRGB_COLOR(colorHex);
        
        _currentUid = seatModel.uid;
        [_avaterV showUserIconUrl:seatModel.avatar vipBorderUrl:seatModel.avatarFrame];
        _micImgV.hidden = seatModel.onOffState?YES:NO;
        if (seatModel.appStrickerVO.gifUrl.length > 0) {
            [self.emojiView stopAnimation];
            [self.emojiView playAnimation:seatModel.appStrickerVO.gifUrl playTime:seatModel.appStrickerVO.gifDuration];
        }
    }else{  ///无人
        [_avaterV showUserIconUrl:nil vipBorderUrl:nil];
        _avaterV.userIcon.image = [UIImage imageNamed:seatModel.retireState?@"mg_audio_mai":@"mg_audio_suo"];
        
        [_voiceAnimation stopAnimation];
        [_voiceAnimation removeFromSuperview];
        _currentUid = 0;
        _micImgV.hidden = YES;
        [_emojiView stopAnimation];

    }
}


- (SoundWaveView *)voiceAnimation{
    
    if (!_voiceAnimation) {
        
        SoundWaveView *animationView = [[SoundWaveView alloc] init];
        [_avaterV.superview addSubview:animationView];
        [_avaterV.superview sendSubviewToBack:animationView];
        _voiceAnimation = animationView;

        [animationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_avaterV);
            make.height.width.equalTo(_avaterV).multipliedBy(1.30);
        }];
            
        [animationView layoutIfNeeded];
    }
    return _voiceAnimation;
}



@end
