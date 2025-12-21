//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
短视频广告VO
 */
@interface ShortVideoAdsVOModel : NSObject 


	/**
短视频广告轮播图地址
 */
@property (nonatomic, copy) NSString * adsBannerUrl;

	/**
短视频广告链接
 */
@property (nonatomic, copy) NSString * adsUrl;

	/**
短视频广告头像
 */
@property (nonatomic, copy) NSString * avatarAds;

	/**
短视频广告标题
 */
@property (nonatomic, copy) NSString * adsTitle;

	/**
短视频广告类型 1：头像广告 2:轮播图广告
 */
@property (nonatomic, assign) int adsType;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

 +(NSMutableArray<ShortVideoAdsVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShortVideoAdsVOModel*>*)list;

 +(ShortVideoAdsVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShortVideoAdsVOModel*) source target:(ShortVideoAdsVOModel*)target;

@end

NS_ASSUME_NONNULL_END
