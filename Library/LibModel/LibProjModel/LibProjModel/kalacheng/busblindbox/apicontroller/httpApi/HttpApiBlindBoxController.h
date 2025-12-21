//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "DrawBlindBoxRecordVOModel.h"

#import "HttpNoneModel.h"

#import "BlindBoxUserSimpleInfoModel.h"

#import "BlindBoxUserInfoVOModel.h"

#import "BlindBoxAppealTypeVOModel.h"

typedef void (^CallBackBlindBoxController_DrawBlindBoxRecordVO)(int code,NSString *strMsg,DrawBlindBoxRecordVOModel* model);
typedef void (^CallBackBlindBoxController_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackBlindBoxController_BlindBoxUserSimpleInfoArr)(int code,NSString *strMsg,NSArray<BlindBoxUserSimpleInfoModel*>* arr);
typedef void (^CallBackBlindBoxController_DrawBlindBoxRecordVOArr)(int code,NSString *strMsg,NSArray<DrawBlindBoxRecordVOModel*>* arr);
typedef void (^CallBackBlindBoxController_BlindBoxUserInfoVO)(int code,NSString *strMsg,BlindBoxUserInfoVOModel* model);
typedef void (^CallBackBlindBoxController_BlindBoxAppealTypeVOArr)(int code,NSString *strMsg,NSArray<BlindBoxAppealTypeVOModel*>* arr);
NS_ASSUME_NONNULL_BEGIN



/**
盲盒
 */
@interface HttpApiBlindBoxController: NSObject



/**
 根据性别获得随机匹配的用户
 @param gender 性别
 */
+(void) getRandomUserInfo:(int)gender  callback:(CallBackBlindBoxController_DrawBlindBoxRecordVO)callback;


/**
 保存盲盒用户信息
 @param age 年龄
 @param gender 性别
 @param introduce 自我介绍
 @param labIds 标签名称(用,分割)
 @param phone 手机号
 @param realPicture 真实照片
 @param school 学校名称
 @param wechatNo 微信号
 */
+(void) addBlindBoxUser:(int)age gender:(int)gender introduce:(NSString *)introduce labIds:(NSString *)labIds phone:(NSString *)phone realPicture:(NSString *)realPicture school:(NSString *)school wechatNo:(NSString *)wechatNo  callback:(CallBackBlindBoxController_HttpNone)callback;


/**
 转圈圈的球
 */
+(void) getBallData:(CallBackBlindBoxController_BlindBoxUserSimpleInfoArr)callback;


/**
 获取用户的抽取盲盒的记录
 @param pageIndex 当前页
 @param pageSize 每页大小
 @param type 抽取类型 1:性别盲盒, 2.随机匹配, -1:全部
 @param userId UserId抽盲盒的记录， -1为全部
 */
+(void) getBlindBoxRecord:(int)pageIndex pageSize:(int)pageSize type:(int64_t)type userId:(int64_t)userId  callback:(CallBackBlindBoxController_DrawBlindBoxRecordVOArr)callback;


/**
 开启匹配的用户盲盒
 @param userId 查看的用户Id
 */
+(void) openMatchingUser:(int64_t)userId  callback:(CallBackBlindBoxController_DrawBlindBoxRecordVO)callback;


/**
 下架用户信息
 */
+(void) outBlindBoxUser:(CallBackBlindBoxController_HttpNone)callback;


/**
 获取盲盒公告
 */
+(void) getBlindBoxNotice:(CallBackBlindBoxController_HttpNone)callback;


/**
 投诉盲盒用户
 @param appealTypeId 投诉类型ID
 @param appealUserId 获取用户ID的信息
 */
+(void) appealBlindBoxUser:(int64_t)appealTypeId appealUserId:(int64_t)appealUserId  callback:(CallBackBlindBoxController_HttpNone)callback;


/**
 获取随机匹配的用户
 @param outUid 排除匹配的用户ID
 */
+(void) getMatchingUser:(int64_t)outUid  callback:(CallBackBlindBoxController_BlindBoxUserInfoVO)callback;


/**
 获取盲盒总人数
 */
+(void) getBlindBoxTotalPeople:(CallBackBlindBoxController_HttpNone)callback;


/**
 获取盲盒投诉类型
 */
+(void) getBlindBoxAppealType:(CallBackBlindBoxController_BlindBoxAppealTypeVOArr)callback;


/**
 用户保存盲盒信息记录
 @param userId 获取用户ID的信息
 */
+(void) getBlindBoxUserInfo:(int64_t)userId  callback:(CallBackBlindBoxController_BlindBoxUserInfoVO)callback;


/**
 获取一条抽取记录信息
 @param drawId 抽取记录ID
 */
+(void) getDrawOneRecord:(int64_t)drawId  callback:(CallBackBlindBoxController_DrawBlindBoxRecordVO)callback;


/**
 开启盲盒的价钱
 */
+(void) openBlindBoxPrice:(CallBackBlindBoxController_HttpNone)callback;

@end

NS_ASSUME_NONNULL_END
