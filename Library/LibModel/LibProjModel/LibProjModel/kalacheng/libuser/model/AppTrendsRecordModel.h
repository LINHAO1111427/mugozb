//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
我的动态记录
 */
@interface AppTrendsRecordModel : NSObject 


	/**
定位地址
 */
@property (nonatomic, copy) NSString * address;

	/**
预留字段1
 */
@property (nonatomic, copy) NSString * reserve4;

	/**
纬度
 */
@property (nonatomic, copy) NSString * latitude;

	/**
预留字段1（此字段已被占用）
 */
@property (nonatomic, copy) NSString * reserve1;

	/**
预留字段1
 */
@property (nonatomic, copy) NSString * reserve3;

	/**
目标用户ID, 无则默认0(前端不要使用)
 */
@property (nonatomic, assign) int64_t targetUserId;

	/**
预留字段1
 */
@property (nonatomic, copy) NSString * reserve2;

	/**
资源null, 1：图片、封面地址 2：视频地址  3：文字， 4：流
 */
@property (nonatomic, copy) NSString * source;

	/**
动态标题
 */
@property (nonatomic, copy) NSString * title;

	/**
业务类型， 参考TrendsType的枚举
 */
@property (nonatomic, assign) int type;

	/**
动态用户ID
 */
@property (nonatomic, assign) int64_t userId;

	/**
目标ID, 无则默认0(前端可以使用)
 */
@property (nonatomic, assign) int64_t fkId;

	/**
对应的记录ID
 */
@property (nonatomic, assign) int64_t recordId;

	/**
创建时间
 */
@property (nonatomic,copy) NSDate * createTime;

	/**
资源类型；0：未知，1：图片；2：视频; 3:文字，4：流
 */
@property (nonatomic, assign) int sourceType;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
经度
 */
@property (nonatomic, copy) NSString * longitude;

 +(NSMutableArray<AppTrendsRecordModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppTrendsRecordModel*>*)list;

 +(AppTrendsRecordModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppTrendsRecordModel*) source target:(AppTrendsRecordModel*)target;

@end

NS_ASSUME_NONNULL_END
