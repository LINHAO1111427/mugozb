//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP直播/一对一/短视频等标签
 */
@interface AppLiveTagModel : NSObject 


	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
标签样式
 */
@property (nonatomic, copy) NSString * tagStyle;

	/**
直播标签名
 */
@property (nonatomic, copy) NSString * name;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
排序
 */
@property (nonatomic, assign) int sort;

	/**
是否开启 0：关闭， 1开启
 */
@property (nonatomic, assign) int isTip;

	/**
直播频道
 */
@property (nonatomic, assign) int64_t channel_id;

 +(NSMutableArray<AppLiveTagModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppLiveTagModel*>*)list;

 +(AppLiveTagModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppLiveTagModel*) source target:(AppLiveTagModel*)target;

@end

NS_ASSUME_NONNULL_END
