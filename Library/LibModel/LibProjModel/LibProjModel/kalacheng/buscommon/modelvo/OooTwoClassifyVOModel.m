//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "OooTwoClassifyVOModel.h"




 @implementation OooTwoClassifyVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"upTime"]=[HttpClient stringFromDate:_upTime];

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"oooTowTypeName"]=_oooTowTypeName;

dict[@"id"]=@(_id_field);

dict[@"isEnable"]=@(_isEnable);

dict[@"oneClassifyId"]=@(_oneClassifyId);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OooTwoClassifyVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
OooTwoClassifyVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<OooTwoClassifyVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<OooTwoClassifyVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
OooTwoClassifyVOModel* sumMdl=[OooTwoClassifyVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(OooTwoClassifyVOModel*)getFromDict:(NSDictionary*)dict
{
OooTwoClassifyVOModel* model=[[OooTwoClassifyVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }

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

model.oooTowTypeName=[dict[@"oooTowTypeName"] isKindOfClass:[NSNull class]]?@"":dict[@"oooTowTypeName"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.isEnable=[dict[@"isEnable"] isKindOfClass:[NSNull class]]?0:[dict[@"isEnable"] intValue];

model.oneClassifyId=[dict[@"oneClassifyId"] isKindOfClass:[NSNull class]]?0:[dict[@"oneClassifyId"] longLongValue];


 return model;
}

 +(void)cloneObj:(OooTwoClassifyVOModel*) source target:(OooTwoClassifyVOModel*)target
{

target.upTime=source.upTime;

target.addTime=source.addTime;

target.oooTowTypeName=source.oooTowTypeName;

target.id_field=source.id_field;

target.isEnable=source.isEnable;

target.oneClassifyId=source.oneClassifyId;

}

@end

