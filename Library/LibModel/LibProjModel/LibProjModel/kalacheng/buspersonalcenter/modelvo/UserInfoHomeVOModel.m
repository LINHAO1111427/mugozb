//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "UserInfoHomeVOModel.h"
#import "ApiUserInfoModel.h"




 @implementation UserInfoHomeVOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"userInfo" : [ApiUserInfoModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"userInfo"]=[_userInfo modelToJSONObject];

dict[@"isAttentionUser"]=@(_isAttentionUser);

dict[@"oooVoice"]=_oooVoice;

dict[@"svipIcon"]=_svipIcon;

dict[@"distance"]=@(_distance);

dict[@"showStatus"]=@(_showStatus);

dict[@"oooVoiceTime"]=@(_oooVoiceTime);

dict[@"starGrade"]=@(_starGrade);

dict[@"nobleExpireDay"]=@(_nobleExpireDay);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<UserInfoHomeVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
UserInfoHomeVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<UserInfoHomeVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<UserInfoHomeVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
UserInfoHomeVOModel* sumMdl=[UserInfoHomeVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(UserInfoHomeVOModel*)getFromDict:(NSDictionary*)dict
{
UserInfoHomeVOModel* model=[[UserInfoHomeVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }

//getFromDict对象转换  
model.userInfo=[ApiUserInfoModel getFromDict:dict[@"userInfo"]];

model.isAttentionUser=[dict[@"isAttentionUser"] isKindOfClass:[NSNull class]]?0:[dict[@"isAttentionUser"] intValue];

model.oooVoice=[dict[@"oooVoice"] isKindOfClass:[NSNull class]]?@"":dict[@"oooVoice"];

model.svipIcon=[dict[@"svipIcon"] isKindOfClass:[NSNull class]]?@"":dict[@"svipIcon"];

model.distance=[dict[@"distance"] isKindOfClass:[NSNull class]]?0:[dict[@"distance"] doubleValue];

model.showStatus=[dict[@"showStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"showStatus"] intValue];

model.oooVoiceTime=[dict[@"oooVoiceTime"] isKindOfClass:[NSNull class]]?0:[dict[@"oooVoiceTime"] longLongValue];

model.starGrade=[dict[@"starGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"starGrade"] intValue];

model.nobleExpireDay=[dict[@"nobleExpireDay"] isKindOfClass:[NSNull class]]?0:[dict[@"nobleExpireDay"] longLongValue];


 return model;
}

 +(void)cloneObj:(UserInfoHomeVOModel*) source target:(UserInfoHomeVOModel*)target
{
        if(source.userInfo==nil)
        {
//            target.userInfo=nil;
        }else
        {
            [ApiUserInfoModel cloneObj:source.userInfo target:target.userInfo];
        }

target.isAttentionUser=source.isAttentionUser;

target.oooVoice=source.oooVoice;

target.svipIcon=source.svipIcon;

target.distance=source.distance;

target.showStatus=source.showStatus;

target.oooVoiceTime=source.oooVoiceTime;

target.starGrade=source.starGrade;

target.nobleExpireDay=source.nobleExpireDay;

}

@end

