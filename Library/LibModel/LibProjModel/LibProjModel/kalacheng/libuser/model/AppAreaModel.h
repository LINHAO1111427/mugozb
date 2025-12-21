//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
城市列表
 */
@interface AppAreaModel : NSObject 


	/**
城市编号, 咱不管， 为后续做考虑
 */
@property (nonatomic, assign) int code;

	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
城市名称（带省，市，区单位）
 */
@property (nonatomic, copy) NSString * name;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
城市简称， 不带省市区
 */
@property (nonatomic, copy) NSString * shortName;

	/**
是否热门城市 0：否 1：是
 */
@property (nonatomic, assign) int isHot;

 +(NSMutableArray<AppAreaModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppAreaModel*>*)list;

 +(AppAreaModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppAreaModel*) source target:(AppAreaModel*)target;

@end

NS_ASSUME_NONNULL_END
