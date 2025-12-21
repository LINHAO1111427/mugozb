//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "CfgShareDomainNameModel.h"




 @implementation CfgShareDomainNameModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"isDisable"]=@(_isDisable);

dict[@"createTime"]=[HttpClient stringFromDate:_createTime];

dict[@"id"]=@(_id_field);

dict[@"domainUrl"]=_domainUrl;

dict[@"remarks"]=_remarks;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<CfgShareDomainNameModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
CfgShareDomainNameModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<CfgShareDomainNameModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<CfgShareDomainNameModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
CfgShareDomainNameModel* sumMdl=[CfgShareDomainNameModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(CfgShareDomainNameModel*)getFromDict:(NSDictionary*)dict
{
CfgShareDomainNameModel* model=[[CfgShareDomainNameModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.isDisable=[dict[@"isDisable"] isKindOfClass:[NSNull class]]?0:[dict[@"isDisable"] intValue];


{
NSString *strDate= dict[@"createTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.createTime=date;
    }
}

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.domainUrl=[dict[@"domainUrl"] isKindOfClass:[NSNull class]]?@"":dict[@"domainUrl"];

model.remarks=[dict[@"remarks"] isKindOfClass:[NSNull class]]?@"":dict[@"remarks"];


 return model;
}

 +(void)cloneObj:(CfgShareDomainNameModel*) source target:(CfgShareDomainNameModel*)target
{

target.isDisable=source.isDisable;

target.createTime=source.createTime;

target.id_field=source.id_field;

target.domainUrl=source.domainUrl;

target.remarks=source.remarks;

}

@end

