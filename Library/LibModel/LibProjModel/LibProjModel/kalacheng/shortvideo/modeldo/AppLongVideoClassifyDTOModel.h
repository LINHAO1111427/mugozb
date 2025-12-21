//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
长视频分类组合，包含一级，二级分类
 */
@interface AppLongVideoClassifyDTOModel : NSObject 


	/**
广告链接
 */
@property (nonatomic, copy) NSString * adsUrl;

	/**
轮播图
 */
@property (nonatomic, copy) NSString * carouselImageUrl;

	/**
是否是广告 0:不是  1：是
 */
@property (nonatomic, assign) int isAds;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
上级id
 */
@property (nonatomic, assign) int64_t superiorId;

	/**
分类名称
 */
@property (nonatomic, copy) NSString * classifyName;

	/**
轮播图广告地址
 */
@property (nonatomic, copy) NSString * carouselImageAdsUrl;

	/**
序号
 */
@property (nonatomic, assign) int serialNo;

 +(NSMutableArray<AppLongVideoClassifyDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppLongVideoClassifyDTOModel*>*)list;

 +(AppLongVideoClassifyDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppLongVideoClassifyDTOModel*) source target:(AppLongVideoClassifyDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
