//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "aTestModleModel.h"




 @implementation aTestModleModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"name"]=_name;

dict[@"id"]=@(_id_field);

dict[@"pid"]=@(_pid);

dict[@"age"]=@(_age);

dict[@"sex"]=@(_sex);

dict[@"homeAddress"]=_homeAddress;

dict[@"nickname"]=_nickname;

dict[@"createTime"]=[HttpClient stringFromDate:_createTime];

dict[@"moneyxx"]=@(_moneyxx);

dict[@"moneysdfsdf"]=@(_moneysdfsdf);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<aTestModleModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
aTestModleModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<aTestModleModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<aTestModleModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
aTestModleModel* sumMdl=[aTestModleModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(aTestModleModel*)getFromDict:(NSDictionary*)dict
{
aTestModleModel* model=[[aTestModleModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.pid=[dict[@"pid"] isKindOfClass:[NSNull class]]?0:[dict[@"pid"] longLongValue];

model.age=[dict[@"age"] isKindOfClass:[NSNull class]]?0:[dict[@"age"] intValue];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.homeAddress=[dict[@"homeAddress"] isKindOfClass:[NSNull class]]?@"":dict[@"homeAddress"];

model.nickname=[dict[@"nickname"] isKindOfClass:[NSNull class]]?@"":dict[@"nickname"];


{
NSString *strDate= dict[@"createTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.createTime=date;
    }
}

model.moneyxx=[dict[@"moneyxx"] isKindOfClass:[NSNull class]]?0:[dict[@"moneyxx"] doubleValue];

model.moneysdfsdf=[dict[@"moneysdfsdf"] isKindOfClass:[NSNull class]]?0:[dict[@"moneysdfsdf"] doubleValue];


 return model;
}

 +(void)cloneObj:(aTestModleModel*) source target:(aTestModleModel*)target
{

target.name=source.name;

target.id_field=source.id_field;

target.pid=source.pid;

target.age=source.age;

target.sex=source.sex;

target.homeAddress=source.homeAddress;

target.nickname=source.nickname;

target.createTime=source.createTime;

target.moneyxx=source.moneyxx;

target.moneysdfsdf=source.moneysdfsdf;

}

@end

