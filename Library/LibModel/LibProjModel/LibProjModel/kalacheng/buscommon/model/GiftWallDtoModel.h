//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
礼物墙返回结果
 */
@interface GiftWallDtoModel : NSObject 


	/**
null
 */
@property (nonatomic, copy) NSString * gifticon;

	/**
null
 */
@property (nonatomic, copy) NSString * giftname;

	/**
null
 */
@property (nonatomic, assign) int64_t giftId;

	/**
null
 */
@property (nonatomic, assign) double needScore;

	/**
null
 */
@property (nonatomic, assign) int totalNum;

 +(NSMutableArray<GiftWallDtoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GiftWallDtoModel*>*)list;

 +(GiftWallDtoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(GiftWallDtoModel*) source target:(GiftWallDtoModel*)target;

@end

NS_ASSUME_NONNULL_END
