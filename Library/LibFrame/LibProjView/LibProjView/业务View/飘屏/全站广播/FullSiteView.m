//
//  RechangeSuccessView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/24.
//  Copyright © 2020 . All rights reserved.
//

#import "FullSiteView.h"
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/ApiSimpleMsgRoomModel.h>

@interface FullSiteView ()
@property (nonatomic, weak)UIButton *userIconV;  ///用户图标
@property (nonatomic, weak)UILabel *showTextL;  ///显示文字
@property (nonatomic, weak)UIView *contentV;
@property (nonatomic, weak)UIImageView *nobleImageV;//贵族图标

@end

@implementation FullSiteView


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
    bannerView.image = [UIImage imageWithColor:[UIColor whiteColor]];
    [self addSubview:bannerView];
    
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).mas_offset(42);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(self.width-42);
    }];
    [bannerView layoutIfNeeded];
    bannerView.layer.borderColor = kRGBA_COLOR(@"#DEDEDE", 0.8).CGColor;
    bannerView.layer.borderWidth = 1.0;
    bannerView.layer.cornerRadius = bannerView.height/2.0;
    ///副图标
    UIImageView *noticeimageV = [[UIImageView alloc] init];
    noticeimageV.layer.masksToBounds = YES;
    noticeimageV.image = [UIImage imageNamed:@"full_site_notice"];
    [self addSubview:noticeimageV];
  
    
    ///用户头像
    UIButton *userIcon = [[UIButton alloc] init];
    userIcon.layer.masksToBounds = YES;
    userIcon.layer.borderWidth = 1.0;
    userIcon.contentMode = UIViewContentModeScaleToFill;
    userIcon.layer.borderColor = kRGB_COLOR(@"#FFCC5D").CGColor;
    [userIcon addTarget:self action:@selector(avaterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bannerView addSubview:userIcon];
    _userIconV = userIcon;
    
    UIImageView *nobelImgV = [[UIImageView alloc]init];
    [bannerView addSubview:nobelImgV];
    _nobleImageV = nobelImgV;
    

    ///显示文字
    UILabel *showTextL = [[UILabel alloc] init];
    showTextL.font = [UIFont systemFontOfSize:12];
    showTextL.textColor = kRGB_COLOR(@"#666666");
    [bannerView addSubview:showTextL];
    _showTextL = showTextL;
    
    [noticeimageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(12);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.equalTo(bannerView);
    }];
    
    [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bannerView).mas_offset(2);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.equalTo(bannerView);
        make.right.equalTo(nobelImgV.mas_left).mas_offset(-10);
    }];
    
    [nobelImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userIcon.mas_right).mas_offset(2);
        make.size.mas_equalTo(CGSizeMake(30, 15));
        make.centerY.equalTo(bannerView);
        make.right.equalTo(showTextL.mas_left).mas_offset(-10);
    }];
    
    
    [showTextL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bannerView);
        make.right.equalTo(bannerView).mas_offset(5);
    }];
    
    [userIcon layoutIfNeeded];
    userIcon.layer.cornerRadius = userIcon.height/2.0;
}

- (void)showCongratulationModel:(ApiSimpleMsgRoomModel *)model{
    [_userIconV sd_setImageWithURL:[NSURL URLWithString:model.avatar] forState:UIControlStateNormal placeholderImage:[ProjConfig getDefaultImage]];;
    [_nobleImageV sd_setImageWithURL:[NSURL URLWithString:model.nobleGradeImg] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
    NSString *username = [NSString stringWithFormat:@"%@:",model.userName];
    NSString *showStr = [NSString stringWithFormat:@"%@%@",username,model.content];
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc] initWithString:showStr];
    [muStr setAttributes:@{NSForegroundColorAttributeName:kRGB_COLOR(@"#4BC9FF")} range:NSMakeRange(0, username.length)];
    _showTextL.attributedText = muStr;
}

- (void)avaterBtnClick:(UIButton *)btn{
   // NSLog(@"过滤文字查看此人"));
}
@end
