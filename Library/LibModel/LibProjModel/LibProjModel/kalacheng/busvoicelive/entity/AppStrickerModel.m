//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppStrickerModel.h"




 @implementation AppStrickerModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"gifUrl"]=_gifUrl;

dict[@"name"]=_name;

dict[@"id"]=@(_id_field);

dict[@"gifDuration"]=@(_gifDuration);

dict[@"url"]=_url;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppStrickerModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppStrickerModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppStrickerModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppStrickerModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppStrickerModel* sumMdl=[AppStrickerModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppStrickerModel*)getFromDict:(NSDictionary*)dict
{
AppStrickerModel* model=[[AppStrickerModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.gifUrl=[dict[@"gifUrl"] isKindOfClass:[NSNull class]]?@"":dict[@"gifUrl"];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.gifDuration=[dict[@"gifDuration"] isKindOfClass:[NSNull class]]?0:[dict[@"gifDuration"] doubleValue];

model.url=[dict[@"url"] isKindOfClass:[NSNull class]]?@"":dict[@"url"];


 return model;
}

 +(void)cloneObj:(AppStrickerModel*) source target:(AppStrickerModel*)target
{

target.gifUrl=source.gifUrl;

target.name=source.name;

target.id_field=source.id_field;

target.gifDuration=source.gifDuration;

target.url=source.url;

}

@end

