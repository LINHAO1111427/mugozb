//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppSvipVOModel.h"
#import "AppSvipPackageVOModel.h"
#import "SvipPrivilegeConfigVOModel.h"




 @implementation AppSvipVOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"svipPackages" : [AppSvipPackageVOModel class],@"svipPrivilegeConfigVO" : [SvipPrivilegeConfigVOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"svipDescription"]=_svipDescription;

dict[@"notes"]=_notes;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_svipPackages;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppSvipPackageVOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"svipPackages"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_svipPrivilegeConfigVO;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
SvipPrivilegeConfigVOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"svipPrivilegeConfigVO"]=list;
}//end

dict[@"name"]=_name;

dict[@"leftDays"]=@(_leftDays);

dict[@"picture"]=_picture;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppSvipVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppSvipVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppSvipVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppSvipVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppSvipVOModel* sumMdl=[AppSvipVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppSvipVOModel*)getFromDict:(NSDictionary*)dict
{
AppSvipVOModel* model=[[AppSvipVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.svipDescription=[dict[@"svipDescription"] isKindOfClass:[NSNull class]]?@"":dict[@"svipDescription"];

model.notes=[dict[@"notes"] isKindOfClass:[NSNull class]]?@"":dict[@"notes"];

model.svipPackages=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"svipPackages"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppSvipPackageVOModel* sumMdl=[AppSvipPackageVOModel getFromDict:subDic];
[model.svipPackages addObject:sumMdl];

}
}

}

model.svipPrivilegeConfigVO=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"svipPrivilegeConfigVO"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
SvipPrivilegeConfigVOModel* sumMdl=[SvipPrivilegeConfigVOModel getFromDict:subDic];
[model.svipPrivilegeConfigVO addObject:sumMdl];

}
}

}

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.leftDays=[dict[@"leftDays"] isKindOfClass:[NSNull class]]?0:[dict[@"leftDays"] intValue];

model.picture=[dict[@"picture"] isKindOfClass:[NSNull class]]?@"":dict[@"picture"];


 return model;
}

 +(void)cloneObj:(AppSvipVOModel*) source target:(AppSvipVOModel*)target
{

target.svipDescription=source.svipDescription;

target.notes=source.notes;

        if(source.svipPackages==nil)
        {
//            target.svipPackages=nil;
        }else
        {
            target.svipPackages=[[NSMutableArray alloc] init];
            for(int i=0;i<source.svipPackages.count;i++)
            {
		  [target.svipPackages addObject:[[AppSvipPackageVOModel alloc]init]];
            [AppSvipPackageVOModel cloneObj:source.svipPackages[i] target:target.svipPackages[i]];
            }
        }


        if(source.svipPrivilegeConfigVO==nil)
        {
//            target.svipPrivilegeConfigVO=nil;
        }else
        {
            target.svipPrivilegeConfigVO=[[NSMutableArray alloc] init];
            for(int i=0;i<source.svipPrivilegeConfigVO.count;i++)
            {
		  [target.svipPrivilegeConfigVO addObject:[[SvipPrivilegeConfigVOModel alloc]init]];
            [SvipPrivilegeConfigVOModel cloneObj:source.svipPrivilegeConfigVO[i] target:target.svipPrivilegeConfigVO[i]];
            }
        }


target.name=source.name;

target.leftDays=source.leftDays;

target.picture=source.picture;

}

@end

