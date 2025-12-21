//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ProfitCenterDTOModel.h"
#import "FixedWithdrawRuleVOModel.h"
#import "TicketExchangeRuleModel.h"
#import "CfgCurrencySettingModel.h"
#import "AppUsersCashAccountModel.h"




 @implementation ProfitCenterDTOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"fixedWithdrawRuleVOList" : [FixedWithdrawRuleVOModel class],@"exchangeRuleList" : [TicketExchangeRuleModel class],@"cfgCurrency" : [CfgCurrencySettingModel class],@"account" : [AppUsersCashAccountModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"coinExchange"]=@(_coinExchange);

dict[@"guildAccount"]=@(_guildAccount);

dict[@"guildAvatar"]=_guildAvatar;

dict[@"haveSeek"]=@(_haveSeek);

dict[@"cashMin"]=@(_cashMin);

dict[@"withdrawalAmountManner"]=@(_withdrawalAmountManner);

dict[@"goToScoreSystemIOS"]=_goToScoreSystemIOS;

dict[@"recommendCommissionTicket"]=@(_recommendCommissionTicket);

dict[@"amountService"]=@(_amountService);

dict[@"perc"]=@(_perc);

dict[@"anchorGuildCumulativeIncome"]=@(_anchorGuildCumulativeIncome);

dict[@"amountMin"]=@(_amountMin);

dict[@"goToScoreSystemText"]=_goToScoreSystemText;

dict[@"gradeAvatar"]=_gradeAvatar;

dict[@"cashMaxDay"]=@(_cashMaxDay);

dict[@"cashMaxMonth"]=@(_cashMaxMonth);

dict[@"cashRate"]=@(_cashRate);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_fixedWithdrawRuleVOList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
FixedWithdrawRuleVOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"fixedWithdrawRuleVOList"]=list;
}//end

dict[@"noAppCashDesc"]=_noAppCashDesc;

dict[@"haveGoToScoreSystem"]=@(_haveGoToScoreSystem);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_exchangeRuleList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
TicketExchangeRuleModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"exchangeRuleList"]=list;
}//end

dict[@"votestotal"]=@(_votestotal);

dict[@"isFunctionTurnOn"]=@(_isFunctionTurnOn);

dict[@"avatar"]=_avatar;

dict[@"guildPerc"]=@(_guildPerc);

dict[@"guildId"]=@(_guildId);

dict[@"onlyAnchorCash"]=@(_onlyAnchorCash);

dict[@"totalvotes"]=@(_totalvotes);

dict[@"goToScoreSystemAndroid"]=_goToScoreSystemAndroid;

dict[@"cfgCurrency"]=[_cfgCurrency modelToJSONObject];

dict[@"service"]=@(_service);

dict[@"grade"]=@(_grade);

dict[@"votes"]=@(_votes);

dict[@"describe"]=_describe;

dict[@"haveUserScoreSystem"]=@(_haveUserScoreSystem);

dict[@"userRole"]=@(_userRole);

dict[@"account"]=[_account modelToJSONObject];

dict[@"guildCumulativeIncome"]=@(_guildCumulativeIncome);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ProfitCenterDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ProfitCenterDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ProfitCenterDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ProfitCenterDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ProfitCenterDTOModel* sumMdl=[ProfitCenterDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ProfitCenterDTOModel*)getFromDict:(NSDictionary*)dict
{
ProfitCenterDTOModel* model=[[ProfitCenterDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.coinExchange=[dict[@"coinExchange"] isKindOfClass:[NSNull class]]?0:[dict[@"coinExchange"] intValue];

model.guildAccount=[dict[@"guildAccount"] isKindOfClass:[NSNull class]]?0:[dict[@"guildAccount"] doubleValue];

model.guildAvatar=[dict[@"guildAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"guildAvatar"];

model.haveSeek=[dict[@"haveSeek"] isKindOfClass:[NSNull class]]?0:[dict[@"haveSeek"] intValue];

model.cashMin=[dict[@"cashMin"] isKindOfClass:[NSNull class]]?0:[dict[@"cashMin"] doubleValue];

model.withdrawalAmountManner=[dict[@"withdrawalAmountManner"] isKindOfClass:[NSNull class]]?0:[dict[@"withdrawalAmountManner"] intValue];

model.goToScoreSystemIOS=[dict[@"goToScoreSystemIOS"] isKindOfClass:[NSNull class]]?@"":dict[@"goToScoreSystemIOS"];

model.recommendCommissionTicket=[dict[@"recommendCommissionTicket"] isKindOfClass:[NSNull class]]?0:[dict[@"recommendCommissionTicket"] intValue];

model.amountService=[dict[@"amountService"] isKindOfClass:[NSNull class]]?0:[dict[@"amountService"] doubleValue];

model.perc=[dict[@"perc"] isKindOfClass:[NSNull class]]?0:[dict[@"perc"] doubleValue];

model.anchorGuildCumulativeIncome=[dict[@"anchorGuildCumulativeIncome"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorGuildCumulativeIncome"] doubleValue];

model.amountMin=[dict[@"amountMin"] isKindOfClass:[NSNull class]]?0:[dict[@"amountMin"] doubleValue];

model.goToScoreSystemText=[dict[@"goToScoreSystemText"] isKindOfClass:[NSNull class]]?@"":dict[@"goToScoreSystemText"];

model.gradeAvatar=[dict[@"gradeAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"gradeAvatar"];

model.cashMaxDay=[dict[@"cashMaxDay"] isKindOfClass:[NSNull class]]?0:[dict[@"cashMaxDay"] intValue];

model.cashMaxMonth=[dict[@"cashMaxMonth"] isKindOfClass:[NSNull class]]?0:[dict[@"cashMaxMonth"] intValue];

model.cashRate=[dict[@"cashRate"] isKindOfClass:[NSNull class]]?0:[dict[@"cashRate"] doubleValue];

model.fixedWithdrawRuleVOList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"fixedWithdrawRuleVOList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
FixedWithdrawRuleVOModel* sumMdl=[FixedWithdrawRuleVOModel getFromDict:subDic];
[model.fixedWithdrawRuleVOList addObject:sumMdl];

}
}

}

model.noAppCashDesc=[dict[@"noAppCashDesc"] isKindOfClass:[NSNull class]]?@"":dict[@"noAppCashDesc"];

model.haveGoToScoreSystem=[dict[@"haveGoToScoreSystem"] isKindOfClass:[NSNull class]]?0:[dict[@"haveGoToScoreSystem"] intValue];

model.exchangeRuleList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"exchangeRuleList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
TicketExchangeRuleModel* sumMdl=[TicketExchangeRuleModel getFromDict:subDic];
[model.exchangeRuleList addObject:sumMdl];

}
}

}

model.votestotal=[dict[@"votestotal"] isKindOfClass:[NSNull class]]?0:[dict[@"votestotal"] doubleValue];

model.isFunctionTurnOn=[dict[@"isFunctionTurnOn"] isKindOfClass:[NSNull class]]?0:[dict[@"isFunctionTurnOn"] intValue];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.guildPerc=[dict[@"guildPerc"] isKindOfClass:[NSNull class]]?0:[dict[@"guildPerc"] doubleValue];

model.guildId=[dict[@"guildId"] isKindOfClass:[NSNull class]]?0:[dict[@"guildId"] longLongValue];

model.onlyAnchorCash=[dict[@"onlyAnchorCash"] isKindOfClass:[NSNull class]]?0:[dict[@"onlyAnchorCash"] intValue];

model.totalvotes=[dict[@"totalvotes"] isKindOfClass:[NSNull class]]?0:[dict[@"totalvotes"] doubleValue];

model.goToScoreSystemAndroid=[dict[@"goToScoreSystemAndroid"] isKindOfClass:[NSNull class]]?@"":dict[@"goToScoreSystemAndroid"];


//getFromDict对象转换  
model.cfgCurrency=[CfgCurrencySettingModel getFromDict:dict[@"cfgCurrency"]];

model.service=[dict[@"service"] isKindOfClass:[NSNull class]]?0:[dict[@"service"] doubleValue];

model.grade=[dict[@"grade"] isKindOfClass:[NSNull class]]?0:[dict[@"grade"] intValue];

model.votes=[dict[@"votes"] isKindOfClass:[NSNull class]]?0:[dict[@"votes"] doubleValue];

model.describe=[dict[@"describe"] isKindOfClass:[NSNull class]]?@"":dict[@"describe"];

model.haveUserScoreSystem=[dict[@"haveUserScoreSystem"] isKindOfClass:[NSNull class]]?0:[dict[@"haveUserScoreSystem"] intValue];

model.userRole=[dict[@"userRole"] isKindOfClass:[NSNull class]]?0:[dict[@"userRole"] intValue];


//getFromDict对象转换  
model.account=[AppUsersCashAccountModel getFromDict:dict[@"account"]];

model.guildCumulativeIncome=[dict[@"guildCumulativeIncome"] isKindOfClass:[NSNull class]]?0:[dict[@"guildCumulativeIncome"] doubleValue];


 return model;
}

 +(void)cloneObj:(ProfitCenterDTOModel*) source target:(ProfitCenterDTOModel*)target
{

target.coinExchange=source.coinExchange;

target.guildAccount=source.guildAccount;

target.guildAvatar=source.guildAvatar;

target.haveSeek=source.haveSeek;

target.cashMin=source.cashMin;

target.withdrawalAmountManner=source.withdrawalAmountManner;

target.goToScoreSystemIOS=source.goToScoreSystemIOS;

target.recommendCommissionTicket=source.recommendCommissionTicket;

target.amountService=source.amountService;

target.perc=source.perc;

target.anchorGuildCumulativeIncome=source.anchorGuildCumulativeIncome;

target.amountMin=source.amountMin;

target.goToScoreSystemText=source.goToScoreSystemText;

target.gradeAvatar=source.gradeAvatar;

target.cashMaxDay=source.cashMaxDay;

target.cashMaxMonth=source.cashMaxMonth;

target.cashRate=source.cashRate;

        if(source.fixedWithdrawRuleVOList==nil)
        {
//            target.fixedWithdrawRuleVOList=nil;
        }else
        {
            target.fixedWithdrawRuleVOList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.fixedWithdrawRuleVOList.count;i++)
            {
		  [target.fixedWithdrawRuleVOList addObject:[[FixedWithdrawRuleVOModel alloc]init]];
            [FixedWithdrawRuleVOModel cloneObj:source.fixedWithdrawRuleVOList[i] target:target.fixedWithdrawRuleVOList[i]];
            }
        }


target.noAppCashDesc=source.noAppCashDesc;

target.haveGoToScoreSystem=source.haveGoToScoreSystem;

        if(source.exchangeRuleList==nil)
        {
//            target.exchangeRuleList=nil;
        }else
        {
            target.exchangeRuleList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.exchangeRuleList.count;i++)
            {
		  [target.exchangeRuleList addObject:[[TicketExchangeRuleModel alloc]init]];
            [TicketExchangeRuleModel cloneObj:source.exchangeRuleList[i] target:target.exchangeRuleList[i]];
            }
        }


target.votestotal=source.votestotal;

target.isFunctionTurnOn=source.isFunctionTurnOn;

target.avatar=source.avatar;

target.guildPerc=source.guildPerc;

target.guildId=source.guildId;

target.onlyAnchorCash=source.onlyAnchorCash;

target.totalvotes=source.totalvotes;

target.goToScoreSystemAndroid=source.goToScoreSystemAndroid;
        if(source.cfgCurrency==nil)
        {
//            target.cfgCurrency=nil;
        }else
        {
            [CfgCurrencySettingModel cloneObj:source.cfgCurrency target:target.cfgCurrency];
        }

target.service=source.service;

target.grade=source.grade;

target.votes=source.votes;

target.describe=source.describe;

target.haveUserScoreSystem=source.haveUserScoreSystem;

target.userRole=source.userRole;
        if(source.account==nil)
        {
//            target.account=nil;
        }else
        {
            [AppUsersCashAccountModel cloneObj:source.account target:target.account];
        }

target.guildCumulativeIncome=source.guildCumulativeIncome;

}

@end

