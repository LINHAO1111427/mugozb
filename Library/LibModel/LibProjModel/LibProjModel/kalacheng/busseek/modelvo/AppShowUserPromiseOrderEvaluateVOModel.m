//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppShowUserPromiseOrderEvaluateVOModel.h"
#import "AppUserPromiseOrderEvaluateVOModel.h"




 @implementation AppShowUserPromiseOrderEvaluateVOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"appUserPromiseOrderEvaluateVOList" : [AppUserPromiseOrderEvaluateVOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"orderComplexScore"]=@(_orderComplexScore);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_appUserPromiseOrderEvaluateVOList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppUserPromiseOrderEvaluateVOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"appUserPromiseOrderEvaluateVOList"]=list;
}//end

dict[@"promiseTag"]=_promiseTag;

dict[@"userId"]=@(_userId);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppShowUserPromiseOrderEvaluateVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppShowUserPromiseOrderEvaluateVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppShowUserPromiseOrderEvaluateVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppShowUserPromiseOrderEvaluateVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppShowUserPromiseOrderEvaluateVOModel* sumMdl=[AppShowUserPromiseOrderEvaluateVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppShowUserPromiseOrderEvaluateVOModel*)getFromDict:(NSDictionary*)dict
{
AppShowUserPromiseOrderEvaluateVOModel* model=[[AppShowUserPromiseOrderEvaluateVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.orderComplexScore=[dict[@"orderComplexScore"] isKindOfClass:[NSNull class]]?0:[dict[@"orderComplexScore"] doubleValue];

model.appUserPromiseOrderEvaluateVOList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"appUserPromiseOrderEvaluateVOList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppUserPromiseOrderEvaluateVOModel* sumMdl=[AppUserPromiseOrderEvaluateVOModel getFromDict:subDic];
[model.appUserPromiseOrderEvaluateVOList addObject:sumMdl];

}
}

}

model.promiseTag=[dict[@"promiseTag"] isKindOfClass:[NSNull class]]?@"":dict[@"promiseTag"];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];


 return model;
}

 +(void)cloneObj:(AppShowUserPromiseOrderEvaluateVOModel*) source target:(AppShowUserPromiseOrderEvaluateVOModel*)target
{

target.orderComplexScore=source.orderComplexScore;

        if(source.appUserPromiseOrderEvaluateVOList==nil)
        {
//            target.appUserPromiseOrderEvaluateVOList=nil;
        }else
        {
            target.appUserPromiseOrderEvaluateVOList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.appUserPromiseOrderEvaluateVOList.count;i++)
            {
		  [target.appUserPromiseOrderEvaluateVOList addObject:[[AppUserPromiseOrderEvaluateVOModel alloc]init]];
            [AppUserPromiseOrderEvaluateVOModel cloneObj:source.appUserPromiseOrderEvaluateVOList[i] target:target.appUserPromiseOrderEvaluateVOList[i]];
            }
        }


target.promiseTag=source.promiseTag;

target.userId=source.userId;

}

@end

