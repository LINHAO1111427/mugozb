//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
最新十条中奖信息
 */
@interface GameAwardsDTOModel : NSObject 


	/**
奖品名称
 */
@property (nonatomic, copy) NSString * prizeName;

	/**
奖品类型
 */
@property (nonatomic, assign) int prizeType;

	/**
奖品数量
 */
@property (nonatomic, assign) int prizeNum;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * userName;

	/**
用户id
 */
@property (nonatomic, assign) int64_t userId;

 +(NSMutableArray<GameAwardsDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GameAwardsDTOModel*>*)list;

 +(GameAwardsDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(GameAwardsDTOModel*) source target:(GameAwardsDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
