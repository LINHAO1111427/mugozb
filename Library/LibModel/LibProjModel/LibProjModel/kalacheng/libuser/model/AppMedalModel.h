//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
勋章
 */
@interface AppMedalModel : NSObject 


	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
勋章logo
 */
@property (nonatomic, copy) NSString * medalLogo;

	/**
勋章名称
 */
@property (nonatomic, copy) NSString * name;

	/**
勋章级别
 */
@property (nonatomic, assign) int lv;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
类型 1:用户勋章 2：财富勋章 4：贵族勋章 5：守护勋章
 */
@property (nonatomic, assign) int type;

	/**
简介描述
 */
@property (nonatomic, copy) NSString * desr;

 +(NSMutableArray<AppMedalModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppMedalModel*>*)list;

 +(AppMedalModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppMedalModel*) source target:(AppMedalModel*)target;

@end

NS_ASSUME_NONNULL_END
