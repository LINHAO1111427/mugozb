//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppTrendsRecordModel.h"




 @implementation AppTrendsRecordModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"address"]=_address;

dict[@"reserve4"]=_reserve4;

dict[@"latitude"]=_latitude;

dict[@"reserve1"]=_reserve1;

dict[@"reserve3"]=_reserve3;

dict[@"targetUserId"]=@(_targetUserId);

dict[@"reserve2"]=_reserve2;

dict[@"source"]=_source;

dict[@"title"]=_title;

dict[@"type"]=@(_type);

dict[@"userId"]=@(_userId);

dict[@"fkId"]=@(_fkId);

dict[@"recordId"]=@(_recordId);

dict[@"createTime"]=[HttpClient stringFromDate:_createTime];

dict[@"sourceType"]=@(_sourceType);

dict[@"id"]=@(_id_field);

dict[@"longitude"]=_longitude;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppTrendsRecordModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppTrendsRecordModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppTrendsRecordModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppTrendsRecordModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppTrendsRecordModel* sumMdl=[AppTrendsRecordModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppTrendsRecordModel*)getFromDict:(NSDictionary*)dict
{
AppTrendsRecordModel* model=[[AppTrendsRecordModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.address=[dict[@"address"] isKindOfClass:[NSNull class]]?@"":dict[@"address"];

model.reserve4=[dict[@"reserve4"] isKindOfClass:[NSNull class]]?@"":dict[@"reserve4"];

model.latitude=[dict[@"latitude"] isKindOfClass:[NSNull class]]?@"":dict[@"latitude"];

model.reserve1=[dict[@"reserve1"] isKindOfClass:[NSNull class]]?@"":dict[@"reserve1"];

model.reserve3=[dict[@"reserve3"] isKindOfClass:[NSNull class]]?@"":dict[@"reserve3"];

model.targetUserId=[dict[@"targetUserId"] isKindOfClass:[NSNull class]]?0:[dict[@"targetUserId"] longLongValue];

model.reserve2=[dict[@"reserve2"] isKindOfClass:[NSNull class]]?@"":dict[@"reserve2"];

model.source=[dict[@"source"] isKindOfClass:[NSNull class]]?@"":dict[@"source"];

model.title=[dict[@"title"] isKindOfClass:[NSNull class]]?@"":dict[@"title"];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.fkId=[dict[@"fkId"] isKindOfClass:[NSNull class]]?0:[dict[@"fkId"] longLongValue];

model.recordId=[dict[@"recordId"] isKindOfClass:[NSNull class]]?0:[dict[@"recordId"] longLongValue];


{
NSString *strDate= dict[@"createTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.createTime=date;
    }
}

model.sourceType=[dict[@"sourceType"] isKindOfClass:[NSNull class]]?0:[dict[@"sourceType"] intValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.longitude=[dict[@"longitude"] isKindOfClass:[NSNull class]]?@"":dict[@"longitude"];


 return model;
}

 +(void)cloneObj:(AppTrendsRecordModel*) source target:(AppTrendsRecordModel*)target
{

target.address=source.address;

target.reserve4=source.reserve4;

target.latitude=source.latitude;

target.reserve1=source.reserve1;

target.reserve3=source.reserve3;

target.targetUserId=source.targetUserId;

target.reserve2=source.reserve2;

target.source=source.source;

target.title=source.title;

target.type=source.type;

target.userId=source.userId;

target.fkId=source.fkId;

target.recordId=source.recordId;

target.createTime=source.createTime;

target.sourceType=source.sourceType;

target.id_field=source.id_field;

target.longitude=source.longitude;

}

@end

