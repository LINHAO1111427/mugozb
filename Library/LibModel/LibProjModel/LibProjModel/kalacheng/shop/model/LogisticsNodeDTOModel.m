//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "LogisticsNodeDTOModel.h"




 @implementation LogisticsNodeDTOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"courier"]=_courier;

dict[@"courierPhone"]=_courierPhone;

dict[@"time"]=[HttpClient stringFromDate:_time];

dict[@"content"]=_content;

dict[@"deliveryStatus"]=_deliveryStatus;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<LogisticsNodeDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
LogisticsNodeDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<LogisticsNodeDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<LogisticsNodeDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
LogisticsNodeDTOModel* sumMdl=[LogisticsNodeDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(LogisticsNodeDTOModel*)getFromDict:(NSDictionary*)dict
{
LogisticsNodeDTOModel* model=[[LogisticsNodeDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.courier=[dict[@"courier"] isKindOfClass:[NSNull class]]?@"":dict[@"courier"];

model.courierPhone=[dict[@"courierPhone"] isKindOfClass:[NSNull class]]?@"":dict[@"courierPhone"];


{
NSString *strDate= dict[@"time"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.time=date;
    }
}

model.content=[dict[@"content"] isKindOfClass:[NSNull class]]?@"":dict[@"content"];

model.deliveryStatus=[dict[@"deliveryStatus"] isKindOfClass:[NSNull class]]?@"":dict[@"deliveryStatus"];


 return model;
}

 +(void)cloneObj:(LogisticsNodeDTOModel*) source target:(LogisticsNodeDTOModel*)target
{

target.courier=source.courier;

target.courierPhone=source.courierPhone;

target.time=source.time;

target.content=source.content;

target.deliveryStatus=source.deliveryStatus;

}

@end

