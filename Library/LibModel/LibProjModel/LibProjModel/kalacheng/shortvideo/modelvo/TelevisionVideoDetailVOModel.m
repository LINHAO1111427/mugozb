//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "TelevisionVideoDetailVOModel.h"




 @implementation TelevisionVideoDetailVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"rewardTotalNum"]=@(_rewardTotalNum);

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"totalEpisodes"]=@(_totalEpisodes);

dict[@"televisionVideoTitle"]=_televisionVideoTitle;

dict[@"viewingTotalNum"]=@(_viewingTotalNum);

dict[@"commentTotalNum"]=@(_commentTotalNum);

dict[@"keepTotalNum"]=@(_keepTotalNum);

dict[@"televisionVideoId"]=@(_televisionVideoId);

dict[@"televisionPartitionName"]=_televisionPartitionName;

dict[@"televisionVideoCoverImg"]=_televisionVideoCoverImg;

dict[@"televisionVideoDesc"]=_televisionVideoDesc;

dict[@"isOver"]=@(_isOver);

dict[@"likeTotalNum"]=@(_likeTotalNum);

dict[@"televisionVideoTypeName"]=_televisionVideoTypeName;

dict[@"televisionVideoImg"]=_televisionVideoImg;

dict[@"televisionVideoSummary"]=_televisionVideoSummary;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<TelevisionVideoDetailVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
TelevisionVideoDetailVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<TelevisionVideoDetailVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<TelevisionVideoDetailVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
TelevisionVideoDetailVOModel* sumMdl=[TelevisionVideoDetailVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(TelevisionVideoDetailVOModel*)getFromDict:(NSDictionary*)dict
{
TelevisionVideoDetailVOModel* model=[[TelevisionVideoDetailVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.rewardTotalNum=[dict[@"rewardTotalNum"] isKindOfClass:[NSNull class]]?0:[dict[@"rewardTotalNum"] intValue];


{
NSString *strDate= dict[@"addTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addTime=date;
    }
}

model.totalEpisodes=[dict[@"totalEpisodes"] isKindOfClass:[NSNull class]]?0:[dict[@"totalEpisodes"] intValue];

model.televisionVideoTitle=[dict[@"televisionVideoTitle"] isKindOfClass:[NSNull class]]?@"":dict[@"televisionVideoTitle"];

model.viewingTotalNum=[dict[@"viewingTotalNum"] isKindOfClass:[NSNull class]]?0:[dict[@"viewingTotalNum"] intValue];

model.commentTotalNum=[dict[@"commentTotalNum"] isKindOfClass:[NSNull class]]?0:[dict[@"commentTotalNum"] intValue];

model.keepTotalNum=[dict[@"keepTotalNum"] isKindOfClass:[NSNull class]]?0:[dict[@"keepTotalNum"] intValue];

model.televisionVideoId=[dict[@"televisionVideoId"] isKindOfClass:[NSNull class]]?0:[dict[@"televisionVideoId"] longLongValue];

model.televisionPartitionName=[dict[@"televisionPartitionName"] isKindOfClass:[NSNull class]]?@"":dict[@"televisionPartitionName"];

model.televisionVideoCoverImg=[dict[@"televisionVideoCoverImg"] isKindOfClass:[NSNull class]]?@"":dict[@"televisionVideoCoverImg"];

model.televisionVideoDesc=[dict[@"televisionVideoDesc"] isKindOfClass:[NSNull class]]?@"":dict[@"televisionVideoDesc"];

model.isOver=[dict[@"isOver"] isKindOfClass:[NSNull class]]?0:[dict[@"isOver"] intValue];

model.likeTotalNum=[dict[@"likeTotalNum"] isKindOfClass:[NSNull class]]?0:[dict[@"likeTotalNum"] intValue];

model.televisionVideoTypeName=[dict[@"televisionVideoTypeName"] isKindOfClass:[NSNull class]]?@"":dict[@"televisionVideoTypeName"];

model.televisionVideoImg=[dict[@"televisionVideoImg"] isKindOfClass:[NSNull class]]?@"":dict[@"televisionVideoImg"];

model.televisionVideoSummary=[dict[@"televisionVideoSummary"] isKindOfClass:[NSNull class]]?@"":dict[@"televisionVideoSummary"];


 return model;
}

 +(void)cloneObj:(TelevisionVideoDetailVOModel*) source target:(TelevisionVideoDetailVOModel*)target
{

target.rewardTotalNum=source.rewardTotalNum;

target.addTime=source.addTime;

target.totalEpisodes=source.totalEpisodes;

target.televisionVideoTitle=source.televisionVideoTitle;

target.viewingTotalNum=source.viewingTotalNum;

target.commentTotalNum=source.commentTotalNum;

target.keepTotalNum=source.keepTotalNum;

target.televisionVideoId=source.televisionVideoId;

target.televisionPartitionName=source.televisionPartitionName;

target.televisionVideoCoverImg=source.televisionVideoCoverImg;

target.televisionVideoDesc=source.televisionVideoDesc;

target.isOver=source.isOver;

target.likeTotalNum=source.likeTotalNum;

target.televisionVideoTypeName=source.televisionVideoTypeName;

target.televisionVideoImg=source.televisionVideoImg;

target.televisionVideoSummary=source.televisionVideoSummary;

}

@end

