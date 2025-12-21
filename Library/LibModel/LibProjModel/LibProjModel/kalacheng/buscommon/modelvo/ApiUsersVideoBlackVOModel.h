//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP查询拉黑信息
 */
@interface ApiUsersVideoBlackVOModel : NSObject 


	/**
视频是否被拉黑 0：未拉黑 1：已拉黑
 */
@property (nonatomic, assign) int videoBlack;

	/**
被拉黑用户id
 */
@property (nonatomic, assign) int64_t toUId;

	/**
用户是否被拉黑 0：未拉黑 1：已拉黑
 */
@property (nonatomic, assign) int userBlack;

	/**
语音是否被拉黑 0：未拉黑 1：已拉黑
 */
@property (nonatomic, assign) int voiceBlack;

	/**
文本是否被拉黑 0：未拉黑 1：已拉黑
 */
@property (nonatomic, assign) int textBlack;

	/**
当前用户id
 */
@property (nonatomic, assign) int64_t userId;

 +(NSMutableArray<ApiUsersVideoBlackVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUsersVideoBlackVOModel*>*)list;

 +(ApiUsersVideoBlackVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiUsersVideoBlackVOModel*) source target:(ApiUsersVideoBlackVOModel*)target;

@end

NS_ASSUME_NONNULL_END
