//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppGradePrivilegeModel.h"




 @implementation AppGradePrivilegeModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"lineLogo"]=_lineLogo;

dict[@"isStart"]=@(_isStart);

dict[@"sort"]=@(_sort);

dict[@"type"]=@(_type);

dict[@"userId"]=@(_userId);

dict[@"desr"]=_desr;

dict[@"isShow"]=@(_isShow);

dict[@"offLineLogo"]=_offLineLogo;

dict[@"identification"]=_identification;

dict[@"addtime"]=[HttpClient stringFromDate:_addtime];

dict[@"grade"]=@(_grade);

dict[@"name"]=_name;

dict[@"id"]=@(_id_field);

dict[@"status"]=@(_status);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppGradePrivilegeModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppGradePrivilegeModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppGradePrivilegeModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppGradePrivilegeModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppGradePrivilegeModel* sumMdl=[AppGradePrivilegeModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppGradePrivilegeModel*)getFromDict:(NSDictionary*)dict
{
AppGradePrivilegeModel* model=[[AppGradePrivilegeModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.lineLogo=[dict[@"lineLogo"] isKindOfClass:[NSNull class]]?@"":dict[@"lineLogo"];

model.isStart=[dict[@"isStart"] isKindOfClass:[NSNull class]]?0:[dict[@"isStart"] intValue];

model.sort=[dict[@"sort"] isKindOfClass:[NSNull class]]?0:[dict[@"sort"] intValue];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.desr=[dict[@"desr"] isKindOfClass:[NSNull class]]?@"":dict[@"desr"];

model.isShow=[dict[@"isShow"] isKindOfClass:[NSNull class]]?0:[dict[@"isShow"] intValue];

model.offLineLogo=[dict[@"offLineLogo"] isKindOfClass:[NSNull class]]?@"":dict[@"offLineLogo"];

model.identification=[dict[@"identification"] isKindOfClass:[NSNull class]]?@"":dict[@"identification"];


{
NSString *strDate= dict[@"addtime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addtime=date;
    }
}

model.grade=[dict[@"grade"] isKindOfClass:[NSNull class]]?0:[dict[@"grade"] intValue];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];


 return model;
}

 +(void)cloneObj:(AppGradePrivilegeModel*) source target:(AppGradePrivilegeModel*)target
{

target.lineLogo=source.lineLogo;

target.isStart=source.isStart;

target.sort=source.sort;

target.type=source.type;

target.userId=source.userId;

target.desr=source.desr;

target.isShow=source.isShow;

target.offLineLogo=source.offLineLogo;

target.identification=source.identification;

target.addtime=source.addtime;

target.grade=source.grade;

target.name=source.name;

target.id_field=source.id_field;

target.status=source.status;

}

@end

