//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppAreaModel.h"




 @implementation AppAreaModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"code"]=@(_code);

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"name"]=_name;

dict[@"id"]=@(_id_field);

dict[@"shortName"]=_shortName;

dict[@"isHot"]=@(_isHot);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppAreaModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppAreaModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppAreaModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppAreaModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppAreaModel* sumMdl=[AppAreaModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppAreaModel*)getFromDict:(NSDictionary*)dict
{
AppAreaModel* model=[[AppAreaModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.code=[dict[@"code"] isKindOfClass:[NSNull class]]?0:[dict[@"code"] intValue];


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

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.shortName=[dict[@"shortName"] isKindOfClass:[NSNull class]]?@"":dict[@"shortName"];

model.isHot=[dict[@"isHot"] isKindOfClass:[NSNull class]]?0:[dict[@"isHot"] intValue];


 return model;
}

 +(void)cloneObj:(AppAreaModel*) source target:(AppAreaModel*)target
{

target.code=source.code;

target.addTime=source.addTime;

target.name=source.name;

target.id_field=source.id_field;

target.shortName=source.shortName;

target.isHot=source.isHot;

}

@end

