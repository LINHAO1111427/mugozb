//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppUserContactDetailsVOModel.h"




 @implementation AppUserContactDetailsVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"qq"]=_qq;

dict[@"upTime"]=[HttpClient stringFromDate:_upTime];

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"phone"]=_phone;

dict[@"weChat"]=_weChat;

dict[@"id"]=@(_id_field);

dict[@"userId"]=@(_userId);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUserContactDetailsVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppUserContactDetailsVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppUserContactDetailsVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppUserContactDetailsVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppUserContactDetailsVOModel* sumMdl=[AppUserContactDetailsVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppUserContactDetailsVOModel*)getFromDict:(NSDictionary*)dict
{
AppUserContactDetailsVOModel* model=[[AppUserContactDetailsVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.qq=[dict[@"qq"] isKindOfClass:[NSNull class]]?@"":dict[@"qq"];


{
NSString *strDate= dict[@"upTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.upTime=date;
    }
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

model.phone=[dict[@"phone"] isKindOfClass:[NSNull class]]?@"":dict[@"phone"];

model.weChat=[dict[@"weChat"] isKindOfClass:[NSNull class]]?@"":dict[@"weChat"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];


 return model;
}

 +(void)cloneObj:(AppUserContactDetailsVOModel*) source target:(AppUserContactDetailsVOModel*)target
{

target.qq=source.qq;

target.upTime=source.upTime;

target.addTime=source.addTime;

target.phone=source.phone;

target.weChat=source.weChat;

target.id_field=source.id_field;

target.userId=source.userId;

}

@end

