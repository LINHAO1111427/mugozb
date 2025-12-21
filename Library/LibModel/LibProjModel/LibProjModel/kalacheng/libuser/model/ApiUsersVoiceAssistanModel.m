//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiUsersVoiceAssistanModel.h"
#import "AppStrickerVOModel.h"




 @implementation ApiUsersVoiceAssistanModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"appStrickerVO" : [AppStrickerVOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"retireState"]=@(_retireState);

dict[@"no"]=@(_no);

dict[@"volumeVal"]=@(_volumeVal);

dict[@"sex"]=@(_sex);

dict[@"noTalking"]=@(_noTalking);

dict[@"avatar"]=_avatar;

dict[@"anchorId"]=@(_anchorId);

dict[@"type"]=@(_type);

dict[@"userName"]=_userName;

dict[@"roomId"]=@(_roomId);

dict[@"assistanName"]=_assistanName;

dict[@"onOffState"]=@(_onOffState);

dict[@"uid"]=@(_uid);

dict[@"appStrickerVO"]=[_appStrickerVO modelToJSONObject];

dict[@"presenterUserId"]=@(_presenterUserId);

dict[@"avatarFrame"]=_avatarFrame;

dict[@"coin"]=@(_coin);

dict[@"status"]=@(_status);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUsersVoiceAssistanModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiUsersVoiceAssistanModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiUsersVoiceAssistanModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiUsersVoiceAssistanModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiUsersVoiceAssistanModel* sumMdl=[ApiUsersVoiceAssistanModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiUsersVoiceAssistanModel*)getFromDict:(NSDictionary*)dict
{
ApiUsersVoiceAssistanModel* model=[[ApiUsersVoiceAssistanModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.retireState=[dict[@"retireState"] isKindOfClass:[NSNull class]]?0:[dict[@"retireState"] intValue];

model.no=[dict[@"no"] isKindOfClass:[NSNull class]]?0:[dict[@"no"] intValue];

model.volumeVal=[dict[@"volumeVal"] isKindOfClass:[NSNull class]]?0:[dict[@"volumeVal"] intValue];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.noTalking=[dict[@"noTalking"] isKindOfClass:[NSNull class]]?0:[dict[@"noTalking"] intValue];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.anchorId=[dict[@"anchorId"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorId"] longLongValue];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];

model.assistanName=[dict[@"assistanName"] isKindOfClass:[NSNull class]]?@"":dict[@"assistanName"];

model.onOffState=[dict[@"onOffState"] isKindOfClass:[NSNull class]]?0:[dict[@"onOffState"] intValue];

model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];


//getFromDict对象转换  
model.appStrickerVO=[AppStrickerVOModel getFromDict:dict[@"appStrickerVO"]];

model.presenterUserId=[dict[@"presenterUserId"] isKindOfClass:[NSNull class]]?0:[dict[@"presenterUserId"] longLongValue];

model.avatarFrame=[dict[@"avatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"avatarFrame"];

model.coin=[dict[@"coin"] isKindOfClass:[NSNull class]]?0:[dict[@"coin"] doubleValue];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];


 return model;
}

 +(void)cloneObj:(ApiUsersVoiceAssistanModel*) source target:(ApiUsersVoiceAssistanModel*)target
{

target.retireState=source.retireState;

target.no=source.no;

target.volumeVal=source.volumeVal;

target.sex=source.sex;

target.noTalking=source.noTalking;

target.avatar=source.avatar;

target.anchorId=source.anchorId;

target.type=source.type;

target.userName=source.userName;

target.roomId=source.roomId;

target.assistanName=source.assistanName;

target.onOffState=source.onOffState;

target.uid=source.uid;
        if(source.appStrickerVO==nil)
        {
//            target.appStrickerVO=nil;
        }else
        {
            [AppStrickerVOModel cloneObj:source.appStrickerVO target:target.appStrickerVO];
        }

target.presenterUserId=source.presenterUserId;

target.avatarFrame=source.avatarFrame;

target.coin=source.coin;

target.status=source.status;

}

@end

