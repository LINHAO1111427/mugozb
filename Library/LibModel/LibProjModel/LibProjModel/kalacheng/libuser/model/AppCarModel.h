//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
App坐骑表
 */
@interface AppCarModel : NSObject 


	/**
是等级坐骑（财富和贵族） 1:是 0:否
 */
@property (nonatomic, assign) int vipCar;

	/**
序号
 */
@property (nonatomic, assign) int orderno;

	/**
动画链接
 */
@property (nonatomic, copy) NSString * swf;

	/**
图片链接
 */
@property (nonatomic, copy) NSString * thumb;

	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addtime;

	/**
名称
 */
@property (nonatomic, copy) NSString * name;

	/**
价格
 */
@property (nonatomic, assign) double needcoin;

	/**
进场话术
 */
@property (nonatomic, copy) NSString * words;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
动画时长
 */
@property (nonatomic, assign) double swftime;

	/**
状态（0显示1不显示）
 */
@property (nonatomic, assign) int status;

	/**
更新时间
 */
@property (nonatomic,copy) NSDate * uptime;

 +(NSMutableArray<AppCarModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppCarModel*>*)list;

 +(AppCarModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppCarModel*) source target:(AppCarModel*)target;

@end

NS_ASSUME_NONNULL_END
