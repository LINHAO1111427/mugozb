//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "ApiCommentsMsgModel.h"

#import "SingleStringModel.h"

#import "HttpNoneModel.h"

#import "AppHomeSystemNoticeVOModel.h"

#import "AppSystemNoticeUserModel.h"

#import "ApiNoReadModel.h"

typedef void (^CallBackMessage_ApiCommentsMsgPageArr)(int code,NSString *strMsg,PageInfo *pageInfo,NSArray<ApiCommentsMsgModel*>* arr);
typedef void (^CallBackMessage_SingleString)(int code,NSString *strMsg,SingleStringModel* model);
typedef void (^CallBackMessage_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackMessage_AppHomeSystemNoticeVOArr)(int code,NSString *strMsg,NSArray<AppHomeSystemNoticeVOModel*>* arr);
typedef void (^CallBackMessage_AppSystemNoticeUserArr)(int code,NSString *strMsg,NSArray<AppSystemNoticeUserModel*>* arr);
typedef void (^CallBackMessage_ApiNoRead)(int code,NSString *strMsg,ApiNoReadModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
消息API
 */
@interface HttpApiMessage: NSObject



/**
 动态回复消息列表
 @param page 页数
 @param pageSize 每页的条数
 */
+(void) videoCommentsList:(int)page pageSize:(int)pageSize  callback:(CallBackMessage_ApiCommentsMsgPageArr)callback;


/**
 1V1发消息
 @param content 发送内容
 */
+(void) keywordTransform:(NSString *)content  callback:(CallBackMessage_SingleString)callback;


/**
 消息-清除未读为已读
 @param noticeId 对象id(动态消息id/通知id,全清时传-1)
 */
+(void) delNoticeMsg:(int64_t)noticeId  callback:(CallBackMessage_HttpNone)callback;


/**
 短视频回复消息列表
 @param page 页数
 @param pageSize 每页的条数
 */
+(void) shortVideoCommentsList:(int)page pageSize:(int)pageSize  callback:(CallBackMessage_ApiCommentsMsgPageArr)callback;


/**
 系统通知类型列表
 */
+(void) getAppSystemNoticeList:(CallBackMessage_AppHomeSystemNoticeVOArr)callback;


/**
 用户系统通知列表
 @param noticeId 通知类型id
 @param pageIndex 页数
 @param pageSize 每页的条数
 */
+(void) getAppSystemNoticeUserList:(int)noticeId pageIndex:(int)pageIndex pageSize:(int)pageSize  callback:(CallBackMessage_AppSystemNoticeUserArr)callback;


/**
 获取系统通知未读数
 */
+(void) getAppSystemNoRead:(CallBackMessage_ApiNoRead)callback;


/**
 消息-清除未读为已读
 @param objId 对象id(动态消息id/通知id/短视频评论id,全清时传-1)
 @param type 类型 0:全部 1:动态 2:点赞 3:通知 4:短视频评论 5:官方消息
 */
+(void) clearNoticeMsg:(int64_t)objId type:(int)type  callback:(CallBackMessage_HttpNone)callback;

@end

NS_ASSUME_NONNULL_END
