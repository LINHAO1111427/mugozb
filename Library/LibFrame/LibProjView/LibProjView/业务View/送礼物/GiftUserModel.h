//
//  GiftUserModel.h
//  LiveCommon
//
//  Created by klc_sl on 2020/3/28.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GiftUserModel : NSObject

@property (nonatomic, assign) int64_t userId;

@property (nonatomic, copy) NSString *userName;  ///用户名
@property (nonatomic, assign)BOOL isAnchor;  ///是否是主播

///用户头像 默认取userImage, 如果没有值 用UserIcon加载网络头像图片
@property (nonatomic, copy) UIImage *userImage;  ///用户头像
@property (nonatomic, copy) NSString *userIcon;  ///用户头像
@property (nonatomic, assign) int noble_grade;  ///贵族等级

///展示的文字(如果没有，显示用户名)
@property (nonatomic, copy) NSString *showStr;


///接口需要的参数，可传可不传
///
///-------直播间
@property (nonatomic, assign) int64_t roomId;   ///房间号
@property (nonatomic, assign) int64_t anchorId; ///直播间的主播id   暂时只在语音房间PK时候要用到
@property (nonatomic, copy) NSString *showId; ///直播间Id;


///-------短视频
@property (nonatomic, assign) int64_t shortVideoId;   ///短视频Id




@end

NS_ASSUME_NONNULL_END
