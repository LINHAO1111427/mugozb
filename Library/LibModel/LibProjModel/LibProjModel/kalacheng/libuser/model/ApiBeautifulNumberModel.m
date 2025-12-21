//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiBeautifulNumberModel.h"




 @implementation ApiBeautifulNumberModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"serialVersionUID"]=@(_serialVersionUID);

dict[@"avatar"]=_avatar;

dict[@"username"]=_username;

dict[@"uid"]=@(_uid);

dict[@"number"]=_number;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiBeautifulNumberModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiBeautifulNumberModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiBeautifulNumberModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiBeautifulNumberModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiBeautifulNumberModel* sumMdl=[ApiBeautifulNumberModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiBeautifulNumberModel*)getFromDict:(NSDictionary*)dict
{
ApiBeautifulNumberModel* model=[[ApiBeautifulNumberModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.serialVersionUID=[dict[@"serialVersionUID"] isKindOfClass:[NSNull class]]?0:[dict[@"serialVersionUID"] longLongValue];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.username=[dict[@"username"] isKindOfClass:[NSNull class]]?@"":dict[@"username"];

model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];

model.number=[dict[@"number"] isKindOfClass:[NSNull class]]?@"":dict[@"number"];


 return model;
}

 +(void)cloneObj:(ApiBeautifulNumberModel*) source target:(ApiBeautifulNumberModel*)target
{

target.serialVersionUID=source.serialVersionUID;

target.avatar=source.avatar;

target.username=source.username;

target.uid=source.uid;

target.number=source.number;

}

@end

