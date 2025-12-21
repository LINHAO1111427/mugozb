//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "TaskDtoModel.h"
#import "AppUserTaskRecordModel.h"




 @implementation TaskDtoModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"appUserTaskRecord" : [AppUserTaskRecordModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"val"]=@(_val);

dict[@"image"]=_image;

dict[@"taskImg"]=_taskImg;

dict[@"role"]=@(_role);

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"taskCompletionType"]=@(_taskCompletionType);

dict[@"isStart"]=@(_isStart);

dict[@"sort"]=@(_sort);

dict[@"appUserTaskRecord"]=[_appUserTaskRecord modelToJSONObject];

dict[@"userId"]=@(_userId);

dict[@"desr"]=_desr;

dict[@"point"]=@(_point);

dict[@"typeCode"]=_typeCode;

dict[@"taskType"]=@(_taskType);

dict[@"unit"]=_unit;

dict[@"name"]=_name;

dict[@"startTime"]=[HttpClient stringFromDate:_startTime];

dict[@"id"]=@(_id_field);

dict[@"status"]=@(_status);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<TaskDtoModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
TaskDtoModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<TaskDtoModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<TaskDtoModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
TaskDtoModel* sumMdl=[TaskDtoModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(TaskDtoModel*)getFromDict:(NSDictionary*)dict
{
TaskDtoModel* model=[[TaskDtoModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.val=[dict[@"val"] isKindOfClass:[NSNull class]]?0:[dict[@"val"] doubleValue];

model.image=[dict[@"image"] isKindOfClass:[NSNull class]]?@"":dict[@"image"];

model.taskImg=[dict[@"taskImg"] isKindOfClass:[NSNull class]]?@"":dict[@"taskImg"];

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

model.taskCompletionType=[dict[@"taskCompletionType"] isKindOfClass:[NSNull class]]?0:[dict[@"taskCompletionType"] intValue];

model.isStart=[dict[@"isStart"] isKindOfClass:[NSNull class]]?0:[dict[@"isStart"] intValue];

model.sort=[dict[@"sort"] isKindOfClass:[NSNull class]]?0:[dict[@"sort"] intValue];


//getFromDict对象转换  
model.appUserTaskRecord=[AppUserTaskRecordModel getFromDict:dict[@"appUserTaskRecord"]];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.desr=[dict[@"desr"] isKindOfClass:[NSNull class]]?@"":dict[@"desr"];

model.point=[dict[@"point"] isKindOfClass:[NSNull class]]?0:[dict[@"point"] intValue];

model.typeCode=[dict[@"typeCode"] isKindOfClass:[NSNull class]]?@"":dict[@"typeCode"];

model.taskType=[dict[@"taskType"] isKindOfClass:[NSNull class]]?0:[dict[@"taskType"] intValue];

model.unit=[dict[@"unit"] isKindOfClass:[NSNull class]]?@"":dict[@"unit"];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];


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

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];


 return model;
}

 +(void)cloneObj:(TaskDtoModel*) source target:(TaskDtoModel*)target
{

target.val=source.val;

target.image=source.image;

target.taskImg=source.taskImg;

target.role=source.role;

target.addTime=source.addTime;

target.taskCompletionType=source.taskCompletionType;

target.isStart=source.isStart;

target.sort=source.sort;
        if(source.appUserTaskRecord==nil)
        {
//            target.appUserTaskRecord=nil;
        }else
        {
            [AppUserTaskRecordModel cloneObj:source.appUserTaskRecord target:target.appUserTaskRecord];
        }

target.userId=source.userId;

target.desr=source.desr;

target.point=source.point;

target.typeCode=source.typeCode;

target.taskType=source.taskType;

target.unit=source.unit;

target.name=source.name;

target.startTime=source.startTime;

target.id_field=source.id_field;

target.status=source.status;

}

@end

