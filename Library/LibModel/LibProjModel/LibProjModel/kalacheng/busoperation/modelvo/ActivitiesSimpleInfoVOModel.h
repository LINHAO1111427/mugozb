//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
运营活动列表简单信息
 */
@interface ActivitiesSimpleInfoVOModel : NSObject 


	/**
活动的结束时间
 */
@property (nonatomic,copy) NSDate * endDate;

	/**
活动图片
 */
@property (nonatomic, copy) NSString * activityImg;

	/**
活动url地址
 */
@property (nonatomic, copy) NSString * activityLink;

	/**
活动名称
 */
@property (nonatomic, copy) NSString * activityName;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
活动描述
 */
@property (nonatomic, copy) NSString * activityDescribe;

	/**
是否过期 0:未过期 1:已过期
 */
@property (nonatomic, assign) int isExpired;

	/**
活动的开始时间
 */
@property (nonatomic,copy) NSDate * startDate;

 +(NSMutableArray<ActivitiesSimpleInfoVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ActivitiesSimpleInfoVOModel*>*)list;

 +(ActivitiesSimpleInfoVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ActivitiesSimpleInfoVOModel*) source target:(ActivitiesSimpleInfoVOModel*)target;

@end

NS_ASSUME_NONNULL_END
