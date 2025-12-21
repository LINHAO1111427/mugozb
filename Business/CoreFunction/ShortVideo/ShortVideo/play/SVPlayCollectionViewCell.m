//
//  SVPlayCollectionViewCell.m
//  ShortVideo
//
//  Created by KLC on 2020/6/18.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "SVPlayCollectionViewCell.h"
#import <TXImKit/TXImKit.h>
#import <ImageIO/ImageIO.h>
#import <LibTools/LibTools.h>
#import <SDWebImage/SDWebImage.h>
#import <AVFoundation/AVFoundation.h>

#import <LibProjBase/ProjConfig.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjBase/HttpClient.h>

#import <LibProjModel/HttpApiAppShortVideo.h>
#import <LibProjModel/ApiShortVideoDtoModel.h>

#import <LibProjView/TipAlertView.h>
#import <ShortVideo/CustomSlider.h>
#import <LibProjView/MultiGestureScrollView.h>
#import <LibProjView/ShortVideoShopPlayView.h>
#import <LibProjView/BalanceLackPromptView.h>

#import "ShortVideoCountDownView.h"

#import <ShortVideo/ShortVideoinfoView.h>
#import <ShortVideo/SVUserFaceView.h>

#import <ShortVideo/SVAdBannerView.h>
#import <ShortVideo/ShortVideoIdSaveObj.h>
#import <LibProjView/BalanceLackPromptView.h>
#import <ShortVideo/SVCoverView.h>
#import <ShortVideo/SVImageScrollV.h>

@interface SVPlayCollectionViewCell()<PlayVideoDelegate>

@property (nonatomic, strong)NSArray *assemblyArr;

///图片
@property (nonatomic, strong)SVImageScrollV *imageScrollV;

///视频
@property (nonatomic, weak) CustomSlider *videoSliderView;
@property (nonatomic, weak) ShortVideoCountDownView *countDownView;

///蒙层
@property (nonatomic, strong)SVCoverView *coverLayerV;


@property (nonatomic, weak)ShortVideoinfoView *videoInfoV; ///视频信息
@property (nonatomic, weak)SVUserFaceView *userFaceV;   ///用户信息信息


@property (nonatomic, weak)SVAdBannerView *adBannerV;   ///广告

///用户是否取消了登录
@property (nonatomic, assign)BOOL userCancelLogin;


@end

@implementation SVPlayCollectionViewCell


- (void)dealloc
{
    [self stopPlayVideo];
}

- (SVCoverView *)coverLayerV{
    if (!_coverLayerV) {
        kWeakSelf(self);
        _coverLayerV = [[SVCoverView alloc]initWithFrame:self.bounds];
        _coverLayerV.hidden = YES;
        _coverLayerV.lockBtnClick = ^{
            if (![ProjConfig isUserLogin]) {
                [RouteManager routeForName:RN_login_ShowLoginVC currentC:weakself.superVc];
                weakself.userCancelLogin = YES;
            }else{
                [weakself showPayTip];
            }
        };
    }
    return _coverLayerV;
}

- (SVImageScrollV *)imageScrollV{
    if (!_imageScrollV) {
        _imageScrollV = [[SVImageScrollV alloc] initWithFrame:self.bounds];
        _imageScrollV.backgroundColor = [UIColor clearColor];
    }
    return _imageScrollV;
}

- (SVAdBannerView *)adBannerV{
    if (!_adBannerV) {
        kWeakSelf(self);
        SVAdBannerView *adbannerV = [[SVAdBannerView alloc] initWithFrame:CGRectMake(0, kNavBarHeight+5, kScreenWidth, kScreenWidth/5.0)];
        [self.contentView addSubview:adbannerV];
        adbannerV.adItemClick = ^(NSString * _Nonnull url) {
            if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(playCell:adsUrl:)]) {
                [weakself.delegate playCell:weakself adsUrl:url];
            }
        };
        _adBannerV = adbannerV;
    }
    return _adBannerV;
}

- (PlayVideoView *)playVideoView{
    if (!_playVideoView) {
        _playVideoView = [[PlayVideoView alloc] initWithFrame:self.bounds];
        _playVideoView.clipsToBounds = YES;
        _playVideoView.delegate = self;
        ShortVideoCountDownView *countV = [[ShortVideoCountDownView alloc] initWithFrame:CGRectMake(10, kNavBarHeight+(kScreenWidth/5.0), 81, 81)];
        [_playVideoView addSubview:countV];
        countV.lastTimeL.text = 0;
        countV.hidden = YES;
        _countDownView = countV;
    }
    return _playVideoView;
}

- (ShortVideoinfoView *)videoInfoV{
    if (!_videoInfoV) {
        ShortVideoinfoView *videoInfo = [[ShortVideoinfoView alloc] initWithFrame:self.bounds];
        kWeakSelf(self);
        videoInfo.userAvaterClick = ^{
            if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(playCell:showUserInfo:)]) {
                [weakself.delegate playCell:weakself showUserInfo:weakself.model.userId];
            }
        };
        videoInfo.userTagClick = ^(NSInteger tagid, NSString * _Nonnull tagName) {
            if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(playCell:shortVideoTagId:tagLabel:)]) {
                [weakself.delegate playCell:weakself shortVideoTagId:tagid tagLabel:tagName];
            }
        };
        videoInfo.adsClick = ^{
            if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(playCell:adsUrl:)]) {
                [weakself.delegate playCell:weakself adsUrl:weakself.model.adsUrl];
            }
        };
        videoInfo.goodsClick = ^{
            if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(playCell:showGoods:)]) {
                [weakself.delegate playCell:self showGoods:weakself.model.productId];
            }
        };
        [self addSubview:videoInfo];
        _videoInfoV = videoInfo;
    }
    return _videoInfoV;
}

- (SVUserFaceView *)userFaceV{
    if (!_userFaceV) {
        SVUserFaceView *userFace = [[SVUserFaceView alloc] initWithFrame:self.bounds];
        kWeakSelf(self);
        userFace.userAvaterClick = ^(int64_t userId) {
            if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(playCell:showUserInfo:)]) {
                [weakself.delegate playCell:weakself showUserInfo:userId];
            }
        };
        userFace.otoCallClick = ^{
            if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(playCell:otoVideoCall:)]) {
                [weakself.delegate playCell:weakself otoVideoCall:weakself.model];
            }
        };
        userFace.adItemClick = ^(NSString * _Nonnull url) {
            if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(playCell:adsUrl:)]) {
                [weakself.delegate playCell:weakself adsUrl:url];
            }
        };
        userFace.removeBtnClick = ^{
            if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(playCell:removeVideoId:)]) {
                [weakself.delegate playCell:weakself removeVideoId:weakself.model.id_field];
            }
        };
        [self addSubview:userFace];
        _userFaceV = userFace;
    }
    return _userFaceV;
}

- (CustomSlider *)videoSliderView{
    if (!_videoSliderView && _playVideoView) {
        CustomSlider *sliderV = [[CustomSlider alloc] init];
        [_playVideoView addSubview:sliderV];
        [sliderV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.playVideoView);
            make.left.equalTo(self.playVideoView).mas_offset(-15);
            make.bottom.equalTo(self.playVideoView).mas_equalTo(((self.playVideoView.height > (kScreenHeight-5))?-kSafeAreaBottom:0.5)+13);
            make.height.mas_equalTo(30);
        }];
        [sliderV addTarget:self action:@selector(changeVideoPlayTime:) forControlEvents:UIControlEventValueChanged];
        _videoSliderView = sliderV;
    }
    return _videoSliderView;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    self.backgroundColor = [UIColor blackColor];
}

- (void)setModel:(ApiShortVideoDtoModel *)model{
    _model = model;
    [self.contentView removeAllSubViews];
    self.userCancelLogin = NO;
    [_playVideoView stop];
    
    [_playVideoView removeFromSuperview];
    _playVideoView = nil;
    [_videoSliderView removeFromSuperview];
    _videoSliderView = nil;
    
    if (model.type == 1) {
        [self.contentView insertSubview:self.playVideoView atIndex:5];
        if (model.videoUrl.length > 0 ) {
            kWeakSelf(self);
            [self getVideoSize:model callback:^(BOOL success) {
                [weakself showThumb];
            }];
        }else{
            [self showThumb];
        }
    }else{
        
        [self.contentView insertSubview:self.imageScrollV atIndex:5];
        [self showImageV];
    }
    
    [self.coverLayerV removeFromSuperview];
    _coverLayerV = nil;
    
    
    [self.contentView insertSubview:self.coverLayerV atIndex:6];
    [self.contentView insertSubview:self.adBannerV atIndex:7];
    
    if (model.type == 2) {
        self.coverLayerV.hidden = NO;
        self.coverLayerV.marskBlur.hidden = NO;
        self.coverLayerV.lockBtn.hidden = YES;
        ///播放并且判读为不显示提示
        [self playVideoForJudgeShowInfo:NO];
    }
    
    if (model) {
        [self.videoInfoV layerLevel:8 withModel:model indexP:self.indexPath dataType:self.dataType];
        [self.userFaceV layerLevel:9 withModel:model indexP:self.indexPath dataType:self.dataType];
    }

}


- (void)showThumb{
    if ((_model.width > _model.height)|| kISiPAD) {
        self.playVideoView.imageModeAspectFill = NO;
    }else{
        if ([[ProjConfig getAppVerticalVideoGravity] isEqualToString:@"AVLayerVideoGravityResizeAspectFill"]) {
            self.playVideoView.imageModeAspectFill = YES;
        }else{
            self.playVideoView.imageModeAspectFill = NO;
        }
    }
    self.playVideoView.preview = (self.model.thumb.length > 0)?_model.thumb:@"";
}


- (void)getVideoSize:(ApiShortVideoDtoModel *)model callback:(void(^)(BOOL success))callback{
    [HttpClient requestGETWithPath:[NSString stringWithFormat:@"%@?avinfo",model.videoUrl] Param:nil success:^(id  _Nonnull dataBody) {
        if (![dataBody isKindOfClass:[NSError class]]) {
            NSDictionary *dic = dataBody;
            NSArray *arr = dic[@"streams"];
            
            for (NSDictionary *streamDic in arr) {
        
                CGFloat videoW = [streamDic[@"coded_width"] floatValue];
                CGFloat videoH = [streamDic[@"coded_height"] floatValue];
                NSDictionary *tags = streamDic[@"tags"];
                int rotate = [tags[@"rotate"] intValue];
                int direction = rotate/90;
                
                if (direction % 2 != 0) {
                    CGFloat tempF = videoW;
                    videoW = videoH;
                    videoH = tempF;
                }
                
                if (videoW > 0 && videoH > 0) {
                    model.width = videoW;
                    model.height = videoH;
                }
            }
            callback(YES);
        }else{
            callback(NO);
        }
    } failed:^(NSString * _Nonnull error) {
        callback(NO);
    }];
}

#pragma mark - 播放状态
///判断用户权限，是否显示图片或者视频，  showHint：是否显示提示
- (void)playVideoForJudgeShowInfo:(BOOL)showHint{
    if (self.userCancelLogin) {
        ///用户取消了登录，就不播放了
        return;
    }
    kWeakSelf(self);
    [self get_SV_canPlay:^(BOOL success) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (weakself.model.type == 2) {//图片
                weakself.coverLayerV.marskBlur.hidden = success;
            }
            weakself.coverLayerV.hidden = success;
            weakself.coverLayerV.lockBtn.hidden = success;
        });
        ///成功+视频
        if (success && weakself.model.type == 1) {
            weakself.countDownView.hidden = YES;
            [weakself playVideo];
        }
        ///失败
        if (!success && showHint) {
            [weakself showPayTip];//提示收费
        }
        
        [weakself updatePlayNum];
    }];
    
    self.adBannerV.adList = self.model.adsBannerList;
}


- (void)changePlayStaus{
    if (self.playVideoView.isPlaying) {
        [self pauseVideo];
    }else{
        [self resumeVideo];
    }
}
- (void)startPlayVideo{
    [self playVideoForJudgeShowInfo:YES];
}

- (void)pauseVideo{
    if (self.model.type == 1) {
        self.isPausePlay = YES;
        if (self.videoSliderView.value > 0) {
            [self.playVideoView pause];
        }else{
            [self.playVideoView stop];
        }
    }
}
- (void)resumeVideo{
    if (self.userCancelLogin) {
        ///用户取消了登录，就不播放了
        return;
    }
    if (self.model.type == 1) {
        self.isPausePlay = NO;
        if (self.videoSliderView.value > 0) {
            [self.playVideoView resume];
        }else{
            [self startPlayVideo];
        }
         
    }
}
- (void)stopPlayVideo{
    if (self.model.type == 1) {//视频
        self.isPausePlay = YES;
        self.userCancelLogin = NO;
        [self.playVideoView stop];
        [self.adBannerV stopScroll];
    }
}

- (void)changeVideoPlayTime:(CustomSlider *)slider{
    [self.playVideoView seekTime:slider.value];
}

////更新用户播放次数
- (void)updatePlayNum{
    [HttpApiAppShortVideo addShortVideoWatchNum:self.model.id_field callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
    }];
}

#pragma mark - 可显示控制
///图片
- (void)showImageV{
    [self.imageScrollV removeAllSubViews];
    [self.imageScrollV showImages:self.model.images];
}

///视频(必须能播放)
- (void)playVideo{
    self.coverLayerV.hidden = YES;
    
    if (self.playVideoView.isPlaying) {
        [self stopPlayVideo];
    }
    if (self.model.videoUrl.length == 0) {
        return;
    }
   // NSLog(@"过滤文字播放视频地址:%@"),self.model.videoUrl);
    
    self.isPausePlay = !self.playVideoView.isPlaying;
    [self.playVideoView playVideo:_model.videoUrl];
}





///获取当前视频是否可看
- (void)get_SV_canPlay:(void(^)(BOOL success))callback{
    __block int type = 1;
    if (self.model.userId ==  [ProjConfig userId]) {
        type = -2;
        callback(YES);
        return;
    }else{
        __block NSInteger freeNum = [[NSUserDefaults standardUserDefaults] integerForKey:@"short_video_free_num"];
        if (self.model.isPay) {
            type = -1;//已支付
            //            // NSLog(@"过滤文字已支付"));
            callback(YES);
        }else{
            if (!self.model.isPrivate) {
                type = -1;//不是私密
            }else{
                if (freeNum > 0) {
                    type = 0;//有免费次数
                }else{
                    if (_model.type == 1 && _model.shortVideoTrialTime > 0) {  ///视频 并且有试看时长
                        callback(YES);
                    }else{ ///图片或者无试看
                        callback(NO);
                    }
                    return;
                }
            }
            
            [self shortVideoReadWithType:type callBack:^(int code) {
                if (code == 1) {
                    if (type == 0) {
                        [[NSUserDefaults standardUserDefaults] setInteger:freeNum-1 forKey:@"short_video_free_num"];
                    }
                    callback(YES);
                }else{
                    callback(NO);
                }
            }];
            
        }
    }
}


- (void)shortVideoReadWithType:(int)type callBack:(void(^)(int code))callback{
    kWeakSelf(self);
    [HttpApiAppShortVideo useReadShortVideoNumber:self.model.id_field type:type callback:^(int code, NSString *strMsg, ApiBaseEntityModel *model) {
        if(code == 1){
            if (type == 0) {
                [ShortVideoIdSaveObj ArchiveShortVideoWith:self.model.id_field];
            }
            callback(model.code);
            
            if (model.code == 1) {
                
                weakself.model.isPay = 1;
                
            }else if(model.code == 3) {
                
                [BalanceLackPromptView gotoRecharge:nil];
            }
        }else{
            callback(0);
        }
    }];
}


///显示付费提示
- (void)showPayTip{
    kWeakSelf(self);
    void(^isPlayBlock)(BOOL) = ^(BOOL isPlay){
        if (isPlay) {
            weakself.model.isPay = 1;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakself.coverLayerV.hidden = YES;
                weakself.countDownView.hidden = YES;
                if (weakself.videoSliderView.value > 0) {
                    [weakself.playVideoView resume];
                }else{
                    [weakself startPlayVideo];//播放
                }
            });
        }
    };
    [RouteManager routeForName:RN_shortVideo_payAlert currentC:[ProjConfig currentVC] parameters:@{@"model":_model, @"isPlayBlock":isPlayBlock}];
}



#pragma mark - PlayVideoDelegate -
- (void)playVideoDuration:(float)duration progress:(float)progress{
    ///试看时长
    if (_model.adsType == 0) { ///不是广告
        if (_model.userId != [KLCUserInfo getUserId] && _model.isPay == 0 && self.model.isPrivate == 1) {
            _videoSliderView.userInteractionEnabled = NO;
            int lastTime = _model.shortVideoTrialTime - (int)progress;
            self.countDownView.lastTimeL.text = [NSString stringWithFormat:@"%d",lastTime];
            self.countDownView.hidden = NO;
            if (lastTime <= 0) {
                [self.playVideoView pause];
                self.coverLayerV.hidden = NO;
                self.coverLayerV.marskBlur.hidden = NO;
                self.coverLayerV.lockBtn.hidden = NO;
                
                [self showPayTip];
            }
        }else{
            _videoSliderView.userInteractionEnabled  = YES;
        }
    }else{
        _videoSliderView.userInteractionEnabled  = NO;
    }
    
    
    ///设置进度条
    if (self.videoSliderView.state == UIControlStateNormal) {
        ///设置slider
        if (duration > 0) {
            self.videoSliderView.maximumValue = duration;
            self.videoSliderView.minimumValue = 0.0;
            [self.videoSliderView setValue:progress];
        }else{
            self.videoSliderView.maximumValue = 1.0;
            self.videoSliderView.minimumValue = 0.0;
            [self.videoSliderView setValue:0];
        }
    }
}




@end
