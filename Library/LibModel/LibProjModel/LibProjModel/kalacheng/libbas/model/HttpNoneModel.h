//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
没有实际业务用途，在API不需要反复内容时的占位用。
 */
@interface HttpNoneModel : NSObject 


	/**
没有用的东西
 */
@property (nonatomic, copy) NSString * no_use;

 +(NSMutableArray<HttpNoneModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<HttpNoneModel*>*)list;

 +(HttpNoneModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(HttpNoneModel*) source target:(HttpNoneModel*)target;

@end

NS_ASSUME_NONNULL_END
