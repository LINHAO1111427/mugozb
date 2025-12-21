//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class GameAwardsVOModel;
 @class GamePriceModel;
NS_ASSUME_NONNULL_BEGIN




/**
获取游戏奖项以及收费标准
 */
@interface GameAwardsAndPriceDTOModel : NSObject 


	/**
幸运宝箱结束时间
 */
@property (nonatomic, copy) NSString * luckyEndTime;

	/**
幸运加成总次数
 */
@property (nonatomic, assign) int luckyPrizeNum;

	/**
特别说明
 */
@property (nonatomic, copy) NSString * specialNote;

	/**
用户抽奖次数
 */
@property (nonatomic, assign) int userLuckyNum;

	/**
游戏奖项
 */
@property (nonatomic, strong) NSMutableArray<GameAwardsVOModel*>* gameAwardsList;

	/**
幸运宝箱开启时间
 */
@property (nonatomic, copy) NSString * luckyStartTime;

	/**
游戏收费
 */
@property (nonatomic, strong) NSMutableArray<GamePriceModel*>* gamePriceList;

 +(NSMutableArray<GameAwardsAndPriceDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GameAwardsAndPriceDTOModel*>*)list;

 +(GameAwardsAndPriceDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(GameAwardsAndPriceDTOModel*) source target:(GameAwardsAndPriceDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
