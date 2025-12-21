//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/HttpClient.h>
#import "MJExtension.h"
#import <LibTools/NSDictionary+Json.h>
#import "IMApiLive.h"
#import <TXImKit/TXImKit.h>
#import "SingleStringModel.h"





@implementation IMApiLive

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
 leaveRoomAnchor
 @param roomId 房间id
 */
-(void) leaveRoomAnchor:(int64_t)roomId  callback:(CallBack_Live_SingleString)callback;

{

NSDictionary *msgDataDict=@{@"roomId":@(roomId)};
  [self.socket  sendMsg:@"Live" msgSubType:@"leaveRoomAnchor" message:msgDataDict callback:^(int code, NSString * _Nonnull errMsg, NSDictionary * _Nonnull data)
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
 joinRoomAnchor
 @param roomId 房间id
 */
-(void) joinRoomAnchor:(int64_t)roomId  callback:(CallBack_Live_SingleString)callback;

{

NSDictionary *msgDataDict=@{@"roomId":@(roomId)};
  [self.socket  sendMsg:@"Live" msgSubType:@"joinRoomAnchor" message:msgDataDict callback:^(int code, NSString * _Nonnull errMsg, NSDictionary * _Nonnull data)
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


