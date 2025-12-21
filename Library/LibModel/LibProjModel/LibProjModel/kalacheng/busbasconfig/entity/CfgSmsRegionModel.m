//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "CfgSmsRegionModel.h"




 @implementation CfgSmsRegionModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"id"]=@(_id_field);

dict[@"smsRegionCode"]=_smsRegionCode;

dict[@"smsRegionName"]=_smsRegionName;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<CfgSmsRegionModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
CfgSmsRegionModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<CfgSmsRegionModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<CfgSmsRegionModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
CfgSmsRegionModel* sumMdl=[CfgSmsRegionModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(CfgSmsRegionModel*)getFromDict:(NSDictionary*)dict
{
CfgSmsRegionModel* model=[[CfgSmsRegionModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.smsRegionCode=[dict[@"smsRegionCode"] isKindOfClass:[NSNull class]]?@"":dict[@"smsRegionCode"];

model.smsRegionName=[dict[@"smsRegionName"] isKindOfClass:[NSNull class]]?@"":dict[@"smsRegionName"];


 return model;
}

 +(void)cloneObj:(CfgSmsRegionModel*) source target:(CfgSmsRegionModel*)target
{

target.id_field=source.id_field;

target.smsRegionCode=source.smsRegionCode;

target.smsRegionName=source.smsRegionName;

}

@end

