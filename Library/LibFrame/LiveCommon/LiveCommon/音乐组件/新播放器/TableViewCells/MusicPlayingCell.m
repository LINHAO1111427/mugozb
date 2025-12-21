//
//  MusicPlayingCell.m
//  LiveCommon
//
//  Created by klc on 2020/8/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "MusicPlayingCell.h"
#import "PlayPromptView.h"
#import <SDWebImage/SDWebImage.h>


@interface MusicPlayingCell ()

kStrong(UILabel, sortLab)

kStrong(UIImageView, coverImv)
kStrong(UIButton, coverPlayBtn)

kStrong(UILabel, nameLab)
kStrong(UILabel, authorLab)

kStrong(PlayPromptView , playingTipsGif)
kStrong(UILabel, playingTipsLab)


@end

@implementation MusicPlayingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews{
    
    UIView *contentView = self.contentView;
    
    _coverImv = [Maker Imv:nil layerCorner:4 superView:contentView constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.size.mas_equalTo(SIZE(48, 48));
        make.centerY.equalTo(contentView);
        make.left.equalTo(contentView).offset(36);
    }];
    _coverPlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_coverPlayBtn setImage:ImgNamed(@"message_play") forState:0];
    [_coverImv addSubview:_coverPlayBtn];
    [_coverPlayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.center.equalTo(_coverImv);
        make.size.mas_equalTo(SIZE(18, 18));
    }];
    
    _sortLab = [Maker labelWithShadow:NO alignment:NSTextAlignmentCenter backColor:[UIColor clearColor] text:@"" textColor:[UIColor blackColor] font:kFont(14) superView:contentView constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.left.equalTo(contentView).offset(14);
        make.centerY.equalTo(contentView);
    }];
    
    _nameLab = [Maker labelWithShadow:NO alignment:NSTextAlignmentLeft backColor:[UIColor clearColor] text:@"" textColor:[UIColor blackColor] font:kFont(14) superView:contentView constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.top.equalTo(_coverImv);
        make.left.equalTo(_coverImv.mas_right).offset(12);
        make.right.equalTo(contentView).inset(70);
    }];
    
    _authorLab = [Maker labelWithShadow:NO alignment:NSTextAlignmentLeft backColor:[UIColor clearColor] text:@"" textColor:kRGB_COLOR(@"#AAAAAA") font:kFont(13) superView:contentView constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.bottom.equalTo(_coverImv);
        make.left.equalTo(_coverImv.mas_right).offset(12);
        make.right.equalTo(contentView).inset(120);
    }];
    
    _playingTipsLab = [Maker labelWithShadow:NO alignment:NSTextAlignmentCenter backColor:[UIColor clearColor] text:kLocalizationMsg(@"正在播放") textColor:kRGB_COLOR(@"#BBBBBB") font:kFont(13) superView:contentView constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.left.equalTo(_authorLab.mas_right);
        make.centerY.equalTo(contentView);
    }];
    
    UIImageView *removeImv = [Maker Imv:ImgNamed(@"live_guanbi_gray") layerCorner:0 superView:contentView constraints:^(MASConstraintMaker * _Nonnull make) {
        
        make.centerY.equalTo(contentView);
        make.size.mas_equalTo(SIZE(15, 15));
        make.right.equalTo(contentView).inset(12);
    }];
    removeImv.backgroundColor = [UIColor clearColor];
    
    UIControl *removeControl = [[UIControl alloc] initWithFrame:CGRectZero];
    removeControl.backgroundColor = [UIColor clearColor];
    [contentView addSubview:removeControl];
    [removeControl mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(SIZE(40, 40));
        make.center.equalTo(removeImv);
    }];
    [removeControl addTarget:self action:@selector(removeAction:) forControlEvents:UIControlEventTouchUpInside];
}


-(void)removeAction:(UIControl *)sender{
    
    if (self.removeFromListHandler) {
        
        self.removeFromListHandler(_sort);
    }
}

- (void)setModel:(AppUserMusicDTOModel *)model{
    _model = model;
    [_coverImv sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"miniPlayer_music_icon"]];
    _nameLab.text = model.name;
    _authorLab.text = model.author;
}

- (void)setSort:(NSUInteger)sort{
    _sort= sort;
    _sortLab.text = kStringFormat(@"%zi",sort);
}

- (void)setIsPlaying:(BOOL)isPlaying{
    
    _isPlaying = isPlaying;
    
    if (isPlaying) {
    
        [self.playingTipsGif statAnimation];
    }else{
        
        if (_playingTipsGif) {
            
            [_playingTipsGif endAnimation];
            [_playingTipsGif removeFromSuperview];
            _playingTipsGif = nil;
        }
    }
    _playingTipsLab.hidden = !isPlaying;
    _sortLab.hidden = isPlaying;
    _coverPlayBtn.hidden = isPlaying;
}

- (PlayPromptView *)playingTipsGif{
    
    if (!_playingTipsGif) {
        
        _playingTipsGif = [[PlayPromptView alloc] initWithFrame:CGRectMake(10, 0, 16, 16) lineColor:kRGB_COLOR(@"#8A8DFF")];
        [self.contentView addSubview:_playingTipsGif];
        [_playingTipsGif mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).inset(10);
            make.size.mas_equalTo(CGSizeMake(16, 16));
            make.centerY.equalTo(self.contentView);
        }];
    }
    return _playingTipsGif;
}


- (void)setIsPause:(BOOL)isPause{
    
    _isPause = isPause;
    
    if (_playingTipsGif) {
        
        isPause?[_playingTipsGif endAnimation]:[_playingTipsGif statAnimation];
    }
    _playingTipsLab.text = isPause?kLocalizationMsg(@"暂停播放"):kLocalizationMsg(@"正在播放");
    
}
-(void)pauseMusic{
    
    
}

@end
