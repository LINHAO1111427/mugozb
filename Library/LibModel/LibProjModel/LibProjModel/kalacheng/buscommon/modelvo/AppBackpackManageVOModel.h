//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
系统背景图设置VO
 */
@interface AppBackpackManageVOModel : NSObject 


	/**
谁看过我-开通贵族提示窗
 */
@property (nonatomic, copy) NSString * whoLooksAtMe;

	/**
视频连麦背景图
 */
@property (nonatomic, copy) NSString * videoLink;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

 +(NSMutableArray<AppBackpackManageVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppBackpackManageVOModel*>*)list;

 +(AppBackpackManageVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppBackpackManageVOModel*) source target:(AppBackpackManageVOModel*)target;

@end

NS_ASSUME_NONNULL_END
