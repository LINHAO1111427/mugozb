//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class AppHomeMyFamilyVOModel;
NS_ASSUME_NONNULL_BEGIN




/**
用户所有聊天家族信息VO
 */
@interface AppHomeMyAllFamilyVOModel : NSObject 


	/**
是否可以创建家族 0：不可以 1：可以
 */
@property (nonatomic, assign) int isCreateFamily;

	/**
我的家族集合
 */
@property (nonatomic, strong) NSMutableArray<AppHomeMyFamilyVOModel*>* appHomeMyFamilyVOList;

	/**
是否是多家族模式 0：不是 1：是
 */
@property (nonatomic, assign) int isMultipleFamily;

 +(NSMutableArray<AppHomeMyAllFamilyVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppHomeMyAllFamilyVOModel*>*)list;

 +(AppHomeMyAllFamilyVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppHomeMyAllFamilyVOModel*) source target:(AppHomeMyAllFamilyVOModel*)target;

@end

NS_ASSUME_NONNULL_END
