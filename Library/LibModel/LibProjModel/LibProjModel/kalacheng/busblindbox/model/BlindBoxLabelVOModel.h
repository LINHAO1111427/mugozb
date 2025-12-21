//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
盲盒用户标签
 */
@interface BlindBoxLabelVOModel : NSObject 


	/**
是否启用 0:不启用 1: 启用
 */
@property (nonatomic, assign) int enable;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
标签名称
 */
@property (nonatomic, copy) NSString * label;

	/**
是否选中 0未选中  1选中
 */
@property (nonatomic, assign) int selected;

 +(NSMutableArray<BlindBoxLabelVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<BlindBoxLabelVOModel*>*)list;

 +(BlindBoxLabelVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(BlindBoxLabelVOModel*) source target:(BlindBoxLabelVOModel*)target;

@end

NS_ASSUME_NONNULL_END
