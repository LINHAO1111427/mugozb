//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class TabInfoDtoModel;
NS_ASSUME_NONNULL_BEGIN




/**
后台兴趣标签DTO
 */
@interface TabTypeDtoModel : NSObject 


	/**
tab类型名称
 */
@property (nonatomic, copy) NSString * name;

	/**
兴趣标签列表
 */
@property (nonatomic, strong) NSMutableArray<TabInfoDtoModel*>* tabInfoList;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
排序
 */
@property (nonatomic, assign) int sort;

	/**
标签描述
 */
@property (nonatomic, copy) NSString * desr;

 +(NSMutableArray<TabTypeDtoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<TabTypeDtoModel*>*)list;

 +(TabTypeDtoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(TabTypeDtoModel*) source target:(TabTypeDtoModel*)target;

@end

NS_ASSUME_NONNULL_END
