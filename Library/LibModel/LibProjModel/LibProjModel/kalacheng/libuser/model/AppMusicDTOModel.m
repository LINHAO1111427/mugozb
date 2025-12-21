//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppMusicDTOModel.h"




 @implementation AppMusicDTOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"cover"]=_cover;

dict[@"added"]=@(_added);

dict[@"author"]=_author;

dict[@"musicUrl"]=_musicUrl;

dict[@"name"]=_name;

dict[@"id"]=@(_id_field);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppMusicDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppMusicDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppMusicDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppMusicDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppMusicDTOModel* sumMdl=[AppMusicDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppMusicDTOModel*)getFromDict:(NSDictionary*)dict
{
AppMusicDTOModel* model=[[AppMusicDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.cover=[dict[@"cover"] isKindOfClass:[NSNull class]]?@"":dict[@"cover"];

model.added=[dict[@"added"] isKindOfClass:[NSNull class]]?0:[dict[@"added"] intValue];

model.author=[dict[@"author"] isKindOfClass:[NSNull class]]?@"":dict[@"author"];

model.musicUrl=[dict[@"musicUrl"] isKindOfClass:[NSNull class]]?@"":dict[@"musicUrl"];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];


 return model;
}

 +(void)cloneObj:(AppMusicDTOModel*) source target:(AppMusicDTOModel*)target
{

target.cover=source.cover;

target.added=source.added;

target.author=source.author;

target.musicUrl=source.musicUrl;

target.name=source.name;

target.id_field=source.id_field;

}

@end

