//
//  VertifyVideoPlayerView.m
//  MineCenter
//
//  Created by ssssssss on 2020/1/6.
//

#import "VertifyVideoPlayerView.h"
@interface VertifyVideoPlayerView()
@property (nonatomic, strong) CALayer *playerLayer;
@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIView *confirmButton;
@property (nonatomic, strong) UIButton *remakeBtn;
@end

@implementation VertifyVideoPlayerView
- (UIButton *)remakeBtn{
    if (!_remakeBtn) {
        CGFloat deta = [UIScreen mainScreen].bounds.size.width/375.0;
        CGFloat width = 40.0*deta;
        _remakeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, width+20, width)];
        [_remakeBtn setImage:[UIImage imageNamed:@"icon_authority_remake"] forState:UIControlStateNormal];
        [_remakeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_remakeBtn setTitle:kLocalizationMsg(@"重新录制") forState:UIControlStateNormal];
        _remakeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _remakeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_remakeBtn addTarget:self action:@selector(remakeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _remakeBtn.alpha = 0.0;
    }
    return _remakeBtn;
}

- (UIView *)confirmButton{
    if (!_confirmButton) {
        CGFloat deta = [UIScreen mainScreen].bounds.size.width/375.0;
        CGFloat width = 75.0*deta;
        CGFloat magin = (kScreenWidth-width)/2.0;
        _confirmButton = [[UIView alloc] initWithFrame:CGRectMake(magin, self.height-127.5-kSafeAreaBottom, width, width)];
        _confirmButton.backgroundColor = [[ProjConfig normalColors] colorWithAlphaComponent:0.8];
        _confirmButton.layer.cornerRadius = width/2.0;
        _confirmButton.clipsToBounds = YES;
        
        UIButton *conmfirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 5*width/6.0, 5*width/6.0)];
        conmfirmBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        conmfirmBtn.backgroundColor = [UIColor whiteColor];
        conmfirmBtn.center = CGPointMake(width/2.0, width/2.0);
        [conmfirmBtn setTitle:kLocalizationMsg(@"提交") forState:UIControlStateNormal];
        [conmfirmBtn setTitleColor:[ProjConfig normalColors] forState:UIControlStateNormal];
        conmfirmBtn.layer.cornerRadius = 5*width/12.0;
        conmfirmBtn.clipsToBounds = YES;
        [conmfirmBtn addTarget:self action:@selector(clickConfirm) forControlEvents:UIControlEventTouchUpInside];
        [_confirmButton addSubview:conmfirmBtn];
    }
    return _confirmButton;
}
- (CALayer *)playerLayer{
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.frame = self.bounds;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    return playerLayer;
}
- (void)showPlayerButtons{
    //提交
    [self addSubview:self.confirmButton];
    //返回
    [self addSubview:self.cancelButton];
    //重拍
    [self addSubview:self.remakeBtn];
    self.remakeBtn.centerY = self.confirmButton.centerY;
    self.remakeBtn.x = self.confirmButton.x-30-self.remakeBtn.width;
    [self initButton:self.remakeBtn];
    [UIView animateWithDuration:0.2 animations:^{
        self.confirmButton.alpha = 1;
        self.cancelButton.alpha = 1;
        self.remakeBtn.alpha = 1;
    }];
}
 
-(void)initButton:(UIButton*)btn{
    float  spacing = 10;
    CGSize imageSize = btn.imageView.frame.size;
    CGSize titleSize = btn.titleLabel.frame.size;
    CGSize textSize = [btn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    btn.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    
}

- (void)clickConfirm{
    if (self.confirmBlock) {
        self.confirmBlock();
    }
    [self.player pause];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self removeFromSuperview];
}

- (void)remakeBtnClick:(UIButton *)btn{
    if (self.remakeBlock) {
        self.remakeBlock();
    }
    
    [self.player pause];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self removeFromSuperview];
}
 

- (void)setPlayUrl:(NSURL *)playUrl{
    _playUrl = playUrl;
    if (!self.player) {
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:self.playUrl];
        _player = [AVPlayer playerWithPlayerItem:playerItem];
        [self addObserverToPlayerItem:playerItem];
    }
    [self.layer addSublayer:self.playerLayer];
    [self showPlayerButtons];
    [self.player play];
}

- (void)playbackFinished:(NSNotification *)notification{
    [self.player seekToTime:kCMTimeZero];
    [self.player play];
}

- (void)addObserverToPlayerItem:(AVPlayerItem *)playerItem{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
}

- (void)dealloc{
    [self.player pause];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
