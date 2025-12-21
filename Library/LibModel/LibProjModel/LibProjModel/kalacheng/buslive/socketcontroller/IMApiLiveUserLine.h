//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

@class IMSocketIns;
@class SingleStringModel;

@class ApiLinkEntityModel;

typedef void (^CallBack_LiveUserLine_SingleString)(int code,NSString *errMsg,SingleStringModel* model);
typedef void (^CallBack_LiveUserLine_ApiLinkEntity)(int code,NSString *errMsg,ApiLinkEntityModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
用户连麦socket
 */
@interface IMApiLiveUserLine: NSObject


@property (nonatomic, strong)IMSocketIns*  socket;
-(instancetype) init:(IMSocketIns*)socket;

/**
 invitationUserLineResp
 @param isAgree 是否同意连麦1同意,2拒绝,3超时
 @param fromUid 请求用户id
 @param linkSessionID null
 */
-(void) invitationUserLineResp:(int)isAgree fromUid:(int64_t)fromUid linkSessionID:(int64_t)linkSessionID  callback:(CallBack_LiveUserLine_SingleString)callback;


/**
 invitationUserLineClose
 @param anchorId 主播id
 @param linkSessionID null
 */
-(void) invitationUserLineClose:(int64_t)anchorId linkSessionID:(int64_t)linkSessionID  callback:(CallBack_LiveUserLine_SingleString)callback;


/**
 invitationUserLineReq
 @param toUid 被邀请连麦的主播id
 */
-(void) invitationUserLineReq:(int64_t)toUid  callback:(CallBack_LiveUserLine_ApiLinkEntity)callback;


/**
 setAnchorLineStatus
 @param status 设置连麦1开启连麦0关闭连麦
 */
-(void) setAnchorLineStatus:(int)status  callback:(CallBack_LiveUserLine_SingleString)callback;

@end

NS_ASSUME_NONNULL_END
