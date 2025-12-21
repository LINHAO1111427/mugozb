//
//  AudioPkFinishView.m
//  MPVoiceLive
//
//  Created by SL on 2019/12/20.
//  Copyright © 2019 Orely. All rights reserved.
//

#import "AudioPkFinishView.h"
#import <LibProjBase/ProjConfig.h>
#import <Masonry/Masonry.h>
#import <liveCommon/LiveManager.h>
#import <LibTools/LibTools.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjBase/PopupTool.h>

@interface AudioPkFinishView()

@property (nonatomic, copy)TimerBlock *timer;

@property (nonatomic, copy)void (^selectBlock)(BOOL);

@end


@implementation AudioPkFinishView

+ (void)showFinishView:(void (^)(BOOL))block{
    UIView *selfV = [PopupTool getPopupViewForClass:self];
    if (!selfV) {
        AudioPkFinishView *winView = [[AudioPkFinishView alloc] init];
        winView.selectBlock = block;
        [[PopupTool share] createPopupViewWithLinkView:winView allowTapOutside:NO];
        [winView createUI];
    }
}

- (TimerBlock *)timer{
    if (!_timer) {
        _timer = [[TimerBlock alloc] init];
    }
    return _timer;
}

- (void)createUI{
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 220));
        make.center.equalTo(self.superview);
    }];
    
    ///背景图
    UIImageView *bgImageView = [[UIImageView alloc] init];
    [bgImageView setImage:[UIImage imageNamed:@"mg_pk_finish_bg"]];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UILabel *titleL  = [[UILabel alloc] init];
    titleL.text = kLocalizationMsg(@"房间PK结束，5秒退出PK");
    titleL.font = [UIFont systemFontOfSize:12];
    titleL.textColor = [UIColor whiteColor];
    [self addSubview:titleL];
    
    UILabel *secondL = [[UILabel alloc] init];
    secondL.font = [UIFont systemFontOfSize:66 weight:(UIFontWeightBold)];
    secondL.textColor = [UIColor whiteColor];
    [self addSubview:secondL];
    
    UIButton *quitBtn = [UIButton buttonWithType:0];
    quitBtn.layer.masksToBounds = YES;
    [quitBtn setTitle:kLocalizationMsg(@"退出PK") forState:UIControlStateNormal];
    quitBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [quitBtn setBackgroundImage:[UIImage imageNamed:@"mg_pk_finish_exitBtn"] forState:UIControlStateNormal];
    [quitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [quitBtn addTarget:self action:@selector(quitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:quitBtn];
    
    UIButton *reStartBtn = [UIButton buttonWithType:0];
    [reStartBtn setTitle:kLocalizationMsg(@"重新开始") forState:UIControlStateNormal];
    reStartBtn.layer.masksToBounds = YES;
    reStartBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [reStartBtn setBackgroundColor:[UIColor whiteColor]];
    [reStartBtn setTitleColor:kRGB_COLOR(@"#F937D8") forState:UIControlStateNormal];
    [reStartBtn addTarget:self action:@selector(reStartBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:reStartBtn];
    
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(25);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(15);
    }];

    [secondL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];

    [quitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(68, 30));
        make.left.equalTo(self).mas_offset(17);
        make.bottom.equalTo(self).mas_offset(-20);
    }];
    
    [reStartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(68, 30));
        make.right.equalTo(self).mas_offset(-17);
        make.centerY.equalTo(quitBtn);
    }];
    
    [quitBtn layoutIfNeeded];
    quitBtn.layer.cornerRadius = quitBtn.height/2.0;
    [reStartBtn layoutIfNeeded];
    reStartBtn.layer.cornerRadius = quitBtn.height/2.0;
    
    kWeakSelf(secondL);
    kWeakSelf(self);
    [self.timer startTimerForTotalTime:5 IntervalTime:1.0 progress:^(CGFloat progress) {
        weaksecondL.text = [NSString stringWithFormat:@"%.0f",5-progress];
    } finish:^{
        [weakself closePkWinView];
    }];
}

- (void)closePkWinView{
    if (self.selectBlock) {
        self.selectBlock(NO);
    }
    [[PopupTool share] closePopupView:self];
}

- (void)quitBtnClick{
    [self closePkWinView];
}

- (void)reStartBtnClick{
    if (self.selectBlock) {
        self.selectBlock(YES);
    }
    [[PopupTool share] closePopupView:self];
}


@end
