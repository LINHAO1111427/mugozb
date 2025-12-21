//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP主播离开直播响应
 */
@interface ApiLeaveRoomAnchorModel : NSObject 


	/**
null
 */
@property (nonatomic, assign) int64_t serialVersionUID;

	/**
房间号
 */
@property (nonatomic, assign) int64_t roomId;

	/**
主播名称
 */
@property (nonatomic, copy) NSString * userName;

	/**
主播id
 */
@property (nonatomic, assign) int64_t anchorId;

	/**
推送内容
 */
@property (nonatomic, copy) NSString * content;

 +(NSMutableArray<ApiLeaveRoomAnchorModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiLeaveRoomAnchorModel*>*)list;

 +(ApiLeaveRoomAnchorModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiLeaveRoomAnchorModel*) source target:(ApiLeaveRoomAnchorModel*)target;

@end

NS_ASSUME_NONNULL_END
