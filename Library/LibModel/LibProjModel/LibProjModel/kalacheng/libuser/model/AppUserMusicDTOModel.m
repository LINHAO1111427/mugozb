//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppUserMusicDTOModel.h"




 @implementation AppUserMusicDTOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"cover"]=_cover;

dict[@"musicId"]=@(_musicId);

dict[@"author"]=_author;

dict[@"musicUrl"]=_musicUrl;

dict[@"name"]=_name;

dict[@"id"]=@(_id_field);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUserMusicDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppUserMusicDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppUserMusicDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppUserMusicDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppUserMusicDTOModel* sumMdl=[AppUserMusicDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppUserMusicDTOModel*)getFromDict:(NSDictionary*)dict
{
AppUserMusicDTOModel* model=[[AppUserMusicDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.cover=[dict[@"cover"] isKindOfClass:[NSNull class]]?@"":dict[@"cover"];

model.musicId=[dict[@"musicId"] isKindOfClass:[NSNull class]]?0:[dict[@"musicId"] longLongValue];

model.author=[dict[@"author"] isKindOfClass:[NSNull class]]?@"":dict[@"author"];

model.musicUrl=[dict[@"musicUrl"] isKindOfClass:[NSNull class]]?@"":dict[@"musicUrl"];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];


 return model;
}

 +(void)cloneObj:(AppUserMusicDTOModel*) source target:(AppUserMusicDTOModel*)target
{

target.cover=source.cover;

target.musicId=source.musicId;

target.author=source.author;

target.musicUrl=source.musicUrl;

target.name=source.name;

target.id_field=source.id_field;

}

@end

