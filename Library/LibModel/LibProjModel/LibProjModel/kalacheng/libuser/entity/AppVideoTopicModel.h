//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
动态话题
 */
@interface AppVideoTopicModel : NSObject 


	/**
主题图片
 */
@property (nonatomic, copy) NSString * image;

	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
背景色
 */
@property (nonatomic, copy) NSString * tagStyle;

	/**
话题名
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
是否热门0：非热门， 1热门
 */
@property (nonatomic, assign) int isHot;

 +(NSMutableArray<AppVideoTopicModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppVideoTopicModel*>*)list;

 +(AppVideoTopicModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppVideoTopicModel*) source target:(AppVideoTopicModel*)target;

@end

NS_ASSUME_NONNULL_END
