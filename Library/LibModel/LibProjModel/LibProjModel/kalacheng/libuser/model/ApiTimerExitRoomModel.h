//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP计时房间余额不足退出房间
 */
@interface ApiTimerExitRoomModel : NSObject 


	/**
null
 */
@property (nonatomic, assign) int64_t serialVersionUID;

	/**
房间号
 */
@property (nonatomic, assign) int64_t roomId;

	/**
退出用户id
 */
@property (nonatomic, assign) int64_t userId;

 +(NSMutableArray<ApiTimerExitRoomModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiTimerExitRoomModel*>*)list;

 +(ApiTimerExitRoomModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiTimerExitRoomModel*) source target:(ApiTimerExitRoomModel*)target;

@end

NS_ASSUME_NONNULL_END
