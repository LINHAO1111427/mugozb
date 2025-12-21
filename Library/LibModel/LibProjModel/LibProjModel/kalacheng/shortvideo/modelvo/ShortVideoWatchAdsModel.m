//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShortVideoWatchAdsModel.h"




 @implementation ShortVideoWatchAdsModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"adsIcon"]=_adsIcon;

dict[@"upTime"]=[HttpClient stringFromDate:_upTime];

dict[@"adsUrl"]=_adsUrl;

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"adsTitle"]=_adsTitle;

dict[@"adsType"]=@(_adsType);

dict[@"adsDescription"]=_adsDescription;

dict[@"id"]=@(_id_field);

dict[@"isEnable"]=@(_isEnable);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShortVideoWatchAdsModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShortVideoWatchAdsModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShortVideoWatchAdsModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShortVideoWatchAdsModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShortVideoWatchAdsModel* sumMdl=[ShortVideoWatchAdsModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShortVideoWatchAdsModel*)getFromDict:(NSDictionary*)dict
{
ShortVideoWatchAdsModel* model=[[ShortVideoWatchAdsModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.adsIcon=[dict[@"adsIcon"] isKindOfClass:[NSNull class]]?@"":dict[@"adsIcon"];


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

model.adsType=[dict[@"adsType"] isKindOfClass:[NSNull class]]?0:[dict[@"adsType"] intValue];

model.adsDescription=[dict[@"adsDescription"] isKindOfClass:[NSNull class]]?@"":dict[@"adsDescription"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.isEnable=[dict[@"isEnable"] isKindOfClass:[NSNull class]]?0:[dict[@"isEnable"] intValue];


 return model;
}

 +(void)cloneObj:(ShortVideoWatchAdsModel*) source target:(ShortVideoWatchAdsModel*)target
{

target.adsIcon=source.adsIcon;

target.upTime=source.upTime;

target.adsUrl=source.adsUrl;

target.addTime=source.addTime;

target.adsTitle=source.adsTitle;

target.adsType=source.adsType;

target.adsDescription=source.adsDescription;

target.id_field=source.id_field;

target.isEnable=source.isEnable;

}

@end

