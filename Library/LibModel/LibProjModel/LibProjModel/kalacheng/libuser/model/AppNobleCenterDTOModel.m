//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppNobleCenterDTOModel.h"
#import "AppGradeBasisInfoModel.h"
#import "AppGradePrivilegeDTOModel.h"




 @implementation AppNobleCenterDTOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"gradeList" : [AppGradeBasisInfoModel class],@"noblePricelegeList" : [AppGradePrivilegeDTOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_gradeList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppGradeBasisInfoModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"gradeList"]=list;
}//end

dict[@"endDay"]=@(_endDay);

dict[@"grade"]=@(_grade);

dict[@"avatar"]=_avatar;

dict[@"nobleGradeImg"]=_nobleGradeImg;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_noblePricelegeList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppGradePrivilegeDTOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"noblePricelegeList"]=list;
}//end


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppNobleCenterDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppNobleCenterDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppNobleCenterDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppNobleCenterDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppNobleCenterDTOModel* sumMdl=[AppNobleCenterDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppNobleCenterDTOModel*)getFromDict:(NSDictionary*)dict
{
AppNobleCenterDTOModel* model=[[AppNobleCenterDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.gradeList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"gradeList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppGradeBasisInfoModel* sumMdl=[AppGradeBasisInfoModel getFromDict:subDic];
[model.gradeList addObject:sumMdl];

}
}

}

model.endDay=[dict[@"endDay"] isKindOfClass:[NSNull class]]?0:[dict[@"endDay"] intValue];

model.grade=[dict[@"grade"] isKindOfClass:[NSNull class]]?0:[dict[@"grade"] intValue];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.nobleGradeImg=[dict[@"nobleGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleGradeImg"];

model.noblePricelegeList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"noblePricelegeList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppGradePrivilegeDTOModel* sumMdl=[AppGradePrivilegeDTOModel getFromDict:subDic];
[model.noblePricelegeList addObject:sumMdl];

}
}

}


 return model;
}

 +(void)cloneObj:(AppNobleCenterDTOModel*) source target:(AppNobleCenterDTOModel*)target
{

        if(source.gradeList==nil)
        {
//            target.gradeList=nil;
        }else
        {
            target.gradeList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.gradeList.count;i++)
            {
		  [target.gradeList addObject:[[AppGradeBasisInfoModel alloc]init]];
            [AppGradeBasisInfoModel cloneObj:source.gradeList[i] target:target.gradeList[i]];
            }
        }


target.endDay=source.endDay;

target.grade=source.grade;

target.avatar=source.avatar;

target.nobleGradeImg=source.nobleGradeImg;

        if(source.noblePricelegeList==nil)
        {
//            target.noblePricelegeList=nil;
        }else
        {
            target.noblePricelegeList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.noblePricelegeList.count;i++)
            {
		  [target.noblePricelegeList addObject:[[AppGradePrivilegeDTOModel alloc]init]];
            [AppGradePrivilegeDTOModel cloneObj:source.noblePricelegeList[i] target:target.noblePricelegeList[i]];
            }
        }


}

@end

