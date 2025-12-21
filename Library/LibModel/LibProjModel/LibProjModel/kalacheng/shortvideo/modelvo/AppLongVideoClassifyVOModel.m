//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppLongVideoClassifyVOModel.h"
#import "AppLongVideoClassifyDTOModel.h"




 @implementation AppLongVideoClassifyVOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"appLongVideoClassifyDTOList" : [AppLongVideoClassifyDTOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"classifyId"]=@(_classifyId);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_appLongVideoClassifyDTOList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppLongVideoClassifyDTOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"appLongVideoClassifyDTOList"]=list;
}//end

dict[@"classifyName"]=_classifyName;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppLongVideoClassifyVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppLongVideoClassifyVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppLongVideoClassifyVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppLongVideoClassifyVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppLongVideoClassifyVOModel* sumMdl=[AppLongVideoClassifyVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppLongVideoClassifyVOModel*)getFromDict:(NSDictionary*)dict
{
AppLongVideoClassifyVOModel* model=[[AppLongVideoClassifyVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.classifyId=[dict[@"classifyId"] isKindOfClass:[NSNull class]]?0:[dict[@"classifyId"] longLongValue];

model.appLongVideoClassifyDTOList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"appLongVideoClassifyDTOList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppLongVideoClassifyDTOModel* sumMdl=[AppLongVideoClassifyDTOModel getFromDict:subDic];
[model.appLongVideoClassifyDTOList addObject:sumMdl];

}
}

}

model.classifyName=[dict[@"classifyName"] isKindOfClass:[NSNull class]]?@"":dict[@"classifyName"];


 return model;
}

 +(void)cloneObj:(AppLongVideoClassifyVOModel*) source target:(AppLongVideoClassifyVOModel*)target
{

target.classifyId=source.classifyId;

        if(source.appLongVideoClassifyDTOList==nil)
        {
//            target.appLongVideoClassifyDTOList=nil;
        }else
        {
            target.appLongVideoClassifyDTOList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.appLongVideoClassifyDTOList.count;i++)
            {
		  [target.appLongVideoClassifyDTOList addObject:[[AppLongVideoClassifyDTOModel alloc]init]];
            [AppLongVideoClassifyDTOModel cloneObj:source.appLongVideoClassifyDTOList[i] target:target.appLongVideoClassifyDTOList[i]];
            }
        }


target.classifyName=source.classifyName;

}

@end

