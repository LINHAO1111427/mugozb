//
//  CustomPopUpAlert.h
//  LibProjView
//
//  Created by klc on 2020/4/1.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LiveRoomType) {
    ///门票房间
    LiveTypeForTicket,
    ///计时房间
    LiveTypeForTime,
    ///密码房间
    LiveTypeForPassword,
    ///贵族房间
    LiveTypeForNoble,
    ///密码房间2
    LiveTypeForPasswordOther,
    ///余额不足弹框
    LiveTypeForBalanceInsufficient,
    ///主播与主播弹框
    LiveTypeForAnchorAndAnchor,
    ///普通弹框
    LiveTypeForCommon,
};

@interface CustomPopUpAlert : UIViewController


@property (nonatomic,copy)void(^clickCancelBlock)(void);

@property (nonatomic,copy)void(^clickSureBlock)(NSString *passwordStr);


+ (id)alertTitle:(NSString *__nullable)title message:(NSString *__nullable)message liveType:(LiveRoomType)Type;

///余额不足弹框 + 去充值弹框
+ (void)showLiveTypeForBalanceInsufficient;


- (UIViewController *)getCurrentVC;

@end

NS_ASSUME_NONNULL_END
