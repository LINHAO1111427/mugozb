//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "TelevisionEpisodeVOModel.h"




 @implementation TelevisionEpisodeVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"televisionVideoId"]=@(_televisionVideoId);

dict[@"televisionEpisodeId"]=@(_televisionEpisodeId);

dict[@"televisionEpisodeDesc"]=_televisionEpisodeDesc;

dict[@"whichEpisode"]=@(_whichEpisode);

dict[@"televisionEpisodeImg"]=_televisionEpisodeImg;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<TelevisionEpisodeVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
TelevisionEpisodeVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<TelevisionEpisodeVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<TelevisionEpisodeVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
TelevisionEpisodeVOModel* sumMdl=[TelevisionEpisodeVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(TelevisionEpisodeVOModel*)getFromDict:(NSDictionary*)dict
{
TelevisionEpisodeVOModel* model=[[TelevisionEpisodeVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.televisionVideoId=[dict[@"televisionVideoId"] isKindOfClass:[NSNull class]]?0:[dict[@"televisionVideoId"] longLongValue];

model.televisionEpisodeId=[dict[@"televisionEpisodeId"] isKindOfClass:[NSNull class]]?0:[dict[@"televisionEpisodeId"] longLongValue];

model.televisionEpisodeDesc=[dict[@"televisionEpisodeDesc"] isKindOfClass:[NSNull class]]?@"":dict[@"televisionEpisodeDesc"];

model.whichEpisode=[dict[@"whichEpisode"] isKindOfClass:[NSNull class]]?0:[dict[@"whichEpisode"] intValue];

model.televisionEpisodeImg=[dict[@"televisionEpisodeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"televisionEpisodeImg"];


 return model;
}

 +(void)cloneObj:(TelevisionEpisodeVOModel*) source target:(TelevisionEpisodeVOModel*)target
{

target.televisionVideoId=source.televisionVideoId;

target.televisionEpisodeId=source.televisionEpisodeId;

target.televisionEpisodeDesc=source.televisionEpisodeDesc;

target.whichEpisode=source.whichEpisode;

target.televisionEpisodeImg=source.televisionEpisodeImg;

}

@end

