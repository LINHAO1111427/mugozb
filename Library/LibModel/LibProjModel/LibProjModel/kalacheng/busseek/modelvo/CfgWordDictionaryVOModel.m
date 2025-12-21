//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "CfgWordDictionaryVOModel.h"




 @implementation CfgWordDictionaryVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"wordType"]=@(_wordType);

dict[@"id"]=@(_id_field);

dict[@"title"]=_title;

dict[@"content"]=_content;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<CfgWordDictionaryVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
CfgWordDictionaryVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<CfgWordDictionaryVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<CfgWordDictionaryVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
CfgWordDictionaryVOModel* sumMdl=[CfgWordDictionaryVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(CfgWordDictionaryVOModel*)getFromDict:(NSDictionary*)dict
{
CfgWordDictionaryVOModel* model=[[CfgWordDictionaryVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.wordType=[dict[@"wordType"] isKindOfClass:[NSNull class]]?0:[dict[@"wordType"] intValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.title=[dict[@"title"] isKindOfClass:[NSNull class]]?@"":dict[@"title"];

model.content=[dict[@"content"] isKindOfClass:[NSNull class]]?@"":dict[@"content"];


 return model;
}

 +(void)cloneObj:(CfgWordDictionaryVOModel*) source target:(CfgWordDictionaryVOModel*)target
{

target.wordType=source.wordType;

target.id_field=source.id_field;

target.title=source.title;

target.content=source.content;

}

@end

