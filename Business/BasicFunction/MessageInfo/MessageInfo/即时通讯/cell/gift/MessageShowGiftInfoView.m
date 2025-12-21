//
//  MessageShowGiftInfoView.m
//  Message
//
//  Created by klc_sl on 2021/7/24.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "MessageShowGiftInfoView.h"
#import "MessageChatModel.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <SDWebImage/SDWebImage.h>

@implementation MessageShowGiftInfoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    ///礼物背景页面
    UIView *centerView = [[UIView alloc] init];
    centerView.layer.cornerRadius = 8;
    centerView.layer.masksToBounds = YES;
    centerView.layer.borderColor = kRGB_COLOR(@"#EEEEEE").CGColor;
    centerView.layer.borderWidth = 1;
    [self addSubview:centerView];
    self.giftBgView = centerView;
    
    ///礼物图片
    UIImageView *giftHeadV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    giftHeadV.layer.cornerRadius = 15;
    giftHeadV.layer.masksToBounds = YES;
    giftHeadV.contentMode = UIViewContentModeScaleAspectFill;
    giftHeadV.clipsToBounds = YES;
    [centerView addSubview:giftHeadV];
    giftHeadV.userInteractionEnabled = YES;
    self.giftHeadV = giftHeadV;
    
    ///礼物另一个图片
    UIImageView *giftOtherHeadV = [[UIImageView alloc] initWithFrame:CGRectMake(80, 10, 30, 30)];
    giftOtherHeadV.layer.cornerRadius = 15;
    giftOtherHeadV.layer.masksToBounds = YES;
    giftOtherHeadV.contentMode = UIViewContentModeScaleAspectFill;
    giftOtherHeadV.clipsToBounds = YES;
    [centerView addSubview:giftOtherHeadV];
    giftOtherHeadV.userInteractionEnabled = YES;
    self.giftOtherHeadV = giftOtherHeadV;
    
    ///送礼文字
    UILabel *giftdecL = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 60, 50)];
    giftdecL.textAlignment = NSTextAlignmentCenter;
    giftdecL.font = [UIFont systemFontOfSize:15];
    [centerView addSubview:giftdecL];
    self.giftdecL = giftdecL;
    
    
    ///礼物图标
    UIImageView *giftIconV = [[UIImageView alloc] initWithFrame:CGRectMake(120, 5, 40, 40)];
    giftIconV.contentMode = UIViewContentModeScaleAspectFill;
    giftIconV.clipsToBounds = YES;
    [centerView addSubview:giftIconV];
    self.giftIconV = giftIconV;
    
    ///礼物个数
    UILabel *giftCountL = [[UILabel alloc] initWithFrame:CGRectMake(160, 0, 80, 50)];
    giftCountL.textAlignment = NSTextAlignmentCenter;
    giftCountL.textColor = [UIColor whiteColor];
    giftCountL.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:22];
    [centerView addSubview:giftCountL];
    self.giftCountL = giftCountL;
}


- (void)showGiftInfo:(SendGiftInfoModel *)giftInfo isGroup:(BOOL)isGroup isOwn:(BOOL)isOwn{
    
    if (isGroup) {
        self.giftOtherHeadV.hidden = NO;
        self.giftBgView.frame = CGRectMake((kScreenWidth - 250)/2, 0, 250, 50);
        [self.giftHeadV sd_setImageWithURL:[NSURL URLWithString:giftInfo.ownIcon] placeholderImage:[ProjConfig getDefaultImage]];
        [self.giftOtherHeadV sd_setImageWithURL:[NSURL URLWithString:giftInfo.otherIcon] placeholderImage:[ProjConfig getDefaultImage]];
        self.giftdecL.text = kLocalizationMsg(@"送");
        self.giftdecL.frame = CGRectMake(50, 0, 20, 50);
        [self.giftIconV sd_setImageWithURL:[NSURL URLWithString:giftInfo.giftIcon] placeholderImage:[ProjConfig getDefaultImage]];
        NSString *giftNumStr = [NSString stringWithFormat:@"x%d",giftInfo.number];
        self.giftCountL.attributedText = [giftNumStr textColor:[UIColor whiteColor] textBorderColor:kRGB_COLOR(@"#FFCC5D") strokeWidth:-5];
        self.giftIconV.frame = CGRectMake(130, 5, 40, 40);
        self.giftCountL.frame= CGRectMake(170, 0, 80, 50);
    }else{
        self.giftOtherHeadV.hidden = YES;
        if (isOwn) {
            self.giftBgView.frame = CGRectMake((kScreenWidth - 240)/2, 0, 240, 50);
            [self.giftHeadV sd_setImageWithURL:[NSURL URLWithString:giftInfo.ownIcon] placeholderImage:[ProjConfig getDefaultImage]];
            self.giftdecL.text = kLocalizationMsg(@"送TA");
            [self.giftIconV sd_setImageWithURL:[NSURL URLWithString:giftInfo.giftIcon] placeholderImage:[ProjConfig getDefaultImage]];
            NSString *giftNumStr = [NSString stringWithFormat:@"x%d",giftInfo.number];
            self.giftCountL.attributedText = [giftNumStr textColor:[UIColor whiteColor] textBorderColor:kRGB_COLOR(@"#FFCC5D") strokeWidth:-5];
        }else{
            self.giftBgView.frame = CGRectMake((kScreenWidth - 240)/2, 0, 240, 50);
            [self.giftHeadV sd_setImageWithURL:[NSURL URLWithString:giftInfo.ownIcon] placeholderImage:[ProjConfig getDefaultImage]];
            self.giftdecL.text = kLocalizationMsg(@"送你");
            [self.giftIconV sd_setImageWithURL:[NSURL URLWithString:giftInfo.giftIcon] placeholderImage:[ProjConfig getDefaultImage]];
            NSString *giftNumStr = [NSString stringWithFormat:@"x%d",giftInfo.number];
            self.giftCountL.attributedText = [giftNumStr textColor:[UIColor whiteColor] textBorderColor:kRGB_COLOR(@"#FFCC5D") strokeWidth:-5];
        }
    }
}

@end
