//
//  KLCAppConfig.h
//  TCDemo
//
//  Created by admin on 2020/9/19.
//  Copyright © 2019 CH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <LibProjModel/APPConfigModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLCAppConfig : NSObject


+ (void)updateAppConfig:(void (^_Nullable)(BOOL success))complete;

+ (APPConfigModel *)appConfig;

///分享数组
+ (NSArray *)shareArray;

///登录数组
+ (NSArray *)loginArray;

///消费单位文字
+ (NSString *)unitStr;
///收入单位文字
+ (NSString *)incomeUnitStr;


///连送礼物等待时间
+ (NSTimeInterval)giftHoldTime;

///是否显示通话费用
+ (BOOL)showOtmCoin;

///获得金币图标
+ (UIImage *)getCoinImage;
///获得影票图标
+ (UIImage *)getTicketImage;




///临时用户Id
+ (int64_t)tempUid;
///临时token
+ (NSString *)tempUToken;



@end

NS_ASSUME_NONNULL_END
