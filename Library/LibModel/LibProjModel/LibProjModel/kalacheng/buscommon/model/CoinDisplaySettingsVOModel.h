//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
金币显示设置
 */
@interface CoinDisplaySettingsVOModel : NSObject 


	/**
男士聊场余额显示(IOS) 1:显示 0:不显示
 */
@property (nonatomic, assign) int iosChatSquareDisplay;

	/**
通话直播间余额显示(IOS) 1:显示 0:不显示
 */
@property (nonatomic, assign) int iosLiveDisplay;

	/**
通话直播间余额显示(安卓) 1:显示 0:不显示
 */
@property (nonatomic, assign) int androidLiveDisplay;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
ios金币显示总开关 1:显示 0:不显示
 */
@property (nonatomic, assign) int iosCoinShow;

	/**
安卓金币显示总开关 1:显示 0:不显示
 */
@property (nonatomic, assign) int androidCoinShow;

	/**
男士聊场余额显示(安卓) 1:显示 0:不显示
 */
@property (nonatomic, assign) int androidChatSquareDisplay;

 +(NSMutableArray<CoinDisplaySettingsVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<CoinDisplaySettingsVOModel*>*)list;

 +(CoinDisplaySettingsVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(CoinDisplaySettingsVOModel*) source target:(CoinDisplaySettingsVOModel*)target;

@end

NS_ASSUME_NONNULL_END
