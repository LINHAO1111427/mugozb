//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "UserInfoRelationVO2Model.h"
#import "ApiUserInfoModel.h"




 @implementation UserInfoRelationVO2Model  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"userInfo" : [ApiUserInfoModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"userInfo"]=[_userInfo modelToJSONObject];

dict[@"isAttentionUser"]=@(_isAttentionUser);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<UserInfoRelationVO2Model*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
UserInfoRelationVO2Model* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<UserInfoRelationVO2Model*>*)getFromArr:(NSArray*)list
{
NSMutableArray<UserInfoRelationVO2Model*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
UserInfoRelationVO2Model* sumMdl=[UserInfoRelationVO2Model getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(UserInfoRelationVO2Model*)getFromDict:(NSDictionary*)dict
{
UserInfoRelationVO2Model* model=[[UserInfoRelationVO2Model alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }

//getFromDict对象转换  
model.userInfo=[ApiUserInfoModel getFromDict:dict[@"userInfo"]];

model.isAttentionUser=[dict[@"isAttentionUser"] isKindOfClass:[NSNull class]]?0:[dict[@"isAttentionUser"] intValue];


 return model;
}

 +(void)cloneObj:(UserInfoRelationVO2Model*) source target:(UserInfoRelationVO2Model*)target
{
        if(source.userInfo==nil)
        {
//            target.userInfo=nil;
        }else
        {
            [ApiUserInfoModel cloneObj:source.userInfo target:target.userInfo];
        }

target.isAttentionUser=source.isAttentionUser;

}

@end

