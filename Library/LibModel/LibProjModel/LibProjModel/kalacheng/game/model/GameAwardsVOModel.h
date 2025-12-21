//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
奖项设置表VO
 */
@interface GameAwardsVOModel : NSObject 


	/**
游戏id
 */
@property (nonatomic, assign) int64_t gameId;

	/**
添加时间
 */
@property (nonatomic, copy) NSString * addTime;

	/**
奖品对应的礼物名称
 */
@property (nonatomic, copy) NSString * giftName;

	/**
中奖概率
 */
@property (nonatomic, assign) double winningProbability;

	/**
备注
 */
@property (nonatomic, copy) NSString * remake;

	/**
奖品类型金币/礼物
 */
@property (nonatomic, assign) int awardsType;

	/**
奖品图片
 */
@property (nonatomic, copy) NSString * picture;

	/**
奖品对应的礼物id
 */
@property (nonatomic, assign) int64_t giftId;

	/**
礼物价值
 */
@property (nonatomic, assign) double giftNeedcoin;

	/**
是否全局飘屏
 */
@property (nonatomic, assign) int flutterScreen;

	/**
奖品金币数
 */
@property (nonatomic, assign) int coinNum;

	/**
 奖项名称
 */
@property (nonatomic, copy) NSString * name;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
时间对应毫秒值
 */
@property (nonatomic, assign) int64_t time;

 +(NSMutableArray<GameAwardsVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GameAwardsVOModel*>*)list;

 +(GameAwardsVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(GameAwardsVOModel*) source target:(GameAwardsVOModel*)target;

@end

NS_ASSUME_NONNULL_END
