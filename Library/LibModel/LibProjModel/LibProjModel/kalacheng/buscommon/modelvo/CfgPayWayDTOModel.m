//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "CfgPayWayDTOModel.h"




 @implementation CfgPayWayDTOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"pageType"]=@(_pageType);

dict[@"payEquipment"]=_payEquipment;

dict[@"appId"]=_appId;

dict[@"name"]=_name;

dict[@"payChannel"]=@(_payChannel);

dict[@"id"]=@(_id_field);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<CfgPayWayDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
CfgPayWayDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<CfgPayWayDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<CfgPayWayDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
CfgPayWayDTOModel* sumMdl=[CfgPayWayDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(CfgPayWayDTOModel*)getFromDict:(NSDictionary*)dict
{
CfgPayWayDTOModel* model=[[CfgPayWayDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.pageType=[dict[@"pageType"] isKindOfClass:[NSNull class]]?0:[dict[@"pageType"] intValue];

model.payEquipment=[dict[@"payEquipment"] isKindOfClass:[NSNull class]]?@"":dict[@"payEquipment"];

model.appId=[dict[@"appId"] isKindOfClass:[NSNull class]]?@"":dict[@"appId"];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.payChannel=[dict[@"payChannel"] isKindOfClass:[NSNull class]]?0:[dict[@"payChannel"] intValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];


 return model;
}

 +(void)cloneObj:(CfgPayWayDTOModel*) source target:(CfgPayWayDTOModel*)target
{

target.pageType=source.pageType;

target.payEquipment=source.payEquipment;

target.appId=source.appId;

target.name=source.name;

target.payChannel=source.payChannel;

target.id_field=source.id_field;

}

@end

