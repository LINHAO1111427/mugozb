//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
游戏抽奖记录
 */
@interface GameLuckDrawModel : NSObject 


	/**
游戏id
 */
@property (nonatomic, assign) int64_t gameId;

	/**
子交易类型
 */
@property (nonatomic, copy) NSString * sonType;

	/**
中奖次数
 */
@property (nonatomic, assign) int winNum;

	/**
抽奖次数
 */
@property (nonatomic, assign) int gameNum;

	/**
添加时间
 */
@property (nonatomic, copy) NSString * addTime;

	/**
花费金币
 */
@property (nonatomic, assign) double gameCoin;

	/**
交易单号
 */
@property (nonatomic, copy) NSString * num;

	/**
备注
 */
@property (nonatomic, copy) NSString * remake;

	/**
主播id
 */
@property (nonatomic, assign) int64_t anchorId;

	/**
主播名称
 */
@property (nonatomic, copy) NSString * anchorName;

	/**
是否中奖
 */
@property (nonatomic, assign) int isAwards;

	/**
主交易类型
 */
@property (nonatomic, copy) NSString * parentType;

	/**
用户id
 */
@property (nonatomic, assign) int64_t uid;

	/**
游戏名称
 */
@property (nonatomic, copy) NSString * gameName;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
时间对应毫秒值
 */
@property (nonatomic, assign) int64_t time;

	/**
中奖总价值
 */
@property (nonatomic, assign) double totalWinCoin;

 +(NSMutableArray<GameLuckDrawModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GameLuckDrawModel*>*)list;

 +(GameLuckDrawModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(GameLuckDrawModel*) source target:(GameLuckDrawModel*)target;

@end

NS_ASSUME_NONNULL_END
