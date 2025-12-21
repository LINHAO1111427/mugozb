//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "GuildDtoModel.h"




 @implementation GuildDtoModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"name"]=_name;

dict[@"logo"]=_logo;

dict[@"guildId"]=@(_guildId);

dict[@"desr"]=_desr;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GuildDtoModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
GuildDtoModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<GuildDtoModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<GuildDtoModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
GuildDtoModel* sumMdl=[GuildDtoModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(GuildDtoModel*)getFromDict:(NSDictionary*)dict
{
GuildDtoModel* model=[[GuildDtoModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.logo=[dict[@"logo"] isKindOfClass:[NSNull class]]?@"":dict[@"logo"];

model.guildId=[dict[@"guildId"] isKindOfClass:[NSNull class]]?0:[dict[@"guildId"] longLongValue];

model.desr=[dict[@"desr"] isKindOfClass:[NSNull class]]?@"":dict[@"desr"];


 return model;
}

 +(void)cloneObj:(GuildDtoModel*) source target:(GuildDtoModel*)target
{

target.name=source.name;

target.logo=source.logo;

target.guildId=source.guildId;

target.desr=source.desr;

}

@end

