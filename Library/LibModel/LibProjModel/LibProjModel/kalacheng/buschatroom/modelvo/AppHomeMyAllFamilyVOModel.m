//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppHomeMyAllFamilyVOModel.h"
#import "AppHomeMyFamilyVOModel.h"




 @implementation AppHomeMyAllFamilyVOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"appHomeMyFamilyVOList" : [AppHomeMyFamilyVOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"isCreateFamily"]=@(_isCreateFamily);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_appHomeMyFamilyVOList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppHomeMyFamilyVOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"appHomeMyFamilyVOList"]=list;
}//end

dict[@"isMultipleFamily"]=@(_isMultipleFamily);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppHomeMyAllFamilyVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppHomeMyAllFamilyVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppHomeMyAllFamilyVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppHomeMyAllFamilyVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppHomeMyAllFamilyVOModel* sumMdl=[AppHomeMyAllFamilyVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppHomeMyAllFamilyVOModel*)getFromDict:(NSDictionary*)dict
{
AppHomeMyAllFamilyVOModel* model=[[AppHomeMyAllFamilyVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.isCreateFamily=[dict[@"isCreateFamily"] isKindOfClass:[NSNull class]]?0:[dict[@"isCreateFamily"] intValue];

model.appHomeMyFamilyVOList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"appHomeMyFamilyVOList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppHomeMyFamilyVOModel* sumMdl=[AppHomeMyFamilyVOModel getFromDict:subDic];
[model.appHomeMyFamilyVOList addObject:sumMdl];

}
}

}

model.isMultipleFamily=[dict[@"isMultipleFamily"] isKindOfClass:[NSNull class]]?0:[dict[@"isMultipleFamily"] intValue];


 return model;
}

 +(void)cloneObj:(AppHomeMyAllFamilyVOModel*) source target:(AppHomeMyAllFamilyVOModel*)target
{

target.isCreateFamily=source.isCreateFamily;

        if(source.appHomeMyFamilyVOList==nil)
        {
//            target.appHomeMyFamilyVOList=nil;
        }else
        {
            target.appHomeMyFamilyVOList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.appHomeMyFamilyVOList.count;i++)
            {
		  [target.appHomeMyFamilyVOList addObject:[[AppHomeMyFamilyVOModel alloc]init]];
            [AppHomeMyFamilyVOModel cloneObj:source.appHomeMyFamilyVOList[i] target:target.appHomeMyFamilyVOList[i]];
            }
        }


target.isMultipleFamily=source.isMultipleFamily;

}

@end

