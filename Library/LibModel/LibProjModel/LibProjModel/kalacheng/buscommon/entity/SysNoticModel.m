//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "SysNoticModel.h"




 @implementation SysNoticModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"shape"]=@(_shape);

dict[@"addtime"]=[HttpClient stringFromDate:_addtime];

dict[@"imageUrl"]=_imageUrl;

dict[@"showType"]=@(_showType);

dict[@"id"]=@(_id_field);

dict[@"title"]=_title;

dict[@"type"]=@(_type);

dict[@"content"]=_content;

dict[@"url"]=_url;

dict[@"status"]=@(_status);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<SysNoticModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
SysNoticModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<SysNoticModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<SysNoticModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
SysNoticModel* sumMdl=[SysNoticModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(SysNoticModel*)getFromDict:(NSDictionary*)dict
{
SysNoticModel* model=[[SysNoticModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.shape=[dict[@"shape"] isKindOfClass:[NSNull class]]?0:[dict[@"shape"] intValue];


{
NSString *strDate= dict[@"addtime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addtime=date;
    }
}

model.imageUrl=[dict[@"imageUrl"] isKindOfClass:[NSNull class]]?@"":dict[@"imageUrl"];

model.showType=[dict[@"showType"] isKindOfClass:[NSNull class]]?0:[dict[@"showType"] intValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.title=[dict[@"title"] isKindOfClass:[NSNull class]]?@"":dict[@"title"];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];

model.content=[dict[@"content"] isKindOfClass:[NSNull class]]?@"":dict[@"content"];

model.url=[dict[@"url"] isKindOfClass:[NSNull class]]?@"":dict[@"url"];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];


 return model;
}

 +(void)cloneObj:(SysNoticModel*) source target:(SysNoticModel*)target
{

target.shape=source.shape;

target.addtime=source.addtime;

target.imageUrl=source.imageUrl;

target.showType=source.showType;

target.id_field=source.id_field;

target.title=source.title;

target.type=source.type;

target.content=source.content;

target.url=source.url;

target.status=source.status;

}

@end

