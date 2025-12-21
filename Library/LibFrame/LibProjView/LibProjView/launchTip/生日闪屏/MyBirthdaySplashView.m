//
//  MyBirthdaySplashView.m
//  LibProjView
//
//  Created by ssssssss on 2020/8/27.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "MyBirthdaySplashView.h"
#import <LibTools/LibTools.h>
#import <SDWebImage.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjBase/PopupTool.h>
#import "LibProjViewRes.h"
#import <CoreText/CoreText.h>
#import <LibProjModel/HttpApiNobleController.h>
#import <LibProjView/PublicMethodObj.h>

@interface MyBirthdaySplashView ()
@property (nonatomic, copy)BirthdaySplashBlock callBack;
@property (nonatomic, strong)UIImageView *bgImageV;///背景
@property (nonatomic, strong)UIImageView *hatImageV;///帽子
@property (nonatomic, strong)UIImageView *cakeImageV;///蛋糕
@property (nonatomic, strong)UIImageView *avaterImageV;///头像
@property (nonatomic, strong)UIImageView *animationImageView;///动画

@property (nonatomic, strong)UILabel *happyBirthdayEnglishL;///happyBirthday
@property (nonatomic, strong)UILabel *happyBirthdayChineseL;///中文生日快乐
@end

@implementation MyBirthdaySplashView


+ (void)showBirthdaySplashComplete:(BirthdaySplashBlock)complete{
    BOOL result = [MyBirthdaySplashView isMybirthdayToday];
    if (result) {
        [PublicMethodObj launchTimeJudge:@"birthdaySplashShow" withinOneDayBlock:^(BOOL within) {
            if (!within) {
                [HttpApiNobleController getIsOwnerPrivilege:4004 callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
                    if (code == 1 && [model.no_use intValue] == 2) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [MyBirthdaySplashView showBirthdaySplashWithCallBack:complete];
                            [PublicMethodObj LaunchTimechange:@"birthdaySplashShow"];
                        });
                    }else{
                        if (complete) {
                            complete(YES);
                        }
                    }
                }];
            }
        }];
    }else{
        if (complete) {
            complete(YES);
        }
    }
}

+ (BOOL)isMybirthdayToday{
    BOOL result = NO;
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    ApiUserInfoModel *userInfo = [KLCUserInfo getUserInfo];
    NSDate *myDate = [MyBirthdaySplashView nsstringConversionNSDate:userInfo.birthday];
    if (myDate) {
        NSDate *nowDate = [NSDate date];
        unsigned unitFlags =  NSCalendarUnitMonth |  NSCalendarUnitDay ;
        NSDateComponents* compNowDate = [gregorian components: unitFlags fromDate:nowDate];
        NSDateComponents* compMyDate = [gregorian components: unitFlags fromDate:myDate];
        if (compMyDate.month == compNowDate.month && compMyDate.day == compNowDate.day) {
            result = YES;
        }
    }
    return result;
}

+ (NSDate *)nsstringConversionNSDate:(NSString *)dateStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
}


#pragma mark - 显示 -
+ (void)showBirthdaySplashWithCallBack:(BirthdaySplashBlock)callBack{
    MyBirthdaySplashView *showView = [[MyBirthdaySplashView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    showView.backgroundColor = [UIColor whiteColor];
    showView.callBack = callBack;
     
   //背景图
    UIImageView *bgImageV = [[UIImageView alloc]initWithFrame:showView.bounds];
    bgImageV.backgroundColor = [UIColor whiteColor];
    bgImageV.contentMode = UIViewContentModeScaleAspectFill;
    bgImageV.image = [UIImage imageNamed:@"my_birthday_back"];
    [showView addSubview:bgImageV];
    [[PopupTool share] createPopupViewWithLinkView:showView allowTapOutside:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [PopupTool bringViewToFront:[MyBirthdaySplashView class]];
    });
    
    {
        
        //英文生日快乐
        CGFloat scaleBirthEnglish = 202/70.0;
        CGFloat birthEnglishW = kScreenWidth*202.0/360;
        CGFloat birthEnglishH = birthEnglishW/scaleBirthEnglish;
        UILabel *happyBirthdayEnglishL = [[UILabel alloc]initWithFrame:CGRectMake(0, (kScreenHeight-birthEnglishH)*70/(528.0+70.0), kScreenWidth, birthEnglishH+10)];
        happyBirthdayEnglishL.textAlignment = NSTextAlignmentCenter;
        happyBirthdayEnglishL.numberOfLines = 0;
        happyBirthdayEnglishL.textColor = [UIColor whiteColor];
        happyBirthdayEnglishL.text = @"happy\nbirthday!";
        happyBirthdayEnglishL.font = [UIFont fontWithName:[showView getFontNameWithFileName:@"ArialBlackRegular"] size:32];
        showView.happyBirthdayEnglishL = happyBirthdayEnglishL;
        [bgImageV addSubview:happyBirthdayEnglishL];
        //帽子
        CGFloat scaleHat = 50/42.0;
        CGFloat hatImageW = kScreenWidth *50/360.0;
        CGFloat hatImageH = hatImageW/scaleHat;
        UIImageView *hatImageV = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-hatImageW)*106.0/(106+219), (kScreenHeight-hatImageH)*183.0/(183+443), hatImageW, hatImageH)];
        hatImageV.image = [UIImage imageNamed:@"my_birthday_hat"];
        hatImageV.contentMode = UIViewContentModeScaleAspectFit;
        showView.hatImageV = hatImageV;
        [bgImageV addSubview:hatImageV];
     
        //头像
        CGFloat scaleAvater = 130/360.0;
        CGFloat width = kScreenWidth*scaleAvater;
        CGFloat scaleUp = 195.0/(195.0+352.0);
        CGFloat y = (kScreenHeight-width)*scaleUp;
        UIImageView *avaterImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, y, width, width)];
        avaterImageV.layer.cornerRadius = width/2.0;
        avaterImageV.clipsToBounds = YES;
        avaterImageV.contentMode = UIViewContentModeScaleAspectFill;
        avaterImageV.layer.borderWidth = 2.0;
        avaterImageV.centerX = bgImageV.centerX;
        avaterImageV.layer.borderColor = [UIColor whiteColor].CGColor;
        [avaterImageV sd_setImageWithURL:[NSURL URLWithString:[KLCUserInfo getAvatar]] placeholderImage:[ProjConfig getDefaultImage]];
        showView.avaterImageV = avaterImageV;
        [bgImageV addSubview:avaterImageV];
        

        //蛋糕
        CGFloat scaleCake = 172/360.0;
        CGFloat cateW = kScreenWidth *scaleCake;
        UIImageView *cakeImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, kScreenHeight-30-cateW, cateW, cateW)];
        cakeImageV.image = [UIImage imageNamed:@"my_birthday_cake"];
        cakeImageV.centerX = bgImageV.centerX;
        showView.cakeImageV = cakeImageV;
        [bgImageV addSubview:cakeImageV];
        
        //中文生日快乐
        CGFloat birthChineseH = kScreenHeight-avaterImageV.maxY-cateW-30;;
        UILabel *happyBirthdayChineseL = [[UILabel alloc]initWithFrame:CGRectMake(0, avaterImageV.maxY, kScreenWidth, birthChineseH)];
        happyBirthdayChineseL.textAlignment = NSTextAlignmentCenter;
        happyBirthdayChineseL.numberOfLines = 0;
        happyBirthdayChineseL.textColor = kRGB_COLOR(@"#9D5F00");
        happyBirthdayChineseL.text = [NSString stringWithFormat:kLocalizationMsg(@"亲爱的%@\n生日快乐！"),[KLCUserInfo getNikeName]];
        happyBirthdayChineseL.font = [UIFont fontWithName:[showView getFontNameWithFileName:@"YouSheBiaoTiHei"] size:32];
        showView.happyBirthdayChineseL = happyBirthdayChineseL;
        [bgImageV addSubview:happyBirthdayChineseL];
        
        //动画图
        NSString *imageName= [LibProjViewRes getNibFullName:@"myBirthdaySplash"];
        NSString *path =[[NSBundle mainBundle] pathForResource:imageName ofType:@"gif"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        UIImage *image = [UIImage sd_imageWithData:data];
        UIImageView *animationImageV = [[UIImageView alloc]initWithFrame:showView.bounds];
        animationImageV.backgroundColor = [UIColor clearColor];
        animationImageV.image = image;
        showView.animationImageView = animationImageV;
        [showView addSubview:animationImageV];
        [showView bringSubviewToFront:animationImageV];
        
        NSDateFormatter *formattor = [[NSDateFormatter alloc]init];
        [formattor setDateFormat:@"YYYY-MM-dd"];
        NSString *day = [formattor stringFromDate:[NSDate date]];
        if (day) {
            [[NSUserDefaults standardUserDefaults] setObject:day forKey:@"birthdayHaveSplash"];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [showView closeNow];
        });
    }
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
- (void)closeNow{
    if (self.callBack) {
        self.callBack(YES);
    }
    [self removeAllSubViews];
    [self.bgImageV removeAllSubViews];
    [self removeFromSuperview];
    [[PopupTool share] closePopupView:self];
}
@end
