//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "MyPackageDTOModel.h"
#import "AppUsersMicSeatBorderVOModel.h"
#import "AppLiangModel.h"
#import "AppUsersCarModel.h"
#import "NobLiveGiftModel.h"




 @implementation MyPackageDTOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"userMicSeatList" : [AppUsersMicSeatBorderVOModel class],@"userLiangList" : [AppLiangModel class],@"userCarList" : [AppUsersCarModel class],@"myGiftList" : [NobLiveGiftModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_userMicSeatList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppUsersMicSeatBorderVOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"userMicSeatList"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_userLiangList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppLiangModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"userLiangList"]=list;
}//end

dict[@"haveModuleVoiceLive"]=@(_haveModuleVoiceLive);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_userCarList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppUsersCarModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"userCarList"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_myGiftList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
NobLiveGiftModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"myGiftList"]=list;
}//end


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<MyPackageDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
MyPackageDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<MyPackageDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<MyPackageDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
MyPackageDTOModel* sumMdl=[MyPackageDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(MyPackageDTOModel*)getFromDict:(NSDictionary*)dict
{
MyPackageDTOModel* model=[[MyPackageDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.userMicSeatList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"userMicSeatList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppUsersMicSeatBorderVOModel* sumMdl=[AppUsersMicSeatBorderVOModel getFromDict:subDic];
[model.userMicSeatList addObject:sumMdl];

}
}

}

model.userLiangList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"userLiangList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppLiangModel* sumMdl=[AppLiangModel getFromDict:subDic];
[model.userLiangList addObject:sumMdl];

}
}

}

model.haveModuleVoiceLive=[dict[@"haveModuleVoiceLive"] isKindOfClass:[NSNull class]]?0:[dict[@"haveModuleVoiceLive"] intValue];

model.userCarList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"userCarList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppUsersCarModel* sumMdl=[AppUsersCarModel getFromDict:subDic];
[model.userCarList addObject:sumMdl];

}
}

}

model.myGiftList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"myGiftList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
NobLiveGiftModel* sumMdl=[NobLiveGiftModel getFromDict:subDic];
[model.myGiftList addObject:sumMdl];

}
}

}


 return model;
}

 +(void)cloneObj:(MyPackageDTOModel*) source target:(MyPackageDTOModel*)target
{

        if(source.userMicSeatList==nil)
        {
//            target.userMicSeatList=nil;
        }else
        {
            target.userMicSeatList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.userMicSeatList.count;i++)
            {
		  [target.userMicSeatList addObject:[[AppUsersMicSeatBorderVOModel alloc]init]];
            [AppUsersMicSeatBorderVOModel cloneObj:source.userMicSeatList[i] target:target.userMicSeatList[i]];
            }
        }


        if(source.userLiangList==nil)
        {
//            target.userLiangList=nil;
        }else
        {
            target.userLiangList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.userLiangList.count;i++)
            {
		  [target.userLiangList addObject:[[AppLiangModel alloc]init]];
            [AppLiangModel cloneObj:source.userLiangList[i] target:target.userLiangList[i]];
            }
        }


target.haveModuleVoiceLive=source.haveModuleVoiceLive;

        if(source.userCarList==nil)
        {
//            target.userCarList=nil;
        }else
        {
            target.userCarList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.userCarList.count;i++)
            {
		  [target.userCarList addObject:[[AppUsersCarModel alloc]init]];
            [AppUsersCarModel cloneObj:source.userCarList[i] target:target.userCarList[i]];
            }
        }


        if(source.myGiftList==nil)
        {
//            target.myGiftList=nil;
        }else
        {
            target.myGiftList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.myGiftList.count;i++)
            {
		  [target.myGiftList addObject:[[NobLiveGiftModel alloc]init]];
            [NobLiveGiftModel cloneObj:source.myGiftList[i] target:target.myGiftList[i]];
            }
        }


}

@end

