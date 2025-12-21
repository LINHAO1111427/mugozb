//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "GuardUserVOModel.h"




 @implementation GuardUserVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"anchorIdImg"]=_anchorIdImg;

dict[@"consumptionAmount"]=@(_consumptionAmount);

dict[@"anchorId"]=@(_anchorId);

dict[@"anchorName"]=_anchorName;

dict[@"userId"]=@(_userId);

dict[@"userHeadImg"]=_userHeadImg;

dict[@"freeDay"]=@(_freeDay);

dict[@"isOverdue"]=@(_isOverdue);

dict[@"leftDay"]=@(_leftDay);

dict[@"guardDay"]=@(_guardDay);

dict[@"endTime"]=[HttpClient stringFromDate:_endTime];

dict[@"username"]=_username;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GuardUserVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
GuardUserVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<GuardUserVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<GuardUserVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
GuardUserVOModel* sumMdl=[GuardUserVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(GuardUserVOModel*)getFromDict:(NSDictionary*)dict
{
GuardUserVOModel* model=[[GuardUserVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }

{
NSString *strDate= dict[@"addTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addTime=date;
    }
}

model.anchorIdImg=[dict[@"anchorIdImg"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorIdImg"];

model.consumptionAmount=[dict[@"consumptionAmount"] isKindOfClass:[NSNull class]]?0:[dict[@"consumptionAmount"] doubleValue];

model.anchorId=[dict[@"anchorId"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorId"] longLongValue];

model.anchorName=[dict[@"anchorName"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorName"];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.userHeadImg=[dict[@"userHeadImg"] isKindOfClass:[NSNull class]]?@"":dict[@"userHeadImg"];

model.freeDay=[dict[@"freeDay"] isKindOfClass:[NSNull class]]?0:[dict[@"freeDay"] longLongValue];

model.isOverdue=[dict[@"isOverdue"] isKindOfClass:[NSNull class]]?0:[dict[@"isOverdue"] longLongValue];

model.leftDay=[dict[@"leftDay"] isKindOfClass:[NSNull class]]?0:[dict[@"leftDay"] longLongValue];

model.guardDay=[dict[@"guardDay"] isKindOfClass:[NSNull class]]?0:[dict[@"guardDay"] longLongValue];


{
NSString *strDate= dict[@"endTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.endTime=date;
    }
}

model.username=[dict[@"username"] isKindOfClass:[NSNull class]]?@"":dict[@"username"];


 return model;
}

 +(void)cloneObj:(GuardUserVOModel*) source target:(GuardUserVOModel*)target
{

target.addTime=source.addTime;

target.anchorIdImg=source.anchorIdImg;

target.consumptionAmount=source.consumptionAmount;

target.anchorId=source.anchorId;

target.anchorName=source.anchorName;

target.userId=source.userId;

target.userHeadImg=source.userHeadImg;

target.freeDay=source.freeDay;

target.isOverdue=source.isOverdue;

target.leftDay=source.leftDay;

target.guardDay=source.guardDay;

target.endTime=source.endTime;

target.username=source.username;

}

@end

