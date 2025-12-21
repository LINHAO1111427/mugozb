//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "HomeO2ODataModel.h"




 @implementation HomeO2ODataModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"isRecommend"]=@(_isRecommend);

dict[@"anchorGrade"]=@(_anchorGrade);

dict[@"onlineStatus"]=@(_onlineStatus);

dict[@"dspPay"]=@(_dspPay);

dict[@"freeWatchTime"]=@(_freeWatchTime);

dict[@"twoClassifyId"]=@(_twoClassifyId);

dict[@"nobleGradeImg"]=_nobleGradeImg;

dict[@"userSetOnlineStatus"]=@(_userSetOnlineStatus);

dict[@"roomId"]=@(_roomId);

dict[@"likeNum"]=@(_likeNum);

dict[@"roomStatus"]=@(_roomStatus);

dict[@"isLive"]=@(_isLive);

dict[@"ul"]=@(_ul);

dict[@"id"]=@(_id_field);

dict[@"lat"]=@(_lat);

dict[@"liveStatus"]=@(_liveStatus);

dict[@"nums"]=@(_nums);

dict[@"roomType"]=@(_roomType);

dict[@"height"]=@(_height);

dict[@"typeVal"]=_typeVal;

dict[@"tabName"]=_tabName;

dict[@"svipIcon"]=_svipIcon;

dict[@"headImg"]=_headImg;

dict[@"lng"]=@(_lng);

dict[@"liveFunction"]=@(_liveFunction);

dict[@"weight"]=@(_weight);

dict[@"whetherEnablePositioningShow"]=@(_whetherEnablePositioningShow);

dict[@"sort"]=@(_sort);

dict[@"isChecked"]=@(_isChecked);

dict[@"commentNum"]=@(_commentNum);

dict[@"hotSortId"]=@(_hotSortId);

dict[@"oooVoice"]=_oooVoice;

dict[@"sourceType"]=@(_sourceType);

dict[@"lastOffLineTime"]=[HttpClient stringFromDate:_lastOffLineTime];

dict[@"position"]=_position;

dict[@"sourceCover"]=_sourceCover;

dict[@"isSvip"]=@(_isSvip);

dict[@"poster"]=_poster;

dict[@"coin"]=@(_coin);

dict[@"nobleGradeName"]=_nobleGradeName;

dict[@"anchorGradeIcon"]=_anchorGradeIcon;

dict[@"role"]=@(_role);

dict[@"distance"]=_distance;

dict[@"city"]=_city;

dict[@"signature"]=_signature;

dict[@"liveType"]=@(_liveType);

dict[@"videoCoin"]=@(_videoCoin);

dict[@"isPrivate"]=@(_isPrivate);

dict[@"title"]=_title;

dict[@"isvip"]=@(_isvip);

dict[@"typeDec"]=_typeDec;

dict[@"rechargeDiscount"]=@(_rechargeDiscount);

dict[@"voiceCoin"]=@(_voiceCoin);

dict[@"fireVale"]=@(_fireVale);

dict[@"oooLiveStatus"]=@(_oooLiveStatus);

dict[@"voiceTime"]=@(_voiceTime);

dict[@"channelId"]=@(_channelId);

dict[@"createDate"]=[HttpClient stringFromDate:_createDate];

dict[@"oooVideoImg"]=_oooVideoImg;

dict[@"oooVideo"]=_oooVideo;

dict[@"hideDistance"]=@(_hideDistance);

dict[@"isPay"]=@(_isPay);

dict[@"sex"]=@(_sex);

dict[@"businessLogo"]=_businessLogo;

dict[@"channelImage"]=_channelImage;

dict[@"portrait"]=_portrait;

dict[@"todayIncome"]=@(_todayIncome);

dict[@"userId"]=@(_userId);

dict[@"nobleAvatarFrame"]=_nobleAvatarFrame;

dict[@"pull"]=_pull;

dict[@"showid"]=_showid;

dict[@"sourceState"]=@(_sourceState);

dict[@"age"]=@(_age);

dict[@"username"]=_username;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<HomeO2ODataModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
HomeO2ODataModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<HomeO2ODataModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<HomeO2ODataModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
HomeO2ODataModel* sumMdl=[HomeO2ODataModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(HomeO2ODataModel*)getFromDict:(NSDictionary*)dict
{
HomeO2ODataModel* model=[[HomeO2ODataModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.isRecommend=[dict[@"isRecommend"] isKindOfClass:[NSNull class]]?0:[dict[@"isRecommend"] intValue];

model.anchorGrade=[dict[@"anchorGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorGrade"] intValue];

model.onlineStatus=[dict[@"onlineStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"onlineStatus"] intValue];

model.dspPay=[dict[@"dspPay"] isKindOfClass:[NSNull class]]?0:[dict[@"dspPay"] intValue];

model.freeWatchTime=[dict[@"freeWatchTime"] isKindOfClass:[NSNull class]]?0:[dict[@"freeWatchTime"] intValue];

model.twoClassifyId=[dict[@"twoClassifyId"] isKindOfClass:[NSNull class]]?0:[dict[@"twoClassifyId"] longLongValue];

model.nobleGradeImg=[dict[@"nobleGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleGradeImg"];

model.userSetOnlineStatus=[dict[@"userSetOnlineStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"userSetOnlineStatus"] intValue];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];

model.likeNum=[dict[@"likeNum"] isKindOfClass:[NSNull class]]?0:[dict[@"likeNum"] intValue];

model.roomStatus=[dict[@"roomStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"roomStatus"] intValue];

model.isLive=[dict[@"isLive"] isKindOfClass:[NSNull class]]?0:[dict[@"isLive"] intValue];

model.ul=[dict[@"ul"] isKindOfClass:[NSNull class]]?0:[dict[@"ul"] intValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.lat=[dict[@"lat"] isKindOfClass:[NSNull class]]?0:[dict[@"lat"] doubleValue];

model.liveStatus=[dict[@"liveStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"liveStatus"] intValue];

model.nums=[dict[@"nums"] isKindOfClass:[NSNull class]]?0:[dict[@"nums"] intValue];

model.roomType=[dict[@"roomType"] isKindOfClass:[NSNull class]]?0:[dict[@"roomType"] intValue];

model.height=[dict[@"height"] isKindOfClass:[NSNull class]]?0:[dict[@"height"] intValue];

model.typeVal=[dict[@"typeVal"] isKindOfClass:[NSNull class]]?@"":dict[@"typeVal"];

model.tabName=[dict[@"tabName"] isKindOfClass:[NSNull class]]?@"":dict[@"tabName"];

model.svipIcon=[dict[@"svipIcon"] isKindOfClass:[NSNull class]]?@"":dict[@"svipIcon"];

model.headImg=[dict[@"headImg"] isKindOfClass:[NSNull class]]?@"":dict[@"headImg"];

model.lng=[dict[@"lng"] isKindOfClass:[NSNull class]]?0:[dict[@"lng"] doubleValue];

model.liveFunction=[dict[@"liveFunction"] isKindOfClass:[NSNull class]]?0:[dict[@"liveFunction"] intValue];

model.weight=[dict[@"weight"] isKindOfClass:[NSNull class]]?0:[dict[@"weight"] doubleValue];

model.whetherEnablePositioningShow=[dict[@"whetherEnablePositioningShow"] isKindOfClass:[NSNull class]]?0:[dict[@"whetherEnablePositioningShow"] intValue];

model.sort=[dict[@"sort"] isKindOfClass:[NSNull class]]?0:[dict[@"sort"] intValue];

model.isChecked=[dict[@"isChecked"] isKindOfClass:[NSNull class]]?0:[dict[@"isChecked"] intValue];

model.commentNum=[dict[@"commentNum"] isKindOfClass:[NSNull class]]?0:[dict[@"commentNum"] intValue];

model.hotSortId=[dict[@"hotSortId"] isKindOfClass:[NSNull class]]?0:[dict[@"hotSortId"] longLongValue];

model.oooVoice=[dict[@"oooVoice"] isKindOfClass:[NSNull class]]?@"":dict[@"oooVoice"];

model.sourceType=[dict[@"sourceType"] isKindOfClass:[NSNull class]]?0:[dict[@"sourceType"] intValue];


{
NSString *strDate= [NSString stringWithFormat:@"%ld",dict[@"lastOffLineTime"]];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.lastOffLineTime=date;
    }
}

model.position=[dict[@"position"] isKindOfClass:[NSNull class]]?@"":dict[@"position"];

model.sourceCover=[dict[@"sourceCover"] isKindOfClass:[NSNull class]]?@"":dict[@"sourceCover"];

model.isSvip=[dict[@"isSvip"] isKindOfClass:[NSNull class]]?0:[dict[@"isSvip"] intValue];

model.poster=[dict[@"poster"] isKindOfClass:[NSNull class]]?@"":dict[@"poster"];

model.coin=[dict[@"coin"] isKindOfClass:[NSNull class]]?0:[dict[@"coin"] doubleValue];

model.nobleGradeName=[dict[@"nobleGradeName"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleGradeName"];

model.anchorGradeIcon=[dict[@"anchorGradeIcon"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorGradeIcon"];

model.role=[dict[@"role"] isKindOfClass:[NSNull class]]?0:[dict[@"role"] intValue];

model.distance=[dict[@"distance"] isKindOfClass:[NSNull class]]?@"":dict[@"distance"];

model.city=[dict[@"city"] isKindOfClass:[NSNull class]]?@"":dict[@"city"];

model.signature=[dict[@"signature"] isKindOfClass:[NSNull class]]?@"":dict[@"signature"];

model.liveType=[dict[@"liveType"] isKindOfClass:[NSNull class]]?0:[dict[@"liveType"] intValue];

model.videoCoin=[dict[@"videoCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"videoCoin"] doubleValue];

model.isPrivate=[dict[@"isPrivate"] isKindOfClass:[NSNull class]]?0:[dict[@"isPrivate"] intValue];

model.title=[dict[@"title"] isKindOfClass:[NSNull class]]?@"":dict[@"title"];

model.isvip=[dict[@"isvip"] isKindOfClass:[NSNull class]]?0:[dict[@"isvip"] intValue];

model.typeDec=[dict[@"typeDec"] isKindOfClass:[NSNull class]]?@"":dict[@"typeDec"];

model.rechargeDiscount=[dict[@"rechargeDiscount"] isKindOfClass:[NSNull class]]?0:[dict[@"rechargeDiscount"] doubleValue];

model.voiceCoin=[dict[@"voiceCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"voiceCoin"] doubleValue];

model.fireVale=[dict[@"fireVale"] isKindOfClass:[NSNull class]]?0:[dict[@"fireVale"] doubleValue];

model.oooLiveStatus=[dict[@"oooLiveStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"oooLiveStatus"] intValue];

model.voiceTime=[dict[@"voiceTime"] isKindOfClass:[NSNull class]]?0:[dict[@"voiceTime"] longLongValue];

model.channelId=[dict[@"channelId"] isKindOfClass:[NSNull class]]?0:[dict[@"channelId"] longLongValue];


{
NSString *strDate= dict[@"createDate"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.createDate=date;
    }
}

model.oooVideoImg=[dict[@"oooVideoImg"] isKindOfClass:[NSNull class]]?@"":dict[@"oooVideoImg"];

model.oooVideo=[dict[@"oooVideo"] isKindOfClass:[NSNull class]]?@"":dict[@"oooVideo"];

model.hideDistance=[dict[@"hideDistance"] isKindOfClass:[NSNull class]]?0:[dict[@"hideDistance"] intValue];

model.isPay=[dict[@"isPay"] isKindOfClass:[NSNull class]]?0:[dict[@"isPay"] intValue];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.businessLogo=[dict[@"businessLogo"] isKindOfClass:[NSNull class]]?@"":dict[@"businessLogo"];

model.channelImage=[dict[@"channelImage"] isKindOfClass:[NSNull class]]?@"":dict[@"channelImage"];

model.portrait=[dict[@"portrait"] isKindOfClass:[NSNull class]]?@"":dict[@"portrait"];

model.todayIncome=[dict[@"todayIncome"] isKindOfClass:[NSNull class]]?0:[dict[@"todayIncome"] doubleValue];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.nobleAvatarFrame=[dict[@"nobleAvatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleAvatarFrame"];

model.pull=[dict[@"pull"] isKindOfClass:[NSNull class]]?@"":dict[@"pull"];

model.showid=[dict[@"showid"] isKindOfClass:[NSNull class]]?@"":dict[@"showid"];

model.sourceState=[dict[@"sourceState"] isKindOfClass:[NSNull class]]?0:[dict[@"sourceState"] intValue];

model.age=[dict[@"age"] isKindOfClass:[NSNull class]]?0:[dict[@"age"] intValue];

model.username=[dict[@"username"] isKindOfClass:[NSNull class]]?@"":dict[@"username"];


 return model;
}

 +(void)cloneObj:(HomeO2ODataModel*) source target:(HomeO2ODataModel*)target
{

target.isRecommend=source.isRecommend;

target.anchorGrade=source.anchorGrade;

target.onlineStatus=source.onlineStatus;

target.dspPay=source.dspPay;

target.freeWatchTime=source.freeWatchTime;

target.twoClassifyId=source.twoClassifyId;

target.nobleGradeImg=source.nobleGradeImg;

target.userSetOnlineStatus=source.userSetOnlineStatus;

target.roomId=source.roomId;

target.likeNum=source.likeNum;

target.roomStatus=source.roomStatus;

target.isLive=source.isLive;

target.ul=source.ul;

target.id_field=source.id_field;

target.lat=source.lat;

target.liveStatus=source.liveStatus;

target.nums=source.nums;

target.roomType=source.roomType;

target.height=source.height;

target.typeVal=source.typeVal;

target.tabName=source.tabName;

target.svipIcon=source.svipIcon;

target.headImg=source.headImg;

target.lng=source.lng;

target.liveFunction=source.liveFunction;

target.weight=source.weight;

target.whetherEnablePositioningShow=source.whetherEnablePositioningShow;

target.sort=source.sort;

target.isChecked=source.isChecked;

target.commentNum=source.commentNum;

target.hotSortId=source.hotSortId;

target.oooVoice=source.oooVoice;

target.sourceType=source.sourceType;

target.lastOffLineTime=source.lastOffLineTime;

target.position=source.position;

target.sourceCover=source.sourceCover;

target.isSvip=source.isSvip;

target.poster=source.poster;

target.coin=source.coin;

target.nobleGradeName=source.nobleGradeName;

target.anchorGradeIcon=source.anchorGradeIcon;

target.role=source.role;

target.distance=source.distance;

target.city=source.city;

target.signature=source.signature;

target.liveType=source.liveType;

target.videoCoin=source.videoCoin;

target.isPrivate=source.isPrivate;

target.title=source.title;

target.isvip=source.isvip;

target.typeDec=source.typeDec;

target.rechargeDiscount=source.rechargeDiscount;

target.voiceCoin=source.voiceCoin;

target.fireVale=source.fireVale;

target.oooLiveStatus=source.oooLiveStatus;

target.voiceTime=source.voiceTime;

target.channelId=source.channelId;

target.createDate=source.createDate;

target.oooVideoImg=source.oooVideoImg;

target.oooVideo=source.oooVideo;

target.hideDistance=source.hideDistance;

target.isPay=source.isPay;

target.sex=source.sex;

target.businessLogo=source.businessLogo;

target.channelImage=source.channelImage;

target.portrait=source.portrait;

target.todayIncome=source.todayIncome;

target.userId=source.userId;

target.nobleAvatarFrame=source.nobleAvatarFrame;

target.pull=source.pull;

target.showid=source.showid;

target.sourceState=source.sourceState;

target.age=source.age;

target.username=source.username;

}

@end

