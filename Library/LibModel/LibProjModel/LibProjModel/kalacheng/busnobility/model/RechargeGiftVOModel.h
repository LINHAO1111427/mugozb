//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class GiftPackVOModel;
NS_ASSUME_NONNULL_BEGIN




/**
充值礼物model
 */
@interface RechargeGiftVOModel : NSObject 


	/**
null
 */
@property (nonatomic, strong) NSMutableArray<GiftPackVOModel*>* giftList;

	/**
充值价格
 */
@property (nonatomic, assign) double money;

	/**
充值价格id
 */
@property (nonatomic, assign) int64_t id_field;

	/**
礼包中金币值
 */
@property (nonatomic, assign) int coin;

 +(NSMutableArray<RechargeGiftVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<RechargeGiftVOModel*>*)list;

 +(RechargeGiftVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(RechargeGiftVOModel*) source target:(RechargeGiftVOModel*)target;

@end

NS_ASSUME_NONNULL_END
