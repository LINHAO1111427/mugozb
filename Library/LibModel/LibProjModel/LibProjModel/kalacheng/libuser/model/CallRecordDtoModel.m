//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "CallRecordDtoModel.h"




 @implementation CallRecordDtoModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"createTime"]=[HttpClient stringFromDate:_createTime];

dict[@"num"]=@(_num);

dict[@"isVideo"]=@(_isVideo);

dict[@"createTimeDesr"]=_createTimeDesr;

dict[@"longTimeDesr"]=_longTimeDesr;

dict[@"startTime"]=[HttpClient stringFromDate:_startTime];

dict[@"avatar"]=_avatar;

dict[@"endTime"]=[HttpClient stringFromDate:_endTime];

dict[@"anchorId"]=@(_anchorId);

dict[@"userId"]=@(_userId);

dict[@"username"]=_username;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<CallRecordDtoModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
CallRecordDtoModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<CallRecordDtoModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<CallRecordDtoModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
CallRecordDtoModel* sumMdl=[CallRecordDtoModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(CallRecordDtoModel*)getFromDict:(NSDictionary*)dict
{
CallRecordDtoModel* model=[[CallRecordDtoModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }

{
NSString *strDate= dict[@"createTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.createTime=date;
    }
}

model.num=[dict[@"num"] isKindOfClass:[NSNull class]]?0:[dict[@"num"] intValue];

model.isVideo=[dict[@"isVideo"] isKindOfClass:[NSNull class]]?0:[dict[@"isVideo"] intValue];

model.createTimeDesr=[dict[@"createTimeDesr"] isKindOfClass:[NSNull class]]?@"":dict[@"createTimeDesr"];

model.longTimeDesr=[dict[@"longTimeDesr"] isKindOfClass:[NSNull class]]?@"":dict[@"longTimeDesr"];


{
NSString *strDate= dict[@"startTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.startTime=date;
    }
}

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];


{
NSString *strDate= dict[@"endTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.endTime=date;
    }
}

model.anchorId=[dict[@"anchorId"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorId"] longLongValue];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.username=[dict[@"username"] isKindOfClass:[NSNull class]]?@"":dict[@"username"];


 return model;
}

 +(void)cloneObj:(CallRecordDtoModel*) source target:(CallRecordDtoModel*)target
{

target.createTime=source.createTime;

target.num=source.num;

target.isVideo=source.isVideo;

target.createTimeDesr=source.createTimeDesr;

target.longTimeDesr=source.longTimeDesr;

target.startTime=source.startTime;

target.avatar=source.avatar;

target.endTime=source.endTime;

target.anchorId=source.anchorId;

target.userId=source.userId;

target.username=source.username;

}

@end

