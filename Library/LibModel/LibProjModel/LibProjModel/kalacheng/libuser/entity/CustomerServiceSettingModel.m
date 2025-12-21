//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "CustomerServiceSettingModel.h"




 @implementation CustomerServiceSettingModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"qq"]=_qq;

dict[@"complaintTelephone"]=_complaintTelephone;

dict[@"consumerHotline"]=_consumerHotline;

dict[@"wechat"]=_wechat;

dict[@"id"]=@(_id_field);

dict[@"wechatCode"]=_wechatCode;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<CustomerServiceSettingModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
CustomerServiceSettingModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<CustomerServiceSettingModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<CustomerServiceSettingModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
CustomerServiceSettingModel* sumMdl=[CustomerServiceSettingModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(CustomerServiceSettingModel*)getFromDict:(NSDictionary*)dict
{
CustomerServiceSettingModel* model=[[CustomerServiceSettingModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.qq=[dict[@"qq"] isKindOfClass:[NSNull class]]?@"":dict[@"qq"];

model.complaintTelephone=[dict[@"complaintTelephone"] isKindOfClass:[NSNull class]]?@"":dict[@"complaintTelephone"];

model.consumerHotline=[dict[@"consumerHotline"] isKindOfClass:[NSNull class]]?@"":dict[@"consumerHotline"];

model.wechat=[dict[@"wechat"] isKindOfClass:[NSNull class]]?@"":dict[@"wechat"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.wechatCode=[dict[@"wechatCode"] isKindOfClass:[NSNull class]]?@"":dict[@"wechatCode"];


 return model;
}

 +(void)cloneObj:(CustomerServiceSettingModel*) source target:(CustomerServiceSettingModel*)target
{

target.qq=source.qq;

target.complaintTelephone=source.complaintTelephone;

target.consumerHotline=source.consumerHotline;

target.wechat=source.wechat;

target.id_field=source.id_field;

target.wechatCode=source.wechatCode;

}

@end

