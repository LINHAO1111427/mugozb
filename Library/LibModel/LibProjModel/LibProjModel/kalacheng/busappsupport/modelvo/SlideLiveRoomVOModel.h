//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class SlideLiveRoomInfoModel;
NS_ASSUME_NONNULL_BEGIN




/**
滑动直播间返回的数据
 */
@interface SlideLiveRoomVOModel : NSObject 


	/**
房间集合
 */
@property (nonatomic, strong) NSMutableArray<SlideLiveRoomInfoModel*>* slideLiveRoomInfoList;

	/**
我所在房间当前的序号(用户判断我在集合中处于哪个位置)
 */
@property (nonatomic, assign) int mySerialNumber;

 +(NSMutableArray<SlideLiveRoomVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<SlideLiveRoomVOModel*>*)list;

 +(SlideLiveRoomVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(SlideLiveRoomVOModel*) source target:(SlideLiveRoomVOModel*)target;

@end

NS_ASSUME_NONNULL_END
