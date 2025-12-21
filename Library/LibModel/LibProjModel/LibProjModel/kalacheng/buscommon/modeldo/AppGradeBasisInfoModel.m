//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppGradeBasisInfoModel.h"




 @implementation AppGradeBasisInfoModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"gradeIcon"]=_gradeIcon;

dict[@"grade"]=@(_grade);

dict[@"name"]=_name;

dict[@"id"]=@(_id_field);

dict[@"isEnable"]=@(_isEnable);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppGradeBasisInfoModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppGradeBasisInfoModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppGradeBasisInfoModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppGradeBasisInfoModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppGradeBasisInfoModel* sumMdl=[AppGradeBasisInfoModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppGradeBasisInfoModel*)getFromDict:(NSDictionary*)dict
{
AppGradeBasisInfoModel* model=[[AppGradeBasisInfoModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.gradeIcon=[dict[@"gradeIcon"] isKindOfClass:[NSNull class]]?@"":dict[@"gradeIcon"];

model.grade=[dict[@"grade"] isKindOfClass:[NSNull class]]?0:[dict[@"grade"] intValue];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.isEnable=[dict[@"isEnable"] isKindOfClass:[NSNull class]]?0:[dict[@"isEnable"] intValue];


 return model;
}

 +(void)cloneObj:(AppGradeBasisInfoModel*) source target:(AppGradeBasisInfoModel*)target
{

target.gradeIcon=source.gradeIcon;

target.grade=source.grade;

target.name=source.name;

target.id_field=source.id_field;

target.isEnable=source.isEnable;

}

@end

