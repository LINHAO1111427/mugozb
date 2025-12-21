//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppOtherUserSkillTextVOModel.h"




 @implementation AppOtherUserSkillTextVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"skillTypeId"]=@(_skillTypeId);

dict[@"skillTextDescription"]=_skillTextDescription;

dict[@"userAvatar"]=_userAvatar;

dict[@"id"]=@(_id_field);

dict[@"userName"]=_userName;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppOtherUserSkillTextVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppOtherUserSkillTextVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppOtherUserSkillTextVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppOtherUserSkillTextVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppOtherUserSkillTextVOModel* sumMdl=[AppOtherUserSkillTextVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppOtherUserSkillTextVOModel*)getFromDict:(NSDictionary*)dict
{
AppOtherUserSkillTextVOModel* model=[[AppOtherUserSkillTextVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.skillTypeId=[dict[@"skillTypeId"] isKindOfClass:[NSNull class]]?0:[dict[@"skillTypeId"] longLongValue];

model.skillTextDescription=[dict[@"skillTextDescription"] isKindOfClass:[NSNull class]]?@"":dict[@"skillTextDescription"];

model.userAvatar=[dict[@"userAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"userAvatar"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];


 return model;
}

 +(void)cloneObj:(AppOtherUserSkillTextVOModel*) source target:(AppOtherUserSkillTextVOModel*)target
{

target.skillTypeId=source.skillTypeId;

target.skillTextDescription=source.skillTextDescription;

target.userAvatar=source.userAvatar;

target.id_field=source.id_field;

target.userName=source.userName;

}

@end

