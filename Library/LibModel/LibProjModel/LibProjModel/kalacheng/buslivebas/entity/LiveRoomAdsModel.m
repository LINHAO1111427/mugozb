//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "LiveRoomAdsModel.h"




 @implementation LiveRoomAdsModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"adsJumpType"]=@(_adsJumpType);

dict[@"upTime"]=[HttpClient stringFromDate:_upTime];

dict[@"adsUrl"]=_adsUrl;

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"adsTitle"]=_adsTitle;

dict[@"adsLevel"]=@(_adsLevel);

dict[@"id"]=@(_id_field);

dict[@"adsImage"]=_adsImage;

dict[@"superiorId"]=@(_superiorId);

dict[@"isEnable"]=@(_isEnable);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<LiveRoomAdsModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
LiveRoomAdsModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<LiveRoomAdsModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<LiveRoomAdsModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
LiveRoomAdsModel* sumMdl=[LiveRoomAdsModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(LiveRoomAdsModel*)getFromDict:(NSDictionary*)dict
{
LiveRoomAdsModel* model=[[LiveRoomAdsModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.adsJumpType=[dict[@"adsJumpType"] isKindOfClass:[NSNull class]]?0:[dict[@"adsJumpType"] intValue];


{
NSString *strDate= dict[@"upTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.upTime=date;
    }
}

model.adsUrl=[dict[@"adsUrl"] isKindOfClass:[NSNull class]]?@"":dict[@"adsUrl"];


{
NSString *strDate= dict[@"addTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addTime=date;
    }
}

model.adsTitle=[dict[@"adsTitle"] isKindOfClass:[NSNull class]]?@"":dict[@"adsTitle"];

model.adsLevel=[dict[@"adsLevel"] isKindOfClass:[NSNull class]]?0:[dict[@"adsLevel"] intValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.adsImage=[dict[@"adsImage"] isKindOfClass:[NSNull class]]?@"":dict[@"adsImage"];

model.superiorId=[dict[@"superiorId"] isKindOfClass:[NSNull class]]?0:[dict[@"superiorId"] longLongValue];

model.isEnable=[dict[@"isEnable"] isKindOfClass:[NSNull class]]?0:[dict[@"isEnable"] intValue];


 return model;
}

 +(void)cloneObj:(LiveRoomAdsModel*) source target:(LiveRoomAdsModel*)target
{

target.adsJumpType=source.adsJumpType;

target.upTime=source.upTime;

target.adsUrl=source.adsUrl;

target.addTime=source.addTime;

target.adsTitle=source.adsTitle;

target.adsLevel=source.adsLevel;

target.id_field=source.id_field;

target.adsImage=source.adsImage;

target.superiorId=source.superiorId;

target.isEnable=source.isEnable;

}

@end

