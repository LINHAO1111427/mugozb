//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppUserDataReviewVOModel.h"




 @implementation AppUserDataReviewVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"approvalStatus"]=@(_approvalStatus);

dict[@"dataType"]=@(_dataType);

dict[@"id"]=@(_id_field);

dict[@"userId"]=@(_userId);

dict[@"upUserContent"]=_upUserContent;

dict[@"oldUserContent"]=_oldUserContent;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUserDataReviewVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppUserDataReviewVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppUserDataReviewVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppUserDataReviewVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppUserDataReviewVOModel* sumMdl=[AppUserDataReviewVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppUserDataReviewVOModel*)getFromDict:(NSDictionary*)dict
{
AppUserDataReviewVOModel* model=[[AppUserDataReviewVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.approvalStatus=[dict[@"approvalStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"approvalStatus"] intValue];

model.dataType=[dict[@"dataType"] isKindOfClass:[NSNull class]]?0:[dict[@"dataType"] intValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.upUserContent=[dict[@"upUserContent"] isKindOfClass:[NSNull class]]?@"":dict[@"upUserContent"];

model.oldUserContent=[dict[@"oldUserContent"] isKindOfClass:[NSNull class]]?@"":dict[@"oldUserContent"];


 return model;
}

 +(void)cloneObj:(AppUserDataReviewVOModel*) source target:(AppUserDataReviewVOModel*)target
{

target.approvalStatus=source.approvalStatus;

target.dataType=source.dataType;

target.id_field=source.id_field;

target.userId=source.userId;

target.upUserContent=source.upUserContent;

target.oldUserContent=source.oldUserContent;

}

@end

