//
//  PresentNumShowView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/24.
//  Copyright © 2020 . All rights reserved.
//

#import "PresentNumShowView.h"
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjBase/LibProjBase.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjModel/ApiBeautifulNumberModel.h>

@interface PresentNumShowView ()

@property (nonatomic, weak)UIImageView *userIcon;  ///用户图标
@property (nonatomic, weak)UILabel *showTextL;  ///显示文字

@end

@implementation PresentNumShowView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        [self createView];
    }
    return self;
}


- (void)createView{
    
    UIImageView *bannerView = [[UIImageView alloc] init];
    bannerView.layer.masksToBounds = YES;
    bannerView.backgroundColor = [UIColor whiteColor];
    bannerView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:bannerView];
    
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.mas_equalTo(40);
    }];

    ///守护图标
    UIImageView *userIcon = [[UIImageView alloc] init];
    userIcon.layer.masksToBounds = YES;
    userIcon.contentMode = UIViewContentModeScaleAspectFill;
    [bannerView addSubview:userIcon];
    _userIcon = userIcon;
    
    ///显示文字
    UILabel *showTextL = [[UILabel alloc] init];
    showTextL.font = [UIFont systemFontOfSize:14];
    showTextL.textColor = [UIColor blackColor];
    [bannerView addSubview:showTextL];
    _showTextL = showTextL;

    [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bannerView).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(24, 24));
        make.centerY.equalTo(bannerView);
        make.right.equalTo(showTextL.mas_left).mas_offset(-8);
    }];
    
    [showTextL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bannerView);
        make.right.equalTo(bannerView).mas_offset(-10);
    }];

    [bannerView layoutIfNeeded];
    bannerView.layer.cornerRadius = 8.0;
    
    [userIcon layoutIfNeeded];
    userIcon.layer.cornerRadius = userIcon.height/2.0;
}


- (void)showPresentModel:(ApiBeautifulNumberModel *)numberModel{

    [_userIcon sd_setImageWithURL:[NSURL URLWithString:numberModel.avatar] placeholderImage:[ProjConfig getDefaultImage]];
    
    NSMutableAttributedString *muAttrStr = [[NSMutableAttributedString alloc] initWithString:kLocalizationMsg(@"给主播赠送了 ")];

    NSAttributedString *attr = [numberModel.number attachmentForImage:[UIImage imageNamed:@"live_userinfo_lianghao"] bounds:CGRectMake(0, -1, 24, 13) before:YES textFont:[UIFont systemFontOfSize:13] textColor:kRGB_COLOR(@"#FF5E0D")];
    [muAttrStr appendAttributedString:attr];
    
    _showTextL.attributedText = muAttrStr;
    
}


@end
