//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
标签详情
 */
@interface TabInfoDtoModel : NSObject 


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

	/**
兴趣标签选中状态： 0：未选中  1：已选中
 */
@property (nonatomic, assign) int status;

 +(NSMutableArray<TabInfoDtoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<TabInfoDtoModel*>*)list;

 +(TabInfoDtoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(TabInfoDtoModel*) source target:(TabInfoDtoModel*)target;

@end

NS_ASSUME_NONNULL_END
