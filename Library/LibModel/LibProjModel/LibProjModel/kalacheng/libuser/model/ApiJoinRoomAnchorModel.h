//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP主播回来直播响应
 */
@interface ApiJoinRoomAnchorModel : NSObject 


	/**
null
 */
@property (nonatomic, assign) int64_t serialVersionUID;

	/**
房间号
 */
@property (nonatomic, assign) int64_t roomId;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * userName;

	/**
用户id
 */
@property (nonatomic, assign) int64_t anchorId;

	/**
推送内容
 */
@property (nonatomic, copy) NSString * content;

 +(NSMutableArray<ApiJoinRoomAnchorModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiJoinRoomAnchorModel*>*)list;

 +(ApiJoinRoomAnchorModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiJoinRoomAnchorModel*) source target:(ApiJoinRoomAnchorModel*)target;

@end

NS_ASSUME_NONNULL_END
