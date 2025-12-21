//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
查询时间
 */
@interface CfgSearchDateModel : NSObject 


	/**
查询范围值
 */
@property (nonatomic, assign) int val;

	/**
标准值单位
 */
@property (nonatomic, copy) NSString * unit;

	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
时间间隔描述
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
类型 1:分钟  2：小时 3：天 4：月  5：年
 */
@property (nonatomic, assign) int type;

 +(NSMutableArray<CfgSearchDateModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<CfgSearchDateModel*>*)list;

 +(CfgSearchDateModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(CfgSearchDateModel*) source target:(CfgSearchDateModel*)target;

@end

NS_ASSUME_NONNULL_END
