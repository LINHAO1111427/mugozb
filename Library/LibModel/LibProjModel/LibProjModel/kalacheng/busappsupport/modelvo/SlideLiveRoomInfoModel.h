//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
滑动直播间数据
 */
@interface SlideLiveRoomInfoModel : NSObject 


	/**
序号
 */
@property (nonatomic, assign) int serialNumber;

	/**
距离
 */
@property (nonatomic, assign) double distance;

	/**
直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 */
@property (nonatomic, assign) int liveType;

	/**
封面图
 */
@property (nonatomic, copy) NSString * liveThumb;

	/**
房间号
 */
@property (nonatomic, assign) int64_t roomId;

 +(NSMutableArray<SlideLiveRoomInfoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<SlideLiveRoomInfoModel*>*)list;

 +(SlideLiveRoomInfoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(SlideLiveRoomInfoModel*) source target:(SlideLiveRoomInfoModel*)target;

@end

NS_ASSUME_NONNULL_END
