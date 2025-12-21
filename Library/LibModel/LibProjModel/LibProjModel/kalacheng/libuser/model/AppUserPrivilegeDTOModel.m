//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppUserPrivilegeDTOModel.h"
#import "AppImproveQuicklyDTOModel.h"
#import "AppMedalDTOModel.h"
#import "AppGradePrivilegeDTOModel.h"




 @implementation AppUserPrivilegeDTOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"aiqList" : [AppImproveQuicklyDTOModel class],@"amDTOList" : [AppMedalDTOModel class],@"agpDTOList" : [AppGradePrivilegeDTOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_aiqList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppImproveQuicklyDTOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"aiqList"]=list;
}//end

dict[@"nextNeedPoint"]=@(_nextNeedPoint);

dict[@"grade"]=@(_grade);

dict[@"nextStartVal"]=@(_nextStartVal);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_amDTOList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppMedalDTOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"amDTOList"]=list;
}//end

dict[@"avatar"]=_avatar;

dict[@"point"]=@(_point);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_agpDTOList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppGradePrivilegeDTOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"agpDTOList"]=list;
}//end


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUserPrivilegeDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppUserPrivilegeDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppUserPrivilegeDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppUserPrivilegeDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppUserPrivilegeDTOModel* sumMdl=[AppUserPrivilegeDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppUserPrivilegeDTOModel*)getFromDict:(NSDictionary*)dict
{
AppUserPrivilegeDTOModel* model=[[AppUserPrivilegeDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.aiqList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"aiqList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppImproveQuicklyDTOModel* sumMdl=[AppImproveQuicklyDTOModel getFromDict:subDic];
[model.aiqList addObject:sumMdl];

}
}

}

model.nextNeedPoint=[dict[@"nextNeedPoint"] isKindOfClass:[NSNull class]]?0:[dict[@"nextNeedPoint"] intValue];

model.grade=[dict[@"grade"] isKindOfClass:[NSNull class]]?0:[dict[@"grade"] intValue];

model.nextStartVal=[dict[@"nextStartVal"] isKindOfClass:[NSNull class]]?0:[dict[@"nextStartVal"] intValue];

model.amDTOList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"amDTOList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppMedalDTOModel* sumMdl=[AppMedalDTOModel getFromDict:subDic];
[model.amDTOList addObject:sumMdl];

}
}

}

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.point=[dict[@"point"] isKindOfClass:[NSNull class]]?0:[dict[@"point"] intValue];

model.agpDTOList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"agpDTOList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppGradePrivilegeDTOModel* sumMdl=[AppGradePrivilegeDTOModel getFromDict:subDic];
[model.agpDTOList addObject:sumMdl];

}
}

}


 return model;
}

 +(void)cloneObj:(AppUserPrivilegeDTOModel*) source target:(AppUserPrivilegeDTOModel*)target
{

        if(source.aiqList==nil)
        {
//            target.aiqList=nil;
        }else
        {
            target.aiqList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.aiqList.count;i++)
            {
		  [target.aiqList addObject:[[AppImproveQuicklyDTOModel alloc]init]];
            [AppImproveQuicklyDTOModel cloneObj:source.aiqList[i] target:target.aiqList[i]];
            }
        }


target.nextNeedPoint=source.nextNeedPoint;

target.grade=source.grade;

target.nextStartVal=source.nextStartVal;

        if(source.amDTOList==nil)
        {
//            target.amDTOList=nil;
        }else
        {
            target.amDTOList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.amDTOList.count;i++)
            {
		  [target.amDTOList addObject:[[AppMedalDTOModel alloc]init]];
            [AppMedalDTOModel cloneObj:source.amDTOList[i] target:target.amDTOList[i]];
            }
        }


target.avatar=source.avatar;

target.point=source.point;

        if(source.agpDTOList==nil)
        {
//            target.agpDTOList=nil;
        }else
        {
            target.agpDTOList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.agpDTOList.count;i++)
            {
		  [target.agpDTOList addObject:[[AppGradePrivilegeDTOModel alloc]init]];
            [AppGradePrivilegeDTOModel cloneObj:source.agpDTOList[i] target:target.agpDTOList[i]];
            }
        }


}

@end

