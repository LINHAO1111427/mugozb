//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "GiftPackVOModel.h"




 @implementation GiftPackVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"gifticon"]=_gifticon;

dict[@"typeVal"]=@(_typeVal);

dict[@"name"]=_name;

dict[@"action"]=_action;

dict[@"id"]=@(_id_field);

dict[@"type"]=@(_type);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GiftPackVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
GiftPackVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<GiftPackVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<GiftPackVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
GiftPackVOModel* sumMdl=[GiftPackVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(GiftPackVOModel*)getFromDict:(NSDictionary*)dict
{
GiftPackVOModel* model=[[GiftPackVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.gifticon=[dict[@"gifticon"] isKindOfClass:[NSNull class]]?@"":dict[@"gifticon"];

model.typeVal=[dict[@"typeVal"] isKindOfClass:[NSNull class]]?0:[dict[@"typeVal"] intValue];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.action=[dict[@"action"] isKindOfClass:[NSNull class]]?@"":dict[@"action"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] longLongValue];


 return model;
}

 +(void)cloneObj:(GiftPackVOModel*) source target:(GiftPackVOModel*)target
{

target.gifticon=source.gifticon;

target.typeVal=source.typeVal;

target.name=source.name;

target.action=source.action;

target.id_field=source.id_field;

target.type=source.type;

}

@end

