//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
送礼物时,收礼方信息集合
 */
@interface GiftSenderDataModel : NSObject 


	/**
直播标识
 */
@property (nonatomic, copy) NSString * showId;

	/**
收礼方id
 */
@property (nonatomic, assign) int64_t taggerUserId;

	/**
收礼方所在房间的主播id
 */
@property (nonatomic, assign) int64_t anchorId;

	/**
房间号
 */
@property (nonatomic, assign) int64_t roomId;

 +(NSMutableArray<GiftSenderDataModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GiftSenderDataModel*>*)list;

 +(GiftSenderDataModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(GiftSenderDataModel*) source target:(GiftSenderDataModel*)target;

@end

NS_ASSUME_NONNULL_END
