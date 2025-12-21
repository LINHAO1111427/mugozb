//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "AppLiangModel.h"

#import "FansInfoDtoModel.h"

#import "HttpNoneModel.h"

#import "AppUsersAuthModel.h"

#import "FansInfoModel.h"

#import "OpenAuthDataVOModel.h"

#import "AnchorRelatedInfoVOModel.h"

#import "ApiUsersLineModel.h"

#import "RanksDtoModel.h"

typedef void (^CallBackAnchorController_AppLiangArr)(int code,NSString *strMsg,NSArray<AppLiangModel*>* arr);
typedef void (^CallBackAnchorController_FansInfoDto)(int code,NSString *strMsg,FansInfoDtoModel* model);
typedef void (^CallBackAnchorController_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackAnchorController_AppUsersAuth)(int code,NSString *strMsg,AppUsersAuthModel* model);
typedef void (^CallBackAnchorController_FansInfoArr)(int code,NSString *strMsg,NSArray<FansInfoModel*>* arr);
typedef void (^CallBackAnchorController_OpenAuthDataVO)(int code,NSString *strMsg,OpenAuthDataVOModel* model);
typedef void (^CallBackAnchorController_AnchorRelatedInfoVO)(int code,NSString *strMsg,AnchorRelatedInfoVOModel* model);
typedef void (^CallBackAnchorController_ApiUsersLineArr)(int code,NSString *strMsg,NSArray<ApiUsersLineModel*>* arr);
typedef void (^CallBackAnchorController_RanksDtoArr)(int code,NSString *strMsg,NSArray<RanksDtoModel*>* arr);
NS_ASSUME_NONNULL_BEGIN



/**
主播接口API
 */
@interface HttpApiAnchorController: NSObject



/**
 靓号列表
 @param pageIndex pageIndex
 @param pageSize pageSize
 */
+(void) getNumberList:(int)pageIndex pageSize:(int)pageSize  callback:(CallBackAnchorController_AppLiangArr)callback;


/**
 我的粉丝团基本信息
 @param anchorId 主播ID
 */
+(void) fansTeamInfo:(int64_t)anchorId  callback:(CallBackAnchorController_FansInfoDto)callback;


/**
 加入粉丝团
 @param anchorId 主播ID
 */
+(void) joinFansTeam:(int64_t)anchorId  callback:(CallBackAnchorController_HttpNone)callback;


/**
 粉丝团直播间信息
 @param groupId 群组id
 */
+(void) liveFansTeamInfoByGroupId:(int64_t)groupId  callback:(CallBackAnchorController_FansInfoDto)callback;


/**
 主播认证第二步
 @param backView 身份证反面(同上)
 @param frontView 身份证正面(通过轩嗵云上传后返回的图片地址)
 @param handsetView 手持身份证(同上)
 */
+(void) authSecond:(NSString *)backView frontView:(NSString *)frontView handsetView:(NSString *)handsetView  callback:(CallBackAnchorController_AppUsersAuth)callback;


/**
 粉丝团用户信息
 @param groupId 粉丝团群组ID
 */
+(void) getFansByGroupId:(int64_t)groupId  callback:(CallBackAnchorController_FansInfoArr)callback;


/**
 主播认证接口返回的code 1:已认证 2:未认证 3:等待审核
 @param type 类型 1:直播 2:动态 3:实名认证 4:短视频 5:语音
 */
+(void) openAuth:(int)type  callback:(CallBackAnchorController_OpenAuthDataVO)callback;


/**
 获取和主播关联的一些信息
 @param anchorId 主播id
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 (不需要火力值，传0)
 @param roomId 房间号 (不需要火力值，传0)
 */
+(void) getAnchorRelatedInfoVO:(int64_t)anchorId liveType:(int)liveType roomId:(int64_t)roomId  callback:(CallBackAnchorController_AnchorRelatedInfoVO)callback;


/**
 主播认证第一步
 @param cerNo 身份证号码
 @param extraInfo 附加信息
 @param mobile 手机号码
 @param qq qq号
 @param realName 真实姓名
 @param wechat 微信号
 */
+(void) authFirst:(NSString *)cerNo extraInfo:(NSString *)extraInfo mobile:(NSString *)mobile qq:(NSString *)qq realName:(NSString *)realName wechat:(NSString *)wechat  callback:(CallBackAnchorController_AppUsersAuth)callback;


/**
 设置粉丝团信息
 @param avatar avatar
 @param coin 入团费用
 @param name 粉丝团昵称
 */
+(void) setFansTeamInfo:(NSString *)avatar coin:(double)coin name:(NSString *)name  callback:(CallBackAnchorController_HttpNone)callback;


/**
 粉丝团直播间信息
 @param anchorId 主播ID
 */
+(void) liveFansTeamInfo:(int64_t)anchorId  callback:(CallBackAnchorController_FansInfoDto)callback;


/**
 查询在线用户和在线主播列表(附近的人)
 @param city 城市筛选 没有指定城市就传空字符串
 @param pageIndex 当前页
 @param pageSize 每页大小
 @param sex 性别 0:未设置 1:男 2:女 
 @param status 状态 -1:全部 1:直播中 2:房间中 3:在线 4:离线
 @param tabIds 标签ID数组， 逗号隔开
 */
+(void) getLineUser:(NSString *)city pageIndex:(int)pageIndex pageSize:(int)pageSize sex:(int)sex status:(int)status tabIds:(NSString *)tabIds  callback:(CallBackAnchorController_ApiUsersLineArr)callback;


/**
 粉丝团排行
 @param anchorId 主播ID
 @param pageIndex 当前页
 @param pageSize 每页大小
 */
+(void) getFansTeamRank:(int64_t)anchorId pageIndex:(int)pageIndex pageSize:(int)pageSize  callback:(CallBackAnchorController_RanksDtoArr)callback;


/**
 粉丝团用户信息
 @param uid 用户ID
 */
+(void) getFansByUid:(int64_t)uid  callback:(CallBackAnchorController_FansInfoArr)callback;


/**
 赠送靓号
 @param anchorId 主播id
 @param numId 靓号Id
 */
+(void) purchaseNumber:(int64_t)anchorId numId:(int64_t)numId  callback:(CallBackAnchorController_HttpNone)callback;


/**
 主播认证第三步
 @param videoUrl 短视频地址
 */
+(void) authThird:(NSString *)videoUrl  callback:(CallBackAnchorController_AppUsersAuth)callback;


/**
 未认证成功资料回显
 */
+(void) authShow:(CallBackAnchorController_AppUsersAuth)callback;

@end

NS_ASSUME_NONNULL_END
