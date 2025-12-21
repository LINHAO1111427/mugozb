//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class AppLongVideoClassifyDTOModel;
NS_ASSUME_NONNULL_BEGIN




/**
长视频分类组合，包含一级，二级分类
 */
@interface AppLongVideoClassifyVOModel : NSObject 


	/**
一级分类id
 */
@property (nonatomic, assign) int64_t classifyId;

	/**
一级分类下所有的二级分类信息
 */
@property (nonatomic, strong) NSMutableArray<AppLongVideoClassifyDTOModel*>* appLongVideoClassifyDTOList;

	/**
一级分类名称
 */
@property (nonatomic, copy) NSString * classifyName;

 +(NSMutableArray<AppLongVideoClassifyVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppLongVideoClassifyVOModel*>*)list;

 +(AppLongVideoClassifyVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppLongVideoClassifyVOModel*) source target:(AppLongVideoClassifyVOModel*)target;

@end

NS_ASSUME_NONNULL_END
