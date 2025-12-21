//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "KeyValueDtoModel.h"




 @implementation KeyValueDtoModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"isDefault"]=@(_isDefault);

dict[@"value2"]=_value2;

dict[@"value1"]=_value1;

dict[@"value"]=_value;

dict[@"key"]=_key;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<KeyValueDtoModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
KeyValueDtoModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<KeyValueDtoModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<KeyValueDtoModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
KeyValueDtoModel* sumMdl=[KeyValueDtoModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(KeyValueDtoModel*)getFromDict:(NSDictionary*)dict
{
KeyValueDtoModel* model=[[KeyValueDtoModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.isDefault=[dict[@"isDefault"] isKindOfClass:[NSNull class]]?0:[dict[@"isDefault"] intValue];

model.value2=[dict[@"value2"] isKindOfClass:[NSNull class]]?@"":dict[@"value2"];

model.value1=[dict[@"value1"] isKindOfClass:[NSNull class]]?@"":dict[@"value1"];

model.value=[dict[@"value"] isKindOfClass:[NSNull class]]?@"":dict[@"value"];

model.key=[dict[@"key"] isKindOfClass:[NSNull class]]?@"":dict[@"key"];


 return model;
}

 +(void)cloneObj:(KeyValueDtoModel*) source target:(KeyValueDtoModel*)target
{

target.isDefault=source.isDefault;

target.value2=source.value2;

target.value1=source.value1;

target.value=source.value;

target.key=source.key;

}

@end

