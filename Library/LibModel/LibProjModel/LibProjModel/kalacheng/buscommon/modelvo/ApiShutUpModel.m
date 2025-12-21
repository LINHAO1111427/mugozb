//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiShutUpModel.h"




 @implementation ApiShutUpModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"userLevel"]=_userLevel;

dict[@"signature"]=_signature;

dict[@"sex"]=@(_sex);

dict[@"startTime"]=[HttpClient stringFromDate:_startTime];

dict[@"avatar"]=_avatar;

dict[@"endTime"]=[HttpClient stringFromDate:_endTime];

dict[@"anchorLevel"]=_anchorLevel;

dict[@"userId"]=@(_userId);

dict[@"username"]=_username;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiShutUpModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiShutUpModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiShutUpModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiShutUpModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiShutUpModel* sumMdl=[ApiShutUpModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiShutUpModel*)getFromDict:(NSDictionary*)dict
{
ApiShutUpModel* model=[[ApiShutUpModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.userLevel=[dict[@"userLevel"] isKindOfClass:[NSNull class]]?@"":dict[@"userLevel"];

model.signature=[dict[@"signature"] isKindOfClass:[NSNull class]]?@"":dict[@"signature"];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];


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

model.anchorLevel=[dict[@"anchorLevel"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorLevel"];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.username=[dict[@"username"] isKindOfClass:[NSNull class]]?@"":dict[@"username"];


 return model;
}

 +(void)cloneObj:(ApiShutUpModel*) source target:(ApiShutUpModel*)target
{

target.userLevel=source.userLevel;

target.signature=source.signature;

target.sex=source.sex;

target.startTime=source.startTime;

target.avatar=source.avatar;

target.endTime=source.endTime;

target.anchorLevel=source.anchorLevel;

target.userId=source.userId;

target.username=source.username;

}

@end

