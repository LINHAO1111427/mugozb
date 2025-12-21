//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>
#import <LibProjBase/HttpClient.h>
#import "MJExtension.h"

#import <LibTools/NSDictionary+Json.h>
#import "HttpApiAPPFinance.h"




@implementation HttpApiAPPFinance



/**
 收益榜
 @param findType 查询类型 1: 平台排行榜 2: 主播排行榜
 @param sex 性别 -1：表示全部 1：男 2：女
 @param type 类型 0:总榜 1:日榜 2:周榜 3:月榜
 @param uid 用户id(查看礼物榜时必传,默认传0)
 */
+(void) votesList:(int)findType sex:(int)sex type:(int)type uid:(int64_t)uid  callback:(CallBackAPPFinance_RanksDtoPageArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/finance/votesList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"findType":@(findType)
,@"sex":@(sex)
,@"type":@(type)
,@"uid":@(uid)};

 [HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
		PageInfo* pageInfo=[PageInfo new];
		[pageInfo setInfo:dicRet];
        NSMutableArray *retArr=[[NSMutableArray alloc] init];
        if(code==1)
        {
            id idArray = dicRet[@"retArr"];
            if([idArray isKindOfClass:[NSArray class]])
            {
                NSArray*  dataArray=idArray;
                for (NSDictionary *dic in dataArray) {
                    RanksDtoModel *handle = [RanksDtoModel getFromDict:dic];
                    [retArr addObject:handle];
                }
            }
        }
        callback(code,strMsg,pageInfo,retArr);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil,nil);
    }];

}



/**
 粉丝团排行
 @param anchorId 主播ID
 @param pageIndex 当前页
 @param pageSize 每页大小
 */
+(void) getFansTeamRank:(int64_t)anchorId pageIndex:(int)pageIndex pageSize:(int)pageSize  callback:(CallBackAPPFinance_RanksDtoArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/finance/getFansTeamRank",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"anchorId":@(anchorId)
,@"pageIndex":@(pageIndex)
,@"pageSize":@(pageSize)};

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
                    RanksDtoModel *handle = [RanksDtoModel getFromDict:dic];
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
 我的收益里添加提现账号
 @param account 账号
 @param accountBank 银行名称(type为3时传入)
 @param branch 支行
 @param name 姓名
 @param recordId 相关记录ID
 @param type 类型 1：支付宝 2：微信 3：银行卡
 */
+(void) withdrawAccountAdd:(NSString *)account accountBank:(NSString *)accountBank branch:(NSString *)branch name:(NSString *)name recordId:(int64_t)recordId type:(int)type  callback:(CallBackAPPFinance_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/finance/withdrawAccountAdd",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"account":account
,@"accountBank":accountBank
,@"branch":branch
,@"name":name
,@"recordId":@(recordId)
,@"type":@(type)};

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
 我的收益里删除提现账号
 @param id 提现账号id
 */
+(void) withdrawAccountDel:(int64_t)id_field  callback:(CallBackAPPFinance_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/finance/withdrawAccountDel",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"id":@(id_field)};

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
 收入排行
 @param findType 查询类型 1: 平台排行榜
 @param toUserId 用户id(查询自身排行时传,其他传0)
 @param type 类型 0:总榜 1:日榜 2:周榜 3:月榜
 */
+(void) incomeRanking:(int)findType toUserId:(int64_t)toUserId type:(int)type  callback:(CallBackAPPFinance_AppUserIncomeRankingDtoPageArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/finance/incomeRanking",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"findType":@(findType)
,@"toUserId":@(toUserId)
,@"type":@(type)};

 [HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
		PageInfo* pageInfo=[PageInfo new];
		[pageInfo setInfo:dicRet];
        NSMutableArray *retArr=[[NSMutableArray alloc] init];
        if(code==1)
        {
            id idArray = dicRet[@"retArr"];
            if([idArray isKindOfClass:[NSArray class]])
            {
                NSArray*  dataArray=idArray;
                for (NSDictionary *dic in dataArray) {
                    AppUserIncomeRankingDtoModel *handle = [AppUserIncomeRankingDtoModel getFromDict:dic];
                    [retArr addObject:handle];
                }
            }
        }
        callback(code,strMsg,pageInfo,retArr);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil,nil);
    }];

}



/**
 用户收益接口/用户公会收益 （新接口）
 @param type 1.平台收益，2.公会收益
 */
+(void) userProfit:(int)type  callback:(CallBackAPPFinance_ProfitCenterDTO)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/finance/userProfit",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"type":@(type)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        ProfitCenterDTOModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [ProfitCenterDTOModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 获取主播可提现账户余额(优先显示公会)
 */
+(void) anchorVotes:(CallBackAPPFinance_AnchorVotesDTO)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/finance/anchorVotes",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        AnchorVotesDTOModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [AnchorVotesDTOModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 获取提现方式
 */
+(void) getWithdrawalMethod:(CallBackAPPFinance_WithdrawalMethod)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/finance/getWithdrawalMethod",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        WithdrawalMethodModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [WithdrawalMethodModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 我的收益里提现账号列表
 */
+(void) withdrawAccount:(CallBackAPPFinance_AppUsersCashAccountArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/finance/withdrawAccount",nil];
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
                    AppUsersCashAccountModel *handle = [AppUsersCashAccountModel getFromDict:dic];
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
 提现记录(平台/公会)
 @param date 日期
 @param pageIndex 每页的条数
 @param pageSize 每页的条数
 @param status 状态，0审核中，1审核通过，2审核拒绝，-1全部
 @param type 0.平台，1.公会
 */
+(void) userCashRecordList:(NSString *)date pageIndex:(int)pageIndex pageSize:(int)pageSize status:(int)status type:(int)type  callback:(CallBackAPPFinance_CashRecordDTOArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/finance/userCashRecordList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"date":date
,@"pageIndex":@(pageIndex)
,@"pageSize":@(pageSize)
,@"status":@(status)
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
                    CashRecordDTOModel *handle = [CashRecordDTOModel getFromDict:dic];
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
 用户收益映票兑换金币
 @param ruleId 兑换规则
 @param type 1.平台收益，2.公会收益
 */
+(void) ticketExchangeCoin:(int64_t)ruleId type:(int)type  callback:(CallBackAPPFinance_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/finance/ticketExchangeCoin",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"ruleId":@(ruleId)
,@"type":@(type)};

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
 贡献榜
 @param anchorId 主播ID(findType = 2，4，查询自己排名的时候必传 )
 @param findType 查询类型 1: 平台排行榜 2: 主播排行榜 3:粉丝(关注)排行榜 4：每次直播贡献排行榜
 @param sex 性别 -1：表示全部 1：男 2：女
 @param showId 直播标识（findType = 4 时传，其他时间传 ''）
 @param type 类型 0:总榜 1:日榜 2:周榜 3:月榜
 */
+(void) contributionList:(int64_t)anchorId findType:(int)findType sex:(int)sex showId:(NSString *)showId type:(int)type  callback:(CallBackAPPFinance_RanksDtoArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/finance/contributionList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"anchorId":@(anchorId)
,@"findType":@(findType)
,@"sex":@(sex)
,@"showId":showId
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
                    RanksDtoModel *handle = [RanksDtoModel getFromDict:dic];
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
 我的收益提现申请
 @param accountId 提现账号id
 @param accountName accountName
 @param accountType 账号类型 1：支付宝  2：微信，3：银行卡
 @param delta 映票/佣金 数量 
 @param type 提现类型 1：映票  2：佣金提现 3：公会账户提现， 4：商家提现
 */
+(void) withdrawAccountApply:(int64_t)accountId accountName:(NSString *)accountName accountType:(int)accountType delta:(double)delta type:(int)type  callback:(CallBackAPPFinance_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/finance/withdrawAccountApply",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"accountId":@(accountId)
,@"accountName":accountName
,@"accountType":@(accountType)
,@"delta":@(delta)
,@"type":@(type)};

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
 佣金兑换金币
 @param payTerminal 支付终端android/iOS
 @param ruleId 充值规则ID
 */
+(void) moneyExchangeCoin:(NSString *)payTerminal ruleId:(int64_t)ruleId  callback:(CallBackAPPFinance_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/finance/moneyExchangeCoin",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"payTerminal":payTerminal
,@"ruleId":@(ruleId)};

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
 公会榜
 @param type 类型 0:总榜 1:日榜 2:周榜 3:月榜
 */
+(void) guildList:(int)type  callback:(CallBackAPPFinance_GuildListVOPageArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/finance/guildList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"type":@(type)};

 [HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
		PageInfo* pageInfo=[PageInfo new];
		[pageInfo setInfo:dicRet];
        NSMutableArray *retArr=[[NSMutableArray alloc] init];
        if(code==1)
        {
            id idArray = dicRet[@"retArr"];
            if([idArray isKindOfClass:[NSArray class]])
            {
                NSArray*  dataArray=idArray;
                for (NSDictionary *dic in dataArray) {
                    GuildListVOModel *handle = [GuildListVOModel getFromDict:dic];
                    [retArr addObject:handle];
                }
            }
        }
        callback(code,strMsg,pageInfo,retArr);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil,nil);
    }];

}


@end


