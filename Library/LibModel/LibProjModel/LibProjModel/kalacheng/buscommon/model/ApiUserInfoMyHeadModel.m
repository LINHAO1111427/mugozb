//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiUserInfoMyHeadModel.h"
#import "ApiUserInfoModel.h"




 @implementation ApiUserInfoMyHeadModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"userInfo" : [ApiUserInfoModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"anchorAuditStatus"]=@(_anchorAuditStatus);

dict[@"readMeUsersNumber"]=@(_readMeUsersNumber);

dict[@"userInfo"]=[_userInfo modelToJSONObject];

dict[@"fansNum"]=@(_fansNum);

dict[@"followNum"]=@(_followNum);

dict[@"isVipSee"]=@(_isVipSee);

dict[@"collectNum"]=@(_collectNum);

dict[@"anchorAuditReason"]=_anchorAuditReason;

dict[@"svipExpireDay"]=@(_svipExpireDay);

dict[@"televisionNum"]=@(_televisionNum);

dict[@"nobleExpireDay"]=@(_nobleExpireDay);

dict[@"likeNum"]=@(_likeNum);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUserInfoMyHeadModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiUserInfoMyHeadModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiUserInfoMyHeadModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiUserInfoMyHeadModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiUserInfoMyHeadModel* sumMdl=[ApiUserInfoMyHeadModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiUserInfoMyHeadModel*)getFromDict:(NSDictionary*)dict
{
ApiUserInfoMyHeadModel* model=[[ApiUserInfoMyHeadModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.anchorAuditStatus=[dict[@"anchorAuditStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorAuditStatus"] intValue];

model.readMeUsersNumber=[dict[@"readMeUsersNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"readMeUsersNumber"] intValue];


//getFromDict对象转换  
model.userInfo=[ApiUserInfoModel getFromDict:dict[@"userInfo"]];

model.fansNum=[dict[@"fansNum"] isKindOfClass:[NSNull class]]?0:[dict[@"fansNum"] intValue];

model.followNum=[dict[@"followNum"] isKindOfClass:[NSNull class]]?0:[dict[@"followNum"] intValue];

model.isVipSee=[dict[@"isVipSee"] isKindOfClass:[NSNull class]]?0:[dict[@"isVipSee"] intValue];

model.collectNum=[dict[@"collectNum"] isKindOfClass:[NSNull class]]?0:[dict[@"collectNum"] intValue];

model.anchorAuditReason=[dict[@"anchorAuditReason"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorAuditReason"];

model.svipExpireDay=[dict[@"svipExpireDay"] isKindOfClass:[NSNull class]]?0:[dict[@"svipExpireDay"] intValue];

model.televisionNum=[dict[@"televisionNum"] isKindOfClass:[NSNull class]]?0:[dict[@"televisionNum"] intValue];

model.nobleExpireDay=[dict[@"nobleExpireDay"] isKindOfClass:[NSNull class]]?0:[dict[@"nobleExpireDay"] longLongValue];

model.likeNum=[dict[@"likeNum"] isKindOfClass:[NSNull class]]?0:[dict[@"likeNum"] intValue];


 return model;
}

 +(void)cloneObj:(ApiUserInfoMyHeadModel*) source target:(ApiUserInfoMyHeadModel*)target
{

target.anchorAuditStatus=source.anchorAuditStatus;

target.readMeUsersNumber=source.readMeUsersNumber;
        if(source.userInfo==nil)
        {
//            target.userInfo=nil;
        }else
        {
            [ApiUserInfoModel cloneObj:source.userInfo target:target.userInfo];
        }

target.fansNum=source.fansNum;

target.followNum=source.followNum;

target.isVipSee=source.isVipSee;

target.collectNum=source.collectNum;

target.anchorAuditReason=source.anchorAuditReason;

target.svipExpireDay=source.svipExpireDay;

target.televisionNum=source.televisionNum;

target.nobleExpireDay=source.nobleExpireDay;

target.likeNum=source.likeNum;

}

@end

