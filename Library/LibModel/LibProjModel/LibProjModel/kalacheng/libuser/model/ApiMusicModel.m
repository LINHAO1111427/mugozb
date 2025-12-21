//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiMusicModel.h"




 @implementation ApiMusicModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"name"]=_name;

dict[@"progress"]=@(_progress);

dict[@"id"]=_id_field;

dict[@"lyrics"]=_lyrics;

dict[@"authors"]=_authors;

dict[@"playUrl"]=_playUrl;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiMusicModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiMusicModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiMusicModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiMusicModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiMusicModel* sumMdl=[ApiMusicModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiMusicModel*)getFromDict:(NSDictionary*)dict
{
ApiMusicModel* model=[[ApiMusicModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.progress=[dict[@"progress"] isKindOfClass:[NSNull class]]?0:[dict[@"progress"] intValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?@"":dict[@"id"];

model.lyrics=[dict[@"lyrics"] isKindOfClass:[NSNull class]]?@"":dict[@"lyrics"];

model.authors=[dict[@"authors"] isKindOfClass:[NSNull class]]?@"":dict[@"authors"];

model.playUrl=[dict[@"playUrl"] isKindOfClass:[NSNull class]]?@"":dict[@"playUrl"];


 return model;
}

 +(void)cloneObj:(ApiMusicModel*) source target:(ApiMusicModel*)target
{

target.name=source.name;

target.progress=source.progress;

target.id_field=source.id_field;

target.lyrics=source.lyrics;

target.authors=source.authors;

target.playUrl=source.playUrl;

}

@end

