//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "LianAiUserSignVOModel.h"




 @implementation LianAiUserSignVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"giftScore"]=@(_giftScore);

dict[@"sortValue"]=@(_sortValue);

dict[@"id"]=@(_id_field);

dict[@"isSign"]=@(_isSign);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<LianAiUserSignVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
LianAiUserSignVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<LianAiUserSignVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<LianAiUserSignVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
LianAiUserSignVOModel* sumMdl=[LianAiUserSignVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(LianAiUserSignVOModel*)getFromDict:(NSDictionary*)dict
{
LianAiUserSignVOModel* model=[[LianAiUserSignVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.giftScore=[dict[@"giftScore"] isKindOfClass:[NSNull class]]?0:[dict[@"giftScore"] doubleValue];

model.sortValue=[dict[@"sortValue"] isKindOfClass:[NSNull class]]?0:[dict[@"sortValue"] intValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.isSign=[dict[@"isSign"] isKindOfClass:[NSNull class]]?0:[dict[@"isSign"] intValue];


 return model;
}

 +(void)cloneObj:(LianAiUserSignVOModel*) source target:(LianAiUserSignVOModel*)target
{

target.giftScore=source.giftScore;

target.sortValue=source.sortValue;

target.id_field=source.id_field;

target.isSign=source.isSign;

}

@end

