//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiUsersLiveManagerModel.h"




 @implementation ApiUsersLiveManagerModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"uid"]=@(_uid);

dict[@"userLevel"]=_userLevel;

dict[@"signature"]=_signature;

dict[@"sex"]=@(_sex);

dict[@"avatar"]=_avatar;

dict[@"id"]=@(_id_field);

dict[@"anchorLevel"]=_anchorLevel;

dict[@"username"]=_username;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUsersLiveManagerModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiUsersLiveManagerModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiUsersLiveManagerModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiUsersLiveManagerModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiUsersLiveManagerModel* sumMdl=[ApiUsersLiveManagerModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiUsersLiveManagerModel*)getFromDict:(NSDictionary*)dict
{
ApiUsersLiveManagerModel* model=[[ApiUsersLiveManagerModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];

model.userLevel=[dict[@"userLevel"] isKindOfClass:[NSNull class]]?@"":dict[@"userLevel"];

model.signature=[dict[@"signature"] isKindOfClass:[NSNull class]]?@"":dict[@"signature"];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.anchorLevel=[dict[@"anchorLevel"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorLevel"];

model.username=[dict[@"username"] isKindOfClass:[NSNull class]]?@"":dict[@"username"];


 return model;
}

 +(void)cloneObj:(ApiUsersLiveManagerModel*) source target:(ApiUsersLiveManagerModel*)target
{

target.uid=source.uid;

target.userLevel=source.userLevel;

target.signature=source.signature;

target.sex=source.sex;

target.avatar=source.avatar;

target.id_field=source.id_field;

target.anchorLevel=source.anchorLevel;

target.username=source.username;

}

@end

