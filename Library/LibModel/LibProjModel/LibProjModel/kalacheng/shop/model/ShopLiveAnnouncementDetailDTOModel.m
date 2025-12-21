//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopLiveAnnouncementDetailDTOModel.h"




 @implementation ShopLiveAnnouncementDetailDTOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"isAttention"]=@(_isAttention);

dict[@"liveDate"]=_liveDate;

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"startTime"]=[HttpClient stringFromDate:_startTime];

dict[@"id"]=@(_id_field);

dict[@"anchorId"]=@(_anchorId);

dict[@"posterStickers"]=_posterStickers;

dict[@"title"]=_title;

dict[@"roomId"]=@(_roomId);

dict[@"shopCategory"]=_shopCategory;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopLiveAnnouncementDetailDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopLiveAnnouncementDetailDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopLiveAnnouncementDetailDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopLiveAnnouncementDetailDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopLiveAnnouncementDetailDTOModel* sumMdl=[ShopLiveAnnouncementDetailDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopLiveAnnouncementDetailDTOModel*)getFromDict:(NSDictionary*)dict
{
ShopLiveAnnouncementDetailDTOModel* model=[[ShopLiveAnnouncementDetailDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.isAttention=[dict[@"isAttention"] isKindOfClass:[NSNull class]]?0:[dict[@"isAttention"] intValue];

model.liveDate=[dict[@"liveDate"] isKindOfClass:[NSNull class]]?@"":dict[@"liveDate"];


{
NSString *strDate= dict[@"addTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addTime=date;
    }
}


{
NSString *strDate= dict[@"startTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.startTime=date;
    }
}

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.anchorId=[dict[@"anchorId"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorId"] longLongValue];

model.posterStickers=[dict[@"posterStickers"] isKindOfClass:[NSNull class]]?@"":dict[@"posterStickers"];

model.title=[dict[@"title"] isKindOfClass:[NSNull class]]?@"":dict[@"title"];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];

model.shopCategory=[dict[@"shopCategory"] isKindOfClass:[NSNull class]]?@"":dict[@"shopCategory"];


 return model;
}

 +(void)cloneObj:(ShopLiveAnnouncementDetailDTOModel*) source target:(ShopLiveAnnouncementDetailDTOModel*)target
{

target.isAttention=source.isAttention;

target.liveDate=source.liveDate;

target.addTime=source.addTime;

target.startTime=source.startTime;

target.id_field=source.id_field;

target.anchorId=source.anchorId;

target.posterStickers=source.posterStickers;

target.title=source.title;

target.roomId=source.roomId;

target.shopCategory=source.shopCategory;

}

@end

