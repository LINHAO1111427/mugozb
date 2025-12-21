//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "BlindBoxLabelVOModel.h"




 @implementation BlindBoxLabelVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"enable"]=@(_enable);

dict[@"id"]=@(_id_field);

dict[@"label"]=_label;

dict[@"selected"]=@(_selected);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<BlindBoxLabelVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
BlindBoxLabelVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<BlindBoxLabelVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<BlindBoxLabelVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
BlindBoxLabelVOModel* sumMdl=[BlindBoxLabelVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(BlindBoxLabelVOModel*)getFromDict:(NSDictionary*)dict
{
BlindBoxLabelVOModel* model=[[BlindBoxLabelVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.enable=[dict[@"enable"] isKindOfClass:[NSNull class]]?0:[dict[@"enable"] intValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.label=[dict[@"label"] isKindOfClass:[NSNull class]]?@"":dict[@"label"];

model.selected=[dict[@"selected"] isKindOfClass:[NSNull class]]?0:[dict[@"selected"] intValue];


 return model;
}

 +(void)cloneObj:(BlindBoxLabelVOModel*) source target:(BlindBoxLabelVOModel*)target
{

target.enable=source.enable;

target.id_field=source.id_field;

target.label=source.label;

target.selected=source.selected;

}

@end

