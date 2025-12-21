//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ApiUsersVoiceAssistanModel;
NS_ASSUME_NONNULL_BEGIN




/**
pk麦位
 */
@interface PkUserVoiceAssistanModel : NSObject 


	/**
麦位信息实体
 */
@property (strong, nonatomic) ApiUsersVoiceAssistanModel* usersVoiceAssistan;

	/**
当前PK麦位主播所收的礼物值
 */
@property (nonatomic, assign) double giftVotes;

	/**
PK页面麦序编号
 */
@property (nonatomic, assign) int pkNo;

 +(NSMutableArray<PkUserVoiceAssistanModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<PkUserVoiceAssistanModel*>*)list;

 +(PkUserVoiceAssistanModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(PkUserVoiceAssistanModel*) source target:(PkUserVoiceAssistanModel*)target;

@end

NS_ASSUME_NONNULL_END
