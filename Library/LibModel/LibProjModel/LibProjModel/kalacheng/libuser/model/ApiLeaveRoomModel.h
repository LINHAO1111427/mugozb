//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP离开直播响应
 */
@interface ApiLeaveRoomModel : NSObject 


	/**
是否从麦位上退出的房间  1是 0否
 */
@property (nonatomic, assign) int isOnAssistan;

	/**
用户id
 */
@property (nonatomic, assign) int64_t uid;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * userAvatar;

	/**
离开后房间人数
 */
@property (nonatomic, assign) int watchNumber;

	/**
房主ID
 */
@property (nonatomic, assign) int64_t anchorId;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * userName;

	/**
推送内容
 */
@property (nonatomic, copy) NSString * content;

	/**
房间号
 */
@property (nonatomic, assign) int64_t roomId;

 +(NSMutableArray<ApiLeaveRoomModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiLeaveRoomModel*>*)list;

 +(ApiLeaveRoomModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiLeaveRoomModel*) source target:(ApiLeaveRoomModel*)target;

@end

NS_ASSUME_NONNULL_END
