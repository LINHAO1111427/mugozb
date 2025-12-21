//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "TelevisionEpisodeDataVOModel.h"




 @implementation TelevisionEpisodeDataVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"commentNum"]=@(_commentNum);

dict[@"televisionEpisodeId"]=@(_televisionEpisodeId);

dict[@"keepNum"]=@(_keepNum);

dict[@"rewardNum"]=@(_rewardNum);

dict[@"viewingNum"]=@(_viewingNum);

dict[@"likeNum"]=@(_likeNum);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<TelevisionEpisodeDataVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
TelevisionEpisodeDataVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<TelevisionEpisodeDataVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<TelevisionEpisodeDataVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
TelevisionEpisodeDataVOModel* sumMdl=[TelevisionEpisodeDataVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(TelevisionEpisodeDataVOModel*)getFromDict:(NSDictionary*)dict
{
TelevisionEpisodeDataVOModel* model=[[TelevisionEpisodeDataVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.commentNum=[dict[@"commentNum"] isKindOfClass:[NSNull class]]?0:[dict[@"commentNum"] intValue];

model.televisionEpisodeId=[dict[@"televisionEpisodeId"] isKindOfClass:[NSNull class]]?0:[dict[@"televisionEpisodeId"] longLongValue];

model.keepNum=[dict[@"keepNum"] isKindOfClass:[NSNull class]]?0:[dict[@"keepNum"] intValue];

model.rewardNum=[dict[@"rewardNum"] isKindOfClass:[NSNull class]]?0:[dict[@"rewardNum"] intValue];

model.viewingNum=[dict[@"viewingNum"] isKindOfClass:[NSNull class]]?0:[dict[@"viewingNum"] intValue];

model.likeNum=[dict[@"likeNum"] isKindOfClass:[NSNull class]]?0:[dict[@"likeNum"] intValue];


 return model;
}

 +(void)cloneObj:(TelevisionEpisodeDataVOModel*) source target:(TelevisionEpisodeDataVOModel*)target
{

target.commentNum=source.commentNum;

target.televisionEpisodeId=source.televisionEpisodeId;

target.keepNum=source.keepNum;

target.rewardNum=source.rewardNum;

target.viewingNum=source.viewingNum;

target.likeNum=source.likeNum;

}

@end

