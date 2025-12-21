//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP主播修改连麦状态socket
 */
@interface ApiAnchorLineStatusModel : NSObject 


	/**
null
 */
@property (nonatomic, assign) int64_t serialVersionUID;

	/**
连麦状态1开启2关闭
 */
@property (nonatomic, assign) int status;

	/**
对方房间id
 */
@property (nonatomic, assign) int64_t roomId;

	/**
对方用户id
 */
@property (nonatomic, assign) int64_t uid;

	/**
状态1成功2失败
 */
@property (nonatomic, assign) int code;

	/**
状态描述
 */
@property (nonatomic, copy) NSString * msg;

 +(NSMutableArray<ApiAnchorLineStatusModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiAnchorLineStatusModel*>*)list;

 +(ApiAnchorLineStatusModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiAnchorLineStatusModel*) source target:(ApiAnchorLineStatusModel*)target;

@end

NS_ASSUME_NONNULL_END
