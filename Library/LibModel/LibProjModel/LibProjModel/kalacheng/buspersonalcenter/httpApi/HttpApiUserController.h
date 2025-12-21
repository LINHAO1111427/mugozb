//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "SingleStringModel.h"

#import "ApiVersionModel.h"

#import "UserInfo2VOModel.h"

#import "HttpNoneModel.h"

#import "OOORegisterCallVOModel.h"

#import "MyTrendsVOModel.h"

#import "SysNoticModel.h"

#import "ApiUserInfoMyHeadModel.h"

#import "AppUserDataImgModel.h"

#import "AppTrendsRecordModel.h"

#import "UserController_userUpdate.h"
#import "LiveBeanModel.h"

#import "ApiUserIndexRespModel.h"

#import "ApiSignInDtoModel.h"

#import "ApiShareConfigModel.h"

#import "ApiUserAttenModel.h"

#import "TaskDtoModel.h"

#import "AppUserAvatarModel.h"

#import "TabTypeDtoModel.h"

#import "UserSettingInfoVOModel.h"

#import "AppTabInfoModel.h"

#import "ApiUserInfoModel.h"

#import "AppUserDataReviewVOModel.h"

#import "ApiUserBrowseModel.h"

#import "UserInfoLiveVOModel.h"

#import "UserInfoHomeVOModel.h"

#import "ApiUserBlackInfoVOModel.h"

#import "ApiUsersVideoBlackVOModel.h"

#import "MyMemberVOModel.h"

#import "UserInfoRelationVO2Model.h"

#import "MyAnchorVOModel.h"

#import "MyAccountVOModel.h"

#import "ApiUserInfoLoginModel.h"

#import "OooShowAnchorContactVOModel.h"

typedef void (^CallBackUserController_SingleString)(int code,NSString *strMsg,SingleStringModel* model);
typedef void (^CallBackUserController_ApiVersion)(int code,NSString *strMsg,ApiVersionModel* model);
typedef void (^CallBackUserController_UserInfo2VO)(int code,NSString *strMsg,UserInfo2VOModel* model);
typedef void (^CallBackUserController_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackUserController_OOORegisterCallVO)(int code,NSString *strMsg,OOORegisterCallVOModel* model);
typedef void (^CallBackUserController_MyTrendsVO)(int code,NSString *strMsg,MyTrendsVOModel* model);
typedef void (^CallBackUserController_SysNotic)(int code,NSString *strMsg,SysNoticModel* model);
typedef void (^CallBackUserController_ApiUserInfoMyHead)(int code,NSString *strMsg,ApiUserInfoMyHeadModel* model);
typedef void (^CallBackUserController_AppUserDataImg)(int code,NSString *strMsg,AppUserDataImgModel* model);
typedef void (^CallBackUserController_AppTrendsRecordArr)(int code,NSString *strMsg,NSArray<AppTrendsRecordModel*>* arr);
typedef void (^CallBackUserController_LiveBeanPageArr)(int code,NSString *strMsg,PageInfo *pageInfo,NSArray<LiveBeanModel*>* arr);
typedef void (^CallBackUserController_ApiUserIndexResp)(int code,NSString *strMsg,ApiUserIndexRespModel* model);
typedef void (^CallBackUserController_ApiSignInDto)(int code,NSString *strMsg,ApiSignInDtoModel* model);
typedef void (^CallBackUserController_ApiShareConfig)(int code,NSString *strMsg,ApiShareConfigModel* model);
typedef void (^CallBackUserController_ApiUserAttenArr)(int code,NSString *strMsg,NSArray<ApiUserAttenModel*>* arr);
typedef void (^CallBackUserController_TaskDtoArr)(int code,NSString *strMsg,NSArray<TaskDtoModel*>* arr);
typedef void (^CallBackUserController_AppUserAvatarArr)(int code,NSString *strMsg,NSArray<AppUserAvatarModel*>* arr);
typedef void (^CallBackUserController_TabTypeDtoArr)(int code,NSString *strMsg,NSArray<TabTypeDtoModel*>* arr);
typedef void (^CallBackUserController_UserSettingInfoVO)(int code,NSString *strMsg,UserSettingInfoVOModel* model);
typedef void (^CallBackUserController_AppTabInfoArr)(int code,NSString *strMsg,NSArray<AppTabInfoModel*>* arr);
typedef void (^CallBackUserController_ApiUserInfo)(int code,NSString *strMsg,ApiUserInfoModel* model);
typedef void (^CallBackUserController_AppUserDataReviewVOArr)(int code,NSString *strMsg,NSArray<AppUserDataReviewVOModel*>* arr);
typedef void (^CallBackUserController_ApiUserBrowseArr)(int code,NSString *strMsg,NSArray<ApiUserBrowseModel*>* arr);
typedef void (^CallBackUserController_UserInfoLiveVO)(int code,NSString *strMsg,UserInfoLiveVOModel* model);
typedef void (^CallBackUserController_UserInfoHomeVO)(int code,NSString *strMsg,UserInfoHomeVOModel* model);
typedef void (^CallBackUserController_ApiUserBlackInfoVOArr)(int code,NSString *strMsg,NSArray<ApiUserBlackInfoVOModel*>* arr);
typedef void (^CallBackUserController_ApiUsersVideoBlackVO)(int code,NSString *strMsg,ApiUsersVideoBlackVOModel* model);
typedef void (^CallBackUserController_MyMemberVO)(int code,NSString *strMsg,MyMemberVOModel* model);
typedef void (^CallBackUserController_UserInfoRelationVO2)(int code,NSString *strMsg,UserInfoRelationVO2Model* model);
typedef void (^CallBackUserController_MyAnchorVO)(int code,NSString *strMsg,MyAnchorVOModel* model);
typedef void (^CallBackUserController_MyAccountVO)(int code,NSString *strMsg,MyAccountVOModel* model);
typedef void (^CallBackUserController_ApiUserInfoLogin)(int code,NSString *strMsg,ApiUserInfoLoginModel* model);
typedef void (^CallBackUserController_OooShowAnchorContactVO)(int code,NSString *strMsg,OooShowAnchorContactVOModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
用户接口API
 */
@interface HttpApiUserController: NSObject



/**
 修改密码
 @param freshPwd 新密码
 @param freshPwd2 再次输入新密码
 */
+(void) updatePwd:(NSString *)freshPwd freshPwd2:(NSString *)freshPwd2  callback:(CallBackUserController_SingleString)callback;


/**
 版本控制
 @param type 类型 1:安卓 2:ios
 @param versionCode 版本号
 */
+(void) version_control:(int)type versionCode:(int)versionCode  callback:(CallBackUserController_ApiVersion)callback;


/**
 获取用户基本信息
 @param userId 用户id
 */
+(void) getUserInfo2:(int64_t)userId  callback:(CallBackUserController_UserInfo2VO)callback;


/**
 用户登出
 */
+(void) logout:(CallBackUserController_SingleString)callback;


/**
 更新用户推送的注册id
 @param pushPlatform 推送平台 1:小米 2:华为 3:vivo 4:oppo 5:apns 6:极光 7:miApns
 @param pushRegisterId 推送平台对应的注册id
 @param voipToken 苹果voip推送(安卓不传)
 */
+(void) upUserPushInfo:(int)pushPlatform pushRegisterId:(NSString *)pushRegisterId voipToken:(NSString *)voipToken  callback:(CallBackUserController_HttpNone)callback;


/**
 全局获取用户免费通话时间和通话次数(邀请码)
 @param userid 用户id
 */
+(void) getUserByregister:(int64_t)userid  callback:(CallBackUserController_OOORegisterCallVO)callback;


/**
 我的动态
 @param pageIndex 当前页
 @param pageSize 每页大小
 */
+(void) getMyTrendsPage:(int)pageIndex pageSize:(int)pageSize  callback:(CallBackUserController_MyTrendsVO)callback;


/**
 用户关注/取消关注；3还没关注TA
 @param isAtten 1:去关注 0:取消关注
 @param touid 要关注的人ID
 */
+(void) setAtten:(int)isAtten touid:(int64_t)touid  callback:(CallBackUserController_HttpNone)callback;


/**
 获取系统公告
 */
+(void) getSysNotic:(CallBackUserController_SysNotic)callback;


/**
 我的头部信息
 */
+(void) getMyHeadInfo:(CallBackUserController_ApiUserInfoMyHead)callback;


/**
 获取用户资料图片(个人中心资料图片,包含审核中的头像和资料图片)
 */
+(void) getAppUserDataImg:(CallBackUserController_AppUserDataImg)callback;


/**
 我的--动态--时间轴分页
 @param pageIndex 当前页
 @param pageSize 每页大小
 */
+(void) getMyTrendsTime:(int)pageIndex pageSize:(int)pageSize  callback:(CallBackUserController_AppTrendsRecordArr)callback;




/**
 APP修改个人信息
 @param birthday 生日
 @param constellation 星座
 @param height 身高
 @param liveThumb 封面
 @param sanwei 三围
 @param sex 性别0：保密，1：男；2：女
 @param signature 签名
 @param username 用户名
 @param vocation 职业
 @param wechat 微信号
 @param weight 体重
 */
+(void) userUpdate:(UserController_userUpdate*)_mdl callback:(CallBackUserController_HttpNone)callback;
/**
 APP修改个人信息
 @param birthday 生日
 @param constellation 星座
 @param height 身高
 @param liveThumb 封面
 @param sanwei 三围
 @param sex 性别0：保密，1：男；2：女
 @param signature 签名
 @param username 用户名
 @param vocation 职业
 @param wechat 微信号
 @param weight 体重
 */
+(void) userUpdate:(NSString *)birthday constellation:(NSString *)constellation height:(int)height liveThumb:(NSString *)liveThumb sanwei:(NSString *)sanwei sex:(int)sex signature:(NSString *)signature username:(NSString *)username vocation:(NSString *)vocation wechat:(NSString *)wechat weight:(int)weight  callback:(CallBackUserController_HttpNone)callback;


/**
 消息-拉黑操作
 @param type 类型 0:全部 1:语音 2:视频
 @param userId 拉黑用户id
 */
+(void) blockOperation:(int)type userId:(int64_t)userId  callback:(CallBackUserController_HttpNone)callback;


/**
 大厅直播列表
 @param keyWord 搜索关键字
 @param page 当前页
 @param pageSize 每页的条数
 @param type 类型 1:大厅 2:live 3:热门
 */
+(void) lobby:(NSString *)keyWord page:(int)page pageSize:(int)pageSize type:(int)type  callback:(CallBackUserController_LiveBeanPageArr)callback;


/**
 获取APP个人信息接口
 */
+(void) infoIndex:(CallBackUserController_ApiUserIndexResp)callback;


/**
 查看签到数据
 */
+(void) getSignInfo:(CallBackUserController_ApiSignInDto)callback;


/**
 修改礼物全局广播
 @param giftGlobalBroadcast 礼物全局广播(目标值) 0:关闭 1：开启
 */
+(void) upGiftGlobalBroadcast:(int)giftGlobalBroadcast  callback:(CallBackUserController_HttpNone)callback;


/**
 获取分享配置
 @param objId 根据类型传不同的值 type=1:动态id type=2:房间号 type=4:短视频id
 @param type 类型 1:动态 2:直播间 3:App 4:短视频
 */
+(void) share:(int64_t)objId type:(int)type  callback:(CallBackUserController_ApiShareConfig)callback;


/**
 签到
 */
+(void) signIn:(CallBackUserController_HttpNone)callback;


/**
 用户关注列表 ------ 删除使用新的接口
 @param pageIndex 当前页
 @param pageSize 每页大小
 @param touid 要查看的用户ID
 */
+(void) getAttenList:(int)pageIndex pageSize:(int)pageSize touid:(int64_t)touid  callback:(CallBackUserController_ApiUserAttenArr)callback;


/**
 个人中心访问操作(去掉红点)
 */
+(void) delVisit:(CallBackUserController_HttpNone)callback;


/**
 我的声音
 @param path 文件路径(调用文件上传接口获得)
 */
+(void) myvoice:(NSString *)path  callback:(CallBackUserController_HttpNone)callback;


/**
 用户任务列表
 */
+(void) userTaskList:(CallBackUserController_TaskDtoArr)callback;


/**
 获取多个用户备注的名称
 @param ids 查询的用户id 字符串，中间用，号隔开
 */
+(void) getUserNameRemarks:(NSString *)ids  callback:(CallBackUserController_AppUserAvatarArr)callback;


/**
 查询全部标签
 */
+(void) allTabs:(CallBackUserController_TabTypeDtoArr)callback;


/**
 查看用户设置开关信息
 */
+(void) getUserSettingInfo:(CallBackUserController_UserSettingInfoVO)callback;


/**
 获取标签
 @param type 类型 1:兴趣爱好 2:性格标签 3:自我描述 4:关注主题 5:用户评价标签
 */
+(void) getlabels:(int)type  callback:(CallBackUserController_AppTabInfoArr)callback;


/**
 删除用户资料(个人中心资料图片)
 @param dataReviewId 资料id
 */
+(void) delUserDataReview:(int64_t)dataReviewId  callback:(CallBackUserController_HttpNone)callback;


/**
 个人中心访问人是否有未读(红点)：no_use 访问未读人数 0没有未读
 */
+(void) isVisit:(CallBackUserController_HttpNone)callback;


/**
 更新用户资料(这个接口带审核)
 @param dataReviewId 资料id(新增的情况下为0)
 @param dataType 资料类型 1:用户头像 2:用户资料图片(个人中心)
 @param reviewContent 需要审核的资料内容,例如 头像地址,资料图片地址.
 */
+(void) updateUserDataReview:(int64_t)dataReviewId dataType:(int)dataType reviewContent:(NSString *)reviewContent  callback:(CallBackUserController_AppUserDataImg)callback;


/**
 获取用户基本信息
 @param userId 用户id
 */
+(void) getUserInfo:(int64_t)userId  callback:(CallBackUserController_ApiUserInfo)callback;


/**
 修改个人兴趣标签
 @param value 'tabId':'tab名','tabId':'tab名'  '1':'王者荣耀','7':'热情似火','8':'嫉恶如仇'
 */
+(void) updateInterest:(NSString *)value  callback:(CallBackUserController_HttpNone)callback;


/**
 获取用户资料图片(不包含用户头像,只有资料图片,并且是审核通过的)
 @param toUserId 被查看的用户id
 */
+(void) getAppUserDataReviewList:(int64_t)toUserId  callback:(CallBackUserController_AppUserDataReviewVOArr)callback;


/**
 设置用户的备注名称
 @param nameRemarks 备注名称
 @param toUserId 被设置的用户id
 */
+(void) setUserNameRemarks:(NSString *)nameRemarks toUserId:(int64_t)toUserId  callback:(CallBackUserController_HttpNone)callback;


/**
 谁看过我
 @param pageIndex pageIndex
 @param pageSize pageSize
 */
+(void) browseRecord:(int)pageIndex pageSize:(int)pageSize  callback:(CallBackUserController_ApiUserBrowseArr)callback;


/**
 我的--注销账户
 @param code 密码/验证码
 @param type 注销方式1密码2短信验证码
 */
+(void) userCancelAccount:(NSString *)code type:(int)type  callback:(CallBackUserController_HttpNone)callback;


/**
 获取用户基本信息
 @param roomId 房间号
 @param toUserId 查看用户id
 @param type 直播间类型(非直播间调用该接口传-1) 1:视频直播间 2:语音直播间
 */
+(void) getUserInfoLive:(int64_t)roomId toUserId:(int64_t)toUserId type:(int)type  callback:(CallBackUserController_UserInfoLiveVO)callback;


/**
 获取用户基本信息
 @param toUserId 查看用户id
 */
+(void) getUserInfoHome:(int64_t)toUserId  callback:(CallBackUserController_UserInfoHomeVO)callback;


/**
 查询是否存在我的声音
 */
+(void) isMyVoice:(CallBackUserController_HttpNone)callback;


/**
 获取用户拉黑列表
 @param pageIndex 当前页
 @param pageSize 每页页数
 */
+(void) getBlockList:(int)pageIndex pageSize:(int)pageSize  callback:(CallBackUserController_ApiUserBlackInfoVOArr)callback;


/**
 获取拉黑信息
 @param userId 拉黑用户id
 */
+(void) getBlockinfo:(int64_t)userId  callback:(CallBackUserController_ApiUsersVideoBlackVO)callback;


/**
 我的会员
 */
+(void) getMyMember:(CallBackUserController_MyMemberVO)callback;


/**
 获取用户基本信息及与用户的关系
 @param userId 用户id
 */
+(void) getUserInfoRelation:(int64_t)userId  callback:(CallBackUserController_UserInfoRelationVO2)callback;


/**
 我的--主播
 */
+(void) getMyAnchor:(CallBackUserController_MyAnchorVO)callback;


/**
 我的账户
 */
+(void) getMyAccount:(CallBackUserController_MyAccountVO)callback;


/**
 用户粉丝列表 --- 删除使用新的接口
 @param pageIndex 当前页
 @param pageSize 每页代销
 @param touid 要查看的用户ID
 */
+(void) getFansList:(int)pageIndex pageSize:(int)pageSize touid:(int64_t)touid  callback:(CallBackUserController_ApiUserAttenArr)callback;


/**
 查询用户信息
 */
+(void) info:(CallBackUserController_ApiUserInfoLogin)callback;


/**
 我的--修改是否开启定位显示
 @param type 隐藏位置 0:未开启 1:开启
 */
+(void) upPositioningShow:(int)type  callback:(CallBackUserController_HttpNone)callback;


/**
 分享成功后回调
 @param objId 根据类型传不同的值 type=1:动态id type=2:房间号 type=4:短视频id
 @param type 类型 1:动态 2:直播间 3:App 4:短视频
 */
+(void) shareCallback:(int64_t)objId type:(int)type  callback:(CallBackUserController_HttpNone)callback;


/**
 查看能否获取用户微信号
 @param anchorId anchorId
 */
+(void) getShowAnchorContact:(int64_t)anchorId  callback:(CallBackUserController_OooShowAnchorContactVO)callback;


/**
 主播任务列表
 */
+(void) anchorTaskList:(CallBackUserController_TaskDtoArr)callback;


/**
 我的--勿扰
 @param type 类型 1:开启 2:关闭
 */
+(void) isNotDisturb:(int)type  callback:(CallBackUserController_HttpNone)callback;


/**
 拉黑用户
 @param touid 被拉黑用户
 */
+(void) usersBlack:(int64_t)touid  callback:(CallBackUserController_HttpNone)callback;


/**
 绑定上级
 @param code 邀请码
 @param fromSource 绑定来源 1：手动填写 2：openInstall 3:后台操作
 */
+(void) binding:(NSString *)code fromSource:(int)fromSource  callback:(CallBackUserController_HttpNone)callback;

@end

NS_ASSUME_NONNULL_END
