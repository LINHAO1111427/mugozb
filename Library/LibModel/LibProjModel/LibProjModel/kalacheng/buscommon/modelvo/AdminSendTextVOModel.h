//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
后台向app端发送文本消息
 */
@interface AdminSendTextVOModel : NSObject 


	/**
null
 */
@property (nonatomic, assign) int64_t serialVersionUID;

	/**
用户id
 */
@property (nonatomic, assign) int64_t userId;

	/**
消息内容
 */
@property (nonatomic, copy) NSString * msgContext;

 +(NSMutableArray<AdminSendTextVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AdminSendTextVOModel*>*)list;

 +(AdminSendTextVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AdminSendTextVOModel*) source target:(AdminSendTextVOModel*)target;

@end

NS_ASSUME_NONNULL_END
