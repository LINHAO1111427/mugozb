//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "TicketExchangeRuleModel.h"




 @implementation TicketExchangeRuleModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"coinNum"]=@(_coinNum);

dict[@"ticketNum"]=@(_ticketNum);

dict[@"sortNum"]=@(_sortNum);

dict[@"id"]=@(_id_field);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<TicketExchangeRuleModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
TicketExchangeRuleModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<TicketExchangeRuleModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<TicketExchangeRuleModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
TicketExchangeRuleModel* sumMdl=[TicketExchangeRuleModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(TicketExchangeRuleModel*)getFromDict:(NSDictionary*)dict
{
TicketExchangeRuleModel* model=[[TicketExchangeRuleModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.coinNum=[dict[@"coinNum"] isKindOfClass:[NSNull class]]?0:[dict[@"coinNum"] intValue];

model.ticketNum=[dict[@"ticketNum"] isKindOfClass:[NSNull class]]?0:[dict[@"ticketNum"] intValue];

model.sortNum=[dict[@"sortNum"] isKindOfClass:[NSNull class]]?0:[dict[@"sortNum"] intValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];


 return model;
}

 +(void)cloneObj:(TicketExchangeRuleModel*) source target:(TicketExchangeRuleModel*)target
{

target.coinNum=source.coinNum;

target.ticketNum=source.ticketNum;

target.sortNum=source.sortNum;

target.id_field=source.id_field;

}

@end

