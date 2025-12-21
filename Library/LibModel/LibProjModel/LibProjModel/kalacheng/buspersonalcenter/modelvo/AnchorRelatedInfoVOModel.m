//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AnchorRelatedInfoVOModel.h"
#import "ApiUsersLiveWishModel.h"




 @implementation AnchorRelatedInfoVOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"apiUsersLiveWishList" : [ApiUsersLiveWishModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"isGuard"]=@(_isGuard);

dict[@"isAtten"]=@(_isAtten);

dict[@"isFans"]=@(_isFans);

dict[@"isNoble"]=@(_isNoble);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_apiUsersLiveWishList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ApiUsersLiveWishModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"apiUsersLiveWishList"]=list;
}//end

dict[@"hotVotes"]=@(_hotVotes);

dict[@"userName"]=_userName;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AnchorRelatedInfoVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AnchorRelatedInfoVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AnchorRelatedInfoVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AnchorRelatedInfoVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AnchorRelatedInfoVOModel* sumMdl=[AnchorRelatedInfoVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AnchorRelatedInfoVOModel*)getFromDict:(NSDictionary*)dict
{
AnchorRelatedInfoVOModel* model=[[AnchorRelatedInfoVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.isGuard=[dict[@"isGuard"] isKindOfClass:[NSNull class]]?0:[dict[@"isGuard"] intValue];

model.isAtten=[dict[@"isAtten"] isKindOfClass:[NSNull class]]?0:[dict[@"isAtten"] intValue];

model.isFans=[dict[@"isFans"] isKindOfClass:[NSNull class]]?0:[dict[@"isFans"] intValue];

model.isNoble=[dict[@"isNoble"] isKindOfClass:[NSNull class]]?0:[dict[@"isNoble"] intValue];

model.apiUsersLiveWishList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"apiUsersLiveWishList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiUsersLiveWishModel* sumMdl=[ApiUsersLiveWishModel getFromDict:subDic];
[model.apiUsersLiveWishList addObject:sumMdl];

}
}

}

model.hotVotes=[dict[@"hotVotes"] isKindOfClass:[NSNull class]]?0:[dict[@"hotVotes"] doubleValue];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];


 return model;
}

 +(void)cloneObj:(AnchorRelatedInfoVOModel*) source target:(AnchorRelatedInfoVOModel*)target
{

target.isGuard=source.isGuard;

target.isAtten=source.isAtten;

target.isFans=source.isFans;

target.isNoble=source.isNoble;

        if(source.apiUsersLiveWishList==nil)
        {
//            target.apiUsersLiveWishList=nil;
        }else
        {
            target.apiUsersLiveWishList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.apiUsersLiveWishList.count;i++)
            {
		  [target.apiUsersLiveWishList addObject:[[ApiUsersLiveWishModel alloc]init]];
            [ApiUsersLiveWishModel cloneObj:source.apiUsersLiveWishList[i] target:target.apiUsersLiveWishList[i]];
            }
        }


target.hotVotes=source.hotVotes;

target.userName=source.userName;

}

@end

