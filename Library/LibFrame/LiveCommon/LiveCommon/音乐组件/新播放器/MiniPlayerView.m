//
//  MiniPlayerView.m
//  LiveCommon
//
//  Created by klc on 2020/8/20.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "MiniPlayerView.h"
#import <SDWebImage/SDWebImage.h>
#import "LibProjBase/ProjConfig.h"
#import <LibProjModel/AppUserMusicDTOModel.h>

#import <LibTools/LibTools.h>

@interface MiniPlayerView ()


@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)UIButton *modeBtn;//播放模式

@property(nonatomic,strong)UIButton *lastBtn;//上一首

@property(nonatomic,strong)UIButton *playBtn;

@property(nonatomic,strong)UIButton *nextBtn;//下一首

@property(nonatomic,strong)UIButton *volumeBtn;//音量

@property(nonatomic,strong)UIButton *listBtn;//播放列表

@property(nonatomic,strong)UIButton *closeBtn;


@end


@implementation MiniPlayerView{
    
    CAGradientLayer *gLayer;
}

- (void)dealloc
{
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 18;
        [self setupSubs];
    }
    return self;
}

-(void)setupSubs{
    
    gLayer = [CAGradientLayer layer];
    gLayer.colors = @[(id)[UIColor blackColor].CGColor,(id)[UIColor blackColor].CGColor,(id)[UIColor whiteColor].CGColor,(id)[UIColor blackColor].CGColor,(id)[UIColor blackColor].CGColor];
    gLayer.locations = @[@0,@0.25,@0.5,@0.75,@1];
    gLayer.startPoint = POINT(0, 0);
    gLayer.endPoint = POINT(1, 1);
    gLayer.frame = CGRectMake(0, 0, 36, 36);
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:gLayer.bounds cornerRadius:18].CGPath;
    gLayer.mask = shapeLayer;
    [self.layer addSublayer:gLayer];
    
    _iconView = [Maker Imv:nil layerCorner:14 superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.size.mas_equalTo(SIZE(28, 28));
        make.centerY.equalTo(self);
        make.top.left.equalTo(self).offset(4);
    }];
    
    _modeBtn = [self btnWithImgStr:@"miniPlayer_loop" constraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_iconView.mas_right).offset(6);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [_modeBtn addTarget:self action:@selector(modeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _lastBtn = [self btnWithImgStr:@"miniPlayer_previous" constraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_modeBtn.mas_right).offset(2);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [_lastBtn addTarget:self action:@selector(previousBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _playBtn = [self btnWithImgStr:@"miniPlayer_pause" constraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_lastBtn.mas_right).offset(2);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [_playBtn setImage:ImgNamed(@"miniPlayer_play") forState:UIControlStateSelected];
    [_playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _nextBtn = [self btnWithImgStr:@"miniPlayer_next" constraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_playBtn.mas_right).offset(2);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [_nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _volumeBtn = [self btnWithImgStr:@"miniPlayer_volume" constraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_nextBtn.mas_right).offset(2);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [_volumeBtn addTarget:self action:@selector(volumeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _listBtn = [self btnWithImgStr:@"miniPlayer_playList" constraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_volumeBtn.mas_right).offset(2);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [_listBtn addTarget:self action:@selector(listBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line = [Maker viewWithShadow:NO backColor:kRGB_COLOR(@"#FFFFFF") superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.size.mas_equalTo(SIZE(1, 14));
        make.left.equalTo(_listBtn.mas_right).offset(2);
        make.centerY.equalTo(self);
    }];
    
    _closeBtn = [self btnWithImgStr:@"miniPlayer_close" constraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(line.mas_right).offset(2);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [_closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}



-(UIButton *)btnWithImgStr:(NSString *)str constraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make))block{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:ImgNamed(str) forState:0];
    [self addSubview:btn];
    [btn mas_makeConstraints:block];
    return btn;
}


-(void)modeBtnClick:(UIButton *)sender{
    if (self.delegate) {
        [self.delegate miniPlayerPlayModeDidChange];
    }
}

- (void)setCurrentPlayMode:(PlayMusicMode)currentPlayMode {
    
    _currentPlayMode = currentPlayMode;
    switch (currentPlayMode) {
        case playModeListLoop: ///循环播放
            {
                 [_modeBtn setImage:ImgNamed(@"miniPlayer_loop") forState:0];
            }
            break;
         case playModeRandom:  ///随机播放
             {
                  [_modeBtn setImage:ImgNamed(@"miniPlayer_random") forState:0];
             }
             break;
        case playModeOneLoop: ///单曲循环
            {
                
            }
            break;
        default:  ///playModeSquence  顺序播放
        {
            
        }
            break;
    }
}

-(void)setIsPlaying:(BOOL)isPlaying{
    
    _isPlaying = isPlaying;
    _playBtn.selected = !isPlaying;
}


#pragma mark playerPlayingDelegate
-(void)previousBtnClick:(UIButton *)sender{
    if (self.delegate) {
        
        [self.delegate miniPlayerPlayPreviousSong];
        self.isPlaying = YES;
    }
}
-(void)playBtnClick:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    if (self.delegate) {
        
        [self.delegate miniPlayerPlayStateDidChange:!sender.selected];
    }
}
-(void)nextBtnClick:(UIButton *)sender{
    
    if (self.delegate) {
        
        [self.delegate miniPlayerPlayNextSong];
        self.isPlaying = YES;
    }
}

#pragma mark playerManageDelegate
-(void)volumeBtnClick:(UIButton *)sender{
    
    if (self.manageDelegate) {
    
        [self.manageDelegate miniPlayerWillPopVolumeView:self];
    }
}
-(void)listBtnClick:(UIButton *)sender{
    
    if (self.manageDelegate) {
    
        [self.manageDelegate miniPlayerWillPopPlayListView:self];
    }
}
-(void)closeBtnClick:(UIButton *)sender{
    
    if (self.manageDelegate) {
    
        [self.manageDelegate miniPlayerWillDismiss:self];
    }
}

- (void)setMusicModel:(AppUserMusicDTOModel *)musicModel{
    _musicModel = musicModel;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:musicModel.cover] placeholderImage:[UIImage imageNamed:@"miniPlayer_music_icon"]];
}

@end
