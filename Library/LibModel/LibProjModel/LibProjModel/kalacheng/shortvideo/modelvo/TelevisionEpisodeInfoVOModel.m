//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "TelevisionEpisodeInfoVOModel.h"
#import "TelevisionEpisodeVOModel.h"




 @implementation TelevisionEpisodeInfoVOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"anthologyList" : [TelevisionEpisodeVOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"isLike"]=@(_isLike);

dict[@"rewardNum"]=@(_rewardNum);

dict[@"payCoinNum"]=@(_payCoinNum);

dict[@"televisionVideoTitle"]=_televisionVideoTitle;

dict[@"likeNum"]=@(_likeNum);

dict[@"isLogin"]=@(_isLogin);

dict[@"televisionVideoId"]=@(_televisionVideoId);

dict[@"promptImg"]=_promptImg;

dict[@"trialTime"]=@(_trialTime);

dict[@"keepNum"]=@(_keepNum);

dict[@"televisionEpisodeImg"]=_televisionEpisodeImg;

dict[@"promptText"]=_promptText;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_anthologyList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
TelevisionEpisodeVOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"anthologyList"]=list;
}//end

dict[@"televisionVideoUrl"]=_televisionVideoUrl;

dict[@"totalEpisodes"]=@(_totalEpisodes);

dict[@"viewingTotalNum"]=@(_viewingTotalNum);

dict[@"whichEpisode"]=@(_whichEpisode);

dict[@"isKeep"]=@(_isKeep);

dict[@"userId"]=@(_userId);

dict[@"commentNum"]=@(_commentNum);

dict[@"isOpenNoble"]=@(_isOpenNoble);

dict[@"televisionEpisodeId"]=@(_televisionEpisodeId);

dict[@"isPayCoin"]=@(_isPayCoin);

dict[@"paidCoverImage"]=_paidCoverImage;

dict[@"televisionEpisodeDesc"]=_televisionEpisodeDesc;

dict[@"isOver"]=@(_isOver);

dict[@"watchTime"]=@(_watchTime);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<TelevisionEpisodeInfoVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
TelevisionEpisodeInfoVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<TelevisionEpisodeInfoVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<TelevisionEpisodeInfoVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
TelevisionEpisodeInfoVOModel* sumMdl=[TelevisionEpisodeInfoVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(TelevisionEpisodeInfoVOModel*)getFromDict:(NSDictionary*)dict
{
TelevisionEpisodeInfoVOModel* model=[[TelevisionEpisodeInfoVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.isLike=[dict[@"isLike"] isKindOfClass:[NSNull class]]?0:[dict[@"isLike"] intValue];

model.rewardNum=[dict[@"rewardNum"] isKindOfClass:[NSNull class]]?0:[dict[@"rewardNum"] intValue];

model.payCoinNum=[dict[@"payCoinNum"] isKindOfClass:[NSNull class]]?0:[dict[@"payCoinNum"] doubleValue];

model.televisionVideoTitle=[dict[@"televisionVideoTitle"] isKindOfClass:[NSNull class]]?@"":dict[@"televisionVideoTitle"];

model.likeNum=[dict[@"likeNum"] isKindOfClass:[NSNull class]]?0:[dict[@"likeNum"] intValue];

model.isLogin=[dict[@"isLogin"] isKindOfClass:[NSNull class]]?0:[dict[@"isLogin"] intValue];

model.televisionVideoId=[dict[@"televisionVideoId"] isKindOfClass:[NSNull class]]?0:[dict[@"televisionVideoId"] longLongValue];

model.promptImg=[dict[@"promptImg"] isKindOfClass:[NSNull class]]?@"":dict[@"promptImg"];

model.trialTime=[dict[@"trialTime"] isKindOfClass:[NSNull class]]?0:[dict[@"trialTime"] intValue];

model.keepNum=[dict[@"keepNum"] isKindOfClass:[NSNull class]]?0:[dict[@"keepNum"] intValue];

model.televisionEpisodeImg=[dict[@"televisionEpisodeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"televisionEpisodeImg"];

model.promptText=[dict[@"promptText"] isKindOfClass:[NSNull class]]?@"":dict[@"promptText"];

model.anthologyList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"anthologyList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
TelevisionEpisodeVOModel* sumMdl=[TelevisionEpisodeVOModel getFromDict:subDic];
[model.anthologyList addObject:sumMdl];

}
}

}

model.televisionVideoUrl=[dict[@"televisionVideoUrl"] isKindOfClass:[NSNull class]]?@"":dict[@"televisionVideoUrl"];

model.totalEpisodes=[dict[@"totalEpisodes"] isKindOfClass:[NSNull class]]?0:[dict[@"totalEpisodes"] intValue];

model.viewingTotalNum=[dict[@"viewingTotalNum"] isKindOfClass:[NSNull class]]?0:[dict[@"viewingTotalNum"] intValue];

model.whichEpisode=[dict[@"whichEpisode"] isKindOfClass:[NSNull class]]?0:[dict[@"whichEpisode"] intValue];

model.isKeep=[dict[@"isKeep"] isKindOfClass:[NSNull class]]?0:[dict[@"isKeep"] intValue];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.commentNum=[dict[@"commentNum"] isKindOfClass:[NSNull class]]?0:[dict[@"commentNum"] intValue];

model.isOpenNoble=[dict[@"isOpenNoble"] isKindOfClass:[NSNull class]]?0:[dict[@"isOpenNoble"] intValue];

model.televisionEpisodeId=[dict[@"televisionEpisodeId"] isKindOfClass:[NSNull class]]?0:[dict[@"televisionEpisodeId"] longLongValue];

model.isPayCoin=[dict[@"isPayCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"isPayCoin"] intValue];

model.paidCoverImage=[dict[@"paidCoverImage"] isKindOfClass:[NSNull class]]?@"":dict[@"paidCoverImage"];

model.televisionEpisodeDesc=[dict[@"televisionEpisodeDesc"] isKindOfClass:[NSNull class]]?@"":dict[@"televisionEpisodeDesc"];

model.isOver=[dict[@"isOver"] isKindOfClass:[NSNull class]]?0:[dict[@"isOver"] intValue];

model.watchTime=[dict[@"watchTime"] isKindOfClass:[NSNull class]]?0:[dict[@"watchTime"] longLongValue];


 return model;
}

 +(void)cloneObj:(TelevisionEpisodeInfoVOModel*) source target:(TelevisionEpisodeInfoVOModel*)target
{

target.isLike=source.isLike;

target.rewardNum=source.rewardNum;

target.payCoinNum=source.payCoinNum;

target.televisionVideoTitle=source.televisionVideoTitle;

target.likeNum=source.likeNum;

target.isLogin=source.isLogin;

target.televisionVideoId=source.televisionVideoId;

target.promptImg=source.promptImg;

target.trialTime=source.trialTime;

target.keepNum=source.keepNum;

target.televisionEpisodeImg=source.televisionEpisodeImg;

target.promptText=source.promptText;

        if(source.anthologyList==nil)
        {
//            target.anthologyList=nil;
        }else
        {
            target.anthologyList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.anthologyList.count;i++)
            {
		  [target.anthologyList addObject:[[TelevisionEpisodeVOModel alloc]init]];
            [TelevisionEpisodeVOModel cloneObj:source.anthologyList[i] target:target.anthologyList[i]];
            }
        }


target.televisionVideoUrl=source.televisionVideoUrl;

target.totalEpisodes=source.totalEpisodes;

target.viewingTotalNum=source.viewingTotalNum;

target.whichEpisode=source.whichEpisode;

target.isKeep=source.isKeep;

target.userId=source.userId;

target.commentNum=source.commentNum;

target.isOpenNoble=source.isOpenNoble;

target.televisionEpisodeId=source.televisionEpisodeId;

target.isPayCoin=source.isPayCoin;

target.paidCoverImage=source.paidCoverImage;

target.televisionEpisodeDesc=source.televisionEpisodeDesc;

target.isOver=source.isOver;

target.watchTime=source.watchTime;

}

@end

