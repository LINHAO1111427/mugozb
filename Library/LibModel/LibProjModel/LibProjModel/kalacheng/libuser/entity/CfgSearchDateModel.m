//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "CfgSearchDateModel.h"




 @implementation CfgSearchDateModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"val"]=@(_val);

dict[@"unit"]=_unit;

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"name"]=_name;

dict[@"id"]=@(_id_field);

dict[@"sort"]=@(_sort);

dict[@"type"]=@(_type);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<CfgSearchDateModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
CfgSearchDateModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<CfgSearchDateModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<CfgSearchDateModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
CfgSearchDateModel* sumMdl=[CfgSearchDateModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(CfgSearchDateModel*)getFromDict:(NSDictionary*)dict
{
CfgSearchDateModel* model=[[CfgSearchDateModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.val=[dict[@"val"] isKindOfClass:[NSNull class]]?0:[dict[@"val"] intValue];

model.unit=[dict[@"unit"] isKindOfClass:[NSNull class]]?@"":dict[@"unit"];


{
NSString *strDate= dict[@"addTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addTime=date;
    }
}

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.sort=[dict[@"sort"] isKindOfClass:[NSNull class]]?0:[dict[@"sort"] intValue];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];


 return model;
}

 +(void)cloneObj:(CfgSearchDateModel*) source target:(CfgSearchDateModel*)target
{

target.val=source.val;

target.unit=source.unit;

target.addTime=source.addTime;

target.name=source.name;

target.id_field=source.id_field;

target.sort=source.sort;

target.type=source.type;

}

@end

