//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "LiveLiveModel.h"




 @implementation LiveLiveModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"isRecommend"]=@(_isRecommend);

dict[@"starttime"]=[HttpClient stringFromDate:_starttime];

dict[@"gameAction"]=@(_gameAction);

dict[@"roomStatus"]=@(_roomStatus);

dict[@"shopRoomLabel"]=_shopRoomLabel;

dict[@"province"]=_province;

dict[@"id"]=@(_id_field);

dict[@"lat"]=@(_lat);

dict[@"roomType"]=@(_roomType);

dict[@"ismic"]=@(_ismic);

dict[@"islive"]=@(_islive);

dict[@"tabName"]=_tabName;

dict[@"lng"]=@(_lng);

dict[@"liveFunction"]=@(_liveFunction);

dict[@"sort"]=@(_sort);

dict[@"hotSortId"]=@(_hotSortId);

dict[@"roomTypeVal"]=_roomTypeVal;

dict[@"thumbAuditBy"]=_thumbAuditBy;

dict[@"roomAdsId8"]=@(_roomAdsId8);

dict[@"city"]=_city;

dict[@"thumb"]=_thumb;

dict[@"roomAdsId3"]=@(_roomAdsId3);

dict[@"roomAdsId2"]=@(_roomAdsId2);

dict[@"isvideo"]=@(_isvideo);

dict[@"roomAdsId1"]=@(_roomAdsId1);

dict[@"thumbAuditTime"]=[HttpClient stringFromDate:_thumbAuditTime];

dict[@"roomAdsId0"]=@(_roomAdsId0);

dict[@"roomAdsId7"]=@(_roomAdsId7);

dict[@"title"]=_title;

dict[@"roomAdsId6"]=@(_roomAdsId6);

dict[@"roomAdsId5"]=@(_roomAdsId5);

dict[@"roomAdsId4"]=@(_roomAdsId4);

dict[@"thumbAuditReason"]=_thumbAuditReason;

dict[@"adsTemplateId"]=@(_adsTemplateId);

dict[@"shopLiveBanner"]=_shopLiveBanner;

dict[@"stream"]=_stream;

dict[@"nickname"]=_nickname;

dict[@"importTemplateId"]=@(_importTemplateId);

dict[@"tabStyle"]=_tabStyle;

dict[@"thumbState"]=@(_thumbState);

dict[@"bankerCoin"]=@(_bankerCoin);

dict[@"channelId"]=@(_channelId);

dict[@"notice"]=_notice;

dict[@"isEnableAdsTemplate"]=@(_isEnableAdsTemplate);

dict[@"address"]=_address;

dict[@"avatar"]=_avatar;

dict[@"demoAccount"]=@(_demoAccount);

dict[@"userId"]=@(_userId);

dict[@"liveLockStatus"]=@(_liveLockStatus);

dict[@"hotvotes"]=@(_hotvotes);

dict[@"pull"]=_pull;

dict[@"showid"]=_showid;

dict[@"goodnum"]=_goodnum;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<LiveLiveModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
LiveLiveModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<LiveLiveModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<LiveLiveModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
LiveLiveModel* sumMdl=[LiveLiveModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(LiveLiveModel*)getFromDict:(NSDictionary*)dict
{
LiveLiveModel* model=[[LiveLiveModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.isRecommend=[dict[@"isRecommend"] isKindOfClass:[NSNull class]]?0:[dict[@"isRecommend"] intValue];


{
NSString *strDate= dict[@"starttime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.starttime=date;
    }
}

model.gameAction=[dict[@"gameAction"] isKindOfClass:[NSNull class]]?0:[dict[@"gameAction"] intValue];

model.roomStatus=[dict[@"roomStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"roomStatus"] intValue];

model.shopRoomLabel=[dict[@"shopRoomLabel"] isKindOfClass:[NSNull class]]?@"":dict[@"shopRoomLabel"];

model.province=[dict[@"province"] isKindOfClass:[NSNull class]]?@"":dict[@"province"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.lat=[dict[@"lat"] isKindOfClass:[NSNull class]]?0:[dict[@"lat"] doubleValue];

model.roomType=[dict[@"roomType"] isKindOfClass:[NSNull class]]?0:[dict[@"roomType"] intValue];

model.ismic=[dict[@"ismic"] isKindOfClass:[NSNull class]]?0:[dict[@"ismic"] intValue];

model.islive=[dict[@"islive"] isKindOfClass:[NSNull class]]?0:[dict[@"islive"] intValue];

model.tabName=[dict[@"tabName"] isKindOfClass:[NSNull class]]?@"":dict[@"tabName"];

model.lng=[dict[@"lng"] isKindOfClass:[NSNull class]]?0:[dict[@"lng"] doubleValue];

model.liveFunction=[dict[@"liveFunction"] isKindOfClass:[NSNull class]]?0:[dict[@"liveFunction"] intValue];

model.sort=[dict[@"sort"] isKindOfClass:[NSNull class]]?0:[dict[@"sort"] intValue];

model.hotSortId=[dict[@"hotSortId"] isKindOfClass:[NSNull class]]?0:[dict[@"hotSortId"] longLongValue];

model.roomTypeVal=[dict[@"roomTypeVal"] isKindOfClass:[NSNull class]]?@"":dict[@"roomTypeVal"];

model.thumbAuditBy=[dict[@"thumbAuditBy"] isKindOfClass:[NSNull class]]?@"":dict[@"thumbAuditBy"];

model.roomAdsId8=[dict[@"roomAdsId8"] isKindOfClass:[NSNull class]]?0:[dict[@"roomAdsId8"] longLongValue];

model.city=[dict[@"city"] isKindOfClass:[NSNull class]]?@"":dict[@"city"];

model.thumb=[dict[@"thumb"] isKindOfClass:[NSNull class]]?@"":dict[@"thumb"];

model.roomAdsId3=[dict[@"roomAdsId3"] isKindOfClass:[NSNull class]]?0:[dict[@"roomAdsId3"] longLongValue];

model.roomAdsId2=[dict[@"roomAdsId2"] isKindOfClass:[NSNull class]]?0:[dict[@"roomAdsId2"] longLongValue];

model.isvideo=[dict[@"isvideo"] isKindOfClass:[NSNull class]]?0:[dict[@"isvideo"] intValue];

model.roomAdsId1=[dict[@"roomAdsId1"] isKindOfClass:[NSNull class]]?0:[dict[@"roomAdsId1"] longLongValue];


{
NSString *strDate= dict[@"thumbAuditTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.thumbAuditTime=date;
    }
}

model.roomAdsId0=[dict[@"roomAdsId0"] isKindOfClass:[NSNull class]]?0:[dict[@"roomAdsId0"] longLongValue];

model.roomAdsId7=[dict[@"roomAdsId7"] isKindOfClass:[NSNull class]]?0:[dict[@"roomAdsId7"] longLongValue];

model.title=[dict[@"title"] isKindOfClass:[NSNull class]]?@"":dict[@"title"];

model.roomAdsId6=[dict[@"roomAdsId6"] isKindOfClass:[NSNull class]]?0:[dict[@"roomAdsId6"] longLongValue];

model.roomAdsId5=[dict[@"roomAdsId5"] isKindOfClass:[NSNull class]]?0:[dict[@"roomAdsId5"] longLongValue];

model.roomAdsId4=[dict[@"roomAdsId4"] isKindOfClass:[NSNull class]]?0:[dict[@"roomAdsId4"] longLongValue];

model.thumbAuditReason=[dict[@"thumbAuditReason"] isKindOfClass:[NSNull class]]?@"":dict[@"thumbAuditReason"];

model.adsTemplateId=[dict[@"adsTemplateId"] isKindOfClass:[NSNull class]]?0:[dict[@"adsTemplateId"] longLongValue];

model.shopLiveBanner=[dict[@"shopLiveBanner"] isKindOfClass:[NSNull class]]?@"":dict[@"shopLiveBanner"];

model.stream=[dict[@"stream"] isKindOfClass:[NSNull class]]?@"":dict[@"stream"];

model.nickname=[dict[@"nickname"] isKindOfClass:[NSNull class]]?@"":dict[@"nickname"];

model.importTemplateId=[dict[@"importTemplateId"] isKindOfClass:[NSNull class]]?0:[dict[@"importTemplateId"] longLongValue];

model.tabStyle=[dict[@"tabStyle"] isKindOfClass:[NSNull class]]?@"":dict[@"tabStyle"];

model.thumbState=[dict[@"thumbState"] isKindOfClass:[NSNull class]]?0:[dict[@"thumbState"] intValue];

model.bankerCoin=[dict[@"bankerCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"bankerCoin"] intValue];

model.channelId=[dict[@"channelId"] isKindOfClass:[NSNull class]]?0:[dict[@"channelId"] longLongValue];

model.notice=[dict[@"notice"] isKindOfClass:[NSNull class]]?@"":dict[@"notice"];

model.isEnableAdsTemplate=[dict[@"isEnableAdsTemplate"] isKindOfClass:[NSNull class]]?0:[dict[@"isEnableAdsTemplate"] intValue];

model.address=[dict[@"address"] isKindOfClass:[NSNull class]]?@"":dict[@"address"];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.demoAccount=[dict[@"demoAccount"] isKindOfClass:[NSNull class]]?0:[dict[@"demoAccount"] intValue];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.liveLockStatus=[dict[@"liveLockStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"liveLockStatus"] intValue];

model.hotvotes=[dict[@"hotvotes"] isKindOfClass:[NSNull class]]?0:[dict[@"hotvotes"] intValue];

model.pull=[dict[@"pull"] isKindOfClass:[NSNull class]]?@"":dict[@"pull"];

model.showid=[dict[@"showid"] isKindOfClass:[NSNull class]]?@"":dict[@"showid"];

model.goodnum=[dict[@"goodnum"] isKindOfClass:[NSNull class]]?@"":dict[@"goodnum"];


 return model;
}

 +(void)cloneObj:(LiveLiveModel*) source target:(LiveLiveModel*)target
{

target.isRecommend=source.isRecommend;

target.starttime=source.starttime;

target.gameAction=source.gameAction;

target.roomStatus=source.roomStatus;

target.shopRoomLabel=source.shopRoomLabel;

target.province=source.province;

target.id_field=source.id_field;

target.lat=source.lat;

target.roomType=source.roomType;

target.ismic=source.ismic;

target.islive=source.islive;

target.tabName=source.tabName;

target.lng=source.lng;

target.liveFunction=source.liveFunction;

target.sort=source.sort;

target.hotSortId=source.hotSortId;

target.roomTypeVal=source.roomTypeVal;

target.thumbAuditBy=source.thumbAuditBy;

target.roomAdsId8=source.roomAdsId8;

target.city=source.city;

target.thumb=source.thumb;

target.roomAdsId3=source.roomAdsId3;

target.roomAdsId2=source.roomAdsId2;

target.isvideo=source.isvideo;

target.roomAdsId1=source.roomAdsId1;

target.thumbAuditTime=source.thumbAuditTime;

target.roomAdsId0=source.roomAdsId0;

target.roomAdsId7=source.roomAdsId7;

target.title=source.title;

target.roomAdsId6=source.roomAdsId6;

target.roomAdsId5=source.roomAdsId5;

target.roomAdsId4=source.roomAdsId4;

target.thumbAuditReason=source.thumbAuditReason;

target.adsTemplateId=source.adsTemplateId;

target.shopLiveBanner=source.shopLiveBanner;

target.stream=source.stream;

target.nickname=source.nickname;

target.importTemplateId=source.importTemplateId;

target.tabStyle=source.tabStyle;

target.thumbState=source.thumbState;

target.bankerCoin=source.bankerCoin;

target.channelId=source.channelId;

target.notice=source.notice;

target.isEnableAdsTemplate=source.isEnableAdsTemplate;

target.address=source.address;

target.avatar=source.avatar;

target.demoAccount=source.demoAccount;

target.userId=source.userId;

target.liveLockStatus=source.liveLockStatus;

target.hotvotes=source.hotvotes;

target.pull=source.pull;

target.showid=source.showid;

target.goodnum=source.goodnum;

}

@end

