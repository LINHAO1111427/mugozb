//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "TelevisionVideoSimpleVOModel.h"




 @implementation TelevisionVideoSimpleVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"totalEpisodes"]=@(_totalEpisodes);

dict[@"televisionVideoCoverImg"]=_televisionVideoCoverImg;

dict[@"televisionVideoDesc"]=_televisionVideoDesc;

dict[@"televisionVideoTitle"]=_televisionVideoTitle;

dict[@"televisionVideoTagIds"]=_televisionVideoTagIds;

dict[@"id"]=@(_id_field);

dict[@"televisionVideoImg"]=_televisionVideoImg;

dict[@"userId"]=@(_userId);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<TelevisionVideoSimpleVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
TelevisionVideoSimpleVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<TelevisionVideoSimpleVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<TelevisionVideoSimpleVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
TelevisionVideoSimpleVOModel* sumMdl=[TelevisionVideoSimpleVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(TelevisionVideoSimpleVOModel*)getFromDict:(NSDictionary*)dict
{
TelevisionVideoSimpleVOModel* model=[[TelevisionVideoSimpleVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.totalEpisodes=[dict[@"totalEpisodes"] isKindOfClass:[NSNull class]]?0:[dict[@"totalEpisodes"] intValue];

model.televisionVideoCoverImg=[dict[@"televisionVideoCoverImg"] isKindOfClass:[NSNull class]]?@"":dict[@"televisionVideoCoverImg"];

model.televisionVideoDesc=[dict[@"televisionVideoDesc"] isKindOfClass:[NSNull class]]?@"":dict[@"televisionVideoDesc"];

model.televisionVideoTitle=[dict[@"televisionVideoTitle"] isKindOfClass:[NSNull class]]?@"":dict[@"televisionVideoTitle"];

model.televisionVideoTagIds=[dict[@"televisionVideoTagIds"] isKindOfClass:[NSNull class]]?@"":dict[@"televisionVideoTagIds"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.televisionVideoImg=[dict[@"televisionVideoImg"] isKindOfClass:[NSNull class]]?@"":dict[@"televisionVideoImg"];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];


 return model;
}

 +(void)cloneObj:(TelevisionVideoSimpleVOModel*) source target:(TelevisionVideoSimpleVOModel*)target
{

target.totalEpisodes=source.totalEpisodes;

target.televisionVideoCoverImg=source.televisionVideoCoverImg;

target.televisionVideoDesc=source.televisionVideoDesc;

target.televisionVideoTitle=source.televisionVideoTitle;

target.televisionVideoTagIds=source.televisionVideoTagIds;

target.id_field=source.id_field;

target.televisionVideoImg=source.televisionVideoImg;

target.userId=source.userId;

}

@end

