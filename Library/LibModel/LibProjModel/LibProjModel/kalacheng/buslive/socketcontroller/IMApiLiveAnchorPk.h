//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

@class IMSocketIns;
@class ApiLinkEntityModel;

@class SingleStringModel;

typedef void (^CallBack_LiveAnchorPk_ApiLinkEntity)(int code,NSString *errMsg,ApiLinkEntityModel* model);
typedef void (^CallBack_LiveAnchorPk_SingleString)(int code,NSString *errMsg,SingleStringModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
主播PKsocket
 */
@interface IMApiLiveAnchorPk: NSObject


@property (nonatomic, strong)IMSocketIns*  socket;
-(instancetype) init:(IMSocketIns*)socket;

/**
 invitationAnchorLinePK
 @param toUid 被邀请PK主播id
 @param pkCfgId pk时长配置id
 */
-(void) invitationAnchorLinePK:(int64_t)toUid pkCfgId:(int64_t)pkCfgId  callback:(CallBack_LiveAnchorPk_ApiLinkEntity)callback;


/**
 invitationAnchorPKResp
 @param isAgree 是否同意连麦1同意,2拒绝,3超时
 @param fromUid 请求PK者主播id
 @param pkSessionID null
 */
-(void) invitationAnchorPKResp:(int)isAgree fromUid:(int64_t)fromUid pkSessionID:(int64_t)pkSessionID  callback:(CallBack_LiveAnchorPk_SingleString)callback;

@end

NS_ASSUME_NONNULL_END
