//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
用户评论未读数消息
 */
@interface ApiSendVideoUnReadNumberModel : NSObject 


	/**
null
 */
@property (nonatomic, assign) int64_t serialVersionUID;

	/**
消息条数
 */
@property (nonatomic, assign) int number;

	/**
状态1成功2失败
 */
@property (nonatomic, assign) int code;

	/**
状态描述
 */
@property (nonatomic, copy) NSString * msg;

 +(NSMutableArray<ApiSendVideoUnReadNumberModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiSendVideoUnReadNumberModel*>*)list;

 +(ApiSendVideoUnReadNumberModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiSendVideoUnReadNumberModel*) source target:(ApiSendVideoUnReadNumberModel*)target;

@end

NS_ASSUME_NONNULL_END
