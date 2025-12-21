//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
看点广告
 */
@interface ShortVideoWatchAdsModel : NSObject 


	/**
看点广告图标
 */
@property (nonatomic, copy) NSString * adsIcon;

	/**
更新时间
 */
@property (nonatomic,copy) NSDate * upTime;

	/**
看点广告链接
 */
@property (nonatomic, copy) NSString * adsUrl;

	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
看点广告标题
 */
@property (nonatomic, copy) NSString * adsTitle;

	/**
看点广告类型 1：图片广告 2:文字广告
 */
@property (nonatomic, assign) int adsType;

	/**
看点广告文字描述
 */
@property (nonatomic, copy) NSString * adsDescription;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
看点广告是否启用 0：不启用 1:启用
 */
@property (nonatomic, assign) int isEnable;

 +(NSMutableArray<ShortVideoWatchAdsModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShortVideoWatchAdsModel*>*)list;

 +(ShortVideoWatchAdsModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShortVideoWatchAdsModel*) source target:(ShortVideoWatchAdsModel*)target;

@end

NS_ASSUME_NONNULL_END
