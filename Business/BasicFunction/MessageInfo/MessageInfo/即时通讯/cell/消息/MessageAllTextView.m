//
//  MessageAllTextView.m
//  Message
//
//  Created by klc_sl on 2021/8/6.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "MessageAllTextView.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <SDWebImage/SDWebImage.h>

@implementation MessageAllTextView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setClipsToBounds:YES];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)showMsgIsOwner:(BOOL)isOwner{
    [self cornerRadiiView:self isOnwer:isOwner];
}

//切圆角
- (void)cornerRadiiView:(UIView *)view isOnwer:(BOOL)isOnwer{
    UIRectCorner corner = (UIRectCornerBottomLeft|UIRectCornerBottomRight|UIRectCornerTopRight);
    if (isOnwer) {
        corner = (UIRectCornerBottomLeft|UIRectCornerBottomRight|UIRectCornerTopLeft);
    }
    [view cornerRadii:CGSizeMake(8, 8) byRoundingCorners:corner];
}


@end


@implementation MessageTextView

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        UILabel *contentLabel = [[UILabel alloc]init];
        contentLabel.font = [UIFont systemFontOfSize:16];
        contentLabel.textAlignment = NSTextAlignmentLeft;
        contentLabel.numberOfLines = 0;
        contentLabel.textColor = kRGB_COLOR(@"#666666");
        [self addSubview:contentLabel];
        _contentLabel = contentLabel;
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(5);
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.bottom.equalTo(self).offset(-5);
        }];
    }
    return _contentLabel;
}

- (UIImageView *)topImgV{
    if (!_topImgV) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [self addSubview:imgV];
        _topImgV = imgV;
    }
    return _topImgV;
}

- (void)showTopIsOwner:(BOOL)isOwner content:(NSString *)content isTop:(BOOL)isTop {
    [super showMsgIsOwner:isOwner];
    
    NSMutableAttributedString *attStr = [[content changeTextForCostomEmojiAndBounds:CGRectMake(0, -5, 21, 21)] mutableCopy];
    self.contentLabel.attributedText = attStr;
    
    self.topImgV.hidden = !isTop;
    self.topImgV.image = [UIImage imageNamed:isOwner?@"message_top_right":@"message_top_left"];
    [self.topImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        if (isOwner) {
            make.left.top.equalTo(self);
        }else{
            make.right.top.equalTo(self);
        }
    }];
}


@end


@implementation MessageOtoCallView

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        UILabel *contentLabel = [[UILabel alloc]init];
        contentLabel.font = [UIFont systemFontOfSize:16];
        contentLabel.textAlignment = NSTextAlignmentCenter;
        contentLabel.numberOfLines = 0;
        contentLabel.textColor = kRGB_COLOR(@"#666666");
        [self addSubview:contentLabel];
        _contentLabel = contentLabel;
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(5);
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.bottom.equalTo(self).offset(-5);
        }];
    }
    return _contentLabel;
}

- (void)showOtoCallStr:(NSString *)callStr isVideo:(BOOL)isVideo isOwner:(BOOL)isOwner{
    [super showMsgIsOwner:isOwner];
    if (isVideo) {
        self.contentLabel.attributedText = [callStr attachmentForImage:[UIImage imageNamed:@"message_shipin_black"] bounds:CGRectMake(0, -3, 18, 18) before:YES];
    }else{
        self.contentLabel.attributedText = [callStr attachmentForImage:[UIImage imageNamed:@"message_tonghua_black"] bounds:CGRectMake(0, -3, 18, 18) before:YES];
    }
}


@end


@implementation MessageAudioView

- (UIImageView *)audioImgView{
    if (!_audioImgView) {
        UIImageView *audioImgView = [[UIImageView alloc] init];
        [self addSubview:audioImgView];
        audioImgView.animationDuration = 1;
        audioImgView.animationRepeatCount = 0;
        [audioImgView stopAnimating];
        audioImgView.image = [UIImage imageNamed:@"message_play_black_1"];
        audioImgView.animationImages = @[[UIImage imageNamed:@"message_play_black_1"],[UIImage imageNamed:@"message_play_black_2"],[UIImage imageNamed:@"message_play_black_3"],[UIImage imageNamed:@"message_play_black_4"],[UIImage imageNamed:@"message_play_black_5"]];
        _audioImgView = audioImgView;
    }
    
    return _audioImgView;
}


- (UILabel *)audioTimeLabel{
    if (!_audioTimeLabel) {
        UILabel *audioTimeLabel = [[UILabel alloc]init];
        audioTimeLabel.font = [UIFont systemFontOfSize:15];
        audioTimeLabel.textAlignment = NSTextAlignmentCenter;
        audioTimeLabel.textColor = kRGB_COLOR(@"#666666");
        [self addSubview:audioTimeLabel];
        _audioTimeLabel = audioTimeLabel;
    }
    
    return _audioTimeLabel;
}


- (void)showMsgIsOwner:(BOOL)isOwner time:(nonnull NSString *)time{
    [super showMsgIsOwner:isOwner];
    
    self.audioTimeLabel.text = [NSString stringWithFormat:@"%@''",time];
    
    self.audioImgView.frame = CGRectMake(15 , 7, 20, 20);
    self.audioTimeLabel.frame = CGRectMake(40 , 7 , 50, 20);
    
    if (isOwner) {
        self.audioImgView.x = 60;
        self.audioTimeLabel.x = 15;
    }
}


@end






@implementation MessageAskGiftView

- (UIImageView *)giftImgView{
    if (!_giftImgView) {
        UIImageView *giftImgView = [[UIImageView alloc] init];
        giftImgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:giftImgView];
        _giftImgView = giftImgView;
    }
    return _giftImgView;
}


- (UILabel *)showLabel{
    if (!_showLabel) {
        UILabel *showLabel = [[UILabel alloc] init];
        showLabel.font = [UIFont systemFontOfSize:16];
        showLabel.textColor = kRGB_COLOR(@"#666666");
        showLabel.numberOfLines = 0;
        [self addSubview:showLabel];
        _showLabel = showLabel;
    }
    return _showLabel;
}


- (void)showMsgIsOwner:(BOOL)isOwner giftIcon:(NSString *)icon showStr:(NSString *)showStr {
    [super showMsgIsOwner:isOwner];
    
    self.giftImgView.frame = CGRectMake(5, 5, self.height-10, self.height-10);
    self.showLabel.frame = CGRectMake(self.height, 5, self.width-self.height, self.height-10);
    
    self.showLabel.text = showStr;
    [self.giftImgView sd_setImageWithURL:[NSURL URLWithString:icon] placeholderImage:PlaholderImage];
    
}


@end
