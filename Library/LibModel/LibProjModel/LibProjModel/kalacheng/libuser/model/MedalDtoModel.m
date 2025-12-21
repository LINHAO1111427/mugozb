//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "MedalDtoModel.h"
#import "AppMedalModel.h"




 @implementation MedalDtoModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"noNobleMedals" : [AppMedalModel class],@"noWealthMedals" : [AppMedalModel class],@"noUserMedals" : [AppMedalModel class],@"noGuardMedals" : [AppMedalModel class],@"myAllMedals" : [AppMedalModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_noNobleMedals;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppMedalModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"noNobleMedals"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_noWealthMedals;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppMedalModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"noWealthMedals"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_noUserMedals;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppMedalModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"noUserMedals"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_noGuardMedals;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppMedalModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"noGuardMedals"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_myAllMedals;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppMedalModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"myAllMedals"]=list;
}//end


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<MedalDtoModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
MedalDtoModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<MedalDtoModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<MedalDtoModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
MedalDtoModel* sumMdl=[MedalDtoModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(MedalDtoModel*)getFromDict:(NSDictionary*)dict
{
MedalDtoModel* model=[[MedalDtoModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.noNobleMedals=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"noNobleMedals"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppMedalModel* sumMdl=[AppMedalModel getFromDict:subDic];
[model.noNobleMedals addObject:sumMdl];

}
}

}

model.noWealthMedals=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"noWealthMedals"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppMedalModel* sumMdl=[AppMedalModel getFromDict:subDic];
[model.noWealthMedals addObject:sumMdl];

}
}

}

model.noUserMedals=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"noUserMedals"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppMedalModel* sumMdl=[AppMedalModel getFromDict:subDic];
[model.noUserMedals addObject:sumMdl];

}
}

}

model.noGuardMedals=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"noGuardMedals"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppMedalModel* sumMdl=[AppMedalModel getFromDict:subDic];
[model.noGuardMedals addObject:sumMdl];

}
}

}

model.myAllMedals=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"myAllMedals"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppMedalModel* sumMdl=[AppMedalModel getFromDict:subDic];
[model.myAllMedals addObject:sumMdl];

}
}

}


 return model;
}

 +(void)cloneObj:(MedalDtoModel*) source target:(MedalDtoModel*)target
{

        if(source.noNobleMedals==nil)
        {
//            target.noNobleMedals=nil;
        }else
        {
            target.noNobleMedals=[[NSMutableArray alloc] init];
            for(int i=0;i<source.noNobleMedals.count;i++)
            {
		  [target.noNobleMedals addObject:[[AppMedalModel alloc]init]];
            [AppMedalModel cloneObj:source.noNobleMedals[i] target:target.noNobleMedals[i]];
            }
        }


        if(source.noWealthMedals==nil)
        {
//            target.noWealthMedals=nil;
        }else
        {
            target.noWealthMedals=[[NSMutableArray alloc] init];
            for(int i=0;i<source.noWealthMedals.count;i++)
            {
		  [target.noWealthMedals addObject:[[AppMedalModel alloc]init]];
            [AppMedalModel cloneObj:source.noWealthMedals[i] target:target.noWealthMedals[i]];
            }
        }


        if(source.noUserMedals==nil)
        {
//            target.noUserMedals=nil;
        }else
        {
            target.noUserMedals=[[NSMutableArray alloc] init];
            for(int i=0;i<source.noUserMedals.count;i++)
            {
		  [target.noUserMedals addObject:[[AppMedalModel alloc]init]];
            [AppMedalModel cloneObj:source.noUserMedals[i] target:target.noUserMedals[i]];
            }
        }


        if(source.noGuardMedals==nil)
        {
//            target.noGuardMedals=nil;
        }else
        {
            target.noGuardMedals=[[NSMutableArray alloc] init];
            for(int i=0;i<source.noGuardMedals.count;i++)
            {
		  [target.noGuardMedals addObject:[[AppMedalModel alloc]init]];
            [AppMedalModel cloneObj:source.noGuardMedals[i] target:target.noGuardMedals[i]];
            }
        }


        if(source.myAllMedals==nil)
        {
//            target.myAllMedals=nil;
        }else
        {
            target.myAllMedals=[[NSMutableArray alloc] init];
            for(int i=0;i<source.myAllMedals.count;i++)
            {
		  [target.myAllMedals addObject:[[AppMedalModel alloc]init]];
            [AppMedalModel cloneObj:source.myAllMedals[i] target:target.myAllMedals[i]];
            }
        }


}

@end

