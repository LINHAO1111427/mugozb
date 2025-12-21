//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
通话评价列表
 */
@interface AppTabInfoModel : NSObject 


	/**
标签类型ID
 */
@property (nonatomic, assign) int64_t tabTypeId;

	/**
tab名称
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
tab描述
 */
@property (nonatomic, copy) NSString * desr;

	/**
tab字体颜色
 */
@property (nonatomic, copy) NSString * fontColor;

 +(NSMutableArray<AppTabInfoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppTabInfoModel*>*)list;

 +(AppTabInfoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppTabInfoModel*) source target:(AppTabInfoModel*)target;

@end

NS_ASSUME_NONNULL_END
