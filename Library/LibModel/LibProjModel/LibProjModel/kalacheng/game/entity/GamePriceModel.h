//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
游戏价格表
 */
@interface GamePriceModel : NSObject 


	/**
游戏id
 */
@property (nonatomic, assign) int64_t gameId;

	/**
抽奖次数
 */
@property (nonatomic, assign) int gameNum;

	/**
添加时间
 */
@property (nonatomic, copy) NSString * addTime;

	/**
名称
 */
@property (nonatomic, copy) NSString * name;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
备注
 */
@property (nonatomic, copy) NSString * remake;

	/**
时间对应毫秒值
 */
@property (nonatomic, assign) int64_t time;

	/**
消耗金币数
 */
@property (nonatomic, assign) int useCoin;

 +(NSMutableArray<GamePriceModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GamePriceModel*>*)list;

 +(GamePriceModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(GamePriceModel*) source target:(GamePriceModel*)target;

@end

NS_ASSUME_NONNULL_END
