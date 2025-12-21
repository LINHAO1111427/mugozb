//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiCloseLiveModel.h"




 @implementation ApiCloseLiveModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"duration"]=@(_duration);

dict[@"rewardNumber"]=@(_rewardNumber);

dict[@"addFollow"]=@(_addFollow);

dict[@"addFansGroup"]=@(_addFansGroup);

dict[@"votes"]=@(_votes);

dict[@"avatar"]=_avatar;

dict[@"anchorId"]=@(_anchorId);

dict[@"anchorName"]=_anchorName;

dict[@"nums"]=@(_nums);

dict[@"roomId"]=@(_roomId);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiCloseLiveModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiCloseLiveModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiCloseLiveModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiCloseLiveModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiCloseLiveModel* sumMdl=[ApiCloseLiveModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiCloseLiveModel*)getFromDict:(NSDictionary*)dict
{
ApiCloseLiveModel* model=[[ApiCloseLiveModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.duration=[dict[@"duration"] isKindOfClass:[NSNull class]]?0:[dict[@"duration"] longLongValue];

model.rewardNumber=[dict[@"rewardNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"rewardNumber"] intValue];

model.addFollow=[dict[@"addFollow"] isKindOfClass:[NSNull class]]?0:[dict[@"addFollow"] intValue];

model.addFansGroup=[dict[@"addFansGroup"] isKindOfClass:[NSNull class]]?0:[dict[@"addFansGroup"] intValue];

model.votes=[dict[@"votes"] isKindOfClass:[NSNull class]]?0:[dict[@"votes"] doubleValue];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.anchorId=[dict[@"anchorId"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorId"] longLongValue];

model.anchorName=[dict[@"anchorName"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorName"];

model.nums=[dict[@"nums"] isKindOfClass:[NSNull class]]?0:[dict[@"nums"] intValue];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];


 return model;
}

 +(void)cloneObj:(ApiCloseLiveModel*) source target:(ApiCloseLiveModel*)target
{

target.duration=source.duration;

target.rewardNumber=source.rewardNumber;

target.addFollow=source.addFollow;

target.addFansGroup=source.addFansGroup;

target.votes=source.votes;

target.avatar=source.avatar;

target.anchorId=source.anchorId;

target.anchorName=source.anchorName;

target.nums=source.nums;

target.roomId=source.roomId;

}

@end

