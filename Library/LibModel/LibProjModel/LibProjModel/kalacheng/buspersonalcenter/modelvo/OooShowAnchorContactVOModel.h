//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
我的账户相关
 */
@interface OooShowAnchorContactVOModel : NSObject 


	/**
手机号
 */
@property (nonatomic, copy) NSString * mobile;

	/**
查看手机号所需金币
 */
@property (nonatomic, assign) double mobileCoin;

	/**
查看微信号所需金币
 */
@property (nonatomic, assign) double wechatCoin;

	/**
微信号
 */
@property (nonatomic, copy) NSString * wechatNo;

 +(NSMutableArray<OooShowAnchorContactVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OooShowAnchorContactVOModel*>*)list;

 +(OooShowAnchorContactVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(OooShowAnchorContactVOModel*) source target:(OooShowAnchorContactVOModel*)target;

@end

NS_ASSUME_NONNULL_END
