//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP关闭主播连麦
 */
@interface ApiCloseLineModel : NSObject 


	/**
null
 */
@property (nonatomic, assign) int64_t serialVersionUID;

	/**
房间号
 */
@property (nonatomic, assign) int64_t roomId;

	/**
对方房间号
 */
@property (nonatomic, assign) int64_t toRoomId;

	/**
用户id
 */
@property (nonatomic, assign) int64_t uid;

	/**
对方id
 */
@property (nonatomic, assign) int64_t touid;

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

 +(NSMutableArray<ApiCloseLineModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiCloseLineModel*>*)list;

 +(ApiCloseLineModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiCloseLineModel*) source target:(ApiCloseLineModel*)target;

@end

NS_ASSUME_NONNULL_END
