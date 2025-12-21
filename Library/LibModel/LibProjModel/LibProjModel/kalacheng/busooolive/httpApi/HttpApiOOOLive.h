//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "ApiCfgPayCallOneVsOneModel.h"

#import "CallRecordDtoModel.h"

#import "OooTwoClassifyVOModel.h"

#import "HttpNoneModel.h"

#import "OOOMeetAnchorModel.h"

#import "MeetPostsVOModel.h"

#import "SingleStringModel.h"

#import "AnchorCommentVOModel.h"

#import "CfgWechatVOModel.h"

#import "ApiLineBeforeOOOModel.h"

#import "PayCallOneVsOneVOModel.h"

typedef void (^CallBackOOOLive_ApiCfgPayCallOneVsOneArr)(int code,NSString *strMsg,NSArray<ApiCfgPayCallOneVsOneModel*>* arr);
typedef void (^CallBackOOOLive_CallRecordDtoArr)(int code,NSString *strMsg,NSArray<CallRecordDtoModel*>* arr);
typedef void (^CallBackOOOLive_OooTwoClassifyVOArr)(int code,NSString *strMsg,NSArray<OooTwoClassifyVOModel*>* arr);
typedef void (^CallBackOOOLive_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackOOOLive_OOOMeetAnchor)(int code,NSString *strMsg,OOOMeetAnchorModel* model);
typedef void (^CallBackOOOLive_MeetPostsVO)(int code,NSString *strMsg,MeetPostsVOModel* model);
typedef void (^CallBackOOOLive_SingleString)(int code,NSString *strMsg,SingleStringModel* model);
typedef void (^CallBackOOOLive_AnchorCommentVOArr)(int code,NSString *strMsg,NSArray<AnchorCommentVOModel*>* arr);
typedef void (^CallBackOOOLive_CfgWechatVO)(int code,NSString *strMsg,CfgWechatVOModel* model);
typedef void (^CallBackOOOLive_ApiLineBeforeOOO)(int code,NSString *strMsg,ApiLineBeforeOOOModel* model);
typedef void (^CallBackOOOLive_PayCallOneVsOneVO)(int code,NSString *strMsg,PayCallOneVsOneVOModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
一对一直播间Http接口
 */
@interface HttpApiOOOLive: NSObject



/**
 用户在前段点击遇见按钮显示的页面数据,单人和多人都是这个接口
 @param lat 纬度
 @param lng 经度
 */
+(void) meetUser:(double)lat lng:(double)lng  callback:(CallBackOOOLive_ApiCfgPayCallOneVsOneArr)callback;


/**
 通话记录
 @param anchorId 主播ID
 @param pageIndex 当前页
 @param pageSize 每页大小
 */
+(void) getCallRecordList:(int64_t)anchorId pageIndex:(int)pageIndex pageSize:(int)pageSize  callback:(CallBackOOOLive_CallRecordDtoArr)callback;


/**
 获取一对一二级分类
 @param oneClassifyId 一级分类id
 */
+(void) getOooTwoClassify:(int64_t)oneClassifyId  callback:(CallBackOOOLive_OooTwoClassifyVOArr)callback;


/**
 设置查看微信号的费用
 @param starPriceId 星级价格id
 */
+(void) setViewContactPrice:(int64_t)starPriceId  callback:(CallBackOOOLive_HttpNone)callback;


/**
 主播端匹配用户
 */
+(void) meetAnchor:(CallBackOOOLive_OOOMeetAnchor)callback;


/**
 遇见-规则
 */
+(void) meetPosts:(CallBackOOOLive_MeetPostsVO)callback;


/**
 查看联系方式
 @param type 联系方式类型 1：手机号  2：微信号
 @param userId 被查看的用户ID
 */
+(void) payViewContact:(int)type userId:(int64_t)userId  callback:(CallBackOOOLive_SingleString)callback;


/**
 主播1v1评价列表
 @param anchorId 主播id
 @param pageIndex 页码
 @param pageSize 每页数量
 */
+(void) anchorCommentList:(int64_t)anchorId pageIndex:(int)pageIndex pageSize:(int)pageSize  callback:(CallBackOOOLive_AnchorCommentVOArr)callback;


/**
 获取微信号相关信息
 */
+(void) getViewContactPrice:(CallBackOOOLive_CfgWechatVO)callback;


/**
 一对一状态设置
 @param liveState 一对一在线状态  0在线1忙碌2离开3通话中
 */
+(void) setPayCallOneVsOneStatus:(int)liveState  callback:(CallBackOOOLive_HttpNone)callback;


/**
 1v1对主播评价操作
 @param anchorId 主播id
 @param ids 标签id(多个标签id用逗号隔开)
 */
+(void) addCommentByAnchor:(int64_t)anchorId ids:(NSString *)ids  callback:(CallBackOOOLive_HttpNone)callback;


/**
 一对一付费通话设置
 @param starPriceId 价格id
 @param type 1.视频，2.语音
 */
+(void) setPayCallOneVsOnePrice:(int64_t)starPriceId type:(int)type  callback:(CallBackOOOLive_HttpNone)callback;


/**
 一对一连线付费提示
 @param type 类型1语音2视频
 */
+(void) getLineBeforeOOO:(int)type  callback:(CallBackOOOLive_ApiLineBeforeOOO)callback;


/**
 获取一对一付费通话设置
 */
+(void) getPayCallOneVsOneCfg:(CallBackOOOLive_PayCallOneVsOneVO)callback;


/**
 一对一付费通话设置
 @param poster 海报, 修改时可为null
 @param video 视频地址, 修改时可为null
 @param videoImg 视频封面地址, 修改时可为null
 @param voice 录音地址, 修改时可为null
 @param voiceTime 语音时长
 */
+(void) setPayCallOneVsOne:(NSString *)poster video:(NSString *)video videoImg:(NSString *)videoImg voice:(NSString *)voice voiceTime:(int64_t)voiceTime  callback:(CallBackOOOLive_HttpNone)callback;


/**
 用户在前段点击遇见按钮显示的页面数据,单人和多人都是这个接口
 */
+(void) exitMeetUser:(CallBackOOOLive_HttpNone)callback;

@end

NS_ASSUME_NONNULL_END
