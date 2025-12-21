//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class GamePrizeRecordModel;
 @class GameLuckDrawModel;
NS_ASSUME_NONNULL_BEGIN




/**
抽奖之后返回
 */
@interface GameUserLuckDrawDTOModel : NSObject 


	/**
用户抽奖次数
 */
@property (nonatomic, assign) int userGameNum;

	/**
中奖记录
 */
@property (nonatomic, strong) NSMutableArray<GamePrizeRecordModel*>* gamePrizeRecordList;

	/**
抽奖记录
 */
@property (strong, nonatomic) GameLuckDrawModel* gameLuckDraw;

	/**
剩余金币
 */
@property (nonatomic, assign) double coin;

 +(NSMutableArray<GameUserLuckDrawDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GameUserLuckDrawDTOModel*>*)list;

 +(GameUserLuckDrawDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(GameUserLuckDrawDTOModel*) source target:(GameUserLuckDrawDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
