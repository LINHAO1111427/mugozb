//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppJoinRoomVOModel.h"
#import "VoicePkVOModel.h"
#import "OneRedPacketVOModel.h"
#import "ApiUserBasicInfoModel.h"
#import "ApiUsersVoiceAssistanModel.h"
#import "AppShareConfigModel.h"




 @implementation AppJoinRoomVOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"voicePkVO" : [VoicePkVOModel class],@"oneRedPacketVO" : [OneRedPacketVOModel class],@"userList" : [ApiUserBasicInfoModel class],@"assistanList" : [ApiUsersVoiceAssistanModel class],@"share" : [AppShareConfigModel class],@"presenterAssistant" : [ApiUsersVoiceAssistanModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"otherLiveThumb"]=_otherLiveThumb;

dict[@"carName"]=_carName;

dict[@"voicePkVO"]=[_voicePkVO modelToJSONObject];

dict[@"currVotesPk"]=@(_currVotesPk);

dict[@"watchNumber"]=@(_watchNumber);

dict[@"nobleName"]=_nobleName;

dict[@"anchorAge"]=@(_anchorAge);

dict[@"freeWatchTime"]=@(_freeWatchTime);

dict[@"nobleGradeImg"]=_nobleGradeImg;

dict[@"oneRedPacketVO"]=[_oneRedPacketVO modelToJSONObject];

dict[@"roomId"]=@(_roomId);

dict[@"guardUsersType"]=@(_guardUsersType);

dict[@"anchorNobleGradeImg"]=_anchorNobleGradeImg;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_userList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ApiUserBasicInfoModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"userList"]=list;
}//end

dict[@"liveStatus"]=@(_liveStatus);

dict[@"roomType"]=@(_roomType);

dict[@"roomTotalVotes"]=@(_roomTotalVotes);

dict[@"ismic"]=@(_ismic);

dict[@"pkProcess"]=@(_pkProcess);

dict[@"anchorNobleMedal"]=_anchorNobleMedal;

dict[@"noticeMsg"]=_noticeMsg;

dict[@"liveFunction"]=@(_liveFunction);

dict[@"anchorNobleAvatarFrame"]=_anchorNobleAvatarFrame;

dict[@"isFans"]=@(_isFans);

dict[@"roomTypeName"]=_roomTypeName;

dict[@"fromVotesPk"]=@(_fromVotesPk);

dict[@"anchorId"]=@(_anchorId);

dict[@"isSh"]=@(_isSh);

dict[@"isWin"]=@(_isWin);

dict[@"onOffState"]=@(_onOffState);

dict[@"anchorGradeImg"]=_anchorGradeImg;

dict[@"sourceType"]=@(_sourceType);

dict[@"roomTypeVal"]=_roomTypeVal;

dict[@"guardNumber"]=@(_guardNumber);

dict[@"gzdmPrivilege"]=@(_gzdmPrivilege);

dict[@"pkTime"]=@(_pkTime);

dict[@"role"]=@(_role);

dict[@"anchorWealthGradeImg"]=_anchorWealthGradeImg;

dict[@"liveType"]=@(_liveType);

dict[@"userAvatar"]=_userAvatar;

dict[@"userGradeImg"]=_userGradeImg;

dict[@"carThumb"]=_carThumb;

dict[@"liveThumb"]=_liveThumb;

dict[@"nobleMedal"]=_nobleMedal;

dict[@"title"]=_title;

dict[@"anchorName"]=_anchorName;

dict[@"content"]=_content;

dict[@"voiceThumb"]=_voiceThumb;

dict[@"shopLiveBanner"]=_shopLiveBanner;

dict[@"otherRoomType"]=@(_otherRoomType);

dict[@"anchorGoodNum"]=_anchorGoodNum;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_assistanList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ApiUsersVoiceAssistanModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"assistanList"]=list;
}//end

dict[@"share"]=[_share modelToJSONObject];

dict[@"startTime"]=@(_startTime);

dict[@"channelId"]=@(_channelId);

dict[@"otherRoomId"]=@(_otherRoomId);

dict[@"notice"]=_notice;

dict[@"wealthGradeImg"]=_wealthGradeImg;

dict[@"anchorAvatar"]=_anchorAvatar;

dict[@"userGoodNum"]=_userGoodNum;

dict[@"userName"]=_userName;

dict[@"presenterAssistant"]=[_presenterAssistant modelToJSONObject];

dict[@"liveLockStatus"]=@(_liveLockStatus);

dict[@"anchorSex"]=@(_anchorSex);

dict[@"isFollow"]=@(_isFollow);

dict[@"nobleAvatarFrame"]=_nobleAvatarFrame;

dict[@"pull"]=_pull;

dict[@"showid"]=_showid;

dict[@"carSwf"]=_carSwf;

dict[@"otherPull"]=_otherPull;

dict[@"votes"]=@(_votes);

dict[@"nobleGrade"]=@(_nobleGrade);

dict[@"carSwftime"]=_carSwftime;

dict[@"pkType"]=@(_pkType);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppJoinRoomVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppJoinRoomVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppJoinRoomVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppJoinRoomVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppJoinRoomVOModel* sumMdl=[AppJoinRoomVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppJoinRoomVOModel*)getFromDict:(NSDictionary*)dict
{
AppJoinRoomVOModel* model=[[AppJoinRoomVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.otherLiveThumb=[dict[@"otherLiveThumb"] isKindOfClass:[NSNull class]]?@"":dict[@"otherLiveThumb"];

model.carName=[dict[@"carName"] isKindOfClass:[NSNull class]]?@"":dict[@"carName"];


//getFromDict对象转换  
model.voicePkVO=[VoicePkVOModel getFromDict:dict[@"voicePkVO"]];

model.currVotesPk=[dict[@"currVotesPk"] isKindOfClass:[NSNull class]]?0:[dict[@"currVotesPk"] intValue];

model.watchNumber=[dict[@"watchNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"watchNumber"] intValue];

model.nobleName=[dict[@"nobleName"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleName"];

model.anchorAge=[dict[@"anchorAge"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorAge"] intValue];

model.freeWatchTime=[dict[@"freeWatchTime"] isKindOfClass:[NSNull class]]?0:[dict[@"freeWatchTime"] intValue];

model.nobleGradeImg=[dict[@"nobleGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleGradeImg"];


//getFromDict对象转换  
model.oneRedPacketVO=[OneRedPacketVOModel getFromDict:dict[@"oneRedPacketVO"]];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];

model.guardUsersType=[dict[@"guardUsersType"] isKindOfClass:[NSNull class]]?0:[dict[@"guardUsersType"] intValue];

model.anchorNobleGradeImg=[dict[@"anchorNobleGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorNobleGradeImg"];

model.userList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"userList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiUserBasicInfoModel* sumMdl=[ApiUserBasicInfoModel getFromDict:subDic];
[model.userList addObject:sumMdl];

}
}

}

model.liveStatus=[dict[@"liveStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"liveStatus"] intValue];

model.roomType=[dict[@"roomType"] isKindOfClass:[NSNull class]]?0:[dict[@"roomType"] intValue];

model.roomTotalVotes=[dict[@"roomTotalVotes"] isKindOfClass:[NSNull class]]?0:[dict[@"roomTotalVotes"] doubleValue];

model.ismic=[dict[@"ismic"] isKindOfClass:[NSNull class]]?0:[dict[@"ismic"] intValue];

model.pkProcess=[dict[@"pkProcess"] isKindOfClass:[NSNull class]]?0:[dict[@"pkProcess"] intValue];

model.anchorNobleMedal=[dict[@"anchorNobleMedal"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorNobleMedal"];

model.noticeMsg=[dict[@"noticeMsg"] isKindOfClass:[NSNull class]]?@"":dict[@"noticeMsg"];

model.liveFunction=[dict[@"liveFunction"] isKindOfClass:[NSNull class]]?0:[dict[@"liveFunction"] intValue];

model.anchorNobleAvatarFrame=[dict[@"anchorNobleAvatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorNobleAvatarFrame"];

model.isFans=[dict[@"isFans"] isKindOfClass:[NSNull class]]?0:[dict[@"isFans"] intValue];

model.roomTypeName=[dict[@"roomTypeName"] isKindOfClass:[NSNull class]]?@"":dict[@"roomTypeName"];

model.fromVotesPk=[dict[@"fromVotesPk"] isKindOfClass:[NSNull class]]?0:[dict[@"fromVotesPk"] intValue];

model.anchorId=[dict[@"anchorId"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorId"] longLongValue];

model.isSh=[dict[@"isSh"] isKindOfClass:[NSNull class]]?0:[dict[@"isSh"] intValue];

model.isWin=[dict[@"isWin"] isKindOfClass:[NSNull class]]?0:[dict[@"isWin"] intValue];

model.onOffState=[dict[@"onOffState"] isKindOfClass:[NSNull class]]?0:[dict[@"onOffState"] intValue];

model.anchorGradeImg=[dict[@"anchorGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorGradeImg"];

model.sourceType=[dict[@"sourceType"] isKindOfClass:[NSNull class]]?0:[dict[@"sourceType"] intValue];

model.roomTypeVal=[dict[@"roomTypeVal"] isKindOfClass:[NSNull class]]?@"":dict[@"roomTypeVal"];

model.guardNumber=[dict[@"guardNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"guardNumber"] intValue];

model.gzdmPrivilege=[dict[@"gzdmPrivilege"] isKindOfClass:[NSNull class]]?0:[dict[@"gzdmPrivilege"] intValue];

model.pkTime=[dict[@"pkTime"] isKindOfClass:[NSNull class]]?0:[dict[@"pkTime"] intValue];

model.role=[dict[@"role"] isKindOfClass:[NSNull class]]?0:[dict[@"role"] intValue];

model.anchorWealthGradeImg=[dict[@"anchorWealthGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorWealthGradeImg"];

model.liveType=[dict[@"liveType"] isKindOfClass:[NSNull class]]?0:[dict[@"liveType"] intValue];

model.userAvatar=[dict[@"userAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"userAvatar"];

model.userGradeImg=[dict[@"userGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"userGradeImg"];

model.carThumb=[dict[@"carThumb"] isKindOfClass:[NSNull class]]?@"":dict[@"carThumb"];

model.liveThumb=[dict[@"liveThumb"] isKindOfClass:[NSNull class]]?@"":dict[@"liveThumb"];

model.nobleMedal=[dict[@"nobleMedal"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleMedal"];

model.title=[dict[@"title"] isKindOfClass:[NSNull class]]?@"":dict[@"title"];

model.anchorName=[dict[@"anchorName"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorName"];

model.content=[dict[@"content"] isKindOfClass:[NSNull class]]?@"":dict[@"content"];

model.voiceThumb=[dict[@"voiceThumb"] isKindOfClass:[NSNull class]]?@"":dict[@"voiceThumb"];

model.shopLiveBanner=[dict[@"shopLiveBanner"] isKindOfClass:[NSNull class]]?@"":dict[@"shopLiveBanner"];

model.otherRoomType=[dict[@"otherRoomType"] isKindOfClass:[NSNull class]]?0:[dict[@"otherRoomType"] intValue];

model.anchorGoodNum=[dict[@"anchorGoodNum"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorGoodNum"];

model.assistanList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"assistanList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiUsersVoiceAssistanModel* sumMdl=[ApiUsersVoiceAssistanModel getFromDict:subDic];
[model.assistanList addObject:sumMdl];

}
}

}


//getFromDict对象转换  
model.share=[AppShareConfigModel getFromDict:dict[@"share"]];

model.startTime=[dict[@"startTime"] isKindOfClass:[NSNull class]]?0:[dict[@"startTime"] longLongValue];

model.channelId=[dict[@"channelId"] isKindOfClass:[NSNull class]]?0:[dict[@"channelId"] longLongValue];

model.otherRoomId=[dict[@"otherRoomId"] isKindOfClass:[NSNull class]]?0:[dict[@"otherRoomId"] longLongValue];

model.notice=[dict[@"notice"] isKindOfClass:[NSNull class]]?@"":dict[@"notice"];

model.wealthGradeImg=[dict[@"wealthGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"wealthGradeImg"];

model.anchorAvatar=[dict[@"anchorAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorAvatar"];

model.userGoodNum=[dict[@"userGoodNum"] isKindOfClass:[NSNull class]]?@"":dict[@"userGoodNum"];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];


//getFromDict对象转换  
model.presenterAssistant=[ApiUsersVoiceAssistanModel getFromDict:dict[@"presenterAssistant"]];

model.liveLockStatus=[dict[@"liveLockStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"liveLockStatus"] intValue];

model.anchorSex=[dict[@"anchorSex"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorSex"] intValue];

model.isFollow=[dict[@"isFollow"] isKindOfClass:[NSNull class]]?0:[dict[@"isFollow"] intValue];

model.nobleAvatarFrame=[dict[@"nobleAvatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleAvatarFrame"];

model.pull=[dict[@"pull"] isKindOfClass:[NSNull class]]?@"":dict[@"pull"];

model.showid=[dict[@"showid"] isKindOfClass:[NSNull class]]?@"":dict[@"showid"];

model.carSwf=[dict[@"carSwf"] isKindOfClass:[NSNull class]]?@"":dict[@"carSwf"];

model.otherPull=[dict[@"otherPull"] isKindOfClass:[NSNull class]]?@"":dict[@"otherPull"];

model.votes=[dict[@"votes"] isKindOfClass:[NSNull class]]?0:[dict[@"votes"] doubleValue];

model.nobleGrade=[dict[@"nobleGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"nobleGrade"] intValue];

model.carSwftime=[dict[@"carSwftime"] isKindOfClass:[NSNull class]]?@"":dict[@"carSwftime"];

model.pkType=[dict[@"pkType"] isKindOfClass:[NSNull class]]?0:[dict[@"pkType"] intValue];


 return model;
}

 +(void)cloneObj:(AppJoinRoomVOModel*) source target:(AppJoinRoomVOModel*)target
{

target.otherLiveThumb=source.otherLiveThumb;

target.carName=source.carName;
        if(source.voicePkVO==nil)
        {
//            target.voicePkVO=nil;
        }else
        {
            [VoicePkVOModel cloneObj:source.voicePkVO target:target.voicePkVO];
        }

target.currVotesPk=source.currVotesPk;

target.watchNumber=source.watchNumber;

target.nobleName=source.nobleName;

target.anchorAge=source.anchorAge;

target.freeWatchTime=source.freeWatchTime;

target.nobleGradeImg=source.nobleGradeImg;
        if(source.oneRedPacketVO==nil)
        {
//            target.oneRedPacketVO=nil;
        }else
        {
            [OneRedPacketVOModel cloneObj:source.oneRedPacketVO target:target.oneRedPacketVO];
        }

target.roomId=source.roomId;

target.guardUsersType=source.guardUsersType;

target.anchorNobleGradeImg=source.anchorNobleGradeImg;

        if(source.userList==nil)
        {
//            target.userList=nil;
        }else
        {
            target.userList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.userList.count;i++)
            {
		  [target.userList addObject:[[ApiUserBasicInfoModel alloc]init]];
            [ApiUserBasicInfoModel cloneObj:source.userList[i] target:target.userList[i]];
            }
        }


target.liveStatus=source.liveStatus;

target.roomType=source.roomType;

target.roomTotalVotes=source.roomTotalVotes;

target.ismic=source.ismic;

target.pkProcess=source.pkProcess;

target.anchorNobleMedal=source.anchorNobleMedal;

target.noticeMsg=source.noticeMsg;

target.liveFunction=source.liveFunction;

target.anchorNobleAvatarFrame=source.anchorNobleAvatarFrame;

target.isFans=source.isFans;

target.roomTypeName=source.roomTypeName;

target.fromVotesPk=source.fromVotesPk;

target.anchorId=source.anchorId;

target.isSh=source.isSh;

target.isWin=source.isWin;

target.onOffState=source.onOffState;

target.anchorGradeImg=source.anchorGradeImg;

target.sourceType=source.sourceType;

target.roomTypeVal=source.roomTypeVal;

target.guardNumber=source.guardNumber;

target.gzdmPrivilege=source.gzdmPrivilege;

target.pkTime=source.pkTime;

target.role=source.role;

target.anchorWealthGradeImg=source.anchorWealthGradeImg;

target.liveType=source.liveType;

target.userAvatar=source.userAvatar;

target.userGradeImg=source.userGradeImg;

target.carThumb=source.carThumb;

target.liveThumb=source.liveThumb;

target.nobleMedal=source.nobleMedal;

target.title=source.title;

target.anchorName=source.anchorName;

target.content=source.content;

target.voiceThumb=source.voiceThumb;

target.shopLiveBanner=source.shopLiveBanner;

target.otherRoomType=source.otherRoomType;

target.anchorGoodNum=source.anchorGoodNum;

        if(source.assistanList==nil)
        {
//            target.assistanList=nil;
        }else
        {
            target.assistanList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.assistanList.count;i++)
            {
		  [target.assistanList addObject:[[ApiUsersVoiceAssistanModel alloc]init]];
            [ApiUsersVoiceAssistanModel cloneObj:source.assistanList[i] target:target.assistanList[i]];
            }
        }

        if(source.share==nil)
        {
//            target.share=nil;
        }else
        {
            [AppShareConfigModel cloneObj:source.share target:target.share];
        }

target.startTime=source.startTime;

target.channelId=source.channelId;

target.otherRoomId=source.otherRoomId;

target.notice=source.notice;

target.wealthGradeImg=source.wealthGradeImg;

target.anchorAvatar=source.anchorAvatar;

target.userGoodNum=source.userGoodNum;

target.userName=source.userName;
        if(source.presenterAssistant==nil)
        {
//            target.presenterAssistant=nil;
        }else
        {
            [ApiUsersVoiceAssistanModel cloneObj:source.presenterAssistant target:target.presenterAssistant];
        }

target.liveLockStatus=source.liveLockStatus;

target.anchorSex=source.anchorSex;

target.isFollow=source.isFollow;

target.nobleAvatarFrame=source.nobleAvatarFrame;

target.pull=source.pull;

target.showid=source.showid;

target.carSwf=source.carSwf;

target.otherPull=source.otherPull;

target.votes=source.votes;

target.nobleGrade=source.nobleGrade;

target.carSwftime=source.carSwftime;

target.pkType=source.pkType;

}

@end

