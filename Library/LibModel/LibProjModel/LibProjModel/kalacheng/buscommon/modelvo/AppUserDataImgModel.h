//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class AppUserDataReviewVOModel;
NS_ASSUME_NONNULL_BEGIN




/**
用户个人资料的图片(个人中心)
 */
@interface AppUserDataImgModel : NSObject 


	/**
用户头像信息
 */
@property (strong, nonatomic) AppUserDataReviewVOModel* appUserAvatar;

	/**
用户个人中心资料图片
 */
@property (nonatomic, strong) NSMutableArray<AppUserDataReviewVOModel*>* appUserPortrait;

 +(NSMutableArray<AppUserDataImgModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUserDataImgModel*>*)list;

 +(AppUserDataImgModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppUserDataImgModel*) source target:(AppUserDataImgModel*)target;

@end

NS_ASSUME_NONNULL_END
