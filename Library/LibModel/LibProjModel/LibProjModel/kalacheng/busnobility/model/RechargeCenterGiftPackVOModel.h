//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class GiftPackVOModel;
NS_ASSUME_NONNULL_BEGIN




/**
充值中心充值礼包
 */
@interface RechargeCenterGiftPackVOModel : NSObject 


	/**
null
 */
@property (nonatomic, strong) NSMutableArray<GiftPackVOModel*>* giftList;

	/**
奖励分类名称（金币，坐骑，短视频，礼物）
 */
@property (nonatomic, copy) NSString * name;

 +(NSMutableArray<RechargeCenterGiftPackVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<RechargeCenterGiftPackVOModel*>*)list;

 +(RechargeCenterGiftPackVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(RechargeCenterGiftPackVOModel*) source target:(RechargeCenterGiftPackVOModel*)target;

@end

NS_ASSUME_NONNULL_END
