//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApplyRefundReasonDTOModel.h"




 @implementation ApplyRefundReasonDTOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"reason"]=_reason;

dict[@"id"]=@(_id_field);

dict[@"sort"]=@(_sort);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApplyRefundReasonDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApplyRefundReasonDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApplyRefundReasonDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApplyRefundReasonDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApplyRefundReasonDTOModel* sumMdl=[ApplyRefundReasonDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApplyRefundReasonDTOModel*)getFromDict:(NSDictionary*)dict
{
ApplyRefundReasonDTOModel* model=[[ApplyRefundReasonDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.reason=[dict[@"reason"] isKindOfClass:[NSNull class]]?@"":dict[@"reason"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.sort=[dict[@"sort"] isKindOfClass:[NSNull class]]?0:[dict[@"sort"] intValue];


 return model;
}

 +(void)cloneObj:(ApplyRefundReasonDTOModel*) source target:(ApplyRefundReasonDTOModel*)target
{

target.reason=source.reason;

target.id_field=source.id_field;

target.sort=source.sort;

}

@end

