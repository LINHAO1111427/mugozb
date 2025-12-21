//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "SvipPrivilegeConfigVOModel.h"




 @implementation SvipPrivilegeConfigVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"svipCallTime"]=@(_svipCallTime);

dict[@"orderNo"]=@(_orderNo);

dict[@"svipCallSecond"]=@(_svipCallSecond);

dict[@"privilegeDescription"]=_privilegeDescription;

dict[@"privilegeImage"]=_privilegeImage;

dict[@"id"]=@(_id_field);

dict[@"privilegeMark"]=_privilegeMark;

dict[@"privilegeTitle"]=_privilegeTitle;

dict[@"isEnable"]=@(_isEnable);

dict[@"privilegeName"]=_privilegeName;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<SvipPrivilegeConfigVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
SvipPrivilegeConfigVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<SvipPrivilegeConfigVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<SvipPrivilegeConfigVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
SvipPrivilegeConfigVOModel* sumMdl=[SvipPrivilegeConfigVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(SvipPrivilegeConfigVOModel*)getFromDict:(NSDictionary*)dict
{
SvipPrivilegeConfigVOModel* model=[[SvipPrivilegeConfigVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.svipCallTime=[dict[@"svipCallTime"] isKindOfClass:[NSNull class]]?0:[dict[@"svipCallTime"] intValue];

model.orderNo=[dict[@"orderNo"] isKindOfClass:[NSNull class]]?0:[dict[@"orderNo"] intValue];

model.svipCallSecond=[dict[@"svipCallSecond"] isKindOfClass:[NSNull class]]?0:[dict[@"svipCallSecond"] intValue];

model.privilegeDescription=[dict[@"privilegeDescription"] isKindOfClass:[NSNull class]]?@"":dict[@"privilegeDescription"];

model.privilegeImage=[dict[@"privilegeImage"] isKindOfClass:[NSNull class]]?@"":dict[@"privilegeImage"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.privilegeMark=[dict[@"privilegeMark"] isKindOfClass:[NSNull class]]?@"":dict[@"privilegeMark"];

model.privilegeTitle=[dict[@"privilegeTitle"] isKindOfClass:[NSNull class]]?@"":dict[@"privilegeTitle"];

model.isEnable=[dict[@"isEnable"] isKindOfClass:[NSNull class]]?0:[dict[@"isEnable"] intValue];

model.privilegeName=[dict[@"privilegeName"] isKindOfClass:[NSNull class]]?@"":dict[@"privilegeName"];


 return model;
}

 +(void)cloneObj:(SvipPrivilegeConfigVOModel*) source target:(SvipPrivilegeConfigVOModel*)target
{

target.svipCallTime=source.svipCallTime;

target.orderNo=source.orderNo;

target.svipCallSecond=source.svipCallSecond;

target.privilegeDescription=source.privilegeDescription;

target.privilegeImage=source.privilegeImage;

target.id_field=source.id_field;

target.privilegeMark=source.privilegeMark;

target.privilegeTitle=source.privilegeTitle;

target.isEnable=source.isEnable;

target.privilegeName=source.privilegeName;

}

@end

