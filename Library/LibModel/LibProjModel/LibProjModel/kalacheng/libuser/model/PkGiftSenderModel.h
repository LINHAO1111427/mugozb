//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
Pk中的礼物发送者
 */
@interface PkGiftSenderModel : NSObject 


	/**
直播间类型 1语音PK 2视频PK
 */
@property (nonatomic, assign) int isVoicePk;

	/**
头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
用户ID
 */
@property (nonatomic, assign) int64_t userId;

	/**
在该PK小队中的送礼总值
 */
@property (nonatomic, assign) double coin;

	/**
PK类型
 */
@property (nonatomic, assign) int pkType;

 +(NSMutableArray<PkGiftSenderModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<PkGiftSenderModel*>*)list;

 +(PkGiftSenderModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(PkGiftSenderModel*) source target:(PkGiftSenderModel*)target;

@end

NS_ASSUME_NONNULL_END
