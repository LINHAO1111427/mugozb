//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiCfgPayCallOneVsOneModel.h"




 @implementation ApiCfgPayCallOneVsOneModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"tabIdList"]=_tabIdList;

dict[@"voice"]=_voice;

dict[@"hideDistance"]=@(_hideDistance);

dict[@"distance"]=_distance;

dict[@"lng"]=@(_lng);

dict[@"city"]=_city;

dict[@"openState"]=@(_openState);

dict[@"videoCoin"]=@(_videoCoin);

dict[@"videoImg"]=_videoImg;

dict[@"liveThumb"]=_liveThumb;

dict[@"updateTime"]=[HttpClient stringFromDate:_updateTime];

dict[@"whetherEnablePositioningShow"]=@(_whetherEnablePositioningShow);

dict[@"video"]=_video;

dict[@"userName"]=_userName;

dict[@"userId"]=@(_userId);

dict[@"province"]=_province;

dict[@"createTime"]=[HttpClient stringFromDate:_createTime];

dict[@"invitedFlag"]=@(_invitedFlag);

dict[@"voiceCoin"]=@(_voiceCoin);

dict[@"id"]=@(_id_field);

dict[@"poster"]=_poster;

dict[@"lat"]=@(_lat);

dict[@"remarks"]=_remarks;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiCfgPayCallOneVsOneModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiCfgPayCallOneVsOneModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiCfgPayCallOneVsOneModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiCfgPayCallOneVsOneModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiCfgPayCallOneVsOneModel* sumMdl=[ApiCfgPayCallOneVsOneModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiCfgPayCallOneVsOneModel*)getFromDict:(NSDictionary*)dict
{
ApiCfgPayCallOneVsOneModel* model=[[ApiCfgPayCallOneVsOneModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.tabIdList=[dict[@"tabIdList"] isKindOfClass:[NSNull class]]?@"":dict[@"tabIdList"];

model.voice=[dict[@"voice"] isKindOfClass:[NSNull class]]?@"":dict[@"voice"];

model.hideDistance=[dict[@"hideDistance"] isKindOfClass:[NSNull class]]?0:[dict[@"hideDistance"] intValue];

model.distance=[dict[@"distance"] isKindOfClass:[NSNull class]]?@"":dict[@"distance"];

model.lng=[dict[@"lng"] isKindOfClass:[NSNull class]]?0:[dict[@"lng"] doubleValue];

model.city=[dict[@"city"] isKindOfClass:[NSNull class]]?@"":dict[@"city"];

model.openState=[dict[@"openState"] isKindOfClass:[NSNull class]]?0:[dict[@"openState"] intValue];

model.videoCoin=[dict[@"videoCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"videoCoin"] doubleValue];

model.videoImg=[dict[@"videoImg"] isKindOfClass:[NSNull class]]?@"":dict[@"videoImg"];

model.liveThumb=[dict[@"liveThumb"] isKindOfClass:[NSNull class]]?@"":dict[@"liveThumb"];


{
NSString *strDate= dict[@"updateTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.updateTime=date;
    }
}

model.whetherEnablePositioningShow=[dict[@"whetherEnablePositioningShow"] isKindOfClass:[NSNull class]]?0:[dict[@"whetherEnablePositioningShow"] intValue];

model.video=[dict[@"video"] isKindOfClass:[NSNull class]]?@"":dict[@"video"];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.province=[dict[@"province"] isKindOfClass:[NSNull class]]?@"":dict[@"province"];


{
NSString *strDate= dict[@"createTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.createTime=date;
    }
}

model.invitedFlag=[dict[@"invitedFlag"] isKindOfClass:[NSNull class]]?0:[dict[@"invitedFlag"] intValue];

model.voiceCoin=[dict[@"voiceCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"voiceCoin"] doubleValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.poster=[dict[@"poster"] isKindOfClass:[NSNull class]]?@"":dict[@"poster"];

model.lat=[dict[@"lat"] isKindOfClass:[NSNull class]]?0:[dict[@"lat"] doubleValue];

model.remarks=[dict[@"remarks"] isKindOfClass:[NSNull class]]?@"":dict[@"remarks"];


 return model;
}

 +(void)cloneObj:(ApiCfgPayCallOneVsOneModel*) source target:(ApiCfgPayCallOneVsOneModel*)target
{

target.tabIdList=source.tabIdList;

target.voice=source.voice;

target.hideDistance=source.hideDistance;

target.distance=source.distance;

target.lng=source.lng;

target.city=source.city;

target.openState=source.openState;

target.videoCoin=source.videoCoin;

target.videoImg=source.videoImg;

target.liveThumb=source.liveThumb;

target.updateTime=source.updateTime;

target.whetherEnablePositioningShow=source.whetherEnablePositioningShow;

target.video=source.video;

target.userName=source.userName;

target.userId=source.userId;

target.province=source.province;

target.createTime=source.createTime;

target.invitedFlag=source.invitedFlag;

target.voiceCoin=source.voiceCoin;

target.id_field=source.id_field;

target.poster=source.poster;

target.lat=source.lat;

target.remarks=source.remarks;

}

@end

