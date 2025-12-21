//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
后台管理-系统配置-关键词屏蔽管理
 */
@interface AdminKeywordManageModel : NSObject 


	/**
用户违规昵称使用*替代 0：关闭 1：开启
 */
@property (nonatomic, assign) int nameUseStar;

	/**
提现提示
 */
@property (nonatomic, copy) NSString * cashOutTip;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
敏感词汇
 */
@property (nonatomic, copy) NSString * keyword;

 +(NSMutableArray<AdminKeywordManageModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AdminKeywordManageModel*>*)list;

 +(AdminKeywordManageModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AdminKeywordManageModel*) source target:(AdminKeywordManageModel*)target;

@end

NS_ASSUME_NONNULL_END
