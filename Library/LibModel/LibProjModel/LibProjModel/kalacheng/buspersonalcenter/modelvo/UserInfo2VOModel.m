//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "UserInfo2VOModel.h"
#import "ApiUserInfoModel.h"
#import "UserInterestTabVOModel.h"
#import "GiftWallDtoModel.h"
#import "AppMedalModel.h"




 @implementation UserInfo2VOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"userInfo" : [ApiUserInfoModel class],@"myInterestList" : [UserInterestTabVOModel class],@"giftWall" : [GiftWallDtoModel class],@"medalWall" : [AppMedalModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"userInfo"]=[_userInfo modelToJSONObject];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_myInterestList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
UserInterestTabVOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"myInterestList"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_giftWall;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
GiftWallDtoModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"giftWall"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_medalWall;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppMedalModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"medalWall"]=list;
}//end


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<UserInfo2VOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
UserInfo2VOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<UserInfo2VOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<UserInfo2VOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
UserInfo2VOModel* sumMdl=[UserInfo2VOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(UserInfo2VOModel*)getFromDict:(NSDictionary*)dict
{
UserInfo2VOModel* model=[[UserInfo2VOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }

//getFromDict对象转换  
model.userInfo=[ApiUserInfoModel getFromDict:dict[@"userInfo"]];

model.myInterestList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"myInterestList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
UserInterestTabVOModel* sumMdl=[UserInterestTabVOModel getFromDict:subDic];
[model.myInterestList addObject:sumMdl];

}
}

}

model.giftWall=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"giftWall"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
GiftWallDtoModel* sumMdl=[GiftWallDtoModel getFromDict:subDic];
[model.giftWall addObject:sumMdl];

}
}

}

model.medalWall=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"medalWall"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppMedalModel* sumMdl=[AppMedalModel getFromDict:subDic];
[model.medalWall addObject:sumMdl];

}
}

}


 return model;
}

 +(void)cloneObj:(UserInfo2VOModel*) source target:(UserInfo2VOModel*)target
{
        if(source.userInfo==nil)
        {
//            target.userInfo=nil;
        }else
        {
            [ApiUserInfoModel cloneObj:source.userInfo target:target.userInfo];
        }

        if(source.myInterestList==nil)
        {
//            target.myInterestList=nil;
        }else
        {
            target.myInterestList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.myInterestList.count;i++)
            {
		  [target.myInterestList addObject:[[UserInterestTabVOModel alloc]init]];
            [UserInterestTabVOModel cloneObj:source.myInterestList[i] target:target.myInterestList[i]];
            }
        }


        if(source.giftWall==nil)
        {
//            target.giftWall=nil;
        }else
        {
            target.giftWall=[[NSMutableArray alloc] init];
            for(int i=0;i<source.giftWall.count;i++)
            {
		  [target.giftWall addObject:[[GiftWallDtoModel alloc]init]];
            [GiftWallDtoModel cloneObj:source.giftWall[i] target:target.giftWall[i]];
            }
        }


        if(source.medalWall==nil)
        {
//            target.medalWall=nil;
        }else
        {
            target.medalWall=[[NSMutableArray alloc] init];
            for(int i=0;i<source.medalWall.count;i++)
            {
		  [target.medalWall addObject:[[AppMedalModel alloc]init]];
            [AppMedalModel cloneObj:source.medalWall[i] target:target.medalWall[i]];
            }
        }


}

@end

