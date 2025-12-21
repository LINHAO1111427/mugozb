//
//  LiveShareView.h
//  klc
//
//  Created by David on 16/5/21.
//  Copyright © 2018年 David. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareFunctionItem : NSObject

@property (nonatomic, assign)NSUInteger funcId;
@property (nonatomic, copy)UIImage *icon;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)void(^clickBlock)(void);

+ (instancetype)shareIcon:(UIImage *)icon name:(NSString *)name clickBlock:(void(^)(void))clickBlock;

///获得分享链接的样式
+ (instancetype)getCopyLinkFunction;

@end


@interface LiveShareView : UIView


/// 显示分享UI
/// @param type 分享类型  类型 1:动态 2:直播间 3:App 4:短视频
/// @param shareId 分享对应的类型的数据ID - type对应的ID 1:动态ID(0) 2:房间id 3:AppId(0) 4:短视频拥有者id
/// @param func 功能按钮 默认有复制链接功能
+ (void)showShareViewForType:(int)type shareId:(int64_t)shareId moreFunction:(NSArray<ShareFunctionItem *> *_Nullable)func;


/// 直接分享
/// @param type type 分享类型  类型 1:动态 2:直播间 3:App 4:短视频
/// @param shareId shareId 分享对应的类型的数据ID - type对应的ID 1:动态ID(0) 2:房间id 3:AppId(0) 4:短视频拥有者id
/// @param shareType 第三方类型
+ (void)shareForType:(int)type shareId:(int64_t)shareId shareType:(NSInteger)shareType;


@end



NS_ASSUME_NONNULL_END
