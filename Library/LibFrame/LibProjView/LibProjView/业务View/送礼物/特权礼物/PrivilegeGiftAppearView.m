//
//  PeivilegeGiftAppearView.m
//  LiveCommon
//
//  Created by ssssssss on 2020/8/29.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "PrivilegeGiftAppearView.h"
#import <LibTools/LibTools.h>
#import <LibTools/LiveMacros.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjBase/ProjConfig.h>
#import <LibProjModel/ApiGiftSenderModel.h>
#import "LibProjViewRes.h"
#import <CoreText/CoreText.h>
#import <LibProjView/KlcAvatarView.h>

@interface PrivilegeGiftAppearView ()
@property (nonatomic, strong)UIView *grayBackView;//黑色背景
@property (nonatomic, strong)KlcAvatarView *avaterImageV;//头像
@property (nonatomic, strong)UIImageView *giftImageV;//礼物
@property (nonatomic, strong)UILabel *sendL;//送礼
@property (nonatomic, strong)UILabel *giftNameL;//礼物名称
@property (nonatomic, strong)UILabel *numL;//数目
@end

@implementation PrivilegeGiftAppearView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView{
    CGFloat scale = 235/200.0;
    CGFloat width = kScreenWidth*200/360.0;
    CGFloat height  = width*scale;
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 25, width, height-25)];
    grayView.backgroundColor = kRGBA_COLOR(@"#000000", 0.3);
    grayView.centerX = self.centerX;
    grayView.clipsToBounds = YES;
    grayView.layer.cornerRadius = 10;
    _grayBackView =grayView;
    [self addSubview:_grayBackView];
    
    // 头像
    KlcAvatarView *avaterImageV = [[KlcAvatarView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    avaterImageV.centerX = self.centerX;
    _avaterImageV = avaterImageV;
    [self addSubview:_avaterImageV];
    
    //赠送
    UILabel *sendL = [[UILabel alloc]initWithFrame:CGRectMake(0, 25+10, width, 20)];
    sendL.font = [UIFont systemFontOfSize:14];
    sendL.textAlignment = NSTextAlignmentCenter;
    sendL.textColor = kRGB_COLOR(@"#00FFF4");
    _sendL = sendL;
    [grayView addSubview:sendL];
    
    //礼物
    UIImageView *giftImaegV = [[UIImageView alloc]initWithFrame:CGRectMake((width-(height -105))/2.0, sendL.maxY, height -105, height -105)];
    giftImaegV.contentMode = UIViewContentModeScaleAspectFit;
    giftImaegV.backgroundColor =[ UIColor clearColor];
    _giftImageV = giftImaegV;
    [grayView addSubview:_giftImageV];
    
    
    //数量
    UILabel *numL = [[UILabel alloc]initWithFrame:CGRectMake(grayView.maxX-60, grayView.maxY-60, kScreenWidth-12-(grayView.maxX-60), 60)];
    numL.font = [UIFont fontWithName:[self getFontNameWithFileName:@"YouSheBiaoTiHei"] size:45];
    numL.textColor = kRGB_COLOR(@"#FF69F4");
    _numL = numL;
    [self addSubview:_numL];
    
    //礼物名名称
    UILabel *giftNameL = [[UILabel alloc] initWithFrame:CGRectMake(0, giftImaegV.maxY,  height -105, 20)];
    giftNameL.textAlignment = NSTextAlignmentCenter;
    giftNameL.textColor = kRGB_COLOR(@"#00FFF4");
    giftNameL.centerX = giftImaegV.centerX;
    giftNameL.font = [UIFont systemFontOfSize:13];
    _giftNameL = giftNameL;
    [grayView addSubview:_giftNameL];
}

- (void)showGiftModel:(ApiGiftSenderModel *)giftModel{
    
    [_avaterImageV showUserIconUrl:giftModel.userAvatar vipBorderUrl:giftModel.nobleAvatarFrame];
    
    [_giftImageV sd_setImageWithURL:[NSURL URLWithString: giftModel.gifticon] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
    _giftNameL.text = [NSString stringWithFormat:@"【%@】",giftModel.giftName];
    
    NSString *sendStr = [NSString stringWithFormat:kLocalizationMsg(@"【%@】赠送 %@"),giftModel.userName,giftModel.anchorName];
    NSMutableAttributedString *sendAttStr = [[NSMutableAttributedString alloc]initWithString:sendStr];
    [sendAttStr setAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(giftModel.userName.length+2, 2)];
    _sendL.attributedText = sendAttStr;
    
    //数目
    NSString *numStr = [NSString stringWithFormat:@"X%d",giftModel.giftNumber];
    NSMutableAttributedString *numAttStr = [[NSMutableAttributedString alloc]initWithString:numStr];
    [numAttStr setAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:[self getFontNameWithFileName:@"YouSheBiaoTiHei"] size:25],NSBaselineOffsetAttributeName:@(0.1 * (45- 25))} range:NSMakeRange(0, 1)];
    [numAttStr setAttributes:@{NSForegroundColorAttributeName:kRGB_COLOR(@"#FF69F4"),NSFontAttributeName:[UIFont fontWithName:[self getFontNameWithFileName:@"YouSheBiaoTiHei"] size:45]} range:NSMakeRange(1, numStr.length-1)];
    _numL.attributedText = numAttStr;
    
}


- (NSString *)getFontNameWithFileName:(NSString *)fileName{
    NSString *fontPath= [LibProjViewRes getNibFullName:fileName];
    NSString *path =[[NSBundle mainBundle] pathForResource:fontPath ofType:@".ttf"];
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithFilename([path UTF8String]);
    CGFontRef customfont = CGFontCreateWithDataProvider(fontDataProvider);
    CGDataProviderRelease(fontDataProvider);
    //    NSString *fontName = (__bridge NSString *)CGFontCopyFullName(customfont);
    NSString *fontName = (__bridge NSString *)CGFontCopyPostScriptName(customfont);
    CFErrorRef error;
    CTFontManagerRegisterGraphicsFont(customfont, &error);
    if (error){
        // 为了可以重复注册
        CTFontManagerUnregisterGraphicsFont(customfont, &error);
        CTFontManagerRegisterGraphicsFont(customfont, &error);
    }
    CGFontRelease(customfont);
    return fontName;
}

@end
