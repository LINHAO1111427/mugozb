//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ImExtraInfoModel.h"




 @implementation ImExtraInfoModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"wealthGradeImg"]=_wealthGradeImg;

dict[@"role"]=@(_role);

dict[@"svipIcon"]=_svipIcon;

dict[@"sex"]=@(_sex);

dict[@"nobleMedal"]=_nobleMedal;

dict[@"UGID"]=@(_UGID);

dict[@"avatar"]=_avatar;

dict[@"nobleGradeImg"]=_nobleGradeImg;

dict[@"gradeIcon"]=_gradeIcon;

dict[@"nobleAvatarFrame"]=_nobleAvatarFrame;

dict[@"name"]=_name;

dict[@"age"]=@(_age);

dict[@"username"]=_username;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ImExtraInfoModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ImExtraInfoModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ImExtraInfoModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ImExtraInfoModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ImExtraInfoModel* sumMdl=[ImExtraInfoModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ImExtraInfoModel*)getFromDict:(NSDictionary*)dict
{
ImExtraInfoModel* model=[[ImExtraInfoModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.wealthGradeImg=[dict[@"wealthGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"wealthGradeImg"];

model.role=[dict[@"role"] isKindOfClass:[NSNull class]]?0:[dict[@"role"] intValue];

model.svipIcon=[dict[@"svipIcon"] isKindOfClass:[NSNull class]]?@"":dict[@"svipIcon"];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.nobleMedal=[dict[@"nobleMedal"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleMedal"];

model.UGID=[dict[@"UGID"] isKindOfClass:[NSNull class]]?0:[dict[@"UGID"] longLongValue];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.nobleGradeImg=[dict[@"nobleGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleGradeImg"];

model.gradeIcon=[dict[@"gradeIcon"] isKindOfClass:[NSNull class]]?@"":dict[@"gradeIcon"];

model.nobleAvatarFrame=[dict[@"nobleAvatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleAvatarFrame"];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.age=[dict[@"age"] isKindOfClass:[NSNull class]]?0:[dict[@"age"] intValue];

model.username=[dict[@"username"] isKindOfClass:[NSNull class]]?@"":dict[@"username"];


 return model;
}

 +(void)cloneObj:(ImExtraInfoModel*) source target:(ImExtraInfoModel*)target
{

target.wealthGradeImg=source.wealthGradeImg;

target.role=source.role;

target.svipIcon=source.svipIcon;

target.sex=source.sex;

target.nobleMedal=source.nobleMedal;

target.UGID=source.UGID;

target.avatar=source.avatar;

target.nobleGradeImg=source.nobleGradeImg;

target.gradeIcon=source.gradeIcon;

target.nobleAvatarFrame=source.nobleAvatarFrame;

target.name=source.name;

target.age=source.age;

target.username=source.username;

}

@end

