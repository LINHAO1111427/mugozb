//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "MyMemberVOModel.h"
#import "GuardUserVOModel.h"
#import "AppGradePrivilegeModel.h"
#import "ApiGradeReWarReModel.h"
#import "TaskDtoModel.h"
#import "AppMedalModel.h"




 @implementation MyMemberVOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"myGuardList" : [GuardUserVOModel class],@"charmGradePrivilegeList" : [AppGradePrivilegeModel class],@"guardMyList" : [GuardUserVOModel class],@"userGradePrivilegeList" : [AppGradePrivilegeModel class],@"wealthGradePrivilegeList" : [AppGradePrivilegeModel class],@"anchorGradePrivilegeList" : [AppGradePrivilegeModel class],@"levelPackList" : [ApiGradeReWarReModel class],@"userTaskList" : [TaskDtoModel class],@"threeMedal" : [AppMedalModel class],@"nobleGradePrivilegeList" : [AppGradePrivilegeModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_myGuardList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
GuardUserVOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"myGuardList"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_charmGradePrivilegeList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppGradePrivilegeModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"charmGradePrivilegeList"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_guardMyList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
GuardUserVOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"guardMyList"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_userGradePrivilegeList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppGradePrivilegeModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"userGradePrivilegeList"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_wealthGradePrivilegeList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppGradePrivilegeModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"wealthGradePrivilegeList"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_anchorGradePrivilegeList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppGradePrivilegeModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"anchorGradePrivilegeList"]=list;
}//end

dict[@"levelPackList"]=[_levelPackList modelToJSONObject];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_userTaskList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
TaskDtoModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"userTaskList"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_threeMedal;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppMedalModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"threeMedal"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_nobleGradePrivilegeList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppGradePrivilegeModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"nobleGradePrivilegeList"]=list;
}//end


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<MyMemberVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
MyMemberVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<MyMemberVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<MyMemberVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
MyMemberVOModel* sumMdl=[MyMemberVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(MyMemberVOModel*)getFromDict:(NSDictionary*)dict
{
MyMemberVOModel* model=[[MyMemberVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.myGuardList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"myGuardList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
GuardUserVOModel* sumMdl=[GuardUserVOModel getFromDict:subDic];
[model.myGuardList addObject:sumMdl];

}
}

}

model.charmGradePrivilegeList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"charmGradePrivilegeList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppGradePrivilegeModel* sumMdl=[AppGradePrivilegeModel getFromDict:subDic];
[model.charmGradePrivilegeList addObject:sumMdl];

}
}

}

model.guardMyList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"guardMyList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
GuardUserVOModel* sumMdl=[GuardUserVOModel getFromDict:subDic];
[model.guardMyList addObject:sumMdl];

}
}

}

model.userGradePrivilegeList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"userGradePrivilegeList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppGradePrivilegeModel* sumMdl=[AppGradePrivilegeModel getFromDict:subDic];
[model.userGradePrivilegeList addObject:sumMdl];

}
}

}

model.wealthGradePrivilegeList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"wealthGradePrivilegeList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppGradePrivilegeModel* sumMdl=[AppGradePrivilegeModel getFromDict:subDic];
[model.wealthGradePrivilegeList addObject:sumMdl];

}
}

}

model.anchorGradePrivilegeList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"anchorGradePrivilegeList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppGradePrivilegeModel* sumMdl=[AppGradePrivilegeModel getFromDict:subDic];
[model.anchorGradePrivilegeList addObject:sumMdl];

}
}

}


//getFromDict对象转换  
model.levelPackList=[ApiGradeReWarReModel getFromDict:dict[@"levelPackList"]];

model.userTaskList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"userTaskList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
TaskDtoModel* sumMdl=[TaskDtoModel getFromDict:subDic];
[model.userTaskList addObject:sumMdl];

}
}

}

model.threeMedal=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"threeMedal"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppMedalModel* sumMdl=[AppMedalModel getFromDict:subDic];
[model.threeMedal addObject:sumMdl];

}
}

}

model.nobleGradePrivilegeList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"nobleGradePrivilegeList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppGradePrivilegeModel* sumMdl=[AppGradePrivilegeModel getFromDict:subDic];
[model.nobleGradePrivilegeList addObject:sumMdl];

}
}

}


 return model;
}

 +(void)cloneObj:(MyMemberVOModel*) source target:(MyMemberVOModel*)target
{

        if(source.myGuardList==nil)
        {
//            target.myGuardList=nil;
        }else
        {
            target.myGuardList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.myGuardList.count;i++)
            {
		  [target.myGuardList addObject:[[GuardUserVOModel alloc]init]];
            [GuardUserVOModel cloneObj:source.myGuardList[i] target:target.myGuardList[i]];
            }
        }


        if(source.charmGradePrivilegeList==nil)
        {
//            target.charmGradePrivilegeList=nil;
        }else
        {
            target.charmGradePrivilegeList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.charmGradePrivilegeList.count;i++)
            {
		  [target.charmGradePrivilegeList addObject:[[AppGradePrivilegeModel alloc]init]];
            [AppGradePrivilegeModel cloneObj:source.charmGradePrivilegeList[i] target:target.charmGradePrivilegeList[i]];
            }
        }


        if(source.guardMyList==nil)
        {
//            target.guardMyList=nil;
        }else
        {
            target.guardMyList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.guardMyList.count;i++)
            {
		  [target.guardMyList addObject:[[GuardUserVOModel alloc]init]];
            [GuardUserVOModel cloneObj:source.guardMyList[i] target:target.guardMyList[i]];
            }
        }


        if(source.userGradePrivilegeList==nil)
        {
//            target.userGradePrivilegeList=nil;
        }else
        {
            target.userGradePrivilegeList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.userGradePrivilegeList.count;i++)
            {
		  [target.userGradePrivilegeList addObject:[[AppGradePrivilegeModel alloc]init]];
            [AppGradePrivilegeModel cloneObj:source.userGradePrivilegeList[i] target:target.userGradePrivilegeList[i]];
            }
        }


        if(source.wealthGradePrivilegeList==nil)
        {
//            target.wealthGradePrivilegeList=nil;
        }else
        {
            target.wealthGradePrivilegeList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.wealthGradePrivilegeList.count;i++)
            {
		  [target.wealthGradePrivilegeList addObject:[[AppGradePrivilegeModel alloc]init]];
            [AppGradePrivilegeModel cloneObj:source.wealthGradePrivilegeList[i] target:target.wealthGradePrivilegeList[i]];
            }
        }


        if(source.anchorGradePrivilegeList==nil)
        {
//            target.anchorGradePrivilegeList=nil;
        }else
        {
            target.anchorGradePrivilegeList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.anchorGradePrivilegeList.count;i++)
            {
		  [target.anchorGradePrivilegeList addObject:[[AppGradePrivilegeModel alloc]init]];
            [AppGradePrivilegeModel cloneObj:source.anchorGradePrivilegeList[i] target:target.anchorGradePrivilegeList[i]];
            }
        }

        if(source.levelPackList==nil)
        {
//            target.levelPackList=nil;
        }else
        {
            [ApiGradeReWarReModel cloneObj:source.levelPackList target:target.levelPackList];
        }

        if(source.userTaskList==nil)
        {
//            target.userTaskList=nil;
        }else
        {
            target.userTaskList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.userTaskList.count;i++)
            {
		  [target.userTaskList addObject:[[TaskDtoModel alloc]init]];
            [TaskDtoModel cloneObj:source.userTaskList[i] target:target.userTaskList[i]];
            }
        }


        if(source.threeMedal==nil)
        {
//            target.threeMedal=nil;
        }else
        {
            target.threeMedal=[[NSMutableArray alloc] init];
            for(int i=0;i<source.threeMedal.count;i++)
            {
		  [target.threeMedal addObject:[[AppMedalModel alloc]init]];
            [AppMedalModel cloneObj:source.threeMedal[i] target:target.threeMedal[i]];
            }
        }


        if(source.nobleGradePrivilegeList==nil)
        {
//            target.nobleGradePrivilegeList=nil;
        }else
        {
            target.nobleGradePrivilegeList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.nobleGradePrivilegeList.count;i++)
            {
		  [target.nobleGradePrivilegeList addObject:[[AppGradePrivilegeModel alloc]init]];
            [AppGradePrivilegeModel cloneObj:source.nobleGradePrivilegeList[i] target:target.nobleGradePrivilegeList[i]];
            }
        }


}

@end

