//
//  LiveSystemNoticeView.m
//  TCDemo
//
//  Created by CH on 2019/11/21.
//  Copyright © 2019 CH. All rights reserved.
//

#import "LiveSystemNoticeView.h"
#import <LibTools/LibTools.h>
#import <LibProjModel/KLCAppConfig.h>
#import <SDWebImage/SDWebImage.h>
#import <Masonry/Masonry.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/ApiSimpleMsgRoomModel.h>

@interface LiveSystemNoticeView ()

@property (nonatomic, weak)UILabel *systemNoticeLab;
@property (nonatomic, weak)UIView *contentBgView;

@end

@implementation LiveSystemNoticeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)showSystemNoticeModel:(ApiSimpleMsgRoomModel *)noticeModel{
    [self createUI:noticeModel.content];
}

- (void)createUI:(NSString *)notice{
    if (!_contentBgView && notice.length>0) {
        
        CGFloat textW = [notice sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}].width+3;
        CGFloat bgViewW = MIN(textW+15+8+14+14, (self.width-24));
        
        UIView *bgColorView = [[UIView alloc] initWithFrame:CGRectMake(12, 0, bgViewW, 25)];
        bgColorView.layer.masksToBounds = YES;
        bgColorView.layer.cornerRadius = 25/2.0;
        bgColorView.centerY = self.height/2.0;
        bgColorView.backgroundColor = kRGB_COLOR(@"#FFA000");
        [self addSubview:bgColorView];
        
        ///通知logo
        UIImageView *noticeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(14, 5, 15, 15)];
        noticeIcon.contentMode = UIViewContentModeScaleAspectFit;
        noticeIcon.image = [UIImage imageNamed:@"live_banner_gonggao"];
        [bgColorView addSubview:noticeIcon];
        
        ///背景
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(noticeIcon.maxX+8, 5, bgViewW-(noticeIcon.maxX+8)-14, 15)];
        bgView.clipsToBounds = YES;
        [bgColorView addSubview:bgView];
        _contentBgView = bgView;
        
        // 弹幕对应的消息文字
        UILabel *contentLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textW, bgView.height)];
        [contentLb setTextColor:[UIColor whiteColor]];
        [contentLb setFont:[UIFont systemFontOfSize:12]];
        contentLb.text = notice;
        [bgView addSubview:contentLb];
        _systemNoticeLab = contentLb;
        
    }
}


- (void)playNoticeAndFinishBlock:(void (^)(void))finishBlock{
    if (_systemNoticeLab.frame.size.width > _contentBgView.frame.size.width) {
        kWeakSelf(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
                NSTimeInterval time = weakself.systemNoticeLab.width/80 + 1.0;
                [UIView animateWithDuration:time animations:^{
            
                    CGRect rc = weakself.systemNoticeLab.frame;
                    rc.origin.x = weakself.contentBgView.width - rc.size.width;
                    weakself.systemNoticeLab.frame = rc;
                    
                } completion:^(BOOL finished) {
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        if (finishBlock) {
                            finishBlock();
                        }
                    });
                    
                }];
            
        });

    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (finishBlock) {
                finishBlock();
            }
        });
    }
    
}

@end
