//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiGradeReWarReModel.h"
#import "ApiGradeReListModel.h"




 @implementation ApiGradeReWarReModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"apiGradeReList" : [ApiGradeReListModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"nextLevelTotalEmpirical"]=@(_nextLevelTotalEmpirical);

dict[@"nextLevelEmpirical"]=@(_nextLevelEmpirical);

dict[@"nextGiftPackLevel"]=@(_nextGiftPackLevel);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_apiGradeReList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ApiGradeReListModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"apiGradeReList"]=list;
}//end

dict[@"nextLevel"]=@(_nextLevel);

dict[@"currLevel"]=@(_currLevel);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiGradeReWarReModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiGradeReWarReModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiGradeReWarReModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiGradeReWarReModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiGradeReWarReModel* sumMdl=[ApiGradeReWarReModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiGradeReWarReModel*)getFromDict:(NSDictionary*)dict
{
ApiGradeReWarReModel* model=[[ApiGradeReWarReModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.nextLevelTotalEmpirical=[dict[@"nextLevelTotalEmpirical"] isKindOfClass:[NSNull class]]?0:[dict[@"nextLevelTotalEmpirical"] intValue];

model.nextLevelEmpirical=[dict[@"nextLevelEmpirical"] isKindOfClass:[NSNull class]]?0:[dict[@"nextLevelEmpirical"] intValue];

model.nextGiftPackLevel=[dict[@"nextGiftPackLevel"] isKindOfClass:[NSNull class]]?0:[dict[@"nextGiftPackLevel"] intValue];

model.apiGradeReList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"apiGradeReList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiGradeReListModel* sumMdl=[ApiGradeReListModel getFromDict:subDic];
[model.apiGradeReList addObject:sumMdl];

}
}

}

model.nextLevel=[dict[@"nextLevel"] isKindOfClass:[NSNull class]]?0:[dict[@"nextLevel"] intValue];

model.currLevel=[dict[@"currLevel"] isKindOfClass:[NSNull class]]?0:[dict[@"currLevel"] intValue];


 return model;
}

 +(void)cloneObj:(ApiGradeReWarReModel*) source target:(ApiGradeReWarReModel*)target
{

target.nextLevelTotalEmpirical=source.nextLevelTotalEmpirical;

target.nextLevelEmpirical=source.nextLevelEmpirical;

target.nextGiftPackLevel=source.nextGiftPackLevel;

        if(source.apiGradeReList==nil)
        {
//            target.apiGradeReList=nil;
        }else
        {
            target.apiGradeReList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.apiGradeReList.count;i++)
            {
		  [target.apiGradeReList addObject:[[ApiGradeReListModel alloc]init]];
            [ApiGradeReListModel cloneObj:source.apiGradeReList[i] target:target.apiGradeReList[i]];
            }
        }


target.nextLevel=source.nextLevel;

target.currLevel=source.currLevel;

}

@end

