//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
常用语
 */
@interface AppCommonWordsModel : NSObject 


	/**
常用语内容
 */
@property (nonatomic, copy) NSString * name;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
常用语类型1一对一常用语
 */
@property (nonatomic, assign) int type;

 +(NSMutableArray<AppCommonWordsModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppCommonWordsModel*>*)list;

 +(AppCommonWordsModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppCommonWordsModel*) source target:(AppCommonWordsModel*)target;

@end

NS_ASSUME_NONNULL_END
