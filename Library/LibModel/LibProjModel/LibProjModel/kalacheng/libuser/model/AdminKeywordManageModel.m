//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AdminKeywordManageModel.h"




 @implementation AdminKeywordManageModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"nameUseStar"]=@(_nameUseStar);

dict[@"cashOutTip"]=_cashOutTip;

dict[@"id"]=@(_id_field);

dict[@"keyword"]=_keyword;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AdminKeywordManageModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AdminKeywordManageModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AdminKeywordManageModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AdminKeywordManageModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AdminKeywordManageModel* sumMdl=[AdminKeywordManageModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AdminKeywordManageModel*)getFromDict:(NSDictionary*)dict
{
AdminKeywordManageModel* model=[[AdminKeywordManageModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.nameUseStar=[dict[@"nameUseStar"] isKindOfClass:[NSNull class]]?0:[dict[@"nameUseStar"] intValue];

model.cashOutTip=[dict[@"cashOutTip"] isKindOfClass:[NSNull class]]?@"":dict[@"cashOutTip"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.keyword=[dict[@"keyword"] isKindOfClass:[NSNull class]]?@"":dict[@"keyword"];


 return model;
}

 +(void)cloneObj:(AdminKeywordManageModel*) source target:(AdminKeywordManageModel*)target
{

target.nameUseStar=source.nameUseStar;

target.cashOutTip=source.cashOutTip;

target.id_field=source.id_field;

target.keyword=source.keyword;

}

@end

