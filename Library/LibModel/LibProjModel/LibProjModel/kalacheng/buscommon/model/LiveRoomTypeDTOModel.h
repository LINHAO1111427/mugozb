//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
房间模式DTO
 */
@interface LiveRoomTypeDTOModel : NSObject 


	/**
房间模式对应的值（安卓用）
 */
@property (nonatomic, copy) NSString * roomTypeVal;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
房间名称
 */
@property (nonatomic, copy) NSString * roomName;

	/**
房间模式标识 0:普通房间 1:私密房间 2:收费房间 3:计时房间 4:贵族房间
 */
@property (nonatomic, assign) int roomType;

 +(NSMutableArray<LiveRoomTypeDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<LiveRoomTypeDTOModel*>*)list;

 +(LiveRoomTypeDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(LiveRoomTypeDTOModel*) source target:(LiveRoomTypeDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
