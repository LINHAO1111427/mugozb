//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "TelevisionShowInfoVOModel.h"




 @implementation TelevisionShowInfoVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"commentNum"]=@(_commentNum);

dict[@"televisionVideoId"]=@(_televisionVideoId);

dict[@"televisionEpisodeId"]=@(_televisionEpisodeId);

dict[@"televisionVideoDuration"]=@(_televisionVideoDuration);

dict[@"televisionEpisodeDesc"]=_televisionEpisodeDesc;

dict[@"televisionVideoTitle"]=_televisionVideoTitle;

dict[@"whichEpisode"]=@(_whichEpisode);

dict[@"televisionEpisodeImg"]=_televisionEpisodeImg;

dict[@"viewingNum"]=@(_viewingNum);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<TelevisionShowInfoVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
TelevisionShowInfoVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<TelevisionShowInfoVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<TelevisionShowInfoVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
TelevisionShowInfoVOModel* sumMdl=[TelevisionShowInfoVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(TelevisionShowInfoVOModel*)getFromDict:(NSDictionary*)dict
{
TelevisionShowInfoVOModel* model=[[TelevisionShowInfoVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.commentNum=[dict[@"commentNum"] isKindOfClass:[NSNull class]]?0:[dict[@"commentNum"] intValue];

model.televisionVideoId=[dict[@"televisionVideoId"] isKindOfClass:[NSNull class]]?0:[dict[@"televisionVideoId"] longLongValue];

model.televisionEpisodeId=[dict[@"televisionEpisodeId"] isKindOfClass:[NSNull class]]?0:[dict[@"televisionEpisodeId"] longLongValue];

model.televisionVideoDuration=[dict[@"televisionVideoDuration"] isKindOfClass:[NSNull class]]?0:[dict[@"televisionVideoDuration"] intValue];

model.televisionEpisodeDesc=[dict[@"televisionEpisodeDesc"] isKindOfClass:[NSNull class]]?@"":dict[@"televisionEpisodeDesc"];

model.televisionVideoTitle=[dict[@"televisionVideoTitle"] isKindOfClass:[NSNull class]]?@"":dict[@"televisionVideoTitle"];

model.whichEpisode=[dict[@"whichEpisode"] isKindOfClass:[NSNull class]]?0:[dict[@"whichEpisode"] intValue];

model.televisionEpisodeImg=[dict[@"televisionEpisodeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"televisionEpisodeImg"];

model.viewingNum=[dict[@"viewingNum"] isKindOfClass:[NSNull class]]?0:[dict[@"viewingNum"] intValue];


 return model;
}

 +(void)cloneObj:(TelevisionShowInfoVOModel*) source target:(TelevisionShowInfoVOModel*)target
{

target.commentNum=source.commentNum;

target.televisionVideoId=source.televisionVideoId;

target.televisionEpisodeId=source.televisionEpisodeId;

target.televisionVideoDuration=source.televisionVideoDuration;

target.televisionEpisodeDesc=source.televisionEpisodeDesc;

target.televisionVideoTitle=source.televisionVideoTitle;

target.whichEpisode=source.whichEpisode;

target.televisionEpisodeImg=source.televisionEpisodeImg;

target.viewingNum=source.viewingNum;

}

@end

