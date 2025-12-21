//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiUsersLineModel.h"




 @implementation ApiUsersLineModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"birthday"]=_birthday;

dict[@"role"]=@(_role);

dict[@"distance"]=_distance;

dict[@"city"]=_city;

dict[@"signature"]=_signature;

dict[@"thumb"]=_thumb;

dict[@"liveType"]=@(_liveType);

dict[@"onlineStatus"]=@(_onlineStatus);

dict[@"userGradeImg"]=_userGradeImg;

dict[@"videoCoin"]=@(_videoCoin);

dict[@"nobleMedal"]=_nobleMedal;

dict[@"title"]=_title;

dict[@"type"]=@(_type);

dict[@"nobleGradeImg"]=_nobleGradeImg;

dict[@"userSetOnlineStatus"]=@(_userSetOnlineStatus);

dict[@"roomId"]=@(_roomId);

dict[@"typeDec"]=_typeDec;

dict[@"uid"]=@(_uid);

dict[@"constellation"]=_constellation;

dict[@"offLineTime"]=_offLineTime;

dict[@"voiceCoin"]=@(_voiceCoin);

dict[@"liveStatus"]=@(_liveStatus);

dict[@"height"]=@(_height);

dict[@"coinType"]=_coinType;

dict[@"wealthGradeImg"]=_wealthGradeImg;

dict[@"typeVal"]=_typeVal;

dict[@"address"]=_address;

dict[@"hideDistance"]=@(_hideDistance);

dict[@"isPay"]=@(_isPay);

dict[@"svipIcon"]=_svipIcon;

dict[@"sex"]=@(_sex);

dict[@"weight"]=@(_weight);

dict[@"whetherEnablePositioningShow"]=@(_whetherEnablePositioningShow);

dict[@"avatar"]=_avatar;

dict[@"portrait"]=_portrait;

dict[@"userName"]=_userName;

dict[@"nobleAvatarFrame"]=_nobleAvatarFrame;

dict[@"anchorGradeImg"]=_anchorGradeImg;

dict[@"showid"]=_showid;

dict[@"offLineTimeData"]=[HttpClient stringFromDate:_offLineTimeData];

dict[@"sourceType"]=@(_sourceType);

dict[@"lastOffLineTime"]=[HttpClient stringFromDate:_lastOffLineTime];

dict[@"isSvip"]=@(_isSvip);

dict[@"age"]=@(_age);

dict[@"coin"]=@(_coin);

dict[@"isSayCoin"]=@(_isSayCoin);

dict[@"status"]=@(_status);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUsersLineModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiUsersLineModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiUsersLineModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiUsersLineModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiUsersLineModel* sumMdl=[ApiUsersLineModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiUsersLineModel*)getFromDict:(NSDictionary*)dict
{
ApiUsersLineModel* model=[[ApiUsersLineModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.birthday=[dict[@"birthday"] isKindOfClass:[NSNull class]]?@"":dict[@"birthday"];

model.role=[dict[@"role"] isKindOfClass:[NSNull class]]?0:[dict[@"role"] intValue];

model.distance=[dict[@"distance"] isKindOfClass:[NSNull class]]?@"":dict[@"distance"];

model.city=[dict[@"city"] isKindOfClass:[NSNull class]]?@"":dict[@"city"];

model.signature=[dict[@"signature"] isKindOfClass:[NSNull class]]?@"":dict[@"signature"];

model.thumb=[dict[@"thumb"] isKindOfClass:[NSNull class]]?@"":dict[@"thumb"];

model.liveType=[dict[@"liveType"] isKindOfClass:[NSNull class]]?0:[dict[@"liveType"] intValue];

model.onlineStatus=[dict[@"onlineStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"onlineStatus"] intValue];

model.userGradeImg=[dict[@"userGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"userGradeImg"];

model.videoCoin=[dict[@"videoCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"videoCoin"] doubleValue];

model.nobleMedal=[dict[@"nobleMedal"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleMedal"];

model.title=[dict[@"title"] isKindOfClass:[NSNull class]]?@"":dict[@"title"];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];

model.nobleGradeImg=[dict[@"nobleGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleGradeImg"];

model.userSetOnlineStatus=[dict[@"userSetOnlineStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"userSetOnlineStatus"] intValue];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];

model.typeDec=[dict[@"typeDec"] isKindOfClass:[NSNull class]]?@"":dict[@"typeDec"];

model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];

model.constellation=[dict[@"constellation"] isKindOfClass:[NSNull class]]?@"":dict[@"constellation"];

model.offLineTime=[dict[@"offLineTime"] isKindOfClass:[NSNull class]]?@"":dict[@"offLineTime"];

model.voiceCoin=[dict[@"voiceCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"voiceCoin"] doubleValue];

model.liveStatus=[dict[@"liveStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"liveStatus"] intValue];

model.height=[dict[@"height"] isKindOfClass:[NSNull class]]?0:[dict[@"height"] intValue];

model.coinType=[dict[@"coinType"] isKindOfClass:[NSNull class]]?@"":dict[@"coinType"];

model.wealthGradeImg=[dict[@"wealthGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"wealthGradeImg"];

model.typeVal=[dict[@"typeVal"] isKindOfClass:[NSNull class]]?@"":dict[@"typeVal"];

model.address=[dict[@"address"] isKindOfClass:[NSNull class]]?@"":dict[@"address"];

model.hideDistance=[dict[@"hideDistance"] isKindOfClass:[NSNull class]]?0:[dict[@"hideDistance"] intValue];

model.isPay=[dict[@"isPay"] isKindOfClass:[NSNull class]]?0:[dict[@"isPay"] intValue];

model.svipIcon=[dict[@"svipIcon"] isKindOfClass:[NSNull class]]?@"":dict[@"svipIcon"];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.weight=[dict[@"weight"] isKindOfClass:[NSNull class]]?0:[dict[@"weight"] doubleValue];

model.whetherEnablePositioningShow=[dict[@"whetherEnablePositioningShow"] isKindOfClass:[NSNull class]]?0:[dict[@"whetherEnablePositioningShow"] intValue];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.portrait=[dict[@"portrait"] isKindOfClass:[NSNull class]]?@"":dict[@"portrait"];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.nobleAvatarFrame=[dict[@"nobleAvatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleAvatarFrame"];

model.anchorGradeImg=[dict[@"anchorGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorGradeImg"];

model.showid=[dict[@"showid"] isKindOfClass:[NSNull class]]?@"":dict[@"showid"];


{
NSString *strDate= dict[@"offLineTimeData"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.offLineTimeData=date;
    }
}

model.sourceType=[dict[@"sourceType"] isKindOfClass:[NSNull class]]?0:[dict[@"sourceType"] intValue];


{
NSString *strDate= dict[@"lastOffLineTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.lastOffLineTime=date;
    }
}

model.isSvip=[dict[@"isSvip"] isKindOfClass:[NSNull class]]?0:[dict[@"isSvip"] intValue];

model.age=[dict[@"age"] isKindOfClass:[NSNull class]]?0:[dict[@"age"] intValue];

model.coin=[dict[@"coin"] isKindOfClass:[NSNull class]]?0:[dict[@"coin"] doubleValue];

model.isSayCoin=[dict[@"isSayCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"isSayCoin"] intValue];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];


 return model;
}

 +(void)cloneObj:(ApiUsersLineModel*) source target:(ApiUsersLineModel*)target
{

target.birthday=source.birthday;

target.role=source.role;

target.distance=source.distance;

target.city=source.city;

target.signature=source.signature;

target.thumb=source.thumb;

target.liveType=source.liveType;

target.onlineStatus=source.onlineStatus;

target.userGradeImg=source.userGradeImg;

target.videoCoin=source.videoCoin;

target.nobleMedal=source.nobleMedal;

target.title=source.title;

target.type=source.type;

target.nobleGradeImg=source.nobleGradeImg;

target.userSetOnlineStatus=source.userSetOnlineStatus;

target.roomId=source.roomId;

target.typeDec=source.typeDec;

target.uid=source.uid;

target.constellation=source.constellation;

target.offLineTime=source.offLineTime;

target.voiceCoin=source.voiceCoin;

target.liveStatus=source.liveStatus;

target.height=source.height;

target.coinType=source.coinType;

target.wealthGradeImg=source.wealthGradeImg;

target.typeVal=source.typeVal;

target.address=source.address;

target.hideDistance=source.hideDistance;

target.isPay=source.isPay;

target.svipIcon=source.svipIcon;

target.sex=source.sex;

target.weight=source.weight;

target.whetherEnablePositioningShow=source.whetherEnablePositioningShow;

target.avatar=source.avatar;

target.portrait=source.portrait;

target.userName=source.userName;

target.nobleAvatarFrame=source.nobleAvatarFrame;

target.anchorGradeImg=source.anchorGradeImg;

target.showid=source.showid;

target.offLineTimeData=source.offLineTimeData;

target.sourceType=source.sourceType;

target.lastOffLineTime=source.lastOffLineTime;

target.isSvip=source.isSvip;

target.age=source.age;

target.coin=source.coin;

target.isSayCoin=source.isSayCoin;

target.status=source.status;

}

@end

