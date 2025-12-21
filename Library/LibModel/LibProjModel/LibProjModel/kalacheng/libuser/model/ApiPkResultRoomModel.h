//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ApiUsersVoiceAssistanModel;
NS_ASSUME_NONNULL_BEGIN




/**
APPPK返回结果
 */
@interface ApiPkResultRoomModel : NSObject 


	/**
麦位列表
 */
@property (nonatomic, strong) NSMutableArray<ApiUsersVoiceAssistanModel*>* assistans;

	/**
PK惩罚/平局时间,单位:秒
 */
@property (nonatomic, assign) int punishTime;

	/**
胜利者用户名称
 */
@property (nonatomic, copy) NSString * winUserName;

	/**
推送内容
 */
@property (nonatomic, copy) NSString * content;

	/**
房间id
 */
@property (nonatomic, assign) int64_t roomId;

	/**
胜利者用户头像
 */
@property (nonatomic, copy) NSString * winUserAvatar;

	/**
单人/激情团战PK结果1胜利0平局-1输了(如果是房间PK,1:1队胜利,0:平局,2:2队胜利)
 */
@property (nonatomic, assign) int isWin;

	/**
1:单人pk(语音/视频) 2:激情团战 3:房间pk
 */
@property (nonatomic, assign) int pkType;

	/**
胜利者用户id
 */
@property (nonatomic, assign) int64_t winUid;

 +(NSMutableArray<ApiPkResultRoomModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiPkResultRoomModel*>*)list;

 +(ApiPkResultRoomModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiPkResultRoomModel*) source target:(ApiPkResultRoomModel*)target;

@end

NS_ASSUME_NONNULL_END
