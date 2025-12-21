//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class AppStrickerVOModel;
NS_ASSUME_NONNULL_BEGIN




/**
APP语音直播麦位数据
 */
@interface ApiUsersVoiceAssistanModel : NSObject 


	/**
封麦状态 0:封麦 1:未封麦
 */
@property (nonatomic, assign) int retireState;

	/**
麦序编号
 */
@property (nonatomic, assign) int no;

	/**
音量值
 */
@property (nonatomic, assign) int volumeVal;

	/**
性别 1:男 2:女 3:其他 0:麦位为空
 */
@property (nonatomic, assign) int sex;

	/**
禁止说话 1:是 0:否 默认0
 */
@property (nonatomic, assign) int noTalking;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
主播id
 */
@property (nonatomic, assign) int64_t anchorId;

	/**
麦序类型 1:主播 2:普通用户
 */
@property (nonatomic, assign) int type;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * userName;

	/**
房间id
 */
@property (nonatomic, assign) int64_t roomId;

	/**
麦序名称
 */
@property (nonatomic, copy) NSString * assistanName;

	/**
开关麦状态 0:关麦 1:开麦(音量)
 */
@property (nonatomic, assign) int onOffState;

	/**
麦序上用户id
 */
@property (nonatomic, assign) int64_t uid;

	/**
表情包实体
 */
@property (strong, nonatomic) AppStrickerVOModel* appStrickerVO;

	/**
当前房间主持人id
 */
@property (nonatomic, assign) int64_t presenterUserId;

	/**
用户的头像框
 */
@property (nonatomic, copy) NSString * avatarFrame;

	/**
用户收益
 */
@property (nonatomic, assign) double coin;

	/**
麦位状态 0:无人 1:有人
 */
@property (nonatomic, assign) int status;

 +(NSMutableArray<ApiUsersVoiceAssistanModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUsersVoiceAssistanModel*>*)list;

 +(ApiUsersVoiceAssistanModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiUsersVoiceAssistanModel*) source target:(ApiUsersVoiceAssistanModel*)target;

@end

NS_ASSUME_NONNULL_END
