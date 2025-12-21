//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "VoicePkVOModel.h"
#import "PkGiftSenderModel.h"
#import "AppStrickerVOModel.h"
#import "PkUserVoiceAssistanModel.h"
#import "ApiPkResultRoomModel.h"




 @implementation VoicePkVOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"thisSenders" : [PkGiftSenderModel class],@"otherSenders" : [PkGiftSenderModel class],@"appStrickerVO" : [AppStrickerVOModel class],@"otherAppStrickerVO" : [AppStrickerVOModel class],@"thisAssistans" : [PkUserVoiceAssistanModel class],@"otherAssistans" : [PkUserVoiceAssistanModel class],@"pkResultRoom" : [ApiPkResultRoomModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"otherAnchorId"]=@(_otherAnchorId);

dict[@"otherShowId"]=_otherShowId;

dict[@"otherTotalVotes"]=@(_otherTotalVotes);

dict[@"thisAge"]=@(_thisAge);

dict[@"otherSex"]=@(_otherSex);

dict[@"otherAnchorVotes"]=@(_otherAnchorVotes);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_thisSenders;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
PkGiftSenderModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"thisSenders"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_otherSenders;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
PkGiftSenderModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"otherSenders"]=list;
}//end

dict[@"pkCountdownMillis"]=@(_pkCountdownMillis);

dict[@"thisAvatarFrame"]=_thisAvatarFrame;

dict[@"appStrickerVO"]=[_appStrickerVO modelToJSONObject];

dict[@"otherAppStrickerVO"]=[_otherAppStrickerVO modelToJSONObject];

dict[@"thisAnchorId"]=@(_thisAnchorId);

dict[@"totalVotes"]=@(_totalVotes);

dict[@"thisShowId"]=_thisShowId;

dict[@"thisUsername"]=_thisUsername;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_thisAssistans;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
PkUserVoiceAssistanModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"thisAssistans"]=list;
}//end

dict[@"hostVolumn"]=@(_hostVolumn);

dict[@"pkProcess"]=@(_pkProcess);

dict[@"thisSex"]=@(_thisSex);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_otherAssistans;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
PkUserVoiceAssistanModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"otherAssistans"]=list;
}//end

dict[@"thisAvatar"]=_thisAvatar;

dict[@"anchorVotes"]=@(_anchorVotes);

dict[@"processEndMills"]=@(_processEndMills);

dict[@"thisPresenterUserId"]=@(_thisPresenterUserId);

dict[@"otherUsername"]=_otherUsername;

dict[@"otherAvatarFrame"]=_otherAvatarFrame;

dict[@"thisRoomID"]=@(_thisRoomID);

dict[@"otherHostVolumn"]=@(_otherHostVolumn);

dict[@"otherPresenterUserId"]=@(_otherPresenterUserId);

dict[@"pkResultRoom"]=[_pkResultRoom modelToJSONObject];

dict[@"processEndTime"]=@(_processEndTime);

dict[@"rdTitle"]=_rdTitle;

dict[@"otherAvatar"]=_otherAvatar;

dict[@"pkMillis"]=@(_pkMillis);

dict[@"otherAge"]=@(_otherAge);

dict[@"otherRoomID"]=@(_otherRoomID);

dict[@"pkType"]=@(_pkType);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<VoicePkVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
VoicePkVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<VoicePkVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<VoicePkVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
VoicePkVOModel* sumMdl=[VoicePkVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(VoicePkVOModel*)getFromDict:(NSDictionary*)dict
{
VoicePkVOModel* model=[[VoicePkVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.otherAnchorId=[dict[@"otherAnchorId"] isKindOfClass:[NSNull class]]?0:[dict[@"otherAnchorId"] longLongValue];

model.otherShowId=[dict[@"otherShowId"] isKindOfClass:[NSNull class]]?@"":dict[@"otherShowId"];

model.otherTotalVotes=[dict[@"otherTotalVotes"] isKindOfClass:[NSNull class]]?0:[dict[@"otherTotalVotes"] doubleValue];

model.thisAge=[dict[@"thisAge"] isKindOfClass:[NSNull class]]?0:[dict[@"thisAge"] intValue];

model.otherSex=[dict[@"otherSex"] isKindOfClass:[NSNull class]]?0:[dict[@"otherSex"] intValue];

model.otherAnchorVotes=[dict[@"otherAnchorVotes"] isKindOfClass:[NSNull class]]?0:[dict[@"otherAnchorVotes"] doubleValue];

model.thisSenders=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"thisSenders"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
PkGiftSenderModel* sumMdl=[PkGiftSenderModel getFromDict:subDic];
[model.thisSenders addObject:sumMdl];

}
}

}

model.otherSenders=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"otherSenders"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
PkGiftSenderModel* sumMdl=[PkGiftSenderModel getFromDict:subDic];
[model.otherSenders addObject:sumMdl];

}
}

}

model.pkCountdownMillis=[dict[@"pkCountdownMillis"] isKindOfClass:[NSNull class]]?0:[dict[@"pkCountdownMillis"] longLongValue];

model.thisAvatarFrame=[dict[@"thisAvatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"thisAvatarFrame"];


//getFromDict对象转换  
model.appStrickerVO=[AppStrickerVOModel getFromDict:dict[@"appStrickerVO"]];


//getFromDict对象转换  
model.otherAppStrickerVO=[AppStrickerVOModel getFromDict:dict[@"otherAppStrickerVO"]];

model.thisAnchorId=[dict[@"thisAnchorId"] isKindOfClass:[NSNull class]]?0:[dict[@"thisAnchorId"] longLongValue];

model.totalVotes=[dict[@"totalVotes"] isKindOfClass:[NSNull class]]?0:[dict[@"totalVotes"] doubleValue];

model.thisShowId=[dict[@"thisShowId"] isKindOfClass:[NSNull class]]?@"":dict[@"thisShowId"];

model.thisUsername=[dict[@"thisUsername"] isKindOfClass:[NSNull class]]?@"":dict[@"thisUsername"];

model.thisAssistans=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"thisAssistans"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
PkUserVoiceAssistanModel* sumMdl=[PkUserVoiceAssistanModel getFromDict:subDic];
[model.thisAssistans addObject:sumMdl];

}
}

}

model.hostVolumn=[dict[@"hostVolumn"] isKindOfClass:[NSNull class]]?0:[dict[@"hostVolumn"] intValue];

model.pkProcess=[dict[@"pkProcess"] isKindOfClass:[NSNull class]]?0:[dict[@"pkProcess"] intValue];

model.thisSex=[dict[@"thisSex"] isKindOfClass:[NSNull class]]?0:[dict[@"thisSex"] intValue];

model.otherAssistans=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"otherAssistans"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
PkUserVoiceAssistanModel* sumMdl=[PkUserVoiceAssistanModel getFromDict:subDic];
[model.otherAssistans addObject:sumMdl];

}
}

}

model.thisAvatar=[dict[@"thisAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"thisAvatar"];

model.anchorVotes=[dict[@"anchorVotes"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorVotes"] doubleValue];

model.processEndMills=[dict[@"processEndMills"] isKindOfClass:[NSNull class]]?0:[dict[@"processEndMills"] longLongValue];

model.thisPresenterUserId=[dict[@"thisPresenterUserId"] isKindOfClass:[NSNull class]]?0:[dict[@"thisPresenterUserId"] longLongValue];

model.otherUsername=[dict[@"otherUsername"] isKindOfClass:[NSNull class]]?@"":dict[@"otherUsername"];

model.otherAvatarFrame=[dict[@"otherAvatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"otherAvatarFrame"];

model.thisRoomID=[dict[@"thisRoomID"] isKindOfClass:[NSNull class]]?0:[dict[@"thisRoomID"] longLongValue];

model.otherHostVolumn=[dict[@"otherHostVolumn"] isKindOfClass:[NSNull class]]?0:[dict[@"otherHostVolumn"] intValue];

model.otherPresenterUserId=[dict[@"otherPresenterUserId"] isKindOfClass:[NSNull class]]?0:[dict[@"otherPresenterUserId"] longLongValue];


//getFromDict对象转换  
model.pkResultRoom=[ApiPkResultRoomModel getFromDict:dict[@"pkResultRoom"]];

model.processEndTime=[dict[@"processEndTime"] isKindOfClass:[NSNull class]]?0:[dict[@"processEndTime"] longLongValue];

model.rdTitle=[dict[@"rdTitle"] isKindOfClass:[NSNull class]]?@"":dict[@"rdTitle"];

model.otherAvatar=[dict[@"otherAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"otherAvatar"];

model.pkMillis=[dict[@"pkMillis"] isKindOfClass:[NSNull class]]?0:[dict[@"pkMillis"] longLongValue];

model.otherAge=[dict[@"otherAge"] isKindOfClass:[NSNull class]]?0:[dict[@"otherAge"] intValue];

model.otherRoomID=[dict[@"otherRoomID"] isKindOfClass:[NSNull class]]?0:[dict[@"otherRoomID"] longLongValue];

model.pkType=[dict[@"pkType"] isKindOfClass:[NSNull class]]?0:[dict[@"pkType"] intValue];


 return model;
}

 +(void)cloneObj:(VoicePkVOModel*) source target:(VoicePkVOModel*)target
{

target.otherAnchorId=source.otherAnchorId;

target.otherShowId=source.otherShowId;

target.otherTotalVotes=source.otherTotalVotes;

target.thisAge=source.thisAge;

target.otherSex=source.otherSex;

target.otherAnchorVotes=source.otherAnchorVotes;

        if(source.thisSenders==nil)
        {
//            target.thisSenders=nil;
        }else
        {
            target.thisSenders=[[NSMutableArray alloc] init];
            for(int i=0;i<source.thisSenders.count;i++)
            {
		  [target.thisSenders addObject:[[PkGiftSenderModel alloc]init]];
            [PkGiftSenderModel cloneObj:source.thisSenders[i] target:target.thisSenders[i]];
            }
        }


        if(source.otherSenders==nil)
        {
//            target.otherSenders=nil;
        }else
        {
            target.otherSenders=[[NSMutableArray alloc] init];
            for(int i=0;i<source.otherSenders.count;i++)
            {
		  [target.otherSenders addObject:[[PkGiftSenderModel alloc]init]];
            [PkGiftSenderModel cloneObj:source.otherSenders[i] target:target.otherSenders[i]];
            }
        }


target.pkCountdownMillis=source.pkCountdownMillis;

target.thisAvatarFrame=source.thisAvatarFrame;
        if(source.appStrickerVO==nil)
        {
//            target.appStrickerVO=nil;
        }else
        {
            [AppStrickerVOModel cloneObj:source.appStrickerVO target:target.appStrickerVO];
        }
        if(source.otherAppStrickerVO==nil)
        {
//            target.otherAppStrickerVO=nil;
        }else
        {
            [AppStrickerVOModel cloneObj:source.otherAppStrickerVO target:target.otherAppStrickerVO];
        }

target.thisAnchorId=source.thisAnchorId;

target.totalVotes=source.totalVotes;

target.thisShowId=source.thisShowId;

target.thisUsername=source.thisUsername;

        if(source.thisAssistans==nil)
        {
//            target.thisAssistans=nil;
        }else
        {
            target.thisAssistans=[[NSMutableArray alloc] init];
            for(int i=0;i<source.thisAssistans.count;i++)
            {
		  [target.thisAssistans addObject:[[PkUserVoiceAssistanModel alloc]init]];
            [PkUserVoiceAssistanModel cloneObj:source.thisAssistans[i] target:target.thisAssistans[i]];
            }
        }


target.hostVolumn=source.hostVolumn;

target.pkProcess=source.pkProcess;

target.thisSex=source.thisSex;

        if(source.otherAssistans==nil)
        {
//            target.otherAssistans=nil;
        }else
        {
            target.otherAssistans=[[NSMutableArray alloc] init];
            for(int i=0;i<source.otherAssistans.count;i++)
            {
		  [target.otherAssistans addObject:[[PkUserVoiceAssistanModel alloc]init]];
            [PkUserVoiceAssistanModel cloneObj:source.otherAssistans[i] target:target.otherAssistans[i]];
            }
        }


target.thisAvatar=source.thisAvatar;

target.anchorVotes=source.anchorVotes;

target.processEndMills=source.processEndMills;

target.thisPresenterUserId=source.thisPresenterUserId;

target.otherUsername=source.otherUsername;

target.otherAvatarFrame=source.otherAvatarFrame;

target.thisRoomID=source.thisRoomID;

target.otherHostVolumn=source.otherHostVolumn;

target.otherPresenterUserId=source.otherPresenterUserId;
        if(source.pkResultRoom==nil)
        {
//            target.pkResultRoom=nil;
        }else
        {
            [ApiPkResultRoomModel cloneObj:source.pkResultRoom target:target.pkResultRoom];
        }

target.processEndTime=source.processEndTime;

target.rdTitle=source.rdTitle;

target.otherAvatar=source.otherAvatar;

target.pkMillis=source.pkMillis;

target.otherAge=source.otherAge;

target.otherRoomID=source.otherRoomID;

target.pkType=source.pkType;

}

@end

