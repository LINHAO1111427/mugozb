//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiUserInfoModel.h"




 @implementation ApiUserInfoModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"anchorGrade"]=@(_anchorGrade);

dict[@"linkOtherStatus"]=@(_linkOtherStatus);

dict[@"joinRoomShow"]=@(_joinRoomShow);

dict[@"groupId"]=@(_groupId);

dict[@"onlineStatus"]=@(_onlineStatus);

dict[@"nobleName"]=_nobleName;

dict[@"noTalking"]=@(_noTalking);

dict[@"pid"]=@(_pid);

dict[@"nobleGradeImg"]=_nobleGradeImg;

dict[@"userSetOnlineStatus"]=@(_userSetOnlineStatus);

dict[@"roomId"]=@(_roomId);

dict[@"oooTwoClassifyId"]=@(_oooTwoClassifyId);

dict[@"otherUid"]=@(_otherUid);

dict[@"broadCast"]=@(_broadCast);

dict[@"isYouthModel"]=@(_isYouthModel);

dict[@"constellation"]=_constellation;

dict[@"province"]=_province;

dict[@"isTone"]=@(_isTone);

dict[@"iszombie"]=@(_iszombie);

dict[@"isFirstRecharge"]=@(_isFirstRecharge);

dict[@"roomIsVideo"]=@(_roomIsVideo);

dict[@"lat"]=@(_lat);

dict[@"liveStatus"]=@(_liveStatus);

dict[@"roomType"]=@(_roomType);

dict[@"height"]=@(_height);

dict[@"canLinkMic"]=@(_canLinkMic);

dict[@"gsRoomId"]=@(_gsRoomId);

dict[@"lng"]=@(_lng);

dict[@"userGrade"]=@(_userGrade);

dict[@"iszombiep"]=@(_iszombiep);

dict[@"weight"]=@(_weight);

dict[@"whetherEnablePositioningShow"]=@(_whetherEnablePositioningShow);

dict[@"roomPkSid"]=@(_roomPkSid);

dict[@"anchorGradeImg"]=_anchorGradeImg;

dict[@"sanwei"]=_sanwei;

dict[@"voiceStatus"]=@(_voiceStatus);

dict[@"wealthGrade"]=@(_wealthGrade);

dict[@"lastOffLineTime"]=[HttpClient stringFromDate:_lastOffLineTime];

dict[@"managerCoId"]=@(_managerCoId);

dict[@"userType"]=@(_userType);

dict[@"isSvip"]=@(_isSvip);

dict[@"poster"]=_poster;

dict[@"coin"]=@(_coin);

dict[@"status"]=@(_status);

dict[@"birthday"]=_birthday;

dict[@"agentId"]=@(_agentId);

dict[@"isPush"]=@(_isPush);

dict[@"role"]=@(_role);

dict[@"city"]=_city;

dict[@"signature"]=_signature;

dict[@"liveType"]=@(_liveType);

dict[@"userGradeImg"]=_userGradeImg;

dict[@"videoCoin"]=@(_videoCoin);

dict[@"liveThumb"]=_liveThumb;

dict[@"nobleMedal"]=_nobleMedal;

dict[@"linkOtherSid"]=@(_linkOtherSid);

dict[@"readShortVideoNumber"]=@(_readShortVideoNumber);

dict[@"showId"]=_showId;

dict[@"chargeShow"]=@(_chargeShow);

dict[@"isAnchorAuth"]=@(_isAnchorAuth);

dict[@"voiceCoin"]=@(_voiceCoin);

dict[@"oooLiveStatus"]=@(_oooLiveStatus);

dict[@"charmPoint"]=@(_charmPoint);

dict[@"otherRoomId"]=@(_otherRoomId);

dict[@"wealthGradeImg"]=_wealthGradeImg;

dict[@"address"]=_address;

dict[@"hideDistance"]=@(_hideDistance);

dict[@"charmGradeImg"]=_charmGradeImg;

dict[@"sex"]=@(_sex);

dict[@"mobile"]=_mobile;

dict[@"charmGrade"]=@(_charmGrade);

dict[@"consumption"]=@(_consumption);

dict[@"avatar"]=_avatar;

dict[@"managerId"]=@(_managerId);

dict[@"mobileLength"]=@(_mobileLength);

dict[@"userId"]=@(_userId);

dict[@"giftGlobalBroadcast"]=@(_giftGlobalBroadcast);

dict[@"vocation"]=_vocation;

dict[@"nobleAvatarFrame"]=_nobleAvatarFrame;

dict[@"createTime"]=_createTime;

dict[@"headNo"]=@(_headNo);

dict[@"votes"]=@(_votes);

dict[@"isNotDisturb"]=@(_isNotDisturb);

dict[@"nobleGrade"]=@(_nobleGrade);

dict[@"isPid"]=@(_isPid);

dict[@"age"]=@(_age);

dict[@"goodnum"]=_goodnum;

dict[@"devoteShow"]=@(_devoteShow);

dict[@"username"]=_username;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUserInfoModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiUserInfoModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiUserInfoModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiUserInfoModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiUserInfoModel* sumMdl=[ApiUserInfoModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiUserInfoModel*)getFromDict:(NSDictionary*)dict
{
ApiUserInfoModel* model=[[ApiUserInfoModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
    
model.anchorGrade=[dict[@"anchorGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorGrade"] intValue];

model.linkOtherStatus=[dict[@"linkOtherStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"linkOtherStatus"] intValue];

model.joinRoomShow=[dict[@"joinRoomShow"] isKindOfClass:[NSNull class]]?0:[dict[@"joinRoomShow"] intValue];

model.groupId=[dict[@"groupId"] isKindOfClass:[NSNull class]]?0:[dict[@"groupId"] longLongValue];

model.onlineStatus=[dict[@"onlineStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"onlineStatus"] intValue];

model.nobleName=[dict[@"nobleName"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleName"];

model.noTalking=[dict[@"noTalking"] isKindOfClass:[NSNull class]]?0:[dict[@"noTalking"] intValue];

model.pid=[dict[@"pid"] isKindOfClass:[NSNull class]]?0:[dict[@"pid"] longLongValue];

model.nobleGradeImg=[dict[@"nobleGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleGradeImg"];

model.userSetOnlineStatus=[dict[@"userSetOnlineStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"userSetOnlineStatus"] intValue];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];

model.oooTwoClassifyId=[dict[@"oooTwoClassifyId"] isKindOfClass:[NSNull class]]?0:[dict[@"oooTwoClassifyId"] longLongValue];

model.otherUid=[dict[@"otherUid"] isKindOfClass:[NSNull class]]?0:[dict[@"otherUid"] longLongValue];

model.broadCast=[dict[@"broadCast"] isKindOfClass:[NSNull class]]?0:[dict[@"broadCast"] intValue];

model.isYouthModel=[dict[@"isYouthModel"] isKindOfClass:[NSNull class]]?0:[dict[@"isYouthModel"] intValue];

model.constellation=[dict[@"constellation"] isKindOfClass:[NSNull class]]?@"":dict[@"constellation"];

model.province=[dict[@"province"] isKindOfClass:[NSNull class]]?@"":dict[@"province"];

model.isTone=[dict[@"isTone"] isKindOfClass:[NSNull class]]?0:[dict[@"isTone"] intValue];

model.iszombie=[dict[@"iszombie"] isKindOfClass:[NSNull class]]?0:[dict[@"iszombie"] intValue];

model.isFirstRecharge=[dict[@"isFirstRecharge"] isKindOfClass:[NSNull class]]?0:[dict[@"isFirstRecharge"] intValue];

model.roomIsVideo=[dict[@"roomIsVideo"] isKindOfClass:[NSNull class]]?0:[dict[@"roomIsVideo"] intValue];

model.lat=[dict[@"lat"] isKindOfClass:[NSNull class]]?0:[dict[@"lat"] doubleValue];

model.liveStatus=[dict[@"liveStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"liveStatus"] intValue];

model.roomType=[dict[@"roomType"] isKindOfClass:[NSNull class]]?0:[dict[@"roomType"] intValue];

model.height=[dict[@"height"] isKindOfClass:[NSNull class]]?0:[dict[@"height"] intValue];

model.canLinkMic=[dict[@"canLinkMic"] isKindOfClass:[NSNull class]]?0:[dict[@"canLinkMic"] intValue];

model.gsRoomId=[dict[@"gsRoomId"] isKindOfClass:[NSNull class]]?0:[dict[@"gsRoomId"] longLongValue];

model.lng=[dict[@"lng"] isKindOfClass:[NSNull class]]?0:[dict[@"lng"] doubleValue];

model.userGrade=[dict[@"userGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"userGrade"] intValue];

model.iszombiep=[dict[@"iszombiep"] isKindOfClass:[NSNull class]]?0:[dict[@"iszombiep"] intValue];

model.weight=[dict[@"weight"] isKindOfClass:[NSNull class]]?0:[dict[@"weight"] doubleValue];

model.whetherEnablePositioningShow=[dict[@"whetherEnablePositioningShow"] isKindOfClass:[NSNull class]]?0:[dict[@"whetherEnablePositioningShow"] intValue];

model.roomPkSid=[dict[@"roomPkSid"] isKindOfClass:[NSNull class]]?0:[dict[@"roomPkSid"] longLongValue];

model.anchorGradeImg=[dict[@"anchorGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorGradeImg"];

model.sanwei=[dict[@"sanwei"] isKindOfClass:[NSNull class]]?@"":dict[@"sanwei"];

model.voiceStatus=[dict[@"voiceStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"voiceStatus"] intValue];

model.wealthGrade=[dict[@"wealthGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"wealthGrade"] intValue];


{
NSString *strDate= dict[@"lastOffLineTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.lastOffLineTime=date;
    }
}

model.managerCoId=[dict[@"managerCoId"] isKindOfClass:[NSNull class]]?0:[dict[@"managerCoId"] longLongValue];

model.userType=[dict[@"userType"] isKindOfClass:[NSNull class]]?0:[dict[@"userType"] intValue];

model.isSvip=[dict[@"isSvip"] isKindOfClass:[NSNull class]]?0:[dict[@"isSvip"] intValue];

model.poster=[dict[@"poster"] isKindOfClass:[NSNull class]]?@"":dict[@"poster"];

model.coin=[dict[@"coin"] isKindOfClass:[NSNull class]]?0:[dict[@"coin"] doubleValue];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];

model.birthday=[dict[@"birthday"] isKindOfClass:[NSNull class]]?@"":dict[@"birthday"];

model.agentId=[dict[@"agentId"] isKindOfClass:[NSNull class]]?0:[dict[@"agentId"] longLongValue];

model.isPush=[dict[@"isPush"] isKindOfClass:[NSNull class]]?0:[dict[@"isPush"] intValue];

model.role=[dict[@"role"] isKindOfClass:[NSNull class]]?0:[dict[@"role"] intValue];

model.city=[dict[@"city"] isKindOfClass:[NSNull class]]?@"":dict[@"city"];

model.signature=[dict[@"signature"] isKindOfClass:[NSNull class]]?@"":dict[@"signature"];

model.liveType=[dict[@"liveType"] isKindOfClass:[NSNull class]]?0:[dict[@"liveType"] intValue];

model.userGradeImg=[dict[@"userGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"userGradeImg"];

model.videoCoin=[dict[@"videoCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"videoCoin"] doubleValue];

model.liveThumb=[dict[@"liveThumb"] isKindOfClass:[NSNull class]]?@"":dict[@"liveThumb"];

model.nobleMedal=[dict[@"nobleMedal"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleMedal"];

model.linkOtherSid=[dict[@"linkOtherSid"] isKindOfClass:[NSNull class]]?0:[dict[@"linkOtherSid"] longLongValue];

model.readShortVideoNumber=[dict[@"readShortVideoNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"readShortVideoNumber"] intValue];

model.showId=[dict[@"showId"] isKindOfClass:[NSNull class]]?@"":dict[@"showId"];

model.chargeShow=[dict[@"chargeShow"] isKindOfClass:[NSNull class]]?0:[dict[@"chargeShow"] intValue];

model.isAnchorAuth=[dict[@"isAnchorAuth"] isKindOfClass:[NSNull class]]?0:[dict[@"isAnchorAuth"] intValue];

model.voiceCoin=[dict[@"voiceCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"voiceCoin"] doubleValue];

model.oooLiveStatus=[dict[@"oooLiveStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"oooLiveStatus"] intValue];

model.charmPoint=[dict[@"charmPoint"] isKindOfClass:[NSNull class]]?0:[dict[@"charmPoint"] intValue];

model.otherRoomId=[dict[@"otherRoomId"] isKindOfClass:[NSNull class]]?0:[dict[@"otherRoomId"] longLongValue];

model.wealthGradeImg=[dict[@"wealthGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"wealthGradeImg"];

model.address=[dict[@"address"] isKindOfClass:[NSNull class]]?@"":dict[@"address"];

model.hideDistance=[dict[@"hideDistance"] isKindOfClass:[NSNull class]]?0:[dict[@"hideDistance"] intValue];

model.charmGradeImg=[dict[@"charmGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"charmGradeImg"];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.mobile=[dict[@"mobile"] isKindOfClass:[NSNull class]]?@"":dict[@"mobile"];

model.charmGrade=[dict[@"charmGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"charmGrade"] intValue];

model.consumption=[dict[@"consumption"] isKindOfClass:[NSNull class]]?0:[dict[@"consumption"] doubleValue];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.managerId=[dict[@"managerId"] isKindOfClass:[NSNull class]]?0:[dict[@"managerId"] longLongValue];

model.mobileLength=[dict[@"mobileLength"] isKindOfClass:[NSNull class]]?0:[dict[@"mobileLength"] intValue];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.giftGlobalBroadcast=[dict[@"giftGlobalBroadcast"] isKindOfClass:[NSNull class]]?0:[dict[@"giftGlobalBroadcast"] intValue];

model.vocation=[dict[@"vocation"] isKindOfClass:[NSNull class]]?@"":dict[@"vocation"];

model.nobleAvatarFrame=[dict[@"nobleAvatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleAvatarFrame"];

model.createTime=[dict[@"createTime"] isKindOfClass:[NSNull class]]?@"":dict[@"createTime"];

model.headNo=[dict[@"headNo"] isKindOfClass:[NSNull class]]?0:[dict[@"headNo"] longLongValue];

model.votes=[dict[@"votes"] isKindOfClass:[NSNull class]]?0:[dict[@"votes"] doubleValue];

model.isNotDisturb=[dict[@"isNotDisturb"] isKindOfClass:[NSNull class]]?0:[dict[@"isNotDisturb"] intValue];

model.nobleGrade=[dict[@"nobleGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"nobleGrade"] intValue];

model.isPid=[dict[@"isPid"] isKindOfClass:[NSNull class]]?0:[dict[@"isPid"] intValue];

model.age=[dict[@"age"] isKindOfClass:[NSNull class]]?0:[dict[@"age"] intValue];

model.goodnum=[dict[@"goodnum"] isKindOfClass:[NSNull class]]?@"":dict[@"goodnum"];

model.devoteShow=[dict[@"devoteShow"] isKindOfClass:[NSNull class]]?0:[dict[@"devoteShow"] intValue];

model.username=[dict[@"username"] isKindOfClass:[NSNull class]]?@"":dict[@"username"];


 return model;
}

 +(void)cloneObj:(ApiUserInfoModel*) source target:(ApiUserInfoModel*)target
{

target.anchorGrade=source.anchorGrade;

target.linkOtherStatus=source.linkOtherStatus;

target.joinRoomShow=source.joinRoomShow;

target.groupId=source.groupId;

target.onlineStatus=source.onlineStatus;

target.nobleName=source.nobleName;

target.noTalking=source.noTalking;

target.pid=source.pid;

target.nobleGradeImg=source.nobleGradeImg;

target.userSetOnlineStatus=source.userSetOnlineStatus;

target.roomId=source.roomId;

target.oooTwoClassifyId=source.oooTwoClassifyId;

target.otherUid=source.otherUid;

target.broadCast=source.broadCast;

target.isYouthModel=source.isYouthModel;

target.constellation=source.constellation;

target.province=source.province;

target.isTone=source.isTone;

target.iszombie=source.iszombie;

target.isFirstRecharge=source.isFirstRecharge;

target.roomIsVideo=source.roomIsVideo;

target.lat=source.lat;

target.liveStatus=source.liveStatus;

target.roomType=source.roomType;

target.height=source.height;

target.canLinkMic=source.canLinkMic;

target.gsRoomId=source.gsRoomId;

target.lng=source.lng;

target.userGrade=source.userGrade;

target.iszombiep=source.iszombiep;

target.weight=source.weight;

target.whetherEnablePositioningShow=source.whetherEnablePositioningShow;

target.roomPkSid=source.roomPkSid;

target.anchorGradeImg=source.anchorGradeImg;

target.sanwei=source.sanwei;

target.voiceStatus=source.voiceStatus;

target.wealthGrade=source.wealthGrade;

target.lastOffLineTime=source.lastOffLineTime;

target.managerCoId=source.managerCoId;

target.userType=source.userType;

target.isSvip=source.isSvip;

target.poster=source.poster;

target.coin=source.coin;

target.status=source.status;

target.birthday=source.birthday;

target.agentId=source.agentId;

target.isPush=source.isPush;

target.role=source.role;

target.city=source.city;

target.signature=source.signature;

target.liveType=source.liveType;

target.userGradeImg=source.userGradeImg;

target.videoCoin=source.videoCoin;

target.liveThumb=source.liveThumb;

target.nobleMedal=source.nobleMedal;

target.linkOtherSid=source.linkOtherSid;

target.readShortVideoNumber=source.readShortVideoNumber;

target.showId=source.showId;

target.chargeShow=source.chargeShow;

target.isAnchorAuth=source.isAnchorAuth;

target.voiceCoin=source.voiceCoin;

target.oooLiveStatus=source.oooLiveStatus;

target.charmPoint=source.charmPoint;

target.otherRoomId=source.otherRoomId;

target.wealthGradeImg=source.wealthGradeImg;

target.address=source.address;

target.hideDistance=source.hideDistance;

target.charmGradeImg=source.charmGradeImg;

target.sex=source.sex;

target.mobile=source.mobile;

target.charmGrade=source.charmGrade;

target.consumption=source.consumption;

target.avatar=source.avatar;

target.managerId=source.managerId;

target.mobileLength=source.mobileLength;

target.userId=source.userId;

target.giftGlobalBroadcast=source.giftGlobalBroadcast;

target.vocation=source.vocation;

target.nobleAvatarFrame=source.nobleAvatarFrame;

target.createTime=source.createTime;

target.headNo=source.headNo;

target.votes=source.votes;

target.isNotDisturb=source.isNotDisturb;

target.nobleGrade=source.nobleGrade;

target.isPid=source.isPid;

target.age=source.age;

target.goodnum=source.goodnum;

target.devoteShow=source.devoteShow;

target.username=source.username;

}

@end

