//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiUserInfoLoginModel.h"
#import "GiftPackVOModel.h"
#import "ApiUserInfoModel.h"




 @implementation ApiUserInfoLoginModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"packList" : [GiftPackVOModel class],@"userInfo" : [ApiUserInfoModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_packList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
GiftPackVOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"packList"]=list;
}//end

dict[@"userInfo"]=[_userInfo modelToJSONObject];

dict[@"isLive"]=@(_isLive);

dict[@"isFirstLogin"]=@(_isFirstLogin);

dict[@"followStatus"]=@(_followStatus);

dict[@"isFirstRecharge"]=@(_isFirstRecharge);

dict[@"isVideo"]=@(_isVideo);

dict[@"vipType"]=@(_vipType);

dict[@"user_token"]=_user_token;

dict[@"isPid"]=@(_isPid);

dict[@"userAvatarId"]=@(_userAvatarId);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUserInfoLoginModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiUserInfoLoginModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiUserInfoLoginModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiUserInfoLoginModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiUserInfoLoginModel* sumMdl=[ApiUserInfoLoginModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiUserInfoLoginModel*)getFromDict:(NSDictionary*)dict
{
ApiUserInfoLoginModel* model=[[ApiUserInfoLoginModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.packList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"packList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
GiftPackVOModel* sumMdl=[GiftPackVOModel getFromDict:subDic];
[model.packList addObject:sumMdl];

}
}

}


//getFromDict对象转换  
model.userInfo=[ApiUserInfoModel getFromDict:dict[@"userInfo"]];

model.isLive=[dict[@"isLive"] isKindOfClass:[NSNull class]]?0:[dict[@"isLive"] intValue];

model.isFirstLogin=[dict[@"isFirstLogin"] isKindOfClass:[NSNull class]]?0:[dict[@"isFirstLogin"] intValue];

model.followStatus=[dict[@"followStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"followStatus"] intValue];

model.isFirstRecharge=[dict[@"isFirstRecharge"] isKindOfClass:[NSNull class]]?0:[dict[@"isFirstRecharge"] intValue];

model.isVideo=[dict[@"isVideo"] isKindOfClass:[NSNull class]]?0:[dict[@"isVideo"] intValue];

model.vipType=[dict[@"vipType"] isKindOfClass:[NSNull class]]?0:[dict[@"vipType"] intValue];

model.user_token=[dict[@"user_token"] isKindOfClass:[NSNull class]]?@"":dict[@"user_token"];

model.isPid=[dict[@"isPid"] isKindOfClass:[NSNull class]]?0:[dict[@"isPid"] intValue];

model.userAvatarId=[dict[@"userAvatarId"] isKindOfClass:[NSNull class]]?0:[dict[@"userAvatarId"] longLongValue];


 return model;
}

 +(void)cloneObj:(ApiUserInfoLoginModel*) source target:(ApiUserInfoLoginModel*)target
{

        if(source.packList==nil)
        {
//            target.packList=nil;
        }else
        {
            target.packList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.packList.count;i++)
            {
		  [target.packList addObject:[[GiftPackVOModel alloc]init]];
            [GiftPackVOModel cloneObj:source.packList[i] target:target.packList[i]];
            }
        }

        if(source.userInfo==nil)
        {
//            target.userInfo=nil;
        }else
        {
            [ApiUserInfoModel cloneObj:source.userInfo target:target.userInfo];
        }

target.isLive=source.isLive;

target.isFirstLogin=source.isFirstLogin;

target.followStatus=source.followStatus;

target.isFirstRecharge=source.isFirstRecharge;

target.isVideo=source.isVideo;

target.vipType=source.vipType;

target.user_token=source.user_token;

target.isPid=source.isPid;

target.userAvatarId=source.userAvatarId;

}

@end

