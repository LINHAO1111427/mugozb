//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppVoiceThumbModel.h"




 @implementation AppVoiceThumbModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"des"]=_des;

dict[@"orderno"]=@(_orderno);

dict[@"thumb"]=_thumb;

dict[@"id"]=@(_id_field);

dict[@"type"]=@(_type);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppVoiceThumbModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppVoiceThumbModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppVoiceThumbModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppVoiceThumbModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppVoiceThumbModel* sumMdl=[AppVoiceThumbModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppVoiceThumbModel*)getFromDict:(NSDictionary*)dict
{
AppVoiceThumbModel* model=[[AppVoiceThumbModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.des=[dict[@"des"] isKindOfClass:[NSNull class]]?@"":dict[@"des"];

model.orderno=[dict[@"orderno"] isKindOfClass:[NSNull class]]?0:[dict[@"orderno"] intValue];

model.thumb=[dict[@"thumb"] isKindOfClass:[NSNull class]]?@"":dict[@"thumb"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];


 return model;
}

 +(void)cloneObj:(AppVoiceThumbModel*) source target:(AppVoiceThumbModel*)target
{

target.des=source.des;

target.orderno=source.orderno;

target.thumb=source.thumb;

target.id_field=source.id_field;

target.type=source.type;

}

@end

