//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiLeaveRoomAnchorModel.h"




 @implementation ApiLeaveRoomAnchorModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"serialVersionUID"]=@(_serialVersionUID);

dict[@"roomId"]=@(_roomId);

dict[@"userName"]=_userName;

dict[@"anchorId"]=@(_anchorId);

dict[@"content"]=_content;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiLeaveRoomAnchorModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiLeaveRoomAnchorModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiLeaveRoomAnchorModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiLeaveRoomAnchorModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiLeaveRoomAnchorModel* sumMdl=[ApiLeaveRoomAnchorModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiLeaveRoomAnchorModel*)getFromDict:(NSDictionary*)dict
{
ApiLeaveRoomAnchorModel* model=[[ApiLeaveRoomAnchorModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.serialVersionUID=[dict[@"serialVersionUID"] isKindOfClass:[NSNull class]]?0:[dict[@"serialVersionUID"] longLongValue];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.anchorId=[dict[@"anchorId"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorId"] longLongValue];

model.content=[dict[@"content"] isKindOfClass:[NSNull class]]?@"":dict[@"content"];


 return model;
}

 +(void)cloneObj:(ApiLeaveRoomAnchorModel*) source target:(ApiLeaveRoomAnchorModel*)target
{

target.serialVersionUID=source.serialVersionUID;

target.roomId=source.roomId;

target.userName=source.userName;

target.anchorId=source.anchorId;

target.content=source.content;

}

@end

