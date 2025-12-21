//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ApiSignInModel;
NS_ASSUME_NONNULL_BEGIN




/**
APP签到页面数据
 */
@interface ApiSignInDtoModel : NSObject 


	/**
签到列表
 */
@property (nonatomic, strong) NSMutableArray<ApiSignInModel*>* signList;

	/**
连续签到天数
 */
@property (nonatomic, assign) int signDay;

	/**
今日是否签到 0:未签到 1:已签到
 */
@property (nonatomic, assign) int isSign;

 +(NSMutableArray<ApiSignInDtoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiSignInDtoModel*>*)list;

 +(ApiSignInDtoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiSignInDtoModel*) source target:(ApiSignInDtoModel*)target;

@end

NS_ASSUME_NONNULL_END
