//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/HttpClient.h>
#import "MJExtension.h"
#import <LibTools/NSDictionary+Json.h>
#import "IMApiLiveAnchorPk.h"
#import <TXImKit/TXImKit.h>
#import "ApiLinkEntityModel.h"

#import "SingleStringModel.h"





@implementation IMApiLiveAnchorPk

-(instancetype) init:(IMSocketIns*)socket
{
    self=[super init];
    if(self)
{
    self.socket=socket;
    }
    return self;
}
/**
 invitationAnchorLinePK
 @param toUid 被邀请PK主播id
 @param pkCfgId pk时长配置id
 */
-(void) invitationAnchorLinePK:(int64_t)toUid pkCfgId:(int64_t)pkCfgId  callback:(CallBack_LiveAnchorPk_ApiLinkEntity)callback;

{

NSDictionary *msgDataDict=@{@"toUid":@(toUid),@"pkCfgId":@(pkCfgId)};
  [self.socket  sendMsg:@"LiveAnchorPk" msgSubType:@"invitationAnchorLinePK" message:msgDataDict callback:^(int code, NSString * _Nonnull errMsg, NSDictionary * _Nonnull data)
 {
        if(code!=1)
        {
            callback(code,errMsg,nil);
            return ;
        }
        ApiLinkEntityModel*  retModel=   [ApiLinkEntityModel getFromDict:data];
        callback(code,errMsg,retModel);
  }];

}

/**
 invitationAnchorPKResp
 @param isAgree 是否同意连麦1同意,2拒绝,3超时
 @param fromUid 请求PK者主播id
 @param pkSessionID null
 */
-(void) invitationAnchorPKResp:(int)isAgree fromUid:(int64_t)fromUid pkSessionID:(int64_t)pkSessionID  callback:(CallBack_LiveAnchorPk_SingleString)callback;

{

NSDictionary *msgDataDict=@{@"isAgree":@(isAgree),@"fromUid":@(fromUid),@"pkSessionID":@(pkSessionID)};
  [self.socket  sendMsg:@"LiveAnchorPk" msgSubType:@"invitationAnchorPKResp" message:msgDataDict callback:^(int code, NSString * _Nonnull errMsg, NSDictionary * _Nonnull data)
 {
        if(code!=1)
        {
            callback(code,errMsg,nil);
            return ;
        }
        SingleStringModel*  retModel=   [SingleStringModel getFromDict:data];
        callback(code,errMsg,retModel);
  }];

}


@end


