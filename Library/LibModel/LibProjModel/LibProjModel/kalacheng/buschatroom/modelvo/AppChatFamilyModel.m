//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppChatFamilyModel.h"




 @implementation AppChatFamilyModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"familyRole"]=@(_familyRole);

dict[@"patriarchId"]=@(_patriarchId);

dict[@"familyProclamation"]=_familyProclamation;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppChatFamilyModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppChatFamilyModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppChatFamilyModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppChatFamilyModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppChatFamilyModel* sumMdl=[AppChatFamilyModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppChatFamilyModel*)getFromDict:(NSDictionary*)dict
{
AppChatFamilyModel* model=[[AppChatFamilyModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.familyRole=[dict[@"familyRole"] isKindOfClass:[NSNull class]]?0:[dict[@"familyRole"] intValue];

model.patriarchId=[dict[@"patriarchId"] isKindOfClass:[NSNull class]]?0:[dict[@"patriarchId"] longLongValue];

model.familyProclamation=[dict[@"familyProclamation"] isKindOfClass:[NSNull class]]?@"":dict[@"familyProclamation"];


 return model;
}

 +(void)cloneObj:(AppChatFamilyModel*) source target:(AppChatFamilyModel*)target
{

target.familyRole=source.familyRole;

target.patriarchId=source.patriarchId;

target.familyProclamation=source.familyProclamation;

}

@end

