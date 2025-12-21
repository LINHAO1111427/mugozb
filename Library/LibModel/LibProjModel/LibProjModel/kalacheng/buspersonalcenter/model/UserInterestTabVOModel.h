//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
用户兴趣标签
 */
@interface UserInterestTabVOModel : NSObject 


	/**
标签名称
 */
@property (nonatomic, copy) NSString * name;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
tab字体颜色
 */
@property (nonatomic, copy) NSString * fontColor;

 +(NSMutableArray<UserInterestTabVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<UserInterestTabVOModel*>*)list;

 +(UserInterestTabVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(UserInterestTabVOModel*) source target:(UserInterestTabVOModel*)target;

@end

NS_ASSUME_NONNULL_END
