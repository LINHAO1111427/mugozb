//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiGuardEntityModel.h"
#import "ApiGuardModel.h"




 @implementation ApiGuardEntityModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"apiGuardList" : [ApiGuardModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_apiGuardList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ApiGuardModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"apiGuardList"]=list;
}//end

dict[@"dayNumber"]=@(_dayNumber);

dict[@"totalCoin"]=@(_totalCoin);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiGuardEntityModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiGuardEntityModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiGuardEntityModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiGuardEntityModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiGuardEntityModel* sumMdl=[ApiGuardEntityModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiGuardEntityModel*)getFromDict:(NSDictionary*)dict
{
ApiGuardEntityModel* model=[[ApiGuardEntityModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.apiGuardList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"apiGuardList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiGuardModel* sumMdl=[ApiGuardModel getFromDict:subDic];
[model.apiGuardList addObject:sumMdl];

}
}

}

model.dayNumber=[dict[@"dayNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"dayNumber"] longLongValue];

model.totalCoin=[dict[@"totalCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"totalCoin"] intValue];


 return model;
}

 +(void)cloneObj:(ApiGuardEntityModel*) source target:(ApiGuardEntityModel*)target
{

        if(source.apiGuardList==nil)
        {
//            target.apiGuardList=nil;
        }else
        {
            target.apiGuardList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.apiGuardList.count;i++)
            {
		  [target.apiGuardList addObject:[[ApiGuardModel alloc]init]];
            [ApiGuardModel cloneObj:source.apiGuardList[i] target:target.apiGuardList[i]];
            }
        }


target.dayNumber=source.dayNumber;

target.totalCoin=source.totalCoin;

}

@end

