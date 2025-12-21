//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
赠送礼物后返回双方血条信息
 */
@interface ApiPkResultModel : NSObject 


	/**
null
 */
@property (nonatomic, assign) int64_t serialVersionUID;

	/**
主播id
 */
@property (nonatomic, assign) int64_t anchorId;

	/**
当前pk值
 */
@property (nonatomic, assign) double votesPK;

	/**
对方pk值
 */
@property (nonatomic, assign) double toVotesPK;

 +(NSMutableArray<ApiPkResultModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiPkResultModel*>*)list;

 +(ApiPkResultModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiPkResultModel*) source target:(ApiPkResultModel*)target;

@end

NS_ASSUME_NONNULL_END
