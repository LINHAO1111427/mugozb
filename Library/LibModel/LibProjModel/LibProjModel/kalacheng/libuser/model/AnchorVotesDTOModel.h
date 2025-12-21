//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
主播可提现余额 model
 */
@interface AnchorVotesDTOModel : NSObject 


	/**
主播可提现余额
 */
@property (nonatomic, assign) double anchorVotes;

 +(NSMutableArray<AnchorVotesDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AnchorVotesDTOModel*>*)list;

 +(AnchorVotesDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AnchorVotesDTOModel*) source target:(AnchorVotesDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
