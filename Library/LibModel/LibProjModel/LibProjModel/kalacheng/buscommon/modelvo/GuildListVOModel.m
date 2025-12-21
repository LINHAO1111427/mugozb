//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "GuildListVOModel.h"




 @implementation GuildListVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"serialNumber"]=@(_serialNumber);

dict[@"guildAvatar"]=_guildAvatar;

dict[@"guildTotalVotes"]=@(_guildTotalVotes);

dict[@"guildId"]=@(_guildId);

dict[@"guildDesr"]=_guildDesr;

dict[@"guildName"]=_guildName;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GuildListVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
GuildListVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<GuildListVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<GuildListVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
GuildListVOModel* sumMdl=[GuildListVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(GuildListVOModel*)getFromDict:(NSDictionary*)dict
{
GuildListVOModel* model=[[GuildListVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.serialNumber=[dict[@"serialNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"serialNumber"] intValue];

model.guildAvatar=[dict[@"guildAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"guildAvatar"];

model.guildTotalVotes=[dict[@"guildTotalVotes"] isKindOfClass:[NSNull class]]?0:[dict[@"guildTotalVotes"] doubleValue];

model.guildId=[dict[@"guildId"] isKindOfClass:[NSNull class]]?0:[dict[@"guildId"] longLongValue];

model.guildDesr=[dict[@"guildDesr"] isKindOfClass:[NSNull class]]?@"":dict[@"guildDesr"];

model.guildName=[dict[@"guildName"] isKindOfClass:[NSNull class]]?@"":dict[@"guildName"];


 return model;
}

 +(void)cloneObj:(GuildListVOModel*) source target:(GuildListVOModel*)target
{

target.serialNumber=source.serialNumber;

target.guildAvatar=source.guildAvatar;

target.guildTotalVotes=source.guildTotalVotes;

target.guildId=source.guildId;

target.guildDesr=source.guildDesr;

target.guildName=source.guildName;

}

@end

