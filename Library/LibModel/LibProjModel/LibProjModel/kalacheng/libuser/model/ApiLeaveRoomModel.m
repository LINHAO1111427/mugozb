//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiLeaveRoomModel.h"




 @implementation ApiLeaveRoomModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"isOnAssistan"]=@(_isOnAssistan);

dict[@"uid"]=@(_uid);

dict[@"userAvatar"]=_userAvatar;

dict[@"watchNumber"]=@(_watchNumber);

dict[@"anchorId"]=@(_anchorId);

dict[@"userName"]=_userName;

dict[@"content"]=_content;

dict[@"roomId"]=@(_roomId);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiLeaveRoomModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiLeaveRoomModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiLeaveRoomModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiLeaveRoomModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiLeaveRoomModel* sumMdl=[ApiLeaveRoomModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiLeaveRoomModel*)getFromDict:(NSDictionary*)dict
{
ApiLeaveRoomModel* model=[[ApiLeaveRoomModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.isOnAssistan=[dict[@"isOnAssistan"] isKindOfClass:[NSNull class]]?0:[dict[@"isOnAssistan"] intValue];

model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];

model.userAvatar=[dict[@"userAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"userAvatar"];

model.watchNumber=[dict[@"watchNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"watchNumber"] intValue];

model.anchorId=[dict[@"anchorId"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorId"] longLongValue];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.content=[dict[@"content"] isKindOfClass:[NSNull class]]?@"":dict[@"content"];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];


 return model;
}

 +(void)cloneObj:(ApiLeaveRoomModel*) source target:(ApiLeaveRoomModel*)target
{

target.isOnAssistan=source.isOnAssistan;

target.uid=source.uid;

target.userAvatar=source.userAvatar;

target.watchNumber=source.watchNumber;

target.anchorId=source.anchorId;

target.userName=source.userName;

target.content=source.content;

target.roomId=source.roomId;

}

@end

