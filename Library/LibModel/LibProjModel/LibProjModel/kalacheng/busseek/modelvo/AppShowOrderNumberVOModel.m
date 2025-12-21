//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppShowOrderNumberVOModel.h"




 @implementation AppShowOrderNumberVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"waitingEvaluationNum"]=@(_waitingEvaluationNum);

dict[@"processingNum"]=@(_processingNum);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppShowOrderNumberVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppShowOrderNumberVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppShowOrderNumberVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppShowOrderNumberVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppShowOrderNumberVOModel* sumMdl=[AppShowOrderNumberVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppShowOrderNumberVOModel*)getFromDict:(NSDictionary*)dict
{
AppShowOrderNumberVOModel* model=[[AppShowOrderNumberVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.waitingEvaluationNum=[dict[@"waitingEvaluationNum"] isKindOfClass:[NSNull class]]?0:[dict[@"waitingEvaluationNum"] intValue];

model.processingNum=[dict[@"processingNum"] isKindOfClass:[NSNull class]]?0:[dict[@"processingNum"] intValue];


 return model;
}

 +(void)cloneObj:(AppShowOrderNumberVOModel*) source target:(AppShowOrderNumberVOModel*)target
{

target.waitingEvaluationNum=source.waitingEvaluationNum;

target.processingNum=source.processingNum;

}

@end

