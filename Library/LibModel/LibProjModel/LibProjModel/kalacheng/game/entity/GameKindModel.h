//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
游戏种类表
 */
@interface GameKindModel : NSObject 


	/**
是否启用新用户保护
 */
@property (nonatomic, assign) int isProtect;

	/**
幸运加成概率
 */
@property (nonatomic, assign) double luckyProbability;

	/**
保护奖项ID
 */
@property (nonatomic, assign) int64_t protectPrizeId;

	/**
添加时间
 */
@property (nonatomic, copy) NSString * addTime;

	/**
游戏说明
 */
@property (nonatomic, copy) NSString * gameExplain;

	/**
幸运加成奖项id
 */
@property (nonatomic, assign) int64_t luckyPrizeId;

	/**
保底比例
 */
@property (nonatomic, assign) double bottomProportion;

	/**
备注
 */
@property (nonatomic, copy) NSString * remake;

	/**
是否启用幸运加成
 */
@property (nonatomic, assign) int isLuckyBonus;

	/**
是否启用保底
 */
@property (nonatomic, assign) int isBottom;

	/**
幸运宝箱结束时间
 */
@property (nonatomic, assign) int luckyEndTime;

	/**
是否开启 0否1开启
 */
@property (nonatomic, assign) int isOpen;

	/**
保底抽奖次数
 */
@property (nonatomic, assign) int bottomPrizeNum;

	/**
幸运加成抽奖次数
 */
@property (nonatomic, assign) int luckyPrizeNum;

	/**
特别说明
 */
@property (nonatomic, copy) NSString * specialNote;

	/**
游戏名称
 */
@property (nonatomic, copy) NSString * name;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
保底奖项ID
 */
@property (nonatomic, assign) int64_t bottomPrizeId;

	/**
幸运宝箱开始时间
 */
@property (nonatomic, assign) int luckyStartTime;

 +(NSMutableArray<GameKindModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GameKindModel*>*)list;

 +(GameKindModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(GameKindModel*) source target:(GameKindModel*)target;

@end

NS_ASSUME_NONNULL_END
