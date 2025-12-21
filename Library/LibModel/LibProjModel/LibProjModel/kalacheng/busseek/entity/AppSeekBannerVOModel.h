//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
寻觅bannerVo
 */
@interface AppSeekBannerVOModel : NSObject 


	/**
轮播图地址
 */
@property (nonatomic, copy) NSString * bannerImage;

	/**
轮播标题
 */
@property (nonatomic, copy) NSString * bannerTitle;

	/**
轮播类型 1：首页轮播图
 */
@property (nonatomic, assign) int bannerType;

	/**
轮播链接
 */
@property (nonatomic, copy) NSString * bannerLink;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
是否启用 0.不启用，1.启用
 */
@property (nonatomic, assign) int isEnable;

 +(NSMutableArray<AppSeekBannerVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppSeekBannerVOModel*>*)list;

 +(AppSeekBannerVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppSeekBannerVOModel*) source target:(AppSeekBannerVOModel*)target;

@end

NS_ASSUME_NONNULL_END
