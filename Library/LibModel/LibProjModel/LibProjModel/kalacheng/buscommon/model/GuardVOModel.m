//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "GuardVOModel.h"
#import "CfgPayWayDTOModel.h"




 @implementation GuardVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"payList" : [CfgPayWayDTOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"iosId"]=_iosId;

dict[@"payType"]=@(_payType);

dict[@"iosPrice"]=@(_iosPrice);

dict[@"length"]=@(_length);

dict[@"name"]=_name;

dict[@"androidPrice"]=@(_androidPrice);

dict[@"id"]=@(_id_field);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_payList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
CfgPayWayDTOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"payList"]=list;
}//end

dict[@"coin"]=@(_coin);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GuardVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
GuardVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<GuardVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<GuardVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
GuardVOModel* sumMdl=[GuardVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(GuardVOModel*)getFromDict:(NSDictionary*)dict
{
GuardVOModel* model=[[GuardVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.iosId=[dict[@"iosId"] isKindOfClass:[NSNull class]]?@"":dict[@"iosId"];

model.payType=[dict[@"payType"] isKindOfClass:[NSNull class]]?0:[dict[@"payType"] intValue];

model.iosPrice=[dict[@"iosPrice"] isKindOfClass:[NSNull class]]?0:[dict[@"iosPrice"] doubleValue];

model.length=[dict[@"length"] isKindOfClass:[NSNull class]]?0:[dict[@"length"] intValue];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.androidPrice=[dict[@"androidPrice"] isKindOfClass:[NSNull class]]?0:[dict[@"androidPrice"] doubleValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.payList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"payList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
CfgPayWayDTOModel* sumMdl=[CfgPayWayDTOModel getFromDict:subDic];
[model.payList addObject:sumMdl];

}
}

}

model.coin=[dict[@"coin"] isKindOfClass:[NSNull class]]?0:[dict[@"coin"] doubleValue];


 return model;
}

 +(void)cloneObj:(GuardVOModel*) source target:(GuardVOModel*)target
{

target.iosId=source.iosId;

target.payType=source.payType;

target.iosPrice=source.iosPrice;

target.length=source.length;

target.name=source.name;

target.androidPrice=source.androidPrice;

target.id_field=source.id_field;

        if(source.payList==nil)
        {
//            target.payList=nil;
        }else
        {
            target.payList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.payList.count;i++)
            {
		  [target.payList addObject:[[CfgPayWayDTOModel alloc]init]];
            [CfgPayWayDTOModel cloneObj:source.payList[i] target:target.payList[i]];
            }
        }


target.coin=source.coin;

}

@end

