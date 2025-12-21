//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppOfficialNewsDTOModel.h"




 @implementation AppOfficialNewsDTOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"publishTime"]=[HttpClient stringFromDate:_publishTime];

dict[@"isRead"]=@(_isRead);

dict[@"logo"]=_logo;

dict[@"id"]=@(_id_field);

dict[@"title"]=_title;

dict[@"content"]=_content;

dict[@"introduction"]=_introduction;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppOfficialNewsDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppOfficialNewsDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppOfficialNewsDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppOfficialNewsDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppOfficialNewsDTOModel* sumMdl=[AppOfficialNewsDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppOfficialNewsDTOModel*)getFromDict:(NSDictionary*)dict
{
AppOfficialNewsDTOModel* model=[[AppOfficialNewsDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }

{
NSString *strDate= dict[@"publishTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.publishTime=date;
    }
}

model.isRead=[dict[@"isRead"] isKindOfClass:[NSNull class]]?0:[dict[@"isRead"] intValue];

model.logo=[dict[@"logo"] isKindOfClass:[NSNull class]]?@"":dict[@"logo"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.title=[dict[@"title"] isKindOfClass:[NSNull class]]?@"":dict[@"title"];

model.content=[dict[@"content"] isKindOfClass:[NSNull class]]?@"":dict[@"content"];

model.introduction=[dict[@"introduction"] isKindOfClass:[NSNull class]]?@"":dict[@"introduction"];


 return model;
}

 +(void)cloneObj:(AppOfficialNewsDTOModel*) source target:(AppOfficialNewsDTOModel*)target
{

target.publishTime=source.publishTime;

target.isRead=source.isRead;

target.logo=source.logo;

target.id_field=source.id_field;

target.title=source.title;

target.content=source.content;

target.introduction=source.introduction;

}

@end

