//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AdminLoginAwardVOModel.h"




 @implementation AdminLoginAwardVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"id"]=@(_id_field);

dict[@"day"]=@(_day);

dict[@"lastLoginDay"]=[HttpClient stringFromDate:_lastLoginDay];

dict[@"coin"]=@(_coin);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AdminLoginAwardVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AdminLoginAwardVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AdminLoginAwardVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AdminLoginAwardVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AdminLoginAwardVOModel* sumMdl=[AdminLoginAwardVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AdminLoginAwardVOModel*)getFromDict:(NSDictionary*)dict
{
AdminLoginAwardVOModel* model=[[AdminLoginAwardVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.day=[dict[@"day"] isKindOfClass:[NSNull class]]?0:[dict[@"day"] intValue];


{
NSString *strDate= dict[@"lastLoginDay"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.lastLoginDay=date;
    }
}

model.coin=[dict[@"coin"] isKindOfClass:[NSNull class]]?0:[dict[@"coin"] intValue];


 return model;
}

 +(void)cloneObj:(AdminLoginAwardVOModel*) source target:(AdminLoginAwardVOModel*)target
{

target.id_field=source.id_field;

target.day=source.day;

target.lastLoginDay=source.lastLoginDay;

target.coin=source.coin;

}

@end

