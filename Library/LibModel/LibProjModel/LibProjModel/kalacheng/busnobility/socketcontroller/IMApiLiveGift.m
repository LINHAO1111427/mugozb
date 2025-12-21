//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/HttpClient.h>
#import "MJExtension.h"
#import <LibTools/NSDictionary+Json.h>
#import "IMApiLiveGift.h"
#import <TXImKit/TXImKit.h>
#import "ApiLightSenderModel.h"




@implementation IMApiLiveGift

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
 sendLight
 @param anchorId 主播id
 @param type 类型 1:视频直播 2:语音直播
 */
-(void) sendLight:(int)anchorId type:(int)type  callback:(CallBack_LiveGift_ApiLightSender)callback;

{

NSDictionary *msgDataDict=@{@"anchorId":@(anchorId),@"type":@(type)};
  [self.socket  sendMsg:@"LiveGift" msgSubType:@"sendLight" message:msgDataDict callback:^(int code, NSString * _Nonnull errMsg, NSDictionary * _Nonnull data)
 {
        if(code!=1)
        {
            callback(code,errMsg,nil);
            return ;
        }
        ApiLightSenderModel*  retModel=   [ApiLightSenderModel getFromDict:data];
        callback(code,errMsg,retModel);
  }];

}

 
@end


