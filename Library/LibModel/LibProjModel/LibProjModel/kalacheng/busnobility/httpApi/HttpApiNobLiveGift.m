//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>
#import <LibProjBase/HttpClient.h>
#import "MJExtension.h"

#import <LibTools/NSDictionary+Json.h>
#import "HttpApiNobLiveGift.h"




@implementation HttpApiNobLiveGift



/**
 发送积分礼物
 @param backid 背包id(没有传-1)
 @param giftId 礼物id
 @param giftSenderDataList giftSenderDataList
 @param number 礼物个数
 @param shortVideoId 短视频id(没有传-1)
 @param type 送礼物类型 1:多人视频 2:语音直播 3:一对一 4:派对 5:电台 6:直播购物 7:私聊礼物 8:家族礼物 9:短视频 10：个人主页送礼物 11：群聊礼物
 */
+(void) sendScoreGift:(int64_t)backid giftId:(int64_t)giftId giftSenderDataList:(NSMutableArray<GiftSenderDataModel*>* )giftSenderDataList number:(int)number shortVideoId:(int64_t)shortVideoId type:(int)type  callback:(CallBackNobLiveGift_ApiGiftSenderArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@?_uid_=%lli&_token_=%@&_OS_=%@&_OSV_=%@&_OSInfo_=%@",[HttpClient getBaseUrl],@"/api/live/sendScoreGift",[HttpClient getUid],[HttpClient getToken],[HttpClient urlEncode:[HttpClient getOSType]],[HttpClient urlEncode:[HttpClient getOSVersion]],[HttpClient urlEncode:[HttpClient getOSInfo]],nil];
 NSString *tmp_para0=[NSString stringWithFormat:@"%@",@(backid),nil];
 NSString *tmp_e_para0= [tmp_para0 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
strUrl  =[NSString stringWithFormat:@"%@&backid=%@",strUrl,tmp_e_para0,nil];
 NSString *tmp_para1=[NSString stringWithFormat:@"%@",@(giftId),nil];
 NSString *tmp_e_para1= [tmp_para1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
strUrl  =[NSString stringWithFormat:@"%@&giftId=%@",strUrl,tmp_e_para1,nil];
 NSString *tmp_para3=[NSString stringWithFormat:@"%@",@(number),nil];
 NSString *tmp_e_para3= [tmp_para3 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
strUrl  =[NSString stringWithFormat:@"%@&number=%@",strUrl,tmp_e_para3,nil];
 NSString *tmp_para4=[NSString stringWithFormat:@"%@",@(shortVideoId),nil];
 NSString *tmp_e_para4= [tmp_para4 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
strUrl  =[NSString stringWithFormat:@"%@&shortVideoId=%@",strUrl,tmp_e_para4,nil];
 NSString *tmp_para5=[NSString stringWithFormat:@"%@",@(type),nil];
 NSString *tmp_e_para5= [tmp_para5 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
strUrl  =[NSString stringWithFormat:@"%@&type=%@",strUrl,tmp_e_para5,nil];
NSMutableArray *dictPara = [GiftSenderDataModel modelToJSONArray:giftSenderDataList];

 [HttpClient jsonPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        NSMutableArray *retArr=[[NSMutableArray alloc] init];
        if(code==1)
        {
            id idArray = dicRet[@"retArr"];
            if([idArray isKindOfClass:[NSArray class]])
            {
                NSArray*  dataArray=idArray;
                for (NSDictionary *dic in dataArray) {
                    ApiGiftSenderModel *handle = [ApiGiftSenderModel getFromDict:dic];
                    [retArr addObject:handle];
                }
            }
        }
        callback(code,strMsg,retArr);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 获取礼物列表
 @param type 礼物类型 -1:查所有礼物 0:普通礼物 1:粉丝团(豪华礼物) 2:守护(专属礼物) 3:贵族礼物(特殊礼物) 4:背包礼物
 */
+(void) getGiftList:(int)type  callback:(CallBackNobLiveGift_ApiNobLiveGiftArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/getGiftList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"type":@(type)};

 [HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        NSMutableArray *retArr=[[NSMutableArray alloc] init];
        if(code==1)
        {
            id idArray = dicRet[@"retArr"];
            if([idArray isKindOfClass:[NSArray class]])
            {
                NSArray*  dataArray=idArray;
                for (NSDictionary *dic in dataArray) {
                    ApiNobLiveGiftModel *handle = [ApiNobLiveGiftModel getFromDict:dic];
                    [retArr addObject:handle];
                }
            }
        }
        callback(code,strMsg,retArr);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 求赏
 @param askType 求赏类型 1:直播间求赏(视频/语音/一对一) 2:聊天求赏(私信)
 @param nobGiftId 礼物id
 @param roomId 房间号(视频/语音/一对一才有,其他为0)
 @param toUserId 被求赏的用户id
 */
+(void) sendAskForAReward:(int)askType nobGiftId:(int64_t)nobGiftId roomId:(int64_t)roomId toUserId:(int64_t)toUserId  callback:(CallBackNobLiveGift_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/sendAskForAReward",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"askType":@(askType)
,@"nobGiftId":@(nobGiftId)
,@"roomId":@(roomId)
,@"toUserId":@(toUserId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        HttpNoneModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [HttpNoneModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 一键赠送所有背包礼物
 @param giftSenderDataList giftSenderDataList
 @param sendGiftType  送礼物类型 1:多人视频 2:语音直播 3:一对一 4:派对 5:电台 6:直播购物 7:私聊礼物 8:家族礼物 9:短视频 10：个人主页送礼物 11：群聊礼物 12:电视剧集
 @param shortVideoId 短视频id(没有传-1)
 */
+(void) senderGiftAll:(NSMutableArray<GiftSenderDataModel*>* )giftSenderDataList sendGiftType:(int)sendGiftType shortVideoId:(int64_t)shortVideoId  callback:(CallBackNobLiveGift_ApiGiftSenderArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@?_uid_=%lli&_token_=%@&_OS_=%@&_OSV_=%@&_OSInfo_=%@",[HttpClient getBaseUrl],@"/api/live/senderGiftAll",[HttpClient getUid],[HttpClient getToken],[HttpClient urlEncode:[HttpClient getOSType]],[HttpClient urlEncode:[HttpClient getOSVersion]],[HttpClient urlEncode:[HttpClient getOSInfo]],nil];
 NSString *tmp_para1=[NSString stringWithFormat:@"%@",@(sendGiftType),nil];
 NSString *tmp_e_para1= [tmp_para1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
strUrl  =[NSString stringWithFormat:@"%@&sendGiftType=%@",strUrl,tmp_e_para1,nil];
 NSString *tmp_para2=[NSString stringWithFormat:@"%@",@(shortVideoId),nil];
 NSString *tmp_e_para2= [tmp_para2 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
strUrl  =[NSString stringWithFormat:@"%@&shortVideoId=%@",strUrl,tmp_e_para2,nil];
NSMutableArray *dictPara = [GiftSenderDataModel modelToJSONArray:giftSenderDataList];

 [HttpClient jsonPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        NSMutableArray *retArr=[[NSMutableArray alloc] init];
        if(code==1)
        {
            id idArray = dicRet[@"retArr"];
            if([idArray isKindOfClass:[NSArray class]])
            {
                NSArray*  dataArray=idArray;
                for (NSDictionary *dic in dataArray) {
                    ApiGiftSenderModel *handle = [ApiGiftSenderModel getFromDict:dic];
                    [retArr addObject:handle];
                }
            }
        }
        callback(code,strMsg,retArr);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 发送礼物HTTP
 @param backid 背包id(没有传-1)
 @param giftId 礼物id
 @param giftSenderDataList giftSenderDataList
 @param number 礼物个数
 @param shortVideoId 短视频id(没有传-1)
 @param type 送礼物类型 1:多人视频 2:语音直播 3:一对一 4:派对 5:电台 6:直播购物 7:私聊礼物 8:家族礼物 9:短视频 10：个人主页送礼物 11：群聊礼物 12:电视剧集
 */
+(void) giftSender:(int64_t)backid giftId:(int64_t)giftId giftSenderDataList:(NSMutableArray<GiftSenderDataModel*>* )giftSenderDataList number:(int)number shortVideoId:(int64_t)shortVideoId type:(int)type  callback:(CallBackNobLiveGift_ApiGiftSenderArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@?_uid_=%lli&_token_=%@&_OS_=%@&_OSV_=%@&_OSInfo_=%@",[HttpClient getBaseUrl],@"/api/live/giftSender",[HttpClient getUid],[HttpClient getToken],[HttpClient urlEncode:[HttpClient getOSType]],[HttpClient urlEncode:[HttpClient getOSVersion]],[HttpClient urlEncode:[HttpClient getOSInfo]],nil];
 NSString *tmp_para0=[NSString stringWithFormat:@"%@",@(backid),nil];
 NSString *tmp_e_para0= [tmp_para0 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
strUrl  =[NSString stringWithFormat:@"%@&backid=%@",strUrl,tmp_e_para0,nil];
 NSString *tmp_para1=[NSString stringWithFormat:@"%@",@(giftId),nil];
 NSString *tmp_e_para1= [tmp_para1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
strUrl  =[NSString stringWithFormat:@"%@&giftId=%@",strUrl,tmp_e_para1,nil];
 NSString *tmp_para3=[NSString stringWithFormat:@"%@",@(number),nil];
 NSString *tmp_e_para3= [tmp_para3 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
strUrl  =[NSString stringWithFormat:@"%@&number=%@",strUrl,tmp_e_para3,nil];
 NSString *tmp_para4=[NSString stringWithFormat:@"%@",@(shortVideoId),nil];
 NSString *tmp_e_para4= [tmp_para4 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
strUrl  =[NSString stringWithFormat:@"%@&shortVideoId=%@",strUrl,tmp_e_para4,nil];
 NSString *tmp_para5=[NSString stringWithFormat:@"%@",@(type),nil];
 NSString *tmp_e_para5= [tmp_para5 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
strUrl  =[NSString stringWithFormat:@"%@&type=%@",strUrl,tmp_e_para5,nil];
NSMutableArray *dictPara = [GiftSenderDataModel modelToJSONArray:giftSenderDataList];

 [HttpClient jsonPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        NSMutableArray *retArr=[[NSMutableArray alloc] init];
        if(code==1)
        {
            id idArray = dicRet[@"retArr"];
            if([idArray isKindOfClass:[NSArray class]])
            {
                NSArray*  dataArray=idArray;
                for (NSDictionary *dic in dataArray) {
                    ApiGiftSenderModel *handle = [ApiGiftSenderModel getFromDict:dic];
                    [retArr addObject:handle];
                }
            }
        }
        callback(code,strMsg,retArr);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 我的的背包礼物
 */
+(void) getMyGiftList:(CallBackNobLiveGift_NobLiveGiftArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/getMyGiftList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]};

 [HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        NSMutableArray *retArr=[[NSMutableArray alloc] init];
        if(code==1)
        {
            id idArray = dicRet[@"retArr"];
            if([idArray isKindOfClass:[NSArray class]])
            {
                NSArray*  dataArray=idArray;
                for (NSDictionary *dic in dataArray) {
                    NobLiveGiftModel *handle = [NobLiveGiftModel getFromDict:dic];
                    [retArr addObject:handle];
                }
            }
        }
        callback(code,strMsg,retArr);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 获取发送礼物数量
 */
+(void) getGiftAmountSetting:(CallBackNobLiveGift_GiftAmountSettingArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/getGiftAmountSetting",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]};

 [HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        NSMutableArray *retArr=[[NSMutableArray alloc] init];
        if(code==1)
        {
            id idArray = dicRet[@"retArr"];
            if([idArray isKindOfClass:[NSArray class]])
            {
                NSArray*  dataArray=idArray;
                for (NSDictionary *dic in dataArray) {
                    GiftAmountSettingModel *handle = [GiftAmountSettingModel getFromDict:dic];
                    [retArr addObject:handle];
                }
            }
        }
        callback(code,strMsg,retArr);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 用户礼物墙
 @param userId 被查看的用户ID
 */
+(void) getUserGift:(int64_t)userId  callback:(CallBackNobLiveGift_GiftWallDtoArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/getUserGift",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"userId":@(userId)};

 [HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        NSMutableArray *retArr=[[NSMutableArray alloc] init];
        if(code==1)
        {
            id idArray = dicRet[@"retArr"];
            if([idArray isKindOfClass:[NSArray class]])
            {
                NSArray*  dataArray=idArray;
                for (NSDictionary *dic in dataArray) {
                    GiftWallDtoModel *handle = [GiftWallDtoModel getFromDict:dic];
                    [retArr addObject:handle];
                }
            }
        }
        callback(code,strMsg,retArr);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}


@end


