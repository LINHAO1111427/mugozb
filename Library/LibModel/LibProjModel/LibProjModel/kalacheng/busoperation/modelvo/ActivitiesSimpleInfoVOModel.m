//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ActivitiesSimpleInfoVOModel.h"




 @implementation ActivitiesSimpleInfoVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"endDate"]=[HttpClient stringFromDate:_endDate];

dict[@"activityImg"]=_activityImg;

dict[@"activityLink"]=_activityLink;

dict[@"activityName"]=_activityName;

dict[@"id"]=@(_id_field);

dict[@"activityDescribe"]=_activityDescribe;

dict[@"isExpired"]=@(_isExpired);

dict[@"startDate"]=[HttpClient stringFromDate:_startDate];


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ActivitiesSimpleInfoVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ActivitiesSimpleInfoVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ActivitiesSimpleInfoVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ActivitiesSimpleInfoVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ActivitiesSimpleInfoVOModel* sumMdl=[ActivitiesSimpleInfoVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ActivitiesSimpleInfoVOModel*)getFromDict:(NSDictionary*)dict
{
ActivitiesSimpleInfoVOModel* model=[[ActivitiesSimpleInfoVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }

{
NSString *strDate= dict[@"endDate"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.endDate=date;
    }
}

model.activityImg=[dict[@"activityImg"] isKindOfClass:[NSNull class]]?@"":dict[@"activityImg"];

model.activityLink=[dict[@"activityLink"] isKindOfClass:[NSNull class]]?@"":dict[@"activityLink"];

model.activityName=[dict[@"activityName"] isKindOfClass:[NSNull class]]?@"":dict[@"activityName"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.activityDescribe=[dict[@"activityDescribe"] isKindOfClass:[NSNull class]]?@"":dict[@"activityDescribe"];

model.isExpired=[dict[@"isExpired"] isKindOfClass:[NSNull class]]?0:[dict[@"isExpired"] intValue];


{
NSString *strDate= dict[@"startDate"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.startDate=date;
    }
}


 return model;
}

 +(void)cloneObj:(ActivitiesSimpleInfoVOModel*) source target:(ActivitiesSimpleInfoVOModel*)target
{

target.endDate=source.endDate;

target.activityImg=source.activityImg;

target.activityLink=source.activityLink;

target.activityName=source.activityName;

target.id_field=source.id_field;

target.activityDescribe=source.activityDescribe;

target.isExpired=source.isExpired;

target.startDate=source.startDate;

}

@end

