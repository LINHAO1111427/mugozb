//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
RtcToken
 */
@interface LiveRtcTokenModel : NSObject 


	/**
token
 */
@property (nonatomic, copy) NSString * rtcToken;

 +(NSMutableArray<LiveRtcTokenModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<LiveRtcTokenModel*>*)list;

 +(LiveRtcTokenModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(LiveRtcTokenModel*) source target:(LiveRtcTokenModel*)target;

@end

NS_ASSUME_NONNULL_END
