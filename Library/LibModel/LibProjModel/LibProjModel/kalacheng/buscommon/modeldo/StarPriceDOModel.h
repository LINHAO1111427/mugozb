//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
主播星级相关的价格
 */
@interface StarPriceDOModel : NSObject 


	/**
金币对应人名币价格
 */
@property (nonatomic, assign) double money;

	/**
价格
 */
@property (nonatomic, assign) double price;

	/**
视频通话价格
 */
@property (nonatomic, assign) double videoCoin;

	/**
语音通话价格
 */
@property (nonatomic, assign) double voiceCoin;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

 +(NSMutableArray<StarPriceDOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<StarPriceDOModel*>*)list;

 +(StarPriceDOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(StarPriceDOModel*) source target:(StarPriceDOModel*)target;

@end

NS_ASSUME_NONNULL_END
