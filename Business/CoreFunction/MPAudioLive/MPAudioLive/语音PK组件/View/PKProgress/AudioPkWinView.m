//
//  AudioPkWinView.m
//  MPVoiceLive
//
//  Created by CH on 2019/12/20.
//  Copyright © 2019 Orely. All rights reserved.
//

#import "AudioPkWinView.h"
#import <LibProjBase/ProjConfig.h>
#import <Masonry/Masonry.h>
#import <LiveCommon/liveManager.h>
#import <LibTools/LibTools.h>
#import <SDWebImage/SDWebImage.h>

@interface AudioPkWinView()

@property (nonatomic, weak)UIImageView *userIconImgV;

@property (nonatomic, weak)UILabel *userNameL;

@end


@implementation AudioPkWinView

+ (void)showWinData:(NSString *)userIcon username:(NSString *)name{
    UIView *selfV = [PopupTool getPopupViewForClass:self];
    if (!selfV) {
        AudioPkWinView *winView = [[AudioPkWinView alloc] init];
        [[PopupTool share] createPopupViewWithLinkView:winView allowTapOutside:YES];
        [winView createUI];
    
        [winView.userIconImgV sd_setImageWithURL:[NSURL URLWithString:userIcon] placeholderImage:[ProjConfig getDefaultImage]];
        winView.userNameL.text = name;
    }
}


+ (void)showRoomResult:(BOOL)blueWin{
    UIView *selfV = [PopupTool getPopupViewForClass:self];
    if (!selfV) {
        AudioPkWinView *winView = [[AudioPkWinView alloc] init];
        [[PopupTool share] createPopupViewWithLinkView:winView allowTapOutside:YES];
        [winView createUI];
    
        winView.userIconImgV.backgroundColor = kRGB_COLOR(@"#E2DAFF");
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.font = [UIFont boldSystemFontOfSize:15];
        titleLab.textColor = blueWin?kRGB_COLOR(@"#A0C8FA"):kRGB_COLOR(@"#F2A9EB");
        titleLab.text = blueWin?kLocalizationMsg(@"蓝方"):kLocalizationMsg(@"红方");
        [winView.userIconImgV addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(titleLab.superview);
        }];
        winView.userNameL.text = nil;
    }
}

- (void)createUI{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(188, 209));
        make.center.equalTo(self.superview);
    }];
    
    ///背景图
    UIImageView *bgImageView = [[UIImageView alloc] init];
    [bgImageView setImage:[UIImage imageNamed:@"mg_pkWin_bg"]];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    ///win
    UIImageView *titleImageView = [[UIImageView alloc] init];
    [titleImageView setImage:[UIImage imageNamed:@"mg_pkWin_shengli"]];
    titleImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:titleImageView];
    
    
    UIImageView *userIcon = [[UIImageView alloc] init];
    userIcon.layer.masksToBounds = YES;
    userIcon.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:userIcon];
    _userIconImgV = userIcon;
    
    UILabel *nameL = [[UILabel alloc] init];
    nameL.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    nameL.textColor = [UIColor whiteColor];
    [self addSubview:nameL];
    _userNameL = nameL;
    
    [titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(91, 39));
        make.top.equalTo(self).offset(19);
        make.centerX.equalTo(self);
    }];

    [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(titleImageView.mas_bottom).offset(17);
        make.size.mas_equalTo(CGSizeMake(76, 76));
    }];
    
    [nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userIcon.mas_bottom).offset(19);
        make.centerX.equalTo(userIcon);
    }];
    
    [userIcon layoutIfNeeded];
    userIcon.layer.cornerRadius = userIcon.height/2.0;
    [nameL layoutIfNeeded];
    
    kWeakSelf(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakself closePkWinView];
    });
    
}

- (void)closePkWinView{
    [[PopupTool share] closePopupView:self];
}



@end
