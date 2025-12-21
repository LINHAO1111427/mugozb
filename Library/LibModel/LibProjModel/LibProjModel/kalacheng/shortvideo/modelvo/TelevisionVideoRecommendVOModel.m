//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "TelevisionVideoRecommendVOModel.h"




 @implementation TelevisionVideoRecommendVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"televisionVideoId"]=@(_televisionVideoId);

dict[@"totalEpisodes"]=@(_totalEpisodes);

dict[@"televisionVideoCoverImg"]=_televisionVideoCoverImg;

dict[@"televisionVideoTitle"]=_televisionVideoTitle;

dict[@"viewingTotalNum"]=@(_viewingTotalNum);

dict[@"likeTotalNum"]=@(_likeTotalNum);

dict[@"televisionVideoImg"]=_televisionVideoImg;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<TelevisionVideoRecommendVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
TelevisionVideoRecommendVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<TelevisionVideoRecommendVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<TelevisionVideoRecommendVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
TelevisionVideoRecommendVOModel* sumMdl=[TelevisionVideoRecommendVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(TelevisionVideoRecommendVOModel*)getFromDict:(NSDictionary*)dict
{
TelevisionVideoRecommendVOModel* model=[[TelevisionVideoRecommendVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.televisionVideoId=[dict[@"televisionVideoId"] isKindOfClass:[NSNull class]]?0:[dict[@"televisionVideoId"] longLongValue];

model.totalEpisodes=[dict[@"totalEpisodes"] isKindOfClass:[NSNull class]]?0:[dict[@"totalEpisodes"] intValue];

model.televisionVideoCoverImg=[dict[@"televisionVideoCoverImg"] isKindOfClass:[NSNull class]]?@"":dict[@"televisionVideoCoverImg"];

model.televisionVideoTitle=[dict[@"televisionVideoTitle"] isKindOfClass:[NSNull class]]?@"":dict[@"televisionVideoTitle"];

model.viewingTotalNum=[dict[@"viewingTotalNum"] isKindOfClass:[NSNull class]]?0:[dict[@"viewingTotalNum"] intValue];

model.likeTotalNum=[dict[@"likeTotalNum"] isKindOfClass:[NSNull class]]?0:[dict[@"likeTotalNum"] intValue];

model.televisionVideoImg=[dict[@"televisionVideoImg"] isKindOfClass:[NSNull class]]?@"":dict[@"televisionVideoImg"];


 return model;
}

 +(void)cloneObj:(TelevisionVideoRecommendVOModel*) source target:(TelevisionVideoRecommendVOModel*)target
{

target.televisionVideoId=source.televisionVideoId;

target.totalEpisodes=source.totalEpisodes;

target.televisionVideoCoverImg=source.televisionVideoCoverImg;

target.televisionVideoTitle=source.televisionVideoTitle;

target.viewingTotalNum=source.viewingTotalNum;

target.likeTotalNum=source.likeTotalNum;

target.televisionVideoImg=source.televisionVideoImg;

}

@end

