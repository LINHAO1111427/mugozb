//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/HttpClient.h>
#import "MJExtension.h"
#import <LibTools/NSDictionary+Json.h>
#import "IMApiATestSocket.h"
#import <TXImKit/TXImKit.h>
#import "aTestModleModel.h"

#import "SingleStringModel.h"





@implementation IMApiATestSocket

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
 getMsg2
 @param mdl null
 @param reqUid null
 */
-(void) getMsg2:(aTestModleModel* )mdl reqUid:(int64_t)reqUid  callback:(CallBack_ATestSocket_aTestModle)callback;

{

NSDictionary *msgDataDict=@{@"mdl":[mdl modelToJSONObject],@"reqUid":@(reqUid)};
  [self.socket  sendMsg:@"ATestSocket" msgSubType:@"getMsg2" message:msgDataDict callback:^(int code, NSString * _Nonnull errMsg, NSDictionary * _Nonnull data)
 {
        if(code!=1)
        {
            callback(code,errMsg,nil);
            return ;
        }
        aTestModleModel*  retModel=   [aTestModleModel getFromDict:data];
        callback(code,errMsg,retModel);
  }];

}

/**
 getMsg1
 @param assistanNo 麦位编号
 @param type 是否能直接上麦,1:能直接上麦,2,不能
 */
-(void) getMsg1:(int)assistanNo type:(int)type  callback:(CallBack_ATestSocket_aTestModle)callback;

{

NSDictionary *msgDataDict=@{@"assistanNo":@(assistanNo),@"type":@(type)};
  [self.socket  sendMsg:@"ATestSocket" msgSubType:@"getMsg1" message:msgDataDict callback:^(int code, NSString * _Nonnull errMsg, NSDictionary * _Nonnull data)
 {
        if(code!=1)
        {
            callback(code,errMsg,nil);
            return ;
        }
        aTestModleModel*  retModel=   [aTestModleModel getFromDict:data];
        callback(code,errMsg,retModel);
  }];

}

/**
 getMsg3
 @param mdl null
 @param reqUid null
 */
-(void) getMsg3:(aTestModleModel* )mdl reqUid:(int64_t)reqUid  callback:(CallBack_ATestSocket_SingleString)callback;

{

NSDictionary *msgDataDict=@{@"mdl":[mdl modelToJSONObject],@"reqUid":@(reqUid)};
  [self.socket  sendMsg:@"ATestSocket" msgSubType:@"getMsg3" message:msgDataDict callback:^(int code, NSString * _Nonnull errMsg, NSDictionary * _Nonnull data)
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


