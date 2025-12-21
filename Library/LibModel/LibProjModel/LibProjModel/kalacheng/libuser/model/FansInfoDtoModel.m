//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "FansInfoDtoModel.h"
#import "KeyValueDtoModel.h"
#import "AppUserAvatarModel.h"




 @implementation FansInfoDtoModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"privileges" : [KeyValueDtoModel class],@"avatars" : [AppUserAvatarModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_privileges;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
KeyValueDtoModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"privileges"]=list;
}//end

dict[@"fansNum"]=@(_fansNum);

dict[@"isCreate"]=@(_isCreate);

dict[@"anchorAvatar"]=_anchorAvatar;

dict[@"fansTeamName"]=_fansTeamName;

dict[@"groupId"]=@(_groupId);

dict[@"fansTeamAvatar"]=_fansTeamAvatar;

dict[@"totalCoin"]=@(_totalCoin);

dict[@"isMember"]=@(_isMember);

dict[@"anchorId"]=@(_anchorId);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_avatars;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppUserAvatarModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"avatars"]=list;
}//end

dict[@"coin"]=@(_coin);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<FansInfoDtoModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
FansInfoDtoModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<FansInfoDtoModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<FansInfoDtoModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
FansInfoDtoModel* sumMdl=[FansInfoDtoModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(FansInfoDtoModel*)getFromDict:(NSDictionary*)dict
{
FansInfoDtoModel* model=[[FansInfoDtoModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.privileges=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"privileges"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
KeyValueDtoModel* sumMdl=[KeyValueDtoModel getFromDict:subDic];
[model.privileges addObject:sumMdl];

}
}

}

model.fansNum=[dict[@"fansNum"] isKindOfClass:[NSNull class]]?0:[dict[@"fansNum"] intValue];

model.isCreate=[dict[@"isCreate"] isKindOfClass:[NSNull class]]?0:[dict[@"isCreate"] intValue];

model.anchorAvatar=[dict[@"anchorAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorAvatar"];

model.fansTeamName=[dict[@"fansTeamName"] isKindOfClass:[NSNull class]]?@"":dict[@"fansTeamName"];

model.groupId=[dict[@"groupId"] isKindOfClass:[NSNull class]]?0:[dict[@"groupId"] longLongValue];

model.fansTeamAvatar=[dict[@"fansTeamAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"fansTeamAvatar"];

model.totalCoin=[dict[@"totalCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"totalCoin"] doubleValue];

model.isMember=[dict[@"isMember"] isKindOfClass:[NSNull class]]?0:[dict[@"isMember"] intValue];

model.anchorId=[dict[@"anchorId"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorId"] longLongValue];

model.avatars=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"avatars"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppUserAvatarModel* sumMdl=[AppUserAvatarModel getFromDict:subDic];
[model.avatars addObject:sumMdl];

}
}

}

model.coin=[dict[@"coin"] isKindOfClass:[NSNull class]]?0:[dict[@"coin"] doubleValue];


 return model;
}

 +(void)cloneObj:(FansInfoDtoModel*) source target:(FansInfoDtoModel*)target
{

        if(source.privileges==nil)
        {
//            target.privileges=nil;
        }else
        {
            target.privileges=[[NSMutableArray alloc] init];
            for(int i=0;i<source.privileges.count;i++)
            {
		  [target.privileges addObject:[[KeyValueDtoModel alloc]init]];
            [KeyValueDtoModel cloneObj:source.privileges[i] target:target.privileges[i]];
            }
        }


target.fansNum=source.fansNum;

target.isCreate=source.isCreate;

target.anchorAvatar=source.anchorAvatar;

target.fansTeamName=source.fansTeamName;

target.groupId=source.groupId;

target.fansTeamAvatar=source.fansTeamAvatar;

target.totalCoin=source.totalCoin;

target.isMember=source.isMember;

target.anchorId=source.anchorId;

        if(source.avatars==nil)
        {
//            target.avatars=nil;
        }else
        {
            target.avatars=[[NSMutableArray alloc] init];
            for(int i=0;i<source.avatars.count;i++)
            {
		  [target.avatars addObject:[[AppUserAvatarModel alloc]init]];
            [AppUserAvatarModel cloneObj:source.avatars[i] target:target.avatars[i]];
            }
        }


target.coin=source.coin;

}

@end

