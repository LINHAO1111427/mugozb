//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/HttpClient.h>
#import "MJExtension.h"
#import <LibTools/NSDictionary+Json.h>
#import "IMApiLiveAnchorLine.h"
#import <TXImKit/TXImKit.h>
#import "SingleStringModel.h"

#import "ApiLinkEntityModel.h"





@implementation IMApiLiveAnchorLine

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
 invitationAnchorLineResp
 @param isAgree 是否同意连麦 1:同意 2:拒绝 3:超时
 @param fromUid 请求者主播id
 @param linkSessionID null
 */
-(void) invitationAnchorLineResp:(int)isAgree fromUid:(int64_t)fromUid linkSessionID:(int64_t)linkSessionID  callback:(CallBack_LiveAnchorLine_SingleString)callback;

{

NSDictionary *msgDataDict=@{@"isAgree":@(isAgree),@"fromUid":@(fromUid),@"linkSessionID":@(linkSessionID)};
  [self.socket  sendMsg:@"LiveAnchorLine" msgSubType:@"invitationAnchorLineResp" message:msgDataDict callback:^(int code, NSString * _Nonnull errMsg, NSDictionary * _Nonnull data)
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

/**
 invitationAnchorLineClose
 @param roomId 房间id
 @param linkSessionID null
 */
-(void) invitationAnchorLineClose:(int64_t)roomId linkSessionID:(int64_t)linkSessionID  callback:(CallBack_LiveAnchorLine_SingleString)callback;

{

NSDictionary *msgDataDict=@{@"roomId":@(roomId),@"linkSessionID":@(linkSessionID)};
  [self.socket  sendMsg:@"LiveAnchorLine" msgSubType:@"invitationAnchorLineClose" message:msgDataDict callback:^(int code, NSString * _Nonnull errMsg, NSDictionary * _Nonnull data)
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

/**
 invitationAnchorLine
 @param toUid 被邀请主播id
 */
-(void) invitationAnchorLine:(int64_t)toUid  callback:(CallBack_LiveAnchorLine_ApiLinkEntity)callback;

{

NSDictionary *msgDataDict=@{@"toUid":@(toUid)};
  [self.socket  sendMsg:@"LiveAnchorLine" msgSubType:@"invitationAnchorLine" message:msgDataDict callback:^(int code, NSString * _Nonnull errMsg, NSDictionary * _Nonnull data)
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


@end


