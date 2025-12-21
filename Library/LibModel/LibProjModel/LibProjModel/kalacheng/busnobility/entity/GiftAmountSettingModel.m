//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "GiftAmountSettingModel.h"




 @implementation GiftAmountSettingModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"serialNumber"]=@(_serialNumber);

dict[@"numberDescription"]=_numberDescription;

dict[@"createTime"]=[HttpClient stringFromDate:_createTime];

dict[@"numberOfGifts"]=@(_numberOfGifts);

dict[@"updateTime"]=[HttpClient stringFromDate:_updateTime];

dict[@"id"]=@(_id_field);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GiftAmountSettingModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
GiftAmountSettingModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<GiftAmountSettingModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<GiftAmountSettingModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
GiftAmountSettingModel* sumMdl=[GiftAmountSettingModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(GiftAmountSettingModel*)getFromDict:(NSDictionary*)dict
{
GiftAmountSettingModel* model=[[GiftAmountSettingModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.serialNumber=[dict[@"serialNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"serialNumber"] intValue];

model.numberDescription=[dict[@"numberDescription"] isKindOfClass:[NSNull class]]?@"":dict[@"numberDescription"];


{
NSString *strDate= dict[@"createTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.createTime=date;
    }
}

model.numberOfGifts=[dict[@"numberOfGifts"] isKindOfClass:[NSNull class]]?0:[dict[@"numberOfGifts"] intValue];


{
NSString *strDate= dict[@"updateTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.updateTime=date;
    }
}

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];


 return model;
}

 +(void)cloneObj:(GiftAmountSettingModel*) source target:(GiftAmountSettingModel*)target
{

target.serialNumber=source.serialNumber;

target.numberDescription=source.numberDescription;

target.createTime=source.createTime;

target.numberOfGifts=source.numberOfGifts;

target.updateTime=source.updateTime;

target.id_field=source.id_field;

}

@end

