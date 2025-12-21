//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
官方消息
 */
@interface AppOfficialNewsDTOModel : NSObject 


	/**
发布时间
 */
@property (nonatomic,copy) NSDate * publishTime;

	/**
是否已读：1已读，0未读
 */
@property (nonatomic, assign) int isRead;

	/**
图片
 */
@property (nonatomic, copy) NSString * logo;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
消息标题
 */
@property (nonatomic, copy) NSString * title;

	/**
消息内容
 */
@property (nonatomic, copy) NSString * content;

	/**
消息简介
 */
@property (nonatomic, copy) NSString * introduction;

 +(NSMutableArray<AppOfficialNewsDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppOfficialNewsDTOModel*>*)list;

 +(AppOfficialNewsDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppOfficialNewsDTOModel*) source target:(AppOfficialNewsDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
