//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
盲盒用户的简单信息
 */
@interface BlindBoxUserSimpleInfoModel : NSObject 


	/**
用户头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * userName;

	/**
用户ID
 */
@property (nonatomic, assign) int64_t userId;

 +(NSMutableArray<BlindBoxUserSimpleInfoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<BlindBoxUserSimpleInfoModel*>*)list;

 +(BlindBoxUserSimpleInfoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(BlindBoxUserSimpleInfoModel*) source target:(BlindBoxUserSimpleInfoModel*)target;

@end

NS_ASSUME_NONNULL_END
