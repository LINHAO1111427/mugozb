//
//  ProjBaseData.h
//  LibProjBase
//
//  Created by klc_sl on 2020/7/15.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProjBaseData : NSObject


+ (instancetype)share;

///用户当前状态:  0 空闲： 1: 主播身份直播中  2: 一对一中  3 用户身份在直播间内
@property (nonatomic, assign)int userState;

@property (nonatomic, assign)int64_t roomId;  ///当前所在的房间号
@property (nonatomic, assign)BOOL isMiniRoom;  ///是不是最小化房间


#pragma mark - 消息声音 -
///消息推送声音
@property (nonatomic, assign)BOOL enableNotifyVoice;
///消息推送震动
//@property (nonatomic, assign)BOOL enableNotifyShake;





#pragma mark - 飘屏 -

///全局飘屏背景UI
@property (nonatomic, weak) UIView *allBannerBgView;
///一对一总开关
/// YES: 开启。 NO: 关闭
@property (nonatomic, assign)BOOL switchOTOBanner;

///全局飘屏总开关
@property (nonatomic, assign)BOOL switchGlobalBanner;
///独立监控
///某一个页面的一对一是否推送
@property (nonatomic, assign)BOOL notShowOTOBanner;

///删除全局UI
- (void)removeAllBanner;




@end

NS_ASSUME_NONNULL_END
