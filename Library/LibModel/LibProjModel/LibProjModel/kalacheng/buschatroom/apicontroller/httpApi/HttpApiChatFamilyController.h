//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "HttpNoneModel.h"

#import "AppHomeMyAllFamilyVOModel.h"

#import "AppFamilyUserRankVOModel.h"

#import "AppChatFamilyAppealTypeVOModel.h"

#import "AppMyChatFamilyBasisInfoVOModel.h"

#import "AppHomeChatPlazaVOModel.h"

#import "AppChatFamilyMuteVOModel.h"

#import "AppChatFamilyOptIntoVOModel.h"

#import "AppHomeFamilyUserVOModel.h"

#import "AppFamilyChatroomInfoVOModel.h"

#import "AppHomeChatFamilyInfoVOModel.h"

#import "AppChatFamilyModel.h"

#import "AppHomeChatFamilyVOModel.h"

typedef void (^CallBackChatFamilyController_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackChatFamilyController_AppHomeMyAllFamilyVO)(int code,NSString *strMsg,AppHomeMyAllFamilyVOModel* model);
typedef void (^CallBackChatFamilyController_AppFamilyUserRankVOArr)(int code,NSString *strMsg,NSArray<AppFamilyUserRankVOModel*>* arr);
typedef void (^CallBackChatFamilyController_AppChatFamilyAppealTypeVOArr)(int code,NSString *strMsg,NSArray<AppChatFamilyAppealTypeVOModel*>* arr);
typedef void (^CallBackChatFamilyController_AppMyChatFamilyBasisInfoVOArr)(int code,NSString *strMsg,NSArray<AppMyChatFamilyBasisInfoVOModel*>* arr);
typedef void (^CallBackChatFamilyController_AppHomeChatPlazaVOArr)(int code,NSString *strMsg,NSArray<AppHomeChatPlazaVOModel*>* arr);
typedef void (^CallBackChatFamilyController_AppChatFamilyMuteVOArr)(int code,NSString *strMsg,NSArray<AppChatFamilyMuteVOModel*>* arr);
typedef void (^CallBackChatFamilyController_AppChatFamilyOptIntoVO)(int code,NSString *strMsg,AppChatFamilyOptIntoVOModel* model);
typedef void (^CallBackChatFamilyController_AppHomeFamilyUserVOArr)(int code,NSString *strMsg,NSArray<AppHomeFamilyUserVOModel*>* arr);
typedef void (^CallBackChatFamilyController_AppFamilyChatroomInfoVO)(int code,NSString *strMsg,AppFamilyChatroomInfoVOModel* model);
typedef void (^CallBackChatFamilyController_AppHomeChatFamilyInfoVO)(int code,NSString *strMsg,AppHomeChatFamilyInfoVOModel* model);
typedef void (^CallBackChatFamilyController_AppChatFamily)(int code,NSString *strMsg,AppChatFamilyModel* model);
typedef void (^CallBackChatFamilyController_AppHomeChatFamilyVOArr)(int code,NSString *strMsg,NSArray<AppHomeChatFamilyVOModel*>* arr);
NS_ASSUME_NONNULL_BEGIN



/**
聊天家族
 */
@interface HttpApiChatFamilyController: NSObject



/**
 用户申请加入聊天家族
 @param applyReason 申请原因
 @param familyId 家族id
 */
+(void) applyJoinFamily:(NSString *)applyReason familyId:(int64_t)familyId  callback:(CallBackChatFamilyController_HttpNone)callback;


/**
 获取我的家族的信息
 */
+(void) getMyChatFamilyInfoVO:(CallBackChatFamilyController_AppHomeMyAllFamilyVO)callback;


/**
 设置用户在家族中的角色
 @param familyId 家族id
 @param familyRole  家族角色 1：族长 2：副族长 3：长老 4：成员
 @param userId 用户id
 */
+(void) upUserFamilyRole:(int64_t)familyId familyRole:(int)familyRole userId:(int64_t)userId  callback:(CallBackChatFamilyController_HttpNone)callback;


/**
 添加或删除家族禁言
 @param familyId 家族id
 @param optType 操作类型 1：禁言 2：解禁
 @param userId 用户id
 */
+(void) addOrDelMuteUser:(int64_t)familyId optType:(int)optType userId:(int64_t)userId  callback:(CallBackChatFamilyController_HttpNone)callback;


/**
 查询家族内部排名
 @param familyId 家族id
 @param pageIndex 页数
 @param pageSize 每页条数
 @param queryType 查询类型 1：贡献榜 2：收益榜
 */
+(void) getAppFamilyUserRankVO:(int64_t)familyId pageIndex:(int)pageIndex pageSize:(int)pageSize queryType:(int)queryType  callback:(CallBackChatFamilyController_AppFamilyUserRankVOArr)callback;


/**
 获取聊天广场总人数
 */
+(void) getChatPlazaTotalNumber:(CallBackChatFamilyController_HttpNone)callback;


/**
 创建家族
 @param applyReason 申请原因
 @param familyCity 家族所在城市
 @param familyDescription 家族描述
 @param familyIcon 家族图标
 @param familyName 家族名称
 @param latitude 家族所在纬度
 @param longitude 家族所在经度
 */
+(void) addChatFamily:(NSString *)applyReason familyCity:(NSString *)familyCity familyDescription:(NSString *)familyDescription familyIcon:(NSString *)familyIcon familyName:(NSString *)familyName latitude:(double)latitude longitude:(double)longitude  callback:(CallBackChatFamilyController_HttpNone)callback;


/**
 获取举报类型列表
 */
+(void) getChatFamilyAppealType:(CallBackChatFamilyController_AppChatFamilyAppealTypeVOArr)callback;


/**
 申请解散聊天家族
 @param disbandReason 解散原因
 @param familyId 家族id
 */
+(void) applyDisbandFamily:(NSString *)disbandReason familyId:(int64_t)familyId  callback:(CallBackChatFamilyController_HttpNone)callback;


/**
 获取我的家族的基本信息
 @param familyId 家族id（-1：查所有）
 @param userId 用户id
 */
+(void) getAppMyChatFamilyBasisInfoVO:(int64_t)familyId userId:(int64_t)userId  callback:(CallBackChatFamilyController_AppMyChatFamilyBasisInfoVOArr)callback;


/**
 获取聊天广场列表
 */
+(void) getAppHomeChatPlazaVO:(CallBackChatFamilyController_AppHomeChatPlazaVOArr)callback;


/**
 修改家族公告
 @param familyId 家族id
 @param familyProclamation 家族公告
 */
+(void) upChatFamilyProclamation:(int64_t)familyId familyProclamation:(NSString *)familyProclamation  callback:(CallBackChatFamilyController_HttpNone)callback;


/**
 修改聊天家族信息
 @param familyDescription 家族描述
 @param familyIcon 家族图标
 @param familyId 家族id
 @param familyName 家族名称
 */
+(void) upChatFamilyInfo:(NSString *)familyDescription familyIcon:(NSString *)familyIcon familyId:(int64_t)familyId familyName:(NSString *)familyName  callback:(CallBackChatFamilyController_HttpNone)callback;


/**
 用户添加聊天家族举报
 @param chatFamilyAppealDescription 家族举报描述
 @param chatFamilyAppealImages 家族举报图片
 @param chatFamilyAppealTypeId 家族举报类型id
 @param chatFamilyAppealTypeName 家族举报类型名称
 @param familyId 家族id
 */
+(void) addFamilyAppeal:(NSString *)chatFamilyAppealDescription chatFamilyAppealImages:(NSString *)chatFamilyAppealImages chatFamilyAppealTypeId:(int64_t)chatFamilyAppealTypeId chatFamilyAppealTypeName:(NSString *)chatFamilyAppealTypeName familyId:(int64_t)familyId  callback:(CallBackChatFamilyController_HttpNone)callback;


/**
 是否可以创建家族
 */
+(void) isAllowedChatFamily:(CallBackChatFamilyController_HttpNone)callback;


/**
 家族禁言列表
 @param familyId 家族id
 */
+(void) getAppChatFamilyMuteVO:(int64_t)familyId  callback:(CallBackChatFamilyController_AppChatFamilyMuteVOArr)callback;


/**
 用户离开聊天家族
 @param familyId 家族id
 */
+(void) userLeaveFamily:(int64_t)familyId  callback:(CallBackChatFamilyController_HttpNone)callback;


/**
 查看我与对方在家族中的操作信息
 @param familyId 家族id
 @param toUserId 被查看人用户id
 */
+(void) getAppChatFamilyOptIntoVO:(int64_t)familyId toUserId:(int64_t)toUserId  callback:(CallBackChatFamilyController_AppChatFamilyOptIntoVO)callback;


/**
 家族踢人
 @param familyId 家族id
 @param userId 被踢用户id
 */
+(void) familyKick:(int64_t)familyId userId:(int64_t)userId  callback:(CallBackChatFamilyController_HttpNone)callback;


/**
 获取聊天家族成员列表
 @param familyId 家族id
 @param pageIndex 页数
 @param pageSize 每页条数
 */
+(void) getFamilyUserList:(int64_t)familyId pageIndex:(int)pageIndex pageSize:(int)pageSize  callback:(CallBackChatFamilyController_AppHomeFamilyUserVOArr)callback;


/**
 获取聊天室首页信息
 @param familyId 家族id
 */
+(void) getAppFamilyChatroomInfoVO:(int64_t)familyId  callback:(CallBackChatFamilyController_AppFamilyChatroomInfoVO)callback;


/**
 获取某一个聊天家族的信息
 @param familyId 家族id
 */
+(void) getHomeChatFamilyInfoVO:(int64_t)familyId  callback:(CallBackChatFamilyController_AppHomeChatFamilyInfoVO)callback;


/**
 获取家族公告
 @param familyId 家族id
 */
+(void) getAppChatFamilyProclamationVO:(int64_t)familyId  callback:(CallBackChatFamilyController_AppChatFamily)callback;


/**
 获取聊天家族待审核列表
 @param familyId 家族id
 @param pageIndex 页数
 @param pageSize 每页条数
 */
+(void) getPendingCheckUserList:(int64_t)familyId pageIndex:(int)pageIndex pageSize:(int)pageSize  callback:(CallBackChatFamilyController_AppHomeFamilyUserVOArr)callback;


/**
 族长审核 用户加入聊天家族
 @param familyId 家族id
 @param userId 被审核的用户id
 @param userStatus 审核状态 1：同意加入 -1：拒绝加入
 */
+(void) joinFamilyCheck:(int64_t)familyId userId:(int64_t)userId userStatus:(int64_t)userStatus  callback:(CallBackChatFamilyController_HttpNone)callback;


/**
 查询家族首页
 @param city 城市（类型为1时传）
 @param latitude 家族所在纬度
 @param longitude 家族所在经度
 @param pageIndex 页数
 @param pageSize 每页条数
 @param queryType 查询类型 1：同城 2：附近 3：日榜 4：周榜 5：月榜 6：总榜
 */
+(void) getHomeChatFamilyList:(NSString *)city latitude:(double)latitude longitude:(double)longitude pageIndex:(int)pageIndex pageSize:(int)pageSize queryType:(int)queryType  callback:(CallBackChatFamilyController_AppHomeChatFamilyVOArr)callback;

@end

NS_ASSUME_NONNULL_END
