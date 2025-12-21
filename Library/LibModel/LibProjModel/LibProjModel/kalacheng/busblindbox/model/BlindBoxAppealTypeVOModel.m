//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "BlindBoxAppealTypeVOModel.h"




 @implementation BlindBoxAppealTypeVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"upTime"]=[HttpClient stringFromDate:_upTime];

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"id"]=@(_id_field);

dict[@"appealTypeName"]=_appealTypeName;

dict[@"isEnable"]=@(_isEnable);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<BlindBoxAppealTypeVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
BlindBoxAppealTypeVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<BlindBoxAppealTypeVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<BlindBoxAppealTypeVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
BlindBoxAppealTypeVOModel* sumMdl=[BlindBoxAppealTypeVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(BlindBoxAppealTypeVOModel*)getFromDict:(NSDictionary*)dict
{
BlindBoxAppealTypeVOModel* model=[[BlindBoxAppealTypeVOModel alloc]init];

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

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.appealTypeName=[dict[@"appealTypeName"] isKindOfClass:[NSNull class]]?@"":dict[@"appealTypeName"];

model.isEnable=[dict[@"isEnable"] isKindOfClass:[NSNull class]]?0:[dict[@"isEnable"] intValue];


 return model;
}

 +(void)cloneObj:(BlindBoxAppealTypeVOModel*) source target:(BlindBoxAppealTypeVOModel*)target
{

target.upTime=source.upTime;

target.addTime=source.addTime;

target.id_field=source.id_field;

target.appealTypeName=source.appealTypeName;

target.isEnable=source.isEnable;

}

@end

