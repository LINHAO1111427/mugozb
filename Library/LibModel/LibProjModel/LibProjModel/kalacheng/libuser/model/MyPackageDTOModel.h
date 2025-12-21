//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class AppUsersMicSeatBorderVOModel;
 @class AppLiangModel;
 @class AppUsersCarModel;
 @class NobLiveGiftModel;
NS_ASSUME_NONNULL_BEGIN




/**
我的背包
 */
@interface MyPackageDTOModel : NSObject 


	/**
麦位饰品集合
 */
@property (nonatomic, strong) NSMutableArray<AppUsersMicSeatBorderVOModel*>* userMicSeatList;

	/**
靓号集合
 */
@property (nonatomic, strong) NSMutableArray<AppLiangModel*>* userLiangList;

	/**
是否有语音模块, 返回h5页面数据，控制前端是否展示语音相关模块, 0无，1有
 */
@property (nonatomic, assign) int haveModuleVoiceLive;

	/**
坐骑集合
 */
@property (nonatomic, strong) NSMutableArray<AppUsersCarModel*>* userCarList;

	/**
礼物集合
 */
@property (nonatomic, strong) NSMutableArray<NobLiveGiftModel*>* myGiftList;

 +(NSMutableArray<MyPackageDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<MyPackageDTOModel*>*)list;

 +(MyPackageDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(MyPackageDTOModel*) source target:(MyPackageDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
