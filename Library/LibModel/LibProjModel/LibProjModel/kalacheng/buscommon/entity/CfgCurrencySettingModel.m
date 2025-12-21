//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "CfgCurrencySettingModel.h"




 @implementation CfgCurrencySettingModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"upTime"]=[HttpClient stringFromDate:_upTime];

dict[@"ticketIcon"]=_ticketIcon;

dict[@"coinName"]=_coinName;

dict[@"id"]=@(_id_field);

dict[@"coinIcon"]=_coinIcon;

dict[@"ticketName"]=_ticketName;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<CfgCurrencySettingModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
CfgCurrencySettingModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<CfgCurrencySettingModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<CfgCurrencySettingModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
CfgCurrencySettingModel* sumMdl=[CfgCurrencySettingModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(CfgCurrencySettingModel*)getFromDict:(NSDictionary*)dict
{
CfgCurrencySettingModel* model=[[CfgCurrencySettingModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }

{
NSString *strDate= dict[@"upTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.upTime=date;
    }
}

model.ticketIcon=[dict[@"ticketIcon"] isKindOfClass:[NSNull class]]?@"":dict[@"ticketIcon"];

model.coinName=[dict[@"coinName"] isKindOfClass:[NSNull class]]?@"":dict[@"coinName"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.coinIcon=[dict[@"coinIcon"] isKindOfClass:[NSNull class]]?@"":dict[@"coinIcon"];

model.ticketName=[dict[@"ticketName"] isKindOfClass:[NSNull class]]?@"":dict[@"ticketName"];


 return model;
}

 +(void)cloneObj:(CfgCurrencySettingModel*) source target:(CfgCurrencySettingModel*)target
{

target.upTime=source.upTime;

target.ticketIcon=source.ticketIcon;

target.coinName=source.coinName;

target.id_field=source.id_field;

target.coinIcon=source.coinIcon;

target.ticketName=source.ticketName;

}

@end

