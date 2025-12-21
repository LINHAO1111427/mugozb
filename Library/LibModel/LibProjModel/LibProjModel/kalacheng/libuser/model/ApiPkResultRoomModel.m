//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiPkResultRoomModel.h"
#import "ApiUsersVoiceAssistanModel.h"




 @implementation ApiPkResultRoomModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"assistans" : [ApiUsersVoiceAssistanModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_assistans;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ApiUsersVoiceAssistanModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"assistans"]=list;
}//end

dict[@"punishTime"]=@(_punishTime);

dict[@"winUserName"]=_winUserName;

dict[@"content"]=_content;

dict[@"roomId"]=@(_roomId);

dict[@"winUserAvatar"]=_winUserAvatar;

dict[@"isWin"]=@(_isWin);

dict[@"pkType"]=@(_pkType);

dict[@"winUid"]=@(_winUid);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiPkResultRoomModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiPkResultRoomModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiPkResultRoomModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiPkResultRoomModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiPkResultRoomModel* sumMdl=[ApiPkResultRoomModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiPkResultRoomModel*)getFromDict:(NSDictionary*)dict
{
ApiPkResultRoomModel* model=[[ApiPkResultRoomModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.assistans=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"assistans"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiUsersVoiceAssistanModel* sumMdl=[ApiUsersVoiceAssistanModel getFromDict:subDic];
[model.assistans addObject:sumMdl];

}
}

}

model.punishTime=[dict[@"punishTime"] isKindOfClass:[NSNull class]]?0:[dict[@"punishTime"] intValue];

model.winUserName=[dict[@"winUserName"] isKindOfClass:[NSNull class]]?@"":dict[@"winUserName"];

model.content=[dict[@"content"] isKindOfClass:[NSNull class]]?@"":dict[@"content"];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];

model.winUserAvatar=[dict[@"winUserAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"winUserAvatar"];

model.isWin=[dict[@"isWin"] isKindOfClass:[NSNull class]]?0:[dict[@"isWin"] intValue];

model.pkType=[dict[@"pkType"] isKindOfClass:[NSNull class]]?0:[dict[@"pkType"] intValue];

model.winUid=[dict[@"winUid"] isKindOfClass:[NSNull class]]?0:[dict[@"winUid"] longLongValue];


 return model;
}

 +(void)cloneObj:(ApiPkResultRoomModel*) source target:(ApiPkResultRoomModel*)target
{

        if(source.assistans==nil)
        {
//            target.assistans=nil;
        }else
        {
            target.assistans=[[NSMutableArray alloc] init];
            for(int i=0;i<source.assistans.count;i++)
            {
		  [target.assistans addObject:[[ApiUsersVoiceAssistanModel alloc]init]];
            [ApiUsersVoiceAssistanModel cloneObj:source.assistans[i] target:target.assistans[i]];
            }
        }


target.punishTime=source.punishTime;

target.winUserName=source.winUserName;

target.content=source.content;

target.roomId=source.roomId;

target.winUserAvatar=source.winUserAvatar;

target.isWin=source.isWin;

target.pkType=source.pkType;

target.winUid=source.winUid;

}

@end

