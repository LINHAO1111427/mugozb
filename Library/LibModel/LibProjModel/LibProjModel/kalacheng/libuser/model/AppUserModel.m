//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppUserModel.h"




 @implementation AppUserModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"appVersion"]=_appVersion;

dict[@"joinRoomShow"]=@(_joinRoomShow);

dict[@"signCount"]=@(_signCount);

dict[@"onlineStatus"]=@(_onlineStatus);

dict[@"deviceId"]=_deviceId;

dict[@"pushPlatform"]=@(_pushPlatform);

dict[@"userSetOnlineStatus"]=@(_userSetOnlineStatus);

dict[@"userid"]=@(_userid);

dict[@"gsRoomType"]=@(_gsRoomType);

dict[@"score"]=@(_score);

dict[@"isYouthModel"]=@(_isYouthModel);

dict[@"password"]=_password;

dict[@"phoneModel"]=_phoneModel;

dict[@"constellation"]=_constellation;

dict[@"province"]=_province;

dict[@"isTone"]=@(_isTone);

dict[@"totalCash"]=@(_totalCash);

dict[@"smsRegion"]=_smsRegion;

dict[@"lastGameNum"]=@(_lastGameNum);

dict[@"ipaddr"]=_ipaddr;

dict[@"ishot"]=@(_ishot);

dict[@"liveStatus"]=@(_liveStatus);

dict[@"roomType"]=@(_roomType);

dict[@"height"]=@(_height);

dict[@"gsRoomId"]=@(_gsRoomId);

dict[@"zombieRatio"]=@(_zombieRatio);

dict[@"votestotal"]=@(_votestotal);

dict[@"lng"]=@(_lng);

dict[@"pushRegisterId"]=_pushRegisterId;

dict[@"userGrade"]=@(_userGrade);

dict[@"liveFunction"]=@(_liveFunction);

dict[@"openid"]=_openid;

dict[@"zombieMaxNum"]=@(_zombieMaxNum);

dict[@"iszombiep"]=@(_iszombiep);

dict[@"cityEdit"]=@(_cityEdit);

dict[@"guildId"]=@(_guildId);

dict[@"lastLoginDay"]=[HttpClient stringFromDate:_lastLoginDay];

dict[@"maxSignCount"]=@(_maxSignCount);

dict[@"totalCharge"]=@(_totalCharge);

dict[@"wealthGrade"]=@(_wealthGrade);

dict[@"lastOffLineTime"]=[HttpClient stringFromDate:_lastOffLineTime];

dict[@"poster"]=_poster;

dict[@"status"]=@(_status);

dict[@"role"]=@(_role);

dict[@"city"]=_city;

dict[@"signature"]=_signature;

dict[@"oooHomePageSortNo"]=@(_oooHomePageSortNo);

dict[@"awardLoginDay"]=@(_awardLoginDay);

dict[@"delFlag"]=@(_delFlag);

dict[@"readShortVideoNumber"]=@(_readShortVideoNumber);

dict[@"lastLoginIp"]=_lastLoginIp;

dict[@"chargeShow"]=@(_chargeShow);

dict[@"lockTime"]=[HttpClient stringFromDate:_lockTime];

dict[@"nickname"]=_nickname;

dict[@"userEmail"]=_userEmail;

dict[@"oooLiveStatus"]=@(_oooLiveStatus);

dict[@"regType"]=@(_regType);

dict[@"channelId"]=@(_channelId);

dict[@"charmPoint"]=@(_charmPoint);

dict[@"address"]=_address;

dict[@"salt"]=_salt;

dict[@"sex"]=@(_sex);

dict[@"phoneFirm"]=_phoneFirm;

dict[@"charmGrade"]=@(_charmGrade);

dict[@"avatar"]=_avatar;

dict[@"managerId"]=@(_managerId);

dict[@"vocation"]=_vocation;

dict[@"lastLoginTime"]=[HttpClient stringFromDate:_lastLoginTime];

dict[@"createTime"]=[HttpClient stringFromDate:_createTime];

dict[@"votes"]=@(_votes);

dict[@"youthPassword"]=_youthPassword;

dict[@"devoteShow"]=@(_devoteShow);

dict[@"voice"]=_voice;

dict[@"isRecommend"]=@(_isRecommend);

dict[@"isOOOAccount"]=@(_isOOOAccount);

dict[@"anchorGrade"]=@(_anchorGrade);

dict[@"groupId"]=@(_groupId);

dict[@"pid"]=@(_pid);

dict[@"optUserName"]=_optUserName;

dict[@"source"]=_source;

dict[@"appVersionCode"]=_appVersionCode;

dict[@"isJoinJg"]=@(_isJoinJg);

dict[@"oooTwoClassifyId"]=@(_oooTwoClassifyId);

dict[@"broadCast"]=@(_broadCast);

dict[@"totalAmountCash"]=@(_totalAmountCash);

dict[@"phoneSystem"]=_phoneSystem;

dict[@"iszombie"]=@(_iszombie);

dict[@"liveThumbs"]=_liveThumbs;

dict[@"lat"]=@(_lat);

dict[@"userUrl"]=_userUrl;

dict[@"registerIp"]=_registerIp;

dict[@"signTime"]=[HttpClient stringFromDate:_signTime];

dict[@"level"]=@(_level);

dict[@"issuper"]=@(_issuper);

dict[@"weight"]=@(_weight);

dict[@"whetherEnablePositioningShow"]=@(_whetherEnablePositioningShow);

dict[@"openLiveZombieNum"]=@(_openLiveZombieNum);

dict[@"isShowHomePage"]=@(_isShowHomePage);

dict[@"totalAmount"]=@(_totalAmount);

dict[@"sanwei"]=_sanwei;

dict[@"kickTime"]=@(_kickTime);

dict[@"voiceStatus"]=@(_voiceStatus);

dict[@"roomTypeVal"]=_roomTypeVal;

dict[@"voipToken"]=_voipToken;

dict[@"managerCoId"]=@(_managerCoId);

dict[@"userType"]=@(_userType);

dict[@"isSvip"]=@(_isSvip);

dict[@"userActivationKey"]=_userActivationKey;

dict[@"coin"]=@(_coin);

dict[@"birthday"]=_birthday;

dict[@"starId"]=@(_starId);

dict[@"agentId"]=@(_agentId);

dict[@"isPush"]=@(_isPush);

dict[@"unionid"]=_unionid;

dict[@"anchorPoint"]=@(_anchorPoint);

dict[@"loginType"]=_loginType;

dict[@"videoCoin"]=@(_videoCoin);

dict[@"liveThumb"]=_liveThumb;

dict[@"video"]=_video;

dict[@"isAnchorAuth"]=@(_isAnchorAuth);

dict[@"voiceCoin"]=@(_voiceCoin);

dict[@"isAutomatic"]=@(_isAutomatic);

dict[@"amount"]=@(_amount);

dict[@"phoneUuid"]=_phoneUuid;

dict[@"userPoint"]=@(_userPoint);

dict[@"hideDistance"]=@(_hideDistance);

dict[@"mobile"]=_mobile;

dict[@"updatePwdTime"]=[HttpClient stringFromDate:_updatePwdTime];

dict[@"videoImg"]=_videoImg;

dict[@"wechat"]=_wechat;

dict[@"consumption"]=@(_consumption);

dict[@"isLiveAccount"]=@(_isLiveAccount);

dict[@"portrait"]=_portrait;

dict[@"dealScalePlan"]=@(_dealScalePlan);

dict[@"lockReason"]=_lockReason;

dict[@"giftGlobalBroadcast"]=@(_giftGlobalBroadcast);

dict[@"headNo"]=@(_headNo);

dict[@"isrecord"]=@(_isrecord);

dict[@"inviteCode"]=_inviteCode;

dict[@"isNotDisturb"]=@(_isNotDisturb);

dict[@"nobleGrade"]=@(_nobleGrade);

dict[@"roomTitle"]=_roomTitle;

dict[@"goodnum"]=_goodnum;

dict[@"username"]=_username;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUserModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppUserModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppUserModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppUserModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppUserModel* sumMdl=[AppUserModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppUserModel*)getFromDict:(NSDictionary*)dict
{
AppUserModel* model=[[AppUserModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.appVersion=[dict[@"appVersion"] isKindOfClass:[NSNull class]]?@"":dict[@"appVersion"];

model.joinRoomShow=[dict[@"joinRoomShow"] isKindOfClass:[NSNull class]]?0:[dict[@"joinRoomShow"] intValue];

model.signCount=[dict[@"signCount"] isKindOfClass:[NSNull class]]?0:[dict[@"signCount"] intValue];

model.onlineStatus=[dict[@"onlineStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"onlineStatus"] intValue];

model.deviceId=[dict[@"deviceId"] isKindOfClass:[NSNull class]]?@"":dict[@"deviceId"];

model.pushPlatform=[dict[@"pushPlatform"] isKindOfClass:[NSNull class]]?0:[dict[@"pushPlatform"] intValue];

model.userSetOnlineStatus=[dict[@"userSetOnlineStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"userSetOnlineStatus"] intValue];

model.userid=[dict[@"userid"] isKindOfClass:[NSNull class]]?0:[dict[@"userid"] longLongValue];

model.gsRoomType=[dict[@"gsRoomType"] isKindOfClass:[NSNull class]]?0:[dict[@"gsRoomType"] intValue];

model.score=[dict[@"score"] isKindOfClass:[NSNull class]]?0:[dict[@"score"] intValue];

model.isYouthModel=[dict[@"isYouthModel"] isKindOfClass:[NSNull class]]?0:[dict[@"isYouthModel"] intValue];

model.password=[dict[@"password"] isKindOfClass:[NSNull class]]?@"":dict[@"password"];

model.phoneModel=[dict[@"phoneModel"] isKindOfClass:[NSNull class]]?@"":dict[@"phoneModel"];

model.constellation=[dict[@"constellation"] isKindOfClass:[NSNull class]]?@"":dict[@"constellation"];

model.province=[dict[@"province"] isKindOfClass:[NSNull class]]?@"":dict[@"province"];

model.isTone=[dict[@"isTone"] isKindOfClass:[NSNull class]]?0:[dict[@"isTone"] intValue];

model.totalCash=[dict[@"totalCash"] isKindOfClass:[NSNull class]]?0:[dict[@"totalCash"] doubleValue];

model.smsRegion=[dict[@"smsRegion"] isKindOfClass:[NSNull class]]?@"":dict[@"smsRegion"];

model.lastGameNum=[dict[@"lastGameNum"] isKindOfClass:[NSNull class]]?0:[dict[@"lastGameNum"] intValue];

model.ipaddr=[dict[@"ipaddr"] isKindOfClass:[NSNull class]]?@"":dict[@"ipaddr"];

model.ishot=[dict[@"ishot"] isKindOfClass:[NSNull class]]?0:[dict[@"ishot"] intValue];

model.liveStatus=[dict[@"liveStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"liveStatus"] intValue];

model.roomType=[dict[@"roomType"] isKindOfClass:[NSNull class]]?0:[dict[@"roomType"] intValue];

model.height=[dict[@"height"] isKindOfClass:[NSNull class]]?0:[dict[@"height"] intValue];

model.gsRoomId=[dict[@"gsRoomId"] isKindOfClass:[NSNull class]]?0:[dict[@"gsRoomId"] longLongValue];

model.zombieRatio=[dict[@"zombieRatio"] isKindOfClass:[NSNull class]]?0:[dict[@"zombieRatio"] doubleValue];

model.votestotal=[dict[@"votestotal"] isKindOfClass:[NSNull class]]?0:[dict[@"votestotal"] doubleValue];

model.lng=[dict[@"lng"] isKindOfClass:[NSNull class]]?0:[dict[@"lng"] doubleValue];

model.pushRegisterId=[dict[@"pushRegisterId"] isKindOfClass:[NSNull class]]?@"":dict[@"pushRegisterId"];

model.userGrade=[dict[@"userGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"userGrade"] intValue];

model.liveFunction=[dict[@"liveFunction"] isKindOfClass:[NSNull class]]?0:[dict[@"liveFunction"] intValue];

model.openid=[dict[@"openid"] isKindOfClass:[NSNull class]]?@"":dict[@"openid"];

model.zombieMaxNum=[dict[@"zombieMaxNum"] isKindOfClass:[NSNull class]]?0:[dict[@"zombieMaxNum"] intValue];

model.iszombiep=[dict[@"iszombiep"] isKindOfClass:[NSNull class]]?0:[dict[@"iszombiep"] intValue];

model.cityEdit=[dict[@"cityEdit"] isKindOfClass:[NSNull class]]?0:[dict[@"cityEdit"] intValue];

model.guildId=[dict[@"guildId"] isKindOfClass:[NSNull class]]?0:[dict[@"guildId"] longLongValue];


{
NSString *strDate= dict[@"lastLoginDay"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.lastLoginDay=date;
    }
}

model.maxSignCount=[dict[@"maxSignCount"] isKindOfClass:[NSNull class]]?0:[dict[@"maxSignCount"] intValue];

model.totalCharge=[dict[@"totalCharge"] isKindOfClass:[NSNull class]]?0:[dict[@"totalCharge"] doubleValue];

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

model.poster=[dict[@"poster"] isKindOfClass:[NSNull class]]?@"":dict[@"poster"];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];

model.role=[dict[@"role"] isKindOfClass:[NSNull class]]?0:[dict[@"role"] intValue];

model.city=[dict[@"city"] isKindOfClass:[NSNull class]]?@"":dict[@"city"];

model.signature=[dict[@"signature"] isKindOfClass:[NSNull class]]?@"":dict[@"signature"];

model.oooHomePageSortNo=[dict[@"oooHomePageSortNo"] isKindOfClass:[NSNull class]]?0:[dict[@"oooHomePageSortNo"] intValue];

model.awardLoginDay=[dict[@"awardLoginDay"] isKindOfClass:[NSNull class]]?0:[dict[@"awardLoginDay"] intValue];

model.delFlag=[dict[@"delFlag"] isKindOfClass:[NSNull class]]?0:[dict[@"delFlag"] intValue];

model.readShortVideoNumber=[dict[@"readShortVideoNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"readShortVideoNumber"] intValue];

model.lastLoginIp=[dict[@"lastLoginIp"] isKindOfClass:[NSNull class]]?@"":dict[@"lastLoginIp"];

model.chargeShow=[dict[@"chargeShow"] isKindOfClass:[NSNull class]]?0:[dict[@"chargeShow"] intValue];


{
NSString *strDate= dict[@"lockTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.lockTime=date;
    }
}

model.nickname=[dict[@"nickname"] isKindOfClass:[NSNull class]]?@"":dict[@"nickname"];

model.userEmail=[dict[@"userEmail"] isKindOfClass:[NSNull class]]?@"":dict[@"userEmail"];

model.oooLiveStatus=[dict[@"oooLiveStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"oooLiveStatus"] intValue];

model.regType=[dict[@"regType"] isKindOfClass:[NSNull class]]?0:[dict[@"regType"] intValue];

model.channelId=[dict[@"channelId"] isKindOfClass:[NSNull class]]?0:[dict[@"channelId"] intValue];

model.charmPoint=[dict[@"charmPoint"] isKindOfClass:[NSNull class]]?0:[dict[@"charmPoint"] intValue];

model.address=[dict[@"address"] isKindOfClass:[NSNull class]]?@"":dict[@"address"];

model.salt=[dict[@"salt"] isKindOfClass:[NSNull class]]?@"":dict[@"salt"];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.phoneFirm=[dict[@"phoneFirm"] isKindOfClass:[NSNull class]]?@"":dict[@"phoneFirm"];

model.charmGrade=[dict[@"charmGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"charmGrade"] intValue];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.managerId=[dict[@"managerId"] isKindOfClass:[NSNull class]]?0:[dict[@"managerId"] longLongValue];

model.vocation=[dict[@"vocation"] isKindOfClass:[NSNull class]]?@"":dict[@"vocation"];


{
NSString *strDate= dict[@"lastLoginTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.lastLoginTime=date;
    }
}


{
NSString *strDate= dict[@"createTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.createTime=date;
    }
}

model.votes=[dict[@"votes"] isKindOfClass:[NSNull class]]?0:[dict[@"votes"] doubleValue];

model.youthPassword=[dict[@"youthPassword"] isKindOfClass:[NSNull class]]?@"":dict[@"youthPassword"];

model.devoteShow=[dict[@"devoteShow"] isKindOfClass:[NSNull class]]?0:[dict[@"devoteShow"] intValue];

model.voice=[dict[@"voice"] isKindOfClass:[NSNull class]]?@"":dict[@"voice"];

model.isRecommend=[dict[@"isRecommend"] isKindOfClass:[NSNull class]]?0:[dict[@"isRecommend"] intValue];

model.isOOOAccount=[dict[@"isOOOAccount"] isKindOfClass:[NSNull class]]?0:[dict[@"isOOOAccount"] intValue];

model.anchorGrade=[dict[@"anchorGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorGrade"] intValue];

model.groupId=[dict[@"groupId"] isKindOfClass:[NSNull class]]?0:[dict[@"groupId"] longLongValue];

model.pid=[dict[@"pid"] isKindOfClass:[NSNull class]]?0:[dict[@"pid"] longLongValue];

model.optUserName=[dict[@"optUserName"] isKindOfClass:[NSNull class]]?@"":dict[@"optUserName"];

model.source=[dict[@"source"] isKindOfClass:[NSNull class]]?@"":dict[@"source"];

model.appVersionCode=[dict[@"appVersionCode"] isKindOfClass:[NSNull class]]?@"":dict[@"appVersionCode"];

model.isJoinJg=[dict[@"isJoinJg"] isKindOfClass:[NSNull class]]?0:[dict[@"isJoinJg"] intValue];

model.oooTwoClassifyId=[dict[@"oooTwoClassifyId"] isKindOfClass:[NSNull class]]?0:[dict[@"oooTwoClassifyId"] longLongValue];

model.broadCast=[dict[@"broadCast"] isKindOfClass:[NSNull class]]?0:[dict[@"broadCast"] intValue];

model.totalAmountCash=[dict[@"totalAmountCash"] isKindOfClass:[NSNull class]]?0:[dict[@"totalAmountCash"] doubleValue];

model.phoneSystem=[dict[@"phoneSystem"] isKindOfClass:[NSNull class]]?@"":dict[@"phoneSystem"];

model.iszombie=[dict[@"iszombie"] isKindOfClass:[NSNull class]]?0:[dict[@"iszombie"] intValue];

model.liveThumbs=[dict[@"liveThumbs"] isKindOfClass:[NSNull class]]?@"":dict[@"liveThumbs"];

model.lat=[dict[@"lat"] isKindOfClass:[NSNull class]]?0:[dict[@"lat"] doubleValue];

model.userUrl=[dict[@"userUrl"] isKindOfClass:[NSNull class]]?@"":dict[@"userUrl"];

model.registerIp=[dict[@"registerIp"] isKindOfClass:[NSNull class]]?@"":dict[@"registerIp"];


{
NSString *strDate= dict[@"signTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.signTime=date;
    }
}

model.level=[dict[@"level"] isKindOfClass:[NSNull class]]?0:[dict[@"level"] intValue];

model.issuper=[dict[@"issuper"] isKindOfClass:[NSNull class]]?0:[dict[@"issuper"] intValue];

model.weight=[dict[@"weight"] isKindOfClass:[NSNull class]]?0:[dict[@"weight"] doubleValue];

model.whetherEnablePositioningShow=[dict[@"whetherEnablePositioningShow"] isKindOfClass:[NSNull class]]?0:[dict[@"whetherEnablePositioningShow"] intValue];

model.openLiveZombieNum=[dict[@"openLiveZombieNum"] isKindOfClass:[NSNull class]]?0:[dict[@"openLiveZombieNum"] intValue];

model.isShowHomePage=[dict[@"isShowHomePage"] isKindOfClass:[NSNull class]]?0:[dict[@"isShowHomePage"] intValue];

model.totalAmount=[dict[@"totalAmount"] isKindOfClass:[NSNull class]]?0:[dict[@"totalAmount"] doubleValue];

model.sanwei=[dict[@"sanwei"] isKindOfClass:[NSNull class]]?@"":dict[@"sanwei"];

model.kickTime=[dict[@"kickTime"] isKindOfClass:[NSNull class]]?0:[dict[@"kickTime"] longLongValue];

model.voiceStatus=[dict[@"voiceStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"voiceStatus"] intValue];

model.roomTypeVal=[dict[@"roomTypeVal"] isKindOfClass:[NSNull class]]?@"":dict[@"roomTypeVal"];

model.voipToken=[dict[@"voipToken"] isKindOfClass:[NSNull class]]?@"":dict[@"voipToken"];

model.managerCoId=[dict[@"managerCoId"] isKindOfClass:[NSNull class]]?0:[dict[@"managerCoId"] longLongValue];

model.userType=[dict[@"userType"] isKindOfClass:[NSNull class]]?0:[dict[@"userType"] intValue];

model.isSvip=[dict[@"isSvip"] isKindOfClass:[NSNull class]]?0:[dict[@"isSvip"] intValue];

model.userActivationKey=[dict[@"userActivationKey"] isKindOfClass:[NSNull class]]?@"":dict[@"userActivationKey"];

model.coin=[dict[@"coin"] isKindOfClass:[NSNull class]]?0:[dict[@"coin"] doubleValue];

model.birthday=[dict[@"birthday"] isKindOfClass:[NSNull class]]?@"":dict[@"birthday"];

model.starId=[dict[@"starId"] isKindOfClass:[NSNull class]]?0:[dict[@"starId"] longLongValue];

model.agentId=[dict[@"agentId"] isKindOfClass:[NSNull class]]?0:[dict[@"agentId"] longLongValue];

model.isPush=[dict[@"isPush"] isKindOfClass:[NSNull class]]?0:[dict[@"isPush"] intValue];

model.unionid=[dict[@"unionid"] isKindOfClass:[NSNull class]]?@"":dict[@"unionid"];

model.anchorPoint=[dict[@"anchorPoint"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorPoint"] intValue];

model.loginType=[dict[@"loginType"] isKindOfClass:[NSNull class]]?@"":dict[@"loginType"];

model.videoCoin=[dict[@"videoCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"videoCoin"] doubleValue];

model.liveThumb=[dict[@"liveThumb"] isKindOfClass:[NSNull class]]?@"":dict[@"liveThumb"];

model.video=[dict[@"video"] isKindOfClass:[NSNull class]]?@"":dict[@"video"];

model.isAnchorAuth=[dict[@"isAnchorAuth"] isKindOfClass:[NSNull class]]?0:[dict[@"isAnchorAuth"] intValue];

model.voiceCoin=[dict[@"voiceCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"voiceCoin"] doubleValue];

model.isAutomatic=[dict[@"isAutomatic"] isKindOfClass:[NSNull class]]?0:[dict[@"isAutomatic"] intValue];

model.amount=[dict[@"amount"] isKindOfClass:[NSNull class]]?0:[dict[@"amount"] doubleValue];

model.phoneUuid=[dict[@"phoneUuid"] isKindOfClass:[NSNull class]]?@"":dict[@"phoneUuid"];

model.userPoint=[dict[@"userPoint"] isKindOfClass:[NSNull class]]?0:[dict[@"userPoint"] intValue];

model.hideDistance=[dict[@"hideDistance"] isKindOfClass:[NSNull class]]?0:[dict[@"hideDistance"] intValue];

model.mobile=[dict[@"mobile"] isKindOfClass:[NSNull class]]?@"":dict[@"mobile"];


{
NSString *strDate= dict[@"updatePwdTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.updatePwdTime=date;
    }
}

model.videoImg=[dict[@"videoImg"] isKindOfClass:[NSNull class]]?@"":dict[@"videoImg"];

model.wechat=[dict[@"wechat"] isKindOfClass:[NSNull class]]?@"":dict[@"wechat"];

model.consumption=[dict[@"consumption"] isKindOfClass:[NSNull class]]?0:[dict[@"consumption"] doubleValue];

model.isLiveAccount=[dict[@"isLiveAccount"] isKindOfClass:[NSNull class]]?0:[dict[@"isLiveAccount"] intValue];

model.portrait=[dict[@"portrait"] isKindOfClass:[NSNull class]]?@"":dict[@"portrait"];

model.dealScalePlan=[dict[@"dealScalePlan"] isKindOfClass:[NSNull class]]?0:[dict[@"dealScalePlan"] longLongValue];

model.lockReason=[dict[@"lockReason"] isKindOfClass:[NSNull class]]?@"":dict[@"lockReason"];

model.giftGlobalBroadcast=[dict[@"giftGlobalBroadcast"] isKindOfClass:[NSNull class]]?0:[dict[@"giftGlobalBroadcast"] intValue];

model.headNo=[dict[@"headNo"] isKindOfClass:[NSNull class]]?0:[dict[@"headNo"] longLongValue];

model.isrecord=[dict[@"isrecord"] isKindOfClass:[NSNull class]]?0:[dict[@"isrecord"] intValue];

model.inviteCode=[dict[@"inviteCode"] isKindOfClass:[NSNull class]]?@"":dict[@"inviteCode"];

model.isNotDisturb=[dict[@"isNotDisturb"] isKindOfClass:[NSNull class]]?0:[dict[@"isNotDisturb"] intValue];

model.nobleGrade=[dict[@"nobleGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"nobleGrade"] intValue];

model.roomTitle=[dict[@"roomTitle"] isKindOfClass:[NSNull class]]?@"":dict[@"roomTitle"];

model.goodnum=[dict[@"goodnum"] isKindOfClass:[NSNull class]]?@"":dict[@"goodnum"];

model.username=[dict[@"username"] isKindOfClass:[NSNull class]]?@"":dict[@"username"];


 return model;
}

 +(void)cloneObj:(AppUserModel*) source target:(AppUserModel*)target
{

target.appVersion=source.appVersion;

target.joinRoomShow=source.joinRoomShow;

target.signCount=source.signCount;

target.onlineStatus=source.onlineStatus;

target.deviceId=source.deviceId;

target.pushPlatform=source.pushPlatform;

target.userSetOnlineStatus=source.userSetOnlineStatus;

target.userid=source.userid;

target.gsRoomType=source.gsRoomType;

target.score=source.score;

target.isYouthModel=source.isYouthModel;

target.password=source.password;

target.phoneModel=source.phoneModel;

target.constellation=source.constellation;

target.province=source.province;

target.isTone=source.isTone;

target.totalCash=source.totalCash;

target.smsRegion=source.smsRegion;

target.lastGameNum=source.lastGameNum;

target.ipaddr=source.ipaddr;

target.ishot=source.ishot;

target.liveStatus=source.liveStatus;

target.roomType=source.roomType;

target.height=source.height;

target.gsRoomId=source.gsRoomId;

target.zombieRatio=source.zombieRatio;

target.votestotal=source.votestotal;

target.lng=source.lng;

target.pushRegisterId=source.pushRegisterId;

target.userGrade=source.userGrade;

target.liveFunction=source.liveFunction;

target.openid=source.openid;

target.zombieMaxNum=source.zombieMaxNum;

target.iszombiep=source.iszombiep;

target.cityEdit=source.cityEdit;

target.guildId=source.guildId;

target.lastLoginDay=source.lastLoginDay;

target.maxSignCount=source.maxSignCount;

target.totalCharge=source.totalCharge;

target.wealthGrade=source.wealthGrade;

target.lastOffLineTime=source.lastOffLineTime;

target.poster=source.poster;

target.status=source.status;

target.role=source.role;

target.city=source.city;

target.signature=source.signature;

target.oooHomePageSortNo=source.oooHomePageSortNo;

target.awardLoginDay=source.awardLoginDay;

target.delFlag=source.delFlag;

target.readShortVideoNumber=source.readShortVideoNumber;

target.lastLoginIp=source.lastLoginIp;

target.chargeShow=source.chargeShow;

target.lockTime=source.lockTime;

target.nickname=source.nickname;

target.userEmail=source.userEmail;

target.oooLiveStatus=source.oooLiveStatus;

target.regType=source.regType;

target.channelId=source.channelId;

target.charmPoint=source.charmPoint;

target.address=source.address;

target.salt=source.salt;

target.sex=source.sex;

target.phoneFirm=source.phoneFirm;

target.charmGrade=source.charmGrade;

target.avatar=source.avatar;

target.managerId=source.managerId;

target.vocation=source.vocation;

target.lastLoginTime=source.lastLoginTime;

target.createTime=source.createTime;

target.votes=source.votes;

target.youthPassword=source.youthPassword;

target.devoteShow=source.devoteShow;

target.voice=source.voice;

target.isRecommend=source.isRecommend;

target.isOOOAccount=source.isOOOAccount;

target.anchorGrade=source.anchorGrade;

target.groupId=source.groupId;

target.pid=source.pid;

target.optUserName=source.optUserName;

target.source=source.source;

target.appVersionCode=source.appVersionCode;

target.isJoinJg=source.isJoinJg;

target.oooTwoClassifyId=source.oooTwoClassifyId;

target.broadCast=source.broadCast;

target.totalAmountCash=source.totalAmountCash;

target.phoneSystem=source.phoneSystem;

target.iszombie=source.iszombie;

target.liveThumbs=source.liveThumbs;

target.lat=source.lat;

target.userUrl=source.userUrl;

target.registerIp=source.registerIp;

target.signTime=source.signTime;

target.level=source.level;

target.issuper=source.issuper;

target.weight=source.weight;

target.whetherEnablePositioningShow=source.whetherEnablePositioningShow;

target.openLiveZombieNum=source.openLiveZombieNum;

target.isShowHomePage=source.isShowHomePage;

target.totalAmount=source.totalAmount;

target.sanwei=source.sanwei;

target.kickTime=source.kickTime;

target.voiceStatus=source.voiceStatus;

target.roomTypeVal=source.roomTypeVal;

target.voipToken=source.voipToken;

target.managerCoId=source.managerCoId;

target.userType=source.userType;

target.isSvip=source.isSvip;

target.userActivationKey=source.userActivationKey;

target.coin=source.coin;

target.birthday=source.birthday;

target.starId=source.starId;

target.agentId=source.agentId;

target.isPush=source.isPush;

target.unionid=source.unionid;

target.anchorPoint=source.anchorPoint;

target.loginType=source.loginType;

target.videoCoin=source.videoCoin;

target.liveThumb=source.liveThumb;

target.video=source.video;

target.isAnchorAuth=source.isAnchorAuth;

target.voiceCoin=source.voiceCoin;

target.isAutomatic=source.isAutomatic;

target.amount=source.amount;

target.phoneUuid=source.phoneUuid;

target.userPoint=source.userPoint;

target.hideDistance=source.hideDistance;

target.mobile=source.mobile;

target.updatePwdTime=source.updatePwdTime;

target.videoImg=source.videoImg;

target.wechat=source.wechat;

target.consumption=source.consumption;

target.isLiveAccount=source.isLiveAccount;

target.portrait=source.portrait;

target.dealScalePlan=source.dealScalePlan;

target.lockReason=source.lockReason;

target.giftGlobalBroadcast=source.giftGlobalBroadcast;

target.headNo=source.headNo;

target.isrecord=source.isrecord;

target.inviteCode=source.inviteCode;

target.isNotDisturb=source.isNotDisturb;

target.nobleGrade=source.nobleGrade;

target.roomTitle=source.roomTitle;

target.goodnum=source.goodnum;

target.username=source.username;

}

@end

