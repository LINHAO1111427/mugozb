//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppUserSkillVOModel.h"
#import "AppScheduleVOModel.h"
#import "AppSkillTagVOModel.h"




 @implementation AppUserSkillVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"appScheduleVOList" : [AppScheduleVOModel class],@"appSkillTagVOList" : [AppSkillTagVOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_appScheduleVOList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppScheduleVOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"appScheduleVOList"]=list;
}//end

dict[@"unitPrice"]=@(_unitPrice);

dict[@"highestPrice"]=@(_highestPrice);

dict[@"lowestPrice"]=@(_lowestPrice);

dict[@"city"]=_city;

dict[@"signature"]=_signature;

dict[@"skillTextDescription"]=_skillTextDescription;

dict[@"recommendHighestPrice"]=@(_recommendHighestPrice);

dict[@"userAvatar"]=_userAvatar;

dict[@"userName"]=_userName;

dict[@"userId"]=@(_userId);

dict[@"recommendLowestPrice"]=@(_recommendLowestPrice);

dict[@"isAttention"]=@(_isAttention);

dict[@"skillName"]=_skillName;

dict[@"schedule"]=_schedule;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_appSkillTagVOList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppSkillTagVOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"appSkillTagVOList"]=list;
}//end

dict[@"skillTypeId"]=@(_skillTypeId);

dict[@"featuredPicture"]=_featuredPicture;

dict[@"id"]=@(_id_field);

dict[@"skillImage"]=_skillImage;

dict[@"skillTypeTagIds"]=_skillTypeTagIds;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUserSkillVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppUserSkillVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppUserSkillVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppUserSkillVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppUserSkillVOModel* sumMdl=[AppUserSkillVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppUserSkillVOModel*)getFromDict:(NSDictionary*)dict
{
AppUserSkillVOModel* model=[[AppUserSkillVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.appScheduleVOList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"appScheduleVOList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppScheduleVOModel* sumMdl=[AppScheduleVOModel getFromDict:subDic];
[model.appScheduleVOList addObject:sumMdl];

}
}

}

model.unitPrice=[dict[@"unitPrice"] isKindOfClass:[NSNull class]]?0:[dict[@"unitPrice"] doubleValue];

model.highestPrice=[dict[@"highestPrice"] isKindOfClass:[NSNull class]]?0:[dict[@"highestPrice"] doubleValue];

model.lowestPrice=[dict[@"lowestPrice"] isKindOfClass:[NSNull class]]?0:[dict[@"lowestPrice"] doubleValue];

model.city=[dict[@"city"] isKindOfClass:[NSNull class]]?@"":dict[@"city"];

model.signature=[dict[@"signature"] isKindOfClass:[NSNull class]]?@"":dict[@"signature"];

model.skillTextDescription=[dict[@"skillTextDescription"] isKindOfClass:[NSNull class]]?@"":dict[@"skillTextDescription"];

model.recommendHighestPrice=[dict[@"recommendHighestPrice"] isKindOfClass:[NSNull class]]?0:[dict[@"recommendHighestPrice"] doubleValue];

model.userAvatar=[dict[@"userAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"userAvatar"];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.recommendLowestPrice=[dict[@"recommendLowestPrice"] isKindOfClass:[NSNull class]]?0:[dict[@"recommendLowestPrice"] doubleValue];

model.isAttention=[dict[@"isAttention"] isKindOfClass:[NSNull class]]?0:[dict[@"isAttention"] intValue];

model.skillName=[dict[@"skillName"] isKindOfClass:[NSNull class]]?@"":dict[@"skillName"];

model.schedule=[dict[@"schedule"] isKindOfClass:[NSNull class]]?@"":dict[@"schedule"];

model.appSkillTagVOList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"appSkillTagVOList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppSkillTagVOModel* sumMdl=[AppSkillTagVOModel getFromDict:subDic];
[model.appSkillTagVOList addObject:sumMdl];

}
}

}

model.skillTypeId=[dict[@"skillTypeId"] isKindOfClass:[NSNull class]]?0:[dict[@"skillTypeId"] longLongValue];

model.featuredPicture=[dict[@"featuredPicture"] isKindOfClass:[NSNull class]]?@"":dict[@"featuredPicture"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.skillImage=[dict[@"skillImage"] isKindOfClass:[NSNull class]]?@"":dict[@"skillImage"];

model.skillTypeTagIds=[dict[@"skillTypeTagIds"] isKindOfClass:[NSNull class]]?@"":dict[@"skillTypeTagIds"];


 return model;
}

 +(void)cloneObj:(AppUserSkillVOModel*) source target:(AppUserSkillVOModel*)target
{

        if(source.appScheduleVOList==nil)
        {
//            target.appScheduleVOList=nil;
        }else
        {
            target.appScheduleVOList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.appScheduleVOList.count;i++)
            {
		  [target.appScheduleVOList addObject:[[AppScheduleVOModel alloc]init]];
            [AppScheduleVOModel cloneObj:source.appScheduleVOList[i] target:target.appScheduleVOList[i]];
            }
        }


target.unitPrice=source.unitPrice;

target.highestPrice=source.highestPrice;

target.lowestPrice=source.lowestPrice;

target.city=source.city;

target.signature=source.signature;

target.skillTextDescription=source.skillTextDescription;

target.recommendHighestPrice=source.recommendHighestPrice;

target.userAvatar=source.userAvatar;

target.userName=source.userName;

target.userId=source.userId;

target.recommendLowestPrice=source.recommendLowestPrice;

target.isAttention=source.isAttention;

target.skillName=source.skillName;

target.schedule=source.schedule;

        if(source.appSkillTagVOList==nil)
        {
//            target.appSkillTagVOList=nil;
        }else
        {
            target.appSkillTagVOList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.appSkillTagVOList.count;i++)
            {
		  [target.appSkillTagVOList addObject:[[AppSkillTagVOModel alloc]init]];
            [AppSkillTagVOModel cloneObj:source.appSkillTagVOList[i] target:target.appSkillTagVOList[i]];
            }
        }


target.skillTypeId=source.skillTypeId;

target.featuredPicture=source.featuredPicture;

target.id_field=source.id_field;

target.skillImage=source.skillImage;

target.skillTypeTagIds=source.skillTypeTagIds;

}

@end

