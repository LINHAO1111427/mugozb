//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AdminLiveConfigModel.h"




 @implementation AdminLiveConfigModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"maleAnchorShowAddress"]=@(_maleAnchorShowAddress);

dict[@"showOnlineService"]=@(_showOnlineService);

dict[@"chatServer"]=_chatServer;

dict[@"logOffSwitch"]=@(_logOffSwitch);

dict[@"femaleAnchorLookCity"]=@(_femaleAnchorLookCity);

dict[@"isEnableLuckyGift"]=@(_isEnableLuckyGift);

dict[@"shortVideoTrial"]=@(_shortVideoTrial);

dict[@"privateShowRedPack"]=@(_privateShowRedPack);

dict[@"isNobleChat"]=@(_isNobleChat);

dict[@"withdrawalRule"]=_withdrawalRule;

dict[@"id"]=@(_id_field);

dict[@"voiceStartCertification"]=@(_voiceStartCertification);

dict[@"VIPStatesFee"]=@(_VIPStatesFee);

dict[@"showTaskCenter"]=@(_showTaskCenter);

dict[@"logOffDay"]=@(_logOffDay);

dict[@"userCancel"]=_userCancel;

dict[@"shortVideoTrialTime"]=@(_shortVideoTrialTime);

dict[@"showWealthAndCharm"]=@(_showWealthAndCharm);

dict[@"groupShowRedPack"]=@(_groupShowRedPack);

dict[@"videoCommentSwitch"]=@(_videoCommentSwitch);

dict[@"kickTime"]=@(_kickTime);

dict[@"authIslimit"]=@(_authIslimit);

dict[@"jumpMode"]=@(_jumpMode);

dict[@"miclimit"]=@(_miclimit);

dict[@"isShortVideoFee"]=@(_isShortVideoFee);

dict[@"anchorTalkFree"]=@(_anchorTalkFree);

dict[@"barrageFee"]=@(_barrageFee);

dict[@"barrageLimit"]=@(_barrageLimit);

dict[@"femaleUserShowAddress"]=@(_femaleUserShowAddress);

dict[@"anchorToAnchor"]=@(_anchorToAnchor);

dict[@"isVipSee"]=@(_isVipSee);

dict[@"onlineServiceUrl"]=_onlineServiceUrl;

dict[@"anchorTalkAnchor"]=@(_anchorTalkAnchor);

dict[@"authIsSex"]=@(_authIsSex);

dict[@"privateCoin"]=@(_privateCoin);

dict[@"analogMessageCount"]=@(_analogMessageCount);

dict[@"authShortVideo"]=@(_authShortVideo);

dict[@"levelLimit"]=@(_levelLimit);

dict[@"dynamicAuditSwitch"]=@(_dynamicAuditSwitch);

dict[@"isAuthShortVideo"]=@(_isAuthShortVideo);

dict[@"isBindPhone"]=@(_isBindPhone);

dict[@"logOffInheritSupper"]=@(_logOffInheritSupper);

dict[@"showInviteToMakeMoney"]=@(_showInviteToMakeMoney);

dict[@"userTalkUser"]=@(_userTalkUser);

dict[@"luckyGiftPerc"]=@(_luckyGiftPerc);

dict[@"anchorTalkUser"]=@(_anchorTalkUser);

dict[@"showAddressEnd"]=@(_showAddressEnd);

dict[@"userToUser"]=@(_userToUser);

dict[@"showCommonService"]=@(_showCommonService);

dict[@"femaleTalkFemale"]=@(_femaleTalkFemale);

dict[@"femaleTalkFree"]=@(_femaleTalkFree);

dict[@"isFunctionTurnOn"]=@(_isFunctionTurnOn);

dict[@"privateChatDeductionTips"]=_privateChatDeductionTips;

dict[@"maleUserShowAddress"]=@(_maleUserShowAddress);

dict[@"femaleAnchorShowAddress"]=@(_femaleAnchorShowAddress);

dict[@"xieyiRule"]=_xieyiRule;

dict[@"shuttime"]=@(_shuttime);

dict[@"analogMessage"]=@(_analogMessage);

dict[@"analogMessageInterval"]=@(_analogMessageInterval);

dict[@"showAddressStart"]=@(_showAddressStart);

dict[@"bidFee"]=@(_bidFee);

dict[@"manTalkMan"]=@(_manTalkMan);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AdminLiveConfigModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AdminLiveConfigModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AdminLiveConfigModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AdminLiveConfigModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AdminLiveConfigModel* sumMdl=[AdminLiveConfigModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AdminLiveConfigModel*)getFromDict:(NSDictionary*)dict
{
AdminLiveConfigModel* model=[[AdminLiveConfigModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.maleAnchorShowAddress=[dict[@"maleAnchorShowAddress"] isKindOfClass:[NSNull class]]?0:[dict[@"maleAnchorShowAddress"] intValue];

model.showOnlineService=[dict[@"showOnlineService"] isKindOfClass:[NSNull class]]?0:[dict[@"showOnlineService"] intValue];

model.chatServer=[dict[@"chatServer"] isKindOfClass:[NSNull class]]?@"":dict[@"chatServer"];

model.logOffSwitch=[dict[@"logOffSwitch"] isKindOfClass:[NSNull class]]?0:[dict[@"logOffSwitch"] intValue];

model.femaleAnchorLookCity=[dict[@"femaleAnchorLookCity"] isKindOfClass:[NSNull class]]?0:[dict[@"femaleAnchorLookCity"] intValue];

model.isEnableLuckyGift=[dict[@"isEnableLuckyGift"] isKindOfClass:[NSNull class]]?0:[dict[@"isEnableLuckyGift"] intValue];

model.shortVideoTrial=[dict[@"shortVideoTrial"] isKindOfClass:[NSNull class]]?0:[dict[@"shortVideoTrial"] intValue];

model.privateShowRedPack=[dict[@"privateShowRedPack"] isKindOfClass:[NSNull class]]?0:[dict[@"privateShowRedPack"] intValue];

model.isNobleChat=[dict[@"isNobleChat"] isKindOfClass:[NSNull class]]?0:[dict[@"isNobleChat"] intValue];

model.withdrawalRule=[dict[@"withdrawalRule"] isKindOfClass:[NSNull class]]?@"":dict[@"withdrawalRule"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.voiceStartCertification=[dict[@"voiceStartCertification"] isKindOfClass:[NSNull class]]?0:[dict[@"voiceStartCertification"] intValue];

model.VIPStatesFee=[dict[@"VIPStatesFee"] isKindOfClass:[NSNull class]]?0:[dict[@"VIPStatesFee"] doubleValue];

model.showTaskCenter=[dict[@"showTaskCenter"] isKindOfClass:[NSNull class]]?0:[dict[@"showTaskCenter"] intValue];

model.logOffDay=[dict[@"logOffDay"] isKindOfClass:[NSNull class]]?0:[dict[@"logOffDay"] intValue];

model.userCancel=[dict[@"userCancel"] isKindOfClass:[NSNull class]]?@"":dict[@"userCancel"];

model.shortVideoTrialTime=[dict[@"shortVideoTrialTime"] isKindOfClass:[NSNull class]]?0:[dict[@"shortVideoTrialTime"] intValue];

model.showWealthAndCharm=[dict[@"showWealthAndCharm"] isKindOfClass:[NSNull class]]?0:[dict[@"showWealthAndCharm"] intValue];

model.groupShowRedPack=[dict[@"groupShowRedPack"] isKindOfClass:[NSNull class]]?0:[dict[@"groupShowRedPack"] intValue];

model.videoCommentSwitch=[dict[@"videoCommentSwitch"] isKindOfClass:[NSNull class]]?0:[dict[@"videoCommentSwitch"] intValue];

model.kickTime=[dict[@"kickTime"] isKindOfClass:[NSNull class]]?0:[dict[@"kickTime"] intValue];

model.authIslimit=[dict[@"authIslimit"] isKindOfClass:[NSNull class]]?0:[dict[@"authIslimit"] intValue];

model.jumpMode=[dict[@"jumpMode"] isKindOfClass:[NSNull class]]?0:[dict[@"jumpMode"] intValue];

model.miclimit=[dict[@"miclimit"] isKindOfClass:[NSNull class]]?0:[dict[@"miclimit"] intValue];

model.isShortVideoFee=[dict[@"isShortVideoFee"] isKindOfClass:[NSNull class]]?0:[dict[@"isShortVideoFee"] intValue];

model.anchorTalkFree=[dict[@"anchorTalkFree"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorTalkFree"] intValue];

model.barrageFee=[dict[@"barrageFee"] isKindOfClass:[NSNull class]]?0:[dict[@"barrageFee"] intValue];

model.barrageLimit=[dict[@"barrageLimit"] isKindOfClass:[NSNull class]]?0:[dict[@"barrageLimit"] intValue];

model.femaleUserShowAddress=[dict[@"femaleUserShowAddress"] isKindOfClass:[NSNull class]]?0:[dict[@"femaleUserShowAddress"] intValue];

model.anchorToAnchor=[dict[@"anchorToAnchor"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorToAnchor"] intValue];

model.isVipSee=[dict[@"isVipSee"] isKindOfClass:[NSNull class]]?0:[dict[@"isVipSee"] intValue];

model.onlineServiceUrl=[dict[@"onlineServiceUrl"] isKindOfClass:[NSNull class]]?@"":dict[@"onlineServiceUrl"];

model.anchorTalkAnchor=[dict[@"anchorTalkAnchor"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorTalkAnchor"] intValue];

model.authIsSex=[dict[@"authIsSex"] isKindOfClass:[NSNull class]]?0:[dict[@"authIsSex"] intValue];

model.privateCoin=[dict[@"privateCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"privateCoin"] intValue];

model.analogMessageCount=[dict[@"analogMessageCount"] isKindOfClass:[NSNull class]]?0:[dict[@"analogMessageCount"] intValue];

model.authShortVideo=[dict[@"authShortVideo"] isKindOfClass:[NSNull class]]?0:[dict[@"authShortVideo"] intValue];

model.levelLimit=[dict[@"levelLimit"] isKindOfClass:[NSNull class]]?0:[dict[@"levelLimit"] intValue];

model.dynamicAuditSwitch=[dict[@"dynamicAuditSwitch"] isKindOfClass:[NSNull class]]?0:[dict[@"dynamicAuditSwitch"] intValue];

model.isAuthShortVideo=[dict[@"isAuthShortVideo"] isKindOfClass:[NSNull class]]?0:[dict[@"isAuthShortVideo"] intValue];

model.isBindPhone=[dict[@"isBindPhone"] isKindOfClass:[NSNull class]]?0:[dict[@"isBindPhone"] intValue];

model.logOffInheritSupper=[dict[@"logOffInheritSupper"] isKindOfClass:[NSNull class]]?0:[dict[@"logOffInheritSupper"] intValue];

model.showInviteToMakeMoney=[dict[@"showInviteToMakeMoney"] isKindOfClass:[NSNull class]]?0:[dict[@"showInviteToMakeMoney"] intValue];

model.userTalkUser=[dict[@"userTalkUser"] isKindOfClass:[NSNull class]]?0:[dict[@"userTalkUser"] intValue];

model.luckyGiftPerc=[dict[@"luckyGiftPerc"] isKindOfClass:[NSNull class]]?0:[dict[@"luckyGiftPerc"] doubleValue];

model.anchorTalkUser=[dict[@"anchorTalkUser"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorTalkUser"] intValue];

model.showAddressEnd=[dict[@"showAddressEnd"] isKindOfClass:[NSNull class]]?0:[dict[@"showAddressEnd"] intValue];

model.userToUser=[dict[@"userToUser"] isKindOfClass:[NSNull class]]?0:[dict[@"userToUser"] intValue];

model.showCommonService=[dict[@"showCommonService"] isKindOfClass:[NSNull class]]?0:[dict[@"showCommonService"] intValue];

model.femaleTalkFemale=[dict[@"femaleTalkFemale"] isKindOfClass:[NSNull class]]?0:[dict[@"femaleTalkFemale"] intValue];

model.femaleTalkFree=[dict[@"femaleTalkFree"] isKindOfClass:[NSNull class]]?0:[dict[@"femaleTalkFree"] intValue];

model.isFunctionTurnOn=[dict[@"isFunctionTurnOn"] isKindOfClass:[NSNull class]]?0:[dict[@"isFunctionTurnOn"] intValue];

model.privateChatDeductionTips=[dict[@"privateChatDeductionTips"] isKindOfClass:[NSNull class]]?@"":dict[@"privateChatDeductionTips"];

model.maleUserShowAddress=[dict[@"maleUserShowAddress"] isKindOfClass:[NSNull class]]?0:[dict[@"maleUserShowAddress"] intValue];

model.femaleAnchorShowAddress=[dict[@"femaleAnchorShowAddress"] isKindOfClass:[NSNull class]]?0:[dict[@"femaleAnchorShowAddress"] intValue];

model.xieyiRule=[dict[@"xieyiRule"] isKindOfClass:[NSNull class]]?@"":dict[@"xieyiRule"];

model.shuttime=[dict[@"shuttime"] isKindOfClass:[NSNull class]]?0:[dict[@"shuttime"] intValue];

model.analogMessage=[dict[@"analogMessage"] isKindOfClass:[NSNull class]]?0:[dict[@"analogMessage"] intValue];

model.analogMessageInterval=[dict[@"analogMessageInterval"] isKindOfClass:[NSNull class]]?0:[dict[@"analogMessageInterval"] intValue];

model.showAddressStart=[dict[@"showAddressStart"] isKindOfClass:[NSNull class]]?0:[dict[@"showAddressStart"] intValue];

model.bidFee=[dict[@"bidFee"] isKindOfClass:[NSNull class]]?0:[dict[@"bidFee"] intValue];

model.manTalkMan=[dict[@"manTalkMan"] isKindOfClass:[NSNull class]]?0:[dict[@"manTalkMan"] intValue];


 return model;
}

 +(void)cloneObj:(AdminLiveConfigModel*) source target:(AdminLiveConfigModel*)target
{

target.maleAnchorShowAddress=source.maleAnchorShowAddress;

target.showOnlineService=source.showOnlineService;

target.chatServer=source.chatServer;

target.logOffSwitch=source.logOffSwitch;

target.femaleAnchorLookCity=source.femaleAnchorLookCity;

target.isEnableLuckyGift=source.isEnableLuckyGift;

target.shortVideoTrial=source.shortVideoTrial;

target.privateShowRedPack=source.privateShowRedPack;

target.isNobleChat=source.isNobleChat;

target.withdrawalRule=source.withdrawalRule;

target.id_field=source.id_field;

target.voiceStartCertification=source.voiceStartCertification;

target.VIPStatesFee=source.VIPStatesFee;

target.showTaskCenter=source.showTaskCenter;

target.logOffDay=source.logOffDay;

target.userCancel=source.userCancel;

target.shortVideoTrialTime=source.shortVideoTrialTime;

target.showWealthAndCharm=source.showWealthAndCharm;

target.groupShowRedPack=source.groupShowRedPack;

target.videoCommentSwitch=source.videoCommentSwitch;

target.kickTime=source.kickTime;

target.authIslimit=source.authIslimit;

target.jumpMode=source.jumpMode;

target.miclimit=source.miclimit;

target.isShortVideoFee=source.isShortVideoFee;

target.anchorTalkFree=source.anchorTalkFree;

target.barrageFee=source.barrageFee;

target.barrageLimit=source.barrageLimit;

target.femaleUserShowAddress=source.femaleUserShowAddress;

target.anchorToAnchor=source.anchorToAnchor;

target.isVipSee=source.isVipSee;

target.onlineServiceUrl=source.onlineServiceUrl;

target.anchorTalkAnchor=source.anchorTalkAnchor;

target.authIsSex=source.authIsSex;

target.privateCoin=source.privateCoin;

target.analogMessageCount=source.analogMessageCount;

target.authShortVideo=source.authShortVideo;

target.levelLimit=source.levelLimit;

target.dynamicAuditSwitch=source.dynamicAuditSwitch;

target.isAuthShortVideo=source.isAuthShortVideo;

target.isBindPhone=source.isBindPhone;

target.logOffInheritSupper=source.logOffInheritSupper;

target.showInviteToMakeMoney=source.showInviteToMakeMoney;

target.userTalkUser=source.userTalkUser;

target.luckyGiftPerc=source.luckyGiftPerc;

target.anchorTalkUser=source.anchorTalkUser;

target.showAddressEnd=source.showAddressEnd;

target.userToUser=source.userToUser;

target.showCommonService=source.showCommonService;

target.femaleTalkFemale=source.femaleTalkFemale;

target.femaleTalkFree=source.femaleTalkFree;

target.isFunctionTurnOn=source.isFunctionTurnOn;

target.privateChatDeductionTips=source.privateChatDeductionTips;

target.maleUserShowAddress=source.maleUserShowAddress;

target.femaleAnchorShowAddress=source.femaleAnchorShowAddress;

target.xieyiRule=source.xieyiRule;

target.shuttime=source.shuttime;

target.analogMessage=source.analogMessage;

target.analogMessageInterval=source.analogMessageInterval;

target.showAddressStart=source.showAddressStart;

target.bidFee=source.bidFee;

target.manTalkMan=source.manTalkMan;

}

@end

