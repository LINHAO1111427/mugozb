//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
用户中奖socket返回
 */
@interface GameUserWinAwardsDTOModel : NSObject 


	/**
null
 */
@property (nonatomic, assign) int64_t serialVersionUID;

	/**
用户id
 */
@property (nonatomic, assign) int64_t userId;

	/**
用户名
 */
@property (nonatomic, copy) NSString * userName;

	/**
游戏名称
 */
@property (nonatomic, copy) NSString * gameName;

	/**
奖品名称
 */
@property (nonatomic, copy) NSString * awardsName;

	/**
奖品数量
 */
@property (nonatomic, assign) int awardsNum;

 +(NSMutableArray<GameUserWinAwardsDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GameUserWinAwardsDTOModel*>*)list;

 +(GameUserWinAwardsDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(GameUserWinAwardsDTOModel*) source target:(GameUserWinAwardsDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
