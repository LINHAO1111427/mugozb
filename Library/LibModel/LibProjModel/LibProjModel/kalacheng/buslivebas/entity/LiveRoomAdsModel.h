//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
直播间内广告
 */
@interface LiveRoomAdsModel : NSObject 


	/**
广告跳转类型 1:外部链接 2：app内链接 3：二级广告
 */
@property (nonatomic, assign) int adsJumpType;

	/**
更新时间
 */
@property (nonatomic,copy) NSDate * upTime;

	/**
直播间广告链接
 */
@property (nonatomic, copy) NSString * adsUrl;

	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
直播间广告标题
 */
@property (nonatomic, copy) NSString * adsTitle;

	/**
广告等级
 */
@property (nonatomic, assign) int adsLevel;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
直播间广告图片
 */
@property (nonatomic, copy) NSString * adsImage;

	/**
上级id
 */
@property (nonatomic, assign) int64_t superiorId;

	/**
是否开启 0：关闭 1：开启
 */
@property (nonatomic, assign) int isEnable;

 +(NSMutableArray<LiveRoomAdsModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<LiveRoomAdsModel*>*)list;

 +(LiveRoomAdsModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(LiveRoomAdsModel*) source target:(LiveRoomAdsModel*)target;

@end

NS_ASSUME_NONNULL_END
