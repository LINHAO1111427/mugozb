//
//  ChangeRoomTypeView.h
//  LiveCommon
//
//  Created by klc_sl on 2020/3/17.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RoomTypeModel;
@interface ChangeRoomTypeView : UIView


/// 显示直播间类型
/// @param isModify 是否是修改
/// @param selectBlock 选择的房间模式回调
+ (void)selectRoomTypeIsModify:(BOOL)isModify roomTypeSelect:(void(^)(RoomTypeModel *selectRoomType))selectBlock;

+ (RoomTypeModel *)getCurrentRoomType;



@end




@interface RoomTypeModel : NSObject

- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, assign)int64_t roomTypeId;  ///房间类型ID

///房间模式标识 0:普通房间 1:私密房间 2:收费房间 3:计时房间 4:贵族房间
@property (nonatomic, assign)int roomType;   ///房间类型类型值
@property (nonatomic, copy)NSString *roomTypeStr;   ///房间类型字符串
@property (nonatomic, copy)NSString *roomTypeValue;  ///房间类型值


@property (nonatomic, assign)BOOL hasValue;  ///是否需要设置值
@property (nonatomic, copy)NSString *tips;   ///没有设置值的提示
@property (nonatomic, copy)NSString *unit;   ///显示的单位文字

- (instancetype)initWithId:(int64_t)roomTypeId roomType:(int)roomType roomTypeStr:(NSString *)roomTypeStr;


@end




NS_ASSUME_NONNULL_END
