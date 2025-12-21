//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "LiveRoomInfoVOModel.h"




 @implementation LiveRoomInfoVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"isRecommend"]=@(_isRecommend);

dict[@"anchorGrade"]=@(_anchorGrade);

dict[@"thumb"]=_thumb;

dict[@"liveFunction"]=@(_liveFunction);

dict[@"liveType"]=@(_liveType);

dict[@"sex"]=@(_sex);

dict[@"channelImage"]=_channelImage;

dict[@"avatar"]=_avatar;

dict[@"sort"]=@(_sort);

dict[@"title"]=_title;

dict[@"isChecked"]=@(_isChecked);

dict[@"userId"]=@(_userId);

dict[@"roomId"]=@(_roomId);

dict[@"hotSortId"]=@(_hotSortId);

dict[@"pull"]=_pull;

dict[@"showid"]=_showid;

dict[@"roomTypeVal"]=_roomTypeVal;

dict[@"channelName"]=_channelName;

dict[@"channelId"]=@(_channelId);

dict[@"nums"]=@(_nums);

dict[@"roomType"]=@(_roomType);

dict[@"username"]=_username;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<LiveRoomInfoVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
LiveRoomInfoVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<LiveRoomInfoVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<LiveRoomInfoVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
LiveRoomInfoVOModel* sumMdl=[LiveRoomInfoVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(LiveRoomInfoVOModel*)getFromDict:(NSDictionary*)dict
{
LiveRoomInfoVOModel* model=[[LiveRoomInfoVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.isRecommend=[dict[@"isRecommend"] isKindOfClass:[NSNull class]]?0:[dict[@"isRecommend"] intValue];

model.anchorGrade=[dict[@"anchorGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorGrade"] intValue];

model.thumb=[dict[@"thumb"] isKindOfClass:[NSNull class]]?@"":dict[@"thumb"];

model.liveFunction=[dict[@"liveFunction"] isKindOfClass:[NSNull class]]?0:[dict[@"liveFunction"] intValue];

model.liveType=[dict[@"liveType"] isKindOfClass:[NSNull class]]?0:[dict[@"liveType"] intValue];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.channelImage=[dict[@"channelImage"] isKindOfClass:[NSNull class]]?@"":dict[@"channelImage"];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.sort=[dict[@"sort"] isKindOfClass:[NSNull class]]?0:[dict[@"sort"] intValue];

model.title=[dict[@"title"] isKindOfClass:[NSNull class]]?@"":dict[@"title"];

model.isChecked=[dict[@"isChecked"] isKindOfClass:[NSNull class]]?0:[dict[@"isChecked"] intValue];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];

model.hotSortId=[dict[@"hotSortId"] isKindOfClass:[NSNull class]]?0:[dict[@"hotSortId"] longLongValue];

model.pull=[dict[@"pull"] isKindOfClass:[NSNull class]]?@"":dict[@"pull"];

model.showid=[dict[@"showid"] isKindOfClass:[NSNull class]]?@"":dict[@"showid"];

model.roomTypeVal=[dict[@"roomTypeVal"] isKindOfClass:[NSNull class]]?@"":dict[@"roomTypeVal"];

model.channelName=[dict[@"channelName"] isKindOfClass:[NSNull class]]?@"":dict[@"channelName"];

model.channelId=[dict[@"channelId"] isKindOfClass:[NSNull class]]?0:[dict[@"channelId"] longLongValue];

model.nums=[dict[@"nums"] isKindOfClass:[NSNull class]]?0:[dict[@"nums"] intValue];

model.roomType=[dict[@"roomType"] isKindOfClass:[NSNull class]]?0:[dict[@"roomType"] intValue];

model.username=[dict[@"username"] isKindOfClass:[NSNull class]]?@"":dict[@"username"];


 return model;
}

 +(void)cloneObj:(LiveRoomInfoVOModel*) source target:(LiveRoomInfoVOModel*)target
{

target.isRecommend=source.isRecommend;

target.anchorGrade=source.anchorGrade;

target.thumb=source.thumb;

target.liveFunction=source.liveFunction;

target.liveType=source.liveType;

target.sex=source.sex;

target.channelImage=source.channelImage;

target.avatar=source.avatar;

target.sort=source.sort;

target.title=source.title;

target.isChecked=source.isChecked;

target.userId=source.userId;

target.roomId=source.roomId;

target.hotSortId=source.hotSortId;

target.pull=source.pull;

target.showid=source.showid;

target.roomTypeVal=source.roomTypeVal;

target.channelName=source.channelName;

target.channelId=source.channelId;

target.nums=source.nums;

target.roomType=source.roomType;

target.username=source.username;

}

@end

