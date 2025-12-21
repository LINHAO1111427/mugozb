//
//  PlayerVolumeView.m
//  LiveCommon
//
//  Created by klc on 2020/8/20.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "PlayerVolumeView.h"
#import <LibTools/LibTools.h>
#import <LibProjView/FunctionSheetBaseView.h>

@interface PlayerVolumeView ()

@property (nonatomic, copy)void (^volumeBlock)(int);

@end

@implementation PlayerVolumeView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

+ (void)showCurrentVolume:(int)volume changeVolume:(void (^)(int))block{
    
    PlayerVolumeView *volumeView = [[PlayerVolumeView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 108)];
    volumeView.volumeBlock = block;
    [FunctionSheetBaseView showTitle:kLocalizationMsg(@"音量调节") detailView:volumeView cover:NO];
    [volumeView setupSubs:volume];
}




-(void)setupSubs:(int)value{
        
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectZero];
    [self addSubview:slider];
    slider.minimumValue = 0;
    slider.maximumValue = 100;
    slider.value  = value;
    slider.minimumTrackTintColor = kRGB_COLOR(@"#8A8DFF");
    slider.maximumTrackTintColor = kRGB_COLOR(@"#EEEEEE");
    [slider setThumbImage:ImgNamed(@"player_volume_slider") forState:0];
    [slider addTarget:self action:@selector(sliderDidSlide:) forControlEvents:UIControlEventValueChanged];
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(35);
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(30);
        make.height.mas_equalTo(30);
    }];
}


-(void)sliderDidSlide:(UISlider *)sender{
    
    if (self.volumeBlock) {
        self.volumeBlock((int)sender.value);
    }
}


@end
