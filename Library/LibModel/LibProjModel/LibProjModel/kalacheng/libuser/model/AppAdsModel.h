//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
轮播图
 */
@interface AppAdsModel : NSObject 


	/**
描述
 */
@property (nonatomic, copy) NSString * des;

	/**
序号
 */
@property (nonatomic, assign) int orderno;

	/**
图片链接
 */
@property (nonatomic, copy) NSString * thumb;

	/**
时间
 */
@property (nonatomic,copy) NSDate * addtime;

	/**
广告名称
 */
@property (nonatomic, copy) NSString * name;

	/**
一级分类(启动图1,0;直播2,1;推荐3,2;附近4,3;一对一5,n;短视频看点6,7;语聊15,1;电台16,1;直播购17,1)
 */
@property (nonatomic, assign) int pid;

	/**
启动图播放时长
 */
@property (nonatomic, assign) int playTime;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
链接
 */
@property (nonatomic, copy) NSString * url;

	/**
二级分类
 */
@property (nonatomic, assign) int sid;

 +(NSMutableArray<AppAdsModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppAdsModel*>*)list;

 +(AppAdsModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppAdsModel*) source target:(AppAdsModel*)target;

@end

NS_ASSUME_NONNULL_END
