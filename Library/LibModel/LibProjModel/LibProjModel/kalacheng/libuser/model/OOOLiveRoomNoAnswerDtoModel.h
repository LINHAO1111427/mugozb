//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP遇见主播端未接来电
 */
@interface OOOLiveRoomNoAnswerDtoModel : NSObject 


	/**
用户id
 */
@property (nonatomic, assign) int64_t uid;

	/**
结束时间
 */
@property (nonatomic,copy) NSDate * createTime;

	/**
用户在线状态,0离线1在线
 */
@property (nonatomic, assign) int onlineStatus;

	/**
时间
 */
@property (nonatomic, copy) NSString * timeStr;

	/**
观众ID
 */
@property (nonatomic, assign) int64_t audienceId;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
类型0语音1视频
 */
@property (nonatomic, assign) int type;

	/**
主播海报
 */
@property (nonatomic, copy) NSString * poster;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * username;

 +(NSMutableArray<OOOLiveRoomNoAnswerDtoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OOOLiveRoomNoAnswerDtoModel*>*)list;

 +(OOOLiveRoomNoAnswerDtoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(OOOLiveRoomNoAnswerDtoModel*) source target:(OOOLiveRoomNoAnswerDtoModel*)target;

@end

NS_ASSUME_NONNULL_END
