//
//  O2ONearbyHeaderView.m
//  LibProjView
//
//  Created by ssssssss on 2020/9/7.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "NearbySiftHeaderView.h"
#import "NearbyGenderSiftPopView.h"
#import <Masonry.h>

@implementation NearbyHeaderSelectedBtn
{
    NSString *_currentTitle;
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.layer.cornerRadius = 15;
    self.layer.masksToBounds = YES;
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.imageView.frame.size.width, 0, self.imageView.frame.size.width)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleLabel.bounds.size.width, 0, - self.titleLabel.bounds.size.width)];
    
}
- (void)creatUI{
    self.backgroundColor = kRGB_COLOR(@"#F4F4F4");
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    

    

    [self setNeedsLayout];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    _currentTitle = title;
    if (state == UIControlStateNormal) {
        NSAttributedString *attrStr = [title attachmentForImage:[UIImage imageNamed:@"nearby_lay_down_arrow_black"] bounds:CGRectMake(0, 2, 10, 6) before:NO textFont:[UIFont systemFontOfSize:13] textColor:kRGB_COLOR(@"#666666")];
        [self setAttributedTitle:attrStr forState:state];
        [self setTitleColor:kRGB_COLOR(@"#666666") forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageWithColor:kRGB_COLOR(@"#F4F4F4")] forState:UIControlStateNormal];

    }else{
        NSAttributedString *attrStr = [title attachmentForImage:[UIImage imageNamed:@"nearby_lay_down_arrow_white"] bounds:CGRectMake(0, 2, 10, 6) before:NO textFont:[UIFont systemFontOfSize:13] textColor:kRGB_COLOR(@"#FFFFFF")];
        [self setAttributedTitle:attrStr forState:state];
        [self setTitleColor:kRGB_COLOR(@"#FFFFFF") forState:UIControlStateSelected];
        [self setBackgroundImage:[UIImage createImageSize:self.size gradientColors:@[kRGB_COLOR(@"#FF54A0"),kRGB_COLOR(@"#FF6CF6")] percentage:@[@0.3,@1.0] gradientType:GradientFromTopToBottom] forState:UIControlStateSelected];
    }
}

- (void)setIsShow:(BOOL)isShow{
    _isShow = isShow;
    if (isShow) {
        self.selected = YES;
        [self setTitle:_currentTitle forState:UIControlStateSelected];
    }else{
        self.selected = NO;
        [self setTitle:_currentTitle forState:UIControlStateNormal];
    }
    [self setNeedsLayout];
}
@end




@interface NearbySiftHeaderView ()
@property (nonatomic, strong)NearbyHeaderSelectedBtn *genderBtn;
@property (nonatomic, strong)NearbyHeaderSelectedBtn *cityBtn;
@property (nonatomic, assign)BOOL isShowing;
@property (nonatomic, assign)int genderSelectedIndex;
@property (nonatomic, assign)NSInteger citySelectedIndex;
@property (nonatomic, strong)UIView *locationTipView;
@property (nonatomic, strong)NearbyGenderSiftPopView *genderSiftPopView;
@end
@implementation NearbySiftHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    self.genderSelectedIndex = 0;
    self.citySelectedIndex = 0;
    [self addSubview:self.genderBtn];
    [self addSubview:self.cityBtn];
    
    [self.cityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(15);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(30);
    }];
    [self.genderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.centerY.equalTo(self);
        make.left.equalTo(self.cityBtn.mas_right).mas_offset(20);
    }];
    [self.cityBtn layoutIfNeeded];
    [self.genderBtn layoutIfNeeded];
    
}
- (void)updateLocationTipView{
    UIView *locationTipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    locationTipView.backgroundColor = kRGB_COLOR(@"#FFEFF8");
    self.locationTipView = locationTipView ;
    [self addSubview:self.locationTipView];
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(12, 5, 20, 20)];
    imageV.image = [UIImage imageNamed:@"icon_location_tip"];
    [locationTipView addSubview:imageV];
    
    UILabel *tipL = [[UILabel alloc]initWithFrame:CGRectMake(37, 5, kScreenWidth-24-80, 20)];
    tipL.text = kLocalizationMsg(@"打开手机定位权限，发现附近好友～");
    tipL.font = [UIFont systemFontOfSize:12];
    tipL.textAlignment = NSTextAlignmentLeft;
    tipL.textColor = [ProjConfig normalColors];
    [locationTipView addSubview:tipL];
    
    UIButton *locationSettingBtn = [[UIButton alloc]initWithFrame:CGRectMake(tipL.maxX+5, 3, 50, 24)];
    locationSettingBtn.backgroundColor = [ProjConfig normalColors];
    locationSettingBtn.layer.cornerRadius = 12;
    locationSettingBtn.clipsToBounds = YES;
    [locationSettingBtn setTitle:kLocalizationMsg(@"打开") forState:UIControlStateNormal];
    [locationSettingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    locationSettingBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [locationSettingBtn addTarget:self action:@selector(locationSettingBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [locationTipView addSubview:locationSettingBtn];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    self.cityBtn.y = self.locationAlways?10:40;
    self.genderBtn.y = self.locationAlways?10:40;
}

- (void)reloadShowTitleWith:(NSString *)city gender:(int)gender{
    if (![city isEqualToString:kLocalizationMsg(@"全部")] && city.length > 0) {
        [self.cityBtn setTitle:city forState:UIControlStateNormal];
    }else{
        [self.cityBtn setTitle:kLocalizationMsg(@"全部") forState:UIControlStateNormal];
    }
    
    self.genderSelectedIndex = gender;
    if (gender > 0) {
        [self.genderBtn setTitle:[ProjConfig getGenderName:gender] forState:UIControlStateNormal];
    }else{
        [self.genderBtn setTitle:kLocalizationMsg(@"不限性别") forState:UIControlStateNormal];
    }
    self.cityBtn.isShow = NO;
}
- (void)setLocationAlways:(BOOL)locationAlways{
    _locationAlways = locationAlways;
    [self setNeedsLayout];
    [self.locationTipView removeAllSubViews];
    [self.locationTipView removeFromSuperview];
    if (!locationAlways) {
        [self updateLocationTipView];
    }
     
}
- (void)locationSettingBtnClick:(UIButton *)btn{
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
    
}

#pragma mark - lazy load
- (UIButton *)cityBtn{
    if (!_cityBtn) {
        _cityBtn = [[NearbyHeaderSelectedBtn alloc]initWithFrame:CGRectMake(15, 0, 120, 30)];
        _cityBtn.centerY = self.height/2.0;
        [_cityBtn setTitle:kLocalizationMsg(@"全部") forState:UIControlStateNormal];
        [_cityBtn addTarget:self action:@selector(cityBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _cityBtn.clipsToBounds = YES;
        _cityBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _cityBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 20);
    }
    return _cityBtn;
}
- (UIButton *)genderBtn{
    if (!_genderBtn) {
        _genderBtn = [[NearbyHeaderSelectedBtn alloc]initWithFrame:CGRectMake(self.cityBtn.maxX+20, 0, 120, 30)];
        _genderBtn.centerY = self.height/2.0;
        [_genderBtn setTitle:kLocalizationMsg(@"不限性别") forState:UIControlStateNormal];
        _genderBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_genderBtn addTarget:self action:@selector(genderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _genderBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 20);
    }
    return _genderBtn;
}

- (void)genderBtnClick:(NearbyHeaderSelectedBtn *)btn{
   // NSLog(@"过滤文字性别选择"));
    self.cityBtn.isShow = NO;
    [self cityViewDismiss];
    btn.isShow = !btn.isShow;
    kWeakSelf(self);
    if (btn.isShow) {
        [NearbyGenderSiftPopView showView:self.superVc.view pointY:self.y+self.height gender:self.genderSelectedIndex callBack:^(BOOL selected,BOOL isInit, int gender, NearbyGenderSiftPopView * _Nonnull showView) {
            if (isInit) {
                 weakself.genderSiftPopView = showView;
            }else{
                if (selected) {
                    NSString *genderStr = @"";
                    if (gender == 0) {
                        genderStr = kLocalizationMsg(@"不限性别");
                    }else if(gender == 1){
                        genderStr = kLocalizationMsg(@"男");
                    }else{
                        genderStr = kLocalizationMsg(@"女");
                    }
                    [weakself.genderBtn setTitle:genderStr forState:UIControlStateNormal];
                    weakself.genderSelectedIndex = gender;
                    if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(NearbySiftHeaderViewGenderSelected:selectedGender:)]) {
                        [weakself.delegate NearbySiftHeaderViewGenderSelected:weakself selectedGender:gender];
                    }
                }
                 btn.isShow = NO;
            }
        }];
    }else{
         [self genderViewDismiss];
    }
}
- (void)cityBtnClick:(NearbyHeaderSelectedBtn *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(NearbySiftHeaderViewCitySelected:)]) {
        self.genderBtn.isShow = NO;
        btn.isShow = YES;
        [self genderViewDismiss];
        [self.delegate NearbySiftHeaderViewCitySelected:self];
    }
}

- (void)genderViewDismiss{
    if (self.genderSiftPopView) {
           [self.genderSiftPopView dismiss:NO gender:0];
           [self.genderSiftPopView removeFromSuperview];
       }
}
- (void)cityViewDismiss{
    //待开发
}
@end
