//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
用户设置vo
 */
@interface UserSettingInfoVOModel : NSObject 


	/**
礼物全局广播 0:关闭 1:开启
 */
@property (nonatomic, assign) int giftGlobalBroadcast;

	/**
隐藏位置 0:未开启 1:开启
 */
@property (nonatomic, assign) int whetherEnablePositioningShow;

 +(NSMutableArray<UserSettingInfoVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<UserSettingInfoVOModel*>*)list;

 +(UserSettingInfoVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(UserSettingInfoVOModel*) source target:(UserSettingInfoVOModel*)target;

@end

NS_ASSUME_NONNULL_END
