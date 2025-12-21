//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiTimerExitRoomModel.h"




 @implementation ApiTimerExitRoomModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"serialVersionUID"]=@(_serialVersionUID);

dict[@"roomId"]=@(_roomId);

dict[@"userId"]=@(_userId);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiTimerExitRoomModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiTimerExitRoomModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiTimerExitRoomModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiTimerExitRoomModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiTimerExitRoomModel* sumMdl=[ApiTimerExitRoomModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiTimerExitRoomModel*)getFromDict:(NSDictionary*)dict
{
ApiTimerExitRoomModel* model=[[ApiTimerExitRoomModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.serialVersionUID=[dict[@"serialVersionUID"] isKindOfClass:[NSNull class]]?0:[dict[@"serialVersionUID"] longLongValue];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];


 return model;
}

 +(void)cloneObj:(ApiTimerExitRoomModel*) source target:(ApiTimerExitRoomModel*)target
{

target.serialVersionUID=source.serialVersionUID;

target.roomId=source.roomId;

target.userId=source.userId;

}

@end

