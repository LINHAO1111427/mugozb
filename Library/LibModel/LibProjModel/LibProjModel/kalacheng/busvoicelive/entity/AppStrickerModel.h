//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
表情包
 */
@interface AppStrickerModel : NSObject 


	/**
表情动图url地址
 */
@property (nonatomic, copy) NSString * gifUrl;

	/**
表情名称
 */
@property (nonatomic, copy) NSString * name;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
表情动图时长
 */
@property (nonatomic, assign) double gifDuration;

	/**
表情图片url地址
 */
@property (nonatomic, copy) NSString * url;

 +(NSMutableArray<AppStrickerModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppStrickerModel*>*)list;

 +(AppStrickerModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppStrickerModel*) source target:(AppStrickerModel*)target;

@end

NS_ASSUME_NONNULL_END
