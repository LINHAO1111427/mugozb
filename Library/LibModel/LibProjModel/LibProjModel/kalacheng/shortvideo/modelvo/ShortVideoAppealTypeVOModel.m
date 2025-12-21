//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShortVideoAppealTypeVOModel.h"




 @implementation ShortVideoAppealTypeVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"id"]=@(_id_field);

dict[@"appealTypeName"]=_appealTypeName;

dict[@"isEnable"]=@(_isEnable);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShortVideoAppealTypeVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShortVideoAppealTypeVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShortVideoAppealTypeVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShortVideoAppealTypeVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShortVideoAppealTypeVOModel* sumMdl=[ShortVideoAppealTypeVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShortVideoAppealTypeVOModel*)getFromDict:(NSDictionary*)dict
{
ShortVideoAppealTypeVOModel* model=[[ShortVideoAppealTypeVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.appealTypeName=[dict[@"appealTypeName"] isKindOfClass:[NSNull class]]?@"":dict[@"appealTypeName"];

model.isEnable=[dict[@"isEnable"] isKindOfClass:[NSNull class]]?0:[dict[@"isEnable"] intValue];


 return model;
}

 +(void)cloneObj:(ShortVideoAppealTypeVOModel*) source target:(ShortVideoAppealTypeVOModel*)target
{

target.id_field=source.id_field;

target.appealTypeName=source.appealTypeName;

target.isEnable=source.isEnable;

}

@end

