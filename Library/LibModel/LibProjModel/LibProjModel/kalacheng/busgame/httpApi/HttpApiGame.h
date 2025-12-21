//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "GameUserPrizeDTOModel.h"

#import "GameLuckDrawModel.h"

#import "GameUserLuckDrawDTOModel.h"

#import "GameAwardsDTOModel.h"

#import "GameAwardsAndPriceDTOModel.h"

#import "GameKindModel.h"

typedef void (^CallBackGame_GameUserPrizeDTOArr)(int code,NSString *strMsg,NSArray<GameUserPrizeDTOModel*>* arr);
typedef void (^CallBackGame_GameLuckDrawArr)(int code,NSString *strMsg,NSArray<GameLuckDrawModel*>* arr);
typedef void (^CallBackGame_GameUserLuckDrawDTO)(int code,NSString *strMsg,GameUserLuckDrawDTOModel* model);
typedef void (^CallBackGame_GameAwardsDTOArr)(int code,NSString *strMsg,NSArray<GameAwardsDTOModel*>* arr);
typedef void (^CallBackGame_GameAwardsAndPriceDTO)(int code,NSString *strMsg,GameAwardsAndPriceDTOModel* model);
typedef void (^CallBackGame_GameKind)(int code,NSString *strMsg,GameKindModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
游戏相关API
 */
@interface HttpApiGame: NSObject



/**
 我的获奖记录
 @param gameKindId 游戏id -1查所有,其它传对应的id
 @param pageIndex 当前页
 @param pageSize 每页大小
 */
+(void) getUserPrizeList:(int64_t)gameKindId pageIndex:(int)pageIndex pageSize:(int)pageSize  callback:(CallBackGame_GameUserPrizeDTOArr)callback;


/**
 我的抽奖记录
 @param gameKindId 游戏id -1查所有,其它传对应的id
 @param pageIndex 当前页
 @param pageSize 每页大小
 */
+(void) getUserLuckDrawList:(int64_t)gameKindId pageIndex:(int)pageIndex pageSize:(int)pageSize  callback:(CallBackGame_GameLuckDrawArr)callback;


/**
 游戏抽奖开始
 @param anchorId 主播id
 @param gamePriceId 游戏收费对应的id
 @param type 宝箱类型 1:普通宝箱 2:幸运宝箱
 */
+(void) starPlayGame:(int64_t)anchorId gamePriceId:(int64_t)gamePriceId type:(int)type  callback:(CallBackGame_GameUserLuckDrawDTO)callback;


/**
 获取最新十条中奖信息
 @param gameKindId 游戏id -1查所有,其它传对应的id
 */
+(void) getUserPrizeRecordList:(int64_t)gameKindId  callback:(CallBackGame_GameAwardsDTOArr)callback;


/**
 获取游戏奖项以及收费标准
 @param gameKindId 游戏id -1查所有,其它传对应的id
 */
+(void) getGamePriceAndAwardsList:(int64_t)gameKindId  callback:(CallBackGame_GameAwardsAndPriceDTO)callback;


/**
 获取游戏说明
 @param gameKindId 游戏id
 */
+(void) getGameKind:(int64_t)gameKindId  callback:(CallBackGame_GameKind)callback;

@end

NS_ASSUME_NONNULL_END
