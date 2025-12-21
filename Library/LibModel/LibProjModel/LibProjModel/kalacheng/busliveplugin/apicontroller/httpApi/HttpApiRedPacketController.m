//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>
#import <LibProjBase/HttpClient.h>
#import "MJExtension.h"

#import <LibTools/NSDictionary+Json.h>
#import "HttpApiRedPacketController.h"




@implementation HttpApiRedPacketController



/**
 单个红包领取记录
 @param redPacketId 红包id
 */
+(void) redPacketRecord:(int64_t)redPacketId  callback:(CallBackRedPacketController_RedPacketReceiveRecordVOArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/redPacket/redPacketRecord",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"redPacketId":@(redPacketId)};

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
                    RedPacketReceiveRecordVOModel *handle = [RedPacketReceiveRecordVOModel getFromDict:dic];
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
 领红包
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 8:家族 9:私聊 10：粉丝团
 @param redPacketId 红包id
 */
+(void) openRedPacket:(int)liveType redPacketId:(int64_t)redPacketId  callback:(CallBackRedPacketController_RedPacketVO)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/redPacket/openRedPacket",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"liveType":@(liveType)
,@"redPacketId":@(redPacketId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        RedPacketVOModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [RedPacketVOModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}





/**
 发送红包
 @param anchorId 在房间红包时必填,其他填-1
 @param currencyType 货币类型 1：金币 2：积分
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 8:家族 9:私聊 10：粉丝团
 @param otherUserId 收红包的用户id(指定红包时必传,其他传空字符串)
 @param redPacketAmount 红包数量
 @param redPacketRange 红包发送的范围 1:房间红包(直播间内/一对一/聊天家族) 2:指定红包
 @param redPacketType 红包类型 1:普通红包
 @param roomId 房间号
 @param showId 直播标识
 @param totalValue 红包总价值
 */
+(void) sendRedPacket:(RedPacketController_sendRedPacket*)_mdl callback:(CallBackRedPacketController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/redPacket/sendRedPacket",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"anchorId":@(_mdl.anchorId)
,@"currencyType":@(_mdl.currencyType)
,@"liveType":@(_mdl.liveType)
,@"otherUserId":_mdl.otherUserId
,@"redPacketAmount":@(_mdl.redPacketAmount)
,@"redPacketRange":@(_mdl.redPacketRange)
,@"redPacketType":@(_mdl.redPacketType)
,@"roomId":@(_mdl.roomId)
,@"showId":_mdl.showId
,@"totalValue":@(_mdl.totalValue)};

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
 发送红包
 @param anchorId 在房间红包时必填,其他填-1
 @param currencyType 货币类型 1：金币 2：积分
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 8:家族 9:私聊 10：粉丝团
 @param otherUserId 收红包的用户id(指定红包时必传,其他传空字符串)
 @param redPacketAmount 红包数量
 @param redPacketRange 红包发送的范围 1:房间红包(直播间内/一对一/聊天家族) 2:指定红包
 @param redPacketType 红包类型 1:普通红包
 @param roomId 房间号
 @param showId 直播标识
 @param totalValue 红包总价值
 */
+(void) sendRedPacket:(int64_t)anchorId currencyType:(int)currencyType liveType:(int)liveType otherUserId:(NSString *)otherUserId redPacketAmount:(int)redPacketAmount redPacketRange:(int)redPacketRange redPacketType:(int)redPacketType roomId:(int64_t)roomId showId:(NSString *)showId totalValue:(double)totalValue  callback:(CallBackRedPacketController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/redPacket/sendRedPacket",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"anchorId":@(anchorId)
,@"currencyType":@(currencyType)
,@"liveType":@(liveType)
,@"otherUserId":otherUserId
,@"redPacketAmount":@(redPacketAmount)
,@"redPacketRange":@(redPacketRange)
,@"redPacketType":@(redPacketType)
,@"roomId":@(roomId)
,@"showId":showId
,@"totalValue":@(totalValue)};

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
 获取我是否领过某个红包
 @param redPacketId 红包id
 */
+(void) getMyRedPacketReceiveVO:(int64_t)redPacketId  callback:(CallBackRedPacketController_RedPacketVO)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/redPacket/getMyRedPacketReceiveVO",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"redPacketId":@(redPacketId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        RedPacketVOModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [RedPacketVOModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}


@end


