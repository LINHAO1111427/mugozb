//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/HttpClient.h>
#import "MJExtension.h"
#import <LibTools/NSDictionary+Json.h>
#import "IMApiLiveUserLine.h"
#import <TXImKit/TXImKit.h>
#import "SingleStringModel.h"

#import "ApiLinkEntityModel.h"





@implementation IMApiLiveUserLine

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
 invitationUserLineResp
 @param isAgree 是否同意连麦1同意,2拒绝,3超时
 @param fromUid 请求用户id
 @param linkSessionID null
 */
-(void) invitationUserLineResp:(int)isAgree fromUid:(int64_t)fromUid linkSessionID:(int64_t)linkSessionID  callback:(CallBack_LiveUserLine_SingleString)callback;

{

NSDictionary *msgDataDict=@{@"isAgree":@(isAgree),@"fromUid":@(fromUid),@"linkSessionID":@(linkSessionID)};
  [self.socket  sendMsg:@"LiveUserLine" msgSubType:@"invitationUserLineResp" message:msgDataDict callback:^(int code, NSString * _Nonnull errMsg, NSDictionary * _Nonnull data)
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
 invitationUserLineClose
 @param anchorId 主播id
 @param linkSessionID null
 */
-(void) invitationUserLineClose:(int64_t)anchorId linkSessionID:(int64_t)linkSessionID  callback:(CallBack_LiveUserLine_SingleString)callback;

{

NSDictionary *msgDataDict=@{@"anchorId":@(anchorId),@"linkSessionID":@(linkSessionID)};
  [self.socket  sendMsg:@"LiveUserLine" msgSubType:@"invitationUserLineClose" message:msgDataDict callback:^(int code, NSString * _Nonnull errMsg, NSDictionary * _Nonnull data)
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
 invitationUserLineReq
 @param toUid 被邀请连麦的主播id
 */
-(void) invitationUserLineReq:(int64_t)toUid  callback:(CallBack_LiveUserLine_ApiLinkEntity)callback;

{

NSDictionary *msgDataDict=@{@"toUid":@(toUid)};
  [self.socket  sendMsg:@"LiveUserLine" msgSubType:@"invitationUserLineReq" message:msgDataDict callback:^(int code, NSString * _Nonnull errMsg, NSDictionary * _Nonnull data)
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
 setAnchorLineStatus
 @param status 设置连麦1开启连麦0关闭连麦
 */
-(void) setAnchorLineStatus:(int)status  callback:(CallBack_LiveUserLine_SingleString)callback;

{

NSDictionary *msgDataDict=@{@"status":@(status)};
  [self.socket  sendMsg:@"LiveUserLine" msgSubType:@"setAnchorLineStatus" message:msgDataDict callback:^(int code, NSString * _Nonnull errMsg, NSDictionary * _Nonnull data)
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


