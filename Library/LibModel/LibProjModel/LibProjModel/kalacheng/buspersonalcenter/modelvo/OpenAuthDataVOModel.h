//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class LiveRoomTypeDTOModel;
NS_ASSUME_NONNULL_BEGIN




/**
返回主播开播的房间数据和房间类型数据
 */
@interface OpenAuthDataVOModel : NSObject 


	/**
详细地址
 */
@property (nonatomic, copy) NSString * address;

	/**
经度
 */
@property (nonatomic, assign) double lng;

	/**
城市
 */
@property (nonatomic, copy) NSString * city;

	/**
直播封面图
 */
@property (nonatomic, copy) NSString * thumb;

	/**
房间类型名称
 */
@property (nonatomic, copy) NSString * roomTypeName;

	/**
标题
 */
@property (nonatomic, copy) NSString * title;

	/**
房间号，语音直播离开房间时，再次开播，进入原来的房间
 */
@property (nonatomic, assign) int64_t roomId;

	/**
背景图地址（视频没有）
 */
@property (nonatomic, copy) NSString * voiceThumb;

	/**
当前房间类型下，已经开启的房间模式
 */
@property (nonatomic, strong) NSMutableArray<LiveRoomTypeDTOModel*>* liveRoomTypeDTOS;

	/**
房间类型值
 */
@property (nonatomic, copy) NSString * roomTypeVal;

	/**
频道名称
 */
@property (nonatomic, copy) NSString * channelName;

	/**
频道ID
 */
@property (nonatomic, assign) int64_t channelId;

	/**
纬度
 */
@property (nonatomic, assign) double lat;

	/**
房间类型 0:是一般直播 1:是私密直播 2:是收费直播 3:是计时直播 4:贵族房间
 */
@property (nonatomic, assign) int roomType;

 +(NSMutableArray<OpenAuthDataVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OpenAuthDataVOModel*>*)list;

 +(OpenAuthDataVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(OpenAuthDataVOModel*) source target:(OpenAuthDataVOModel*)target;

@end

NS_ASSUME_NONNULL_END
