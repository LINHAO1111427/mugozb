//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "OOOLiveTextChatDataModel.h"
#import "OOOLiveRoomTextChatDataModel.h"




 @implementation OOOLiveTextChatDataModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"chatData" : [OOOLiveRoomTextChatDataModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"tabList"]=_tabList;

dict[@"toUserCity"]=_toUserCity;

dict[@"hideDistance"]=@(_hideDistance);

dict[@"distance"]=_distance;

dict[@"toUserAddr"]=_toUserAddr;

dict[@"chatData"]=[_chatData modelToJSONObject];

dict[@"isVideo"]=@(_isVideo);

dict[@"videoId"]=@(_videoId);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OOOLiveTextChatDataModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
OOOLiveTextChatDataModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<OOOLiveTextChatDataModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<OOOLiveTextChatDataModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
OOOLiveTextChatDataModel* sumMdl=[OOOLiveTextChatDataModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(OOOLiveTextChatDataModel*)getFromDict:(NSDictionary*)dict
{
OOOLiveTextChatDataModel* model=[[OOOLiveTextChatDataModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.tabList=[dict[@"tabList"] isKindOfClass:[NSNull class]]?@"":dict[@"tabList"];

model.toUserCity=[dict[@"toUserCity"] isKindOfClass:[NSNull class]]?@"":dict[@"toUserCity"];

model.hideDistance=[dict[@"hideDistance"] isKindOfClass:[NSNull class]]?0:[dict[@"hideDistance"] intValue];

model.distance=[dict[@"distance"] isKindOfClass:[NSNull class]]?@"":dict[@"distance"];

model.toUserAddr=[dict[@"toUserAddr"] isKindOfClass:[NSNull class]]?@"":dict[@"toUserAddr"];


//getFromDict对象转换  
model.chatData=[OOOLiveRoomTextChatDataModel getFromDict:dict[@"chatData"]];

model.isVideo=[dict[@"isVideo"] isKindOfClass:[NSNull class]]?0:[dict[@"isVideo"] intValue];

model.videoId=[dict[@"videoId"] isKindOfClass:[NSNull class]]?0:[dict[@"videoId"] longLongValue];


 return model;
}

 +(void)cloneObj:(OOOLiveTextChatDataModel*) source target:(OOOLiveTextChatDataModel*)target
{

target.tabList=source.tabList;

target.toUserCity=source.toUserCity;

target.hideDistance=source.hideDistance;

target.distance=source.distance;

target.toUserAddr=source.toUserAddr;
        if(source.chatData==nil)
        {
//            target.chatData=nil;
        }else
        {
            [OOOLiveRoomTextChatDataModel cloneObj:source.chatData target:target.chatData];
        }

target.isVideo=source.isVideo;

target.videoId=source.videoId;

}

@end

