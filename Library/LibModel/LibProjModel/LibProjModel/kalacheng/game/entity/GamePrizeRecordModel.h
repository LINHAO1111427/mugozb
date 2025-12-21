//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
用户中奖记录表
 */
@interface GamePrizeRecordModel : NSObject 


	/**
奖项id
 */
@property (nonatomic, assign) int64_t awardsId;

	/**
添加时间
 */
@property (nonatomic, copy) NSString * addTime;

	/**
获奖奖项数量
 */
@property (nonatomic, assign) int awardsNum;

	/**
获奖礼物名称
 */
@property (nonatomic, copy) NSString * giftName;

	/**
游戏id
 */
@property (nonatomic, assign) int64_t gameKindId;

	/**
获奖奖项单价
 */
@property (nonatomic, assign) double awardUnitPrice;

	/**
备注
 */
@property (nonatomic, copy) NSString * remake;

	/**
用户姓名
 */
@property (nonatomic, copy) NSString * userName;

	/**
奖项类型0金币1礼物
 */
@property (nonatomic, assign) int awardsType;

	/**
奖品图片
 */
@property (nonatomic, copy) NSString * picture;

	/**
获奖礼物id
 */
@property (nonatomic, assign) int64_t giftId;

	/**
用户id
 */
@property (nonatomic, assign) int64_t uid;

	/**
获奖金币
 */
@property (nonatomic, assign) double awardsCoin;

	/**
奖项名称
 */
@property (nonatomic, copy) NSString * awardsName;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
时间对应毫秒值
 */
@property (nonatomic, assign) int64_t time;

	/**
抽奖记录Id
 */
@property (nonatomic, assign) int64_t luckDrawId;

 +(NSMutableArray<GamePrizeRecordModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GamePrizeRecordModel*>*)list;

 +(GamePrizeRecordModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(GamePrizeRecordModel*) source target:(GamePrizeRecordModel*)target;

@end

NS_ASSUME_NONNULL_END
