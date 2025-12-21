//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppMedalModel.h"




 @implementation AppMedalModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"medalLogo"]=_medalLogo;

dict[@"name"]=_name;

dict[@"lv"]=@(_lv);

dict[@"id"]=@(_id_field);

dict[@"type"]=@(_type);

dict[@"desr"]=_desr;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppMedalModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppMedalModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppMedalModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppMedalModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppMedalModel* sumMdl=[AppMedalModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppMedalModel*)getFromDict:(NSDictionary*)dict
{
AppMedalModel* model=[[AppMedalModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }

{
NSString *strDate= dict[@"addTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addTime=date;
    }
}

model.medalLogo=[dict[@"medalLogo"] isKindOfClass:[NSNull class]]?@"":dict[@"medalLogo"];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.lv=[dict[@"lv"] isKindOfClass:[NSNull class]]?0:[dict[@"lv"] intValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];

model.desr=[dict[@"desr"] isKindOfClass:[NSNull class]]?@"":dict[@"desr"];


 return model;
}

 +(void)cloneObj:(AppMedalModel*) source target:(AppMedalModel*)target
{

target.addTime=source.addTime;

target.medalLogo=source.medalLogo;

target.name=source.name;

target.lv=source.lv;

target.id_field=source.id_field;

target.type=source.type;

target.desr=source.desr;

}

@end

