//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppSearchRecordModel.h"




 @implementation AppSearchRecordModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"num"]=@(_num);

dict[@"id"]=@(_id_field);

dict[@"userId"]=@(_userId);

dict[@"content"]=_content;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppSearchRecordModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppSearchRecordModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppSearchRecordModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppSearchRecordModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppSearchRecordModel* sumMdl=[AppSearchRecordModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppSearchRecordModel*)getFromDict:(NSDictionary*)dict
{
AppSearchRecordModel* model=[[AppSearchRecordModel alloc]init];

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

model.num=[dict[@"num"] isKindOfClass:[NSNull class]]?0:[dict[@"num"] intValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.content=[dict[@"content"] isKindOfClass:[NSNull class]]?@"":dict[@"content"];


 return model;
}

 +(void)cloneObj:(AppSearchRecordModel*) source target:(AppSearchRecordModel*)target
{

target.addTime=source.addTime;

target.num=source.num;

target.id_field=source.id_field;

target.userId=source.userId;

target.content=source.content;

}

@end

