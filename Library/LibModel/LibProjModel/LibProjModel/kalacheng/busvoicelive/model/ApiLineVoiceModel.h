//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP语音直播连麦请求数据
 */
@interface ApiLineVoiceModel : NSObject 


	/**
申请的麦位编号 (被邀请上麦时该值为-1)
 */
@property (nonatomic, assign) int no;

	/**
主播等级图标
 */
@property (nonatomic, copy) NSString * anchorGrade;

	/**
当前申请/被邀请角色类型 1主播 0普通用户
 */
@property (nonatomic, assign) int role;

	/**
当前申请/被邀请的时间
 */
@property (nonatomic, assign) int64_t addTime;

	/**
用户等级图标
 */
@property (nonatomic, copy) NSString * userGrade;

	/**
当前申请/被邀请角色性别  0：保密，1：男；2：女
 */
@property (nonatomic, assign) int sex;

	/**
预计缓存过期时间
 */
@property (nonatomic, assign) int64_t estimatedExpirationTime;

	/**
当前申请/被邀请用户头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
直播间主播id
 */
@property (nonatomic, assign) int64_t anchorId;

	/**
当前申请/被邀请用户名称
 */
@property (nonatomic, copy) NSString * userName;

	/**
直播间房间id
 */
@property (nonatomic, assign) int64_t roomId;

	/**
连麦状态1等待房主同意连麦 2房主已同意连麦已接入 3连麦被房主拒绝   ---   5等待被邀请方同意连麦  6被邀请方已接受连麦已接入 7被邀请方拒绝连麦 
 */
@property (nonatomic, assign) int lineStatus;

	/**
贵族头像框
 */
@property (nonatomic, copy) NSString * nobleAvatarFrame;

	/**
当前申请/被邀请用户id
 */
@property (nonatomic, assign) int64_t uid;

	/**
财富等级图标
 */
@property (nonatomic, copy) NSString * wealthGrade;

	/**
贵族等级图标
 */
@property (nonatomic, copy) NSString * nobleGrade;

	/**
年龄
 */
@property (nonatomic, assign) int age;

	/**
当前用户贡献值
 */
@property (nonatomic, assign) double coin;

	/**
是否有视频连麦特权 0没有 1有
 */
@property (nonatomic, assign) int mikePrivilege;

 +(NSMutableArray<ApiLineVoiceModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiLineVoiceModel*>*)list;

 +(ApiLineVoiceModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiLineVoiceModel*) source target:(ApiLineVoiceModel*)target;

@end

NS_ASSUME_NONNULL_END
