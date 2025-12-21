//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
修改房间模式,发送的socket实体
 */
@interface ApiExitRoomModel : NSObject 


	/**
null
 */
@property (nonatomic, assign) int64_t serialVersionUID;

	/**
房间号
 */
@property (nonatomic, assign) int64_t roomId;

	/**
房间模式标识 0:普通房间 1:私密房间 2:收费房间 3:计时房间 4:贵族房间
 */
@property (nonatomic, assign) int roomType;

	/**
房间模式对应的值
 */
@property (nonatomic, copy) NSString * roomTypeVal;

	/**
房间名称
 */
@property (nonatomic, copy) NSString * roomName;

	/**
消息内容
 */
@property (nonatomic, copy) NSString * conetnt;

	/**
状态1成功2失败
 */
@property (nonatomic, assign) int code;

	/**
状态描述
 */
@property (nonatomic, copy) NSString * msg;

 +(NSMutableArray<ApiExitRoomModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiExitRoomModel*>*)list;

 +(ApiExitRoomModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiExitRoomModel*) source target:(ApiExitRoomModel*)target;

@end

NS_ASSUME_NONNULL_END
