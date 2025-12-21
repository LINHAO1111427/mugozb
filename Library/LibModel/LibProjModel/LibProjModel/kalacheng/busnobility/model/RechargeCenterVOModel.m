//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "RechargeCenterVOModel.h"
#import "RechargeRulesVOModel.h"
#import "FixedWithdrawRuleVOModel.h"




 @implementation RechargeCenterVOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"rechargeRulesVOList" : [RechargeRulesVOModel class],@"fixedWithdrawRuleVOList" : [FixedWithdrawRuleVOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"promptContent"]=_promptContent;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_rechargeRulesVOList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
RechargeRulesVOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"rechargeRulesVOList"]=list;
}//end

dict[@"coinExchange"]=@(_coinExchange);

dict[@"nobleDiscount"]=@(_nobleDiscount);

dict[@"isFirstRecharge"]=@(_isFirstRecharge);

dict[@"nobleIcon"]=_nobleIcon;

dict[@"nobleName"]=_nobleName;

dict[@"userCoin"]=@(_userCoin);

dict[@"withdrawalAmountManner"]=@(_withdrawalAmountManner);


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

dict[@"isVip"]=@(_isVip);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<RechargeCenterVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
RechargeCenterVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<RechargeCenterVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<RechargeCenterVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
RechargeCenterVOModel* sumMdl=[RechargeCenterVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(RechargeCenterVOModel*)getFromDict:(NSDictionary*)dict
{
RechargeCenterVOModel* model=[[RechargeCenterVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.promptContent=[dict[@"promptContent"] isKindOfClass:[NSNull class]]?@"":dict[@"promptContent"];

model.rechargeRulesVOList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"rechargeRulesVOList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
RechargeRulesVOModel* sumMdl=[RechargeRulesVOModel getFromDict:subDic];
[model.rechargeRulesVOList addObject:sumMdl];

}
}

}

model.coinExchange=[dict[@"coinExchange"] isKindOfClass:[NSNull class]]?0:[dict[@"coinExchange"] intValue];

model.nobleDiscount=[dict[@"nobleDiscount"] isKindOfClass:[NSNull class]]?0:[dict[@"nobleDiscount"] doubleValue];

model.isFirstRecharge=[dict[@"isFirstRecharge"] isKindOfClass:[NSNull class]]?0:[dict[@"isFirstRecharge"] intValue];

model.nobleIcon=[dict[@"nobleIcon"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleIcon"];

model.nobleName=[dict[@"nobleName"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleName"];

model.userCoin=[dict[@"userCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"userCoin"] doubleValue];

model.withdrawalAmountManner=[dict[@"withdrawalAmountManner"] isKindOfClass:[NSNull class]]?0:[dict[@"withdrawalAmountManner"] intValue];

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

model.isVip=[dict[@"isVip"] isKindOfClass:[NSNull class]]?0:[dict[@"isVip"] intValue];


 return model;
}

 +(void)cloneObj:(RechargeCenterVOModel*) source target:(RechargeCenterVOModel*)target
{

target.promptContent=source.promptContent;

        if(source.rechargeRulesVOList==nil)
        {
//            target.rechargeRulesVOList=nil;
        }else
        {
            target.rechargeRulesVOList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.rechargeRulesVOList.count;i++)
            {
		  [target.rechargeRulesVOList addObject:[[RechargeRulesVOModel alloc]init]];
            [RechargeRulesVOModel cloneObj:source.rechargeRulesVOList[i] target:target.rechargeRulesVOList[i]];
            }
        }


target.coinExchange=source.coinExchange;

target.nobleDiscount=source.nobleDiscount;

target.isFirstRecharge=source.isFirstRecharge;

target.nobleIcon=source.nobleIcon;

target.nobleName=source.nobleName;

target.userCoin=source.userCoin;

target.withdrawalAmountManner=source.withdrawalAmountManner;

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


target.isVip=source.isVip;

}

@end

