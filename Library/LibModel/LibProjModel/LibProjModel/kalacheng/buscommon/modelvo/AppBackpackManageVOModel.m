//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppBackpackManageVOModel.h"




 @implementation AppBackpackManageVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"whoLooksAtMe"]=_whoLooksAtMe;

dict[@"videoLink"]=_videoLink;

dict[@"id"]=@(_id_field);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppBackpackManageVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppBackpackManageVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppBackpackManageVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppBackpackManageVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppBackpackManageVOModel* sumMdl=[AppBackpackManageVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppBackpackManageVOModel*)getFromDict:(NSDictionary*)dict
{
AppBackpackManageVOModel* model=[[AppBackpackManageVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.whoLooksAtMe=[dict[@"whoLooksAtMe"] isKindOfClass:[NSNull class]]?@"":dict[@"whoLooksAtMe"];

model.videoLink=[dict[@"videoLink"] isKindOfClass:[NSNull class]]?@"":dict[@"videoLink"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];


 return model;
}

 +(void)cloneObj:(AppBackpackManageVOModel*) source target:(AppBackpackManageVOModel*)target
{

target.whoLooksAtMe=source.whoLooksAtMe;

target.videoLink=source.videoLink;

target.id_field=source.id_field;

}

@end

