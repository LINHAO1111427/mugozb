//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class NobLiveGiftModel;
NS_ASSUME_NONNULL_BEGIN




/**
直播礼物列表响应
 */
@interface ApiNobLiveGiftModel : NSObject 


	/**
礼物列表
 */
@property (nonatomic, strong) NSMutableArray<NobLiveGiftModel*>* giftList;

	/**
背包礼物总价值
 */
@property (nonatomic, assign) double backGiftCoin;

	/**
礼物类型名称
 */
@property (nonatomic, copy) NSString * giftTypeName;

	/**
礼物类型id
 */
@property (nonatomic, assign) int giftTypeId;

	/**
用户余额
 */
@property (nonatomic, assign) double coin;

 +(NSMutableArray<ApiNobLiveGiftModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiNobLiveGiftModel*>*)list;

 +(ApiNobLiveGiftModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiNobLiveGiftModel*) source target:(ApiNobLiveGiftModel*)target;

@end

NS_ASSUME_NONNULL_END
