//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppUserTaskRecordModel.h"




 @implementation AppUserTaskRecordModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"upTime"]=[HttpClient stringFromDate:_upTime];

dict[@"role"]=@(_role);

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"name"]=_name;

dict[@"taskCompletionType"]=@(_taskCompletionType);

dict[@"id"]=@(_id_field);

dict[@"isFinish"]=@(_isFinish);

dict[@"totalTaskVal"]=@(_totalTaskVal);

dict[@"userId"]=@(_userId);

dict[@"point"]=@(_point);

dict[@"taskId"]=@(_taskId);

dict[@"typeCode"]=_typeCode;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUserTaskRecordModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppUserTaskRecordModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppUserTaskRecordModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppUserTaskRecordModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppUserTaskRecordModel* sumMdl=[AppUserTaskRecordModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppUserTaskRecordModel*)getFromDict:(NSDictionary*)dict
{
AppUserTaskRecordModel* model=[[AppUserTaskRecordModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }

{
NSString *strDate= dict[@"upTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.upTime=date;
    }
}

model.role=[dict[@"role"] isKindOfClass:[NSNull class]]?0:[dict[@"role"] intValue];


{
NSString *strDate= dict[@"addTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addTime=date;
    }
}

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.taskCompletionType=[dict[@"taskCompletionType"] isKindOfClass:[NSNull class]]?0:[dict[@"taskCompletionType"] intValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.isFinish=[dict[@"isFinish"] isKindOfClass:[NSNull class]]?0:[dict[@"isFinish"] intValue];

model.totalTaskVal=[dict[@"totalTaskVal"] isKindOfClass:[NSNull class]]?0:[dict[@"totalTaskVal"] doubleValue];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.point=[dict[@"point"] isKindOfClass:[NSNull class]]?0:[dict[@"point"] intValue];

model.taskId=[dict[@"taskId"] isKindOfClass:[NSNull class]]?0:[dict[@"taskId"] longLongValue];

model.typeCode=[dict[@"typeCode"] isKindOfClass:[NSNull class]]?@"":dict[@"typeCode"];


 return model;
}

 +(void)cloneObj:(AppUserTaskRecordModel*) source target:(AppUserTaskRecordModel*)target
{

target.upTime=source.upTime;

target.role=source.role;

target.addTime=source.addTime;

target.name=source.name;

target.taskCompletionType=source.taskCompletionType;

target.id_field=source.id_field;

target.isFinish=source.isFinish;

target.totalTaskVal=source.totalTaskVal;

target.userId=source.userId;

target.point=source.point;

target.taskId=source.taskId;

target.typeCode=source.typeCode;

}

@end

