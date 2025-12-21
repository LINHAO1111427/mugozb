//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

@class IMSocketIns;
@class SingleStringModel;

@class ApiLinkEntityModel;

typedef void (^CallBack_LiveAnchorLine_SingleString)(int code,NSString *errMsg,SingleStringModel* model);
typedef void (^CallBack_LiveAnchorLine_ApiLinkEntity)(int code,NSString *errMsg,ApiLinkEntityModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
主播互动socket
 */
@interface IMApiLiveAnchorLine: NSObject


@property (nonatomic, strong)IMSocketIns*  socket;
-(instancetype) init:(IMSocketIns*)socket;

/**
 invitationAnchorLineResp
 @param isAgree 是否同意连麦 1:同意 2:拒绝 3:超时
 @param fromUid 请求者主播id
 @param linkSessionID null
 */
-(void) invitationAnchorLineResp:(int)isAgree fromUid:(int64_t)fromUid linkSessionID:(int64_t)linkSessionID  callback:(CallBack_LiveAnchorLine_SingleString)callback;


/**
 invitationAnchorLineClose
 @param roomId 房间id
 @param linkSessionID null
 */
-(void) invitationAnchorLineClose:(int64_t)roomId linkSessionID:(int64_t)linkSessionID  callback:(CallBack_LiveAnchorLine_SingleString)callback;


/**
 invitationAnchorLine
 @param toUid 被邀请主播id
 */
-(void) invitationAnchorLine:(int64_t)toUid  callback:(CallBack_LiveAnchorLine_ApiLinkEntity)callback;

@end

NS_ASSUME_NONNULL_END
