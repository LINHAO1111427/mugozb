//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class GamePrizeRecordModel;
NS_ASSUME_NONNULL_BEGIN




/**
中奖数据返回
 */
@interface GameUserPrizeDTOModel : NSObject 


	/**
抽奖日期
 */
@property (nonatomic, copy) NSString * luckDrawDate;

	/**
游戏名称
 */
@property (nonatomic, copy) NSString * gameName;

	/**
奖品数量
 */
@property (nonatomic, strong) NSMutableArray<GamePrizeRecordModel*>* gamePrizeRecordList;

 +(NSMutableArray<GameUserPrizeDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GameUserPrizeDTOModel*>*)list;

 +(GameUserPrizeDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(GameUserPrizeDTOModel*) source target:(GameUserPrizeDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
