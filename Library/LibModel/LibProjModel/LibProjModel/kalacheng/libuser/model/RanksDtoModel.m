//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "RanksDtoModel.h"




 @implementation RanksDtoModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"wealthGradeImg"]=_wealthGradeImg;

dict[@"upperLevelDelta"]=@(_upperLevelDelta);

dict[@"anchorGrade"]=@(_anchorGrade);

dict[@"role"]=@(_role);

dict[@"userGrade"]=@(_userGrade);

dict[@"sex"]=@(_sex);

dict[@"userGradeImg"]=_userGradeImg;

dict[@"delta"]=@(_delta);

dict[@"nobleMedal"]=_nobleMedal;

dict[@"avatar"]=_avatar;

dict[@"sort"]=@(_sort);

dict[@"nobleGradeImg"]=_nobleGradeImg;

dict[@"userId"]=@(_userId);

dict[@"nobleAvatarFrame"]=_nobleAvatarFrame;

dict[@"anchorGradeImg"]=_anchorGradeImg;

dict[@"wealthGrade"]=@(_wealthGrade);

dict[@"nobleGrade"]=@(_nobleGrade);

dict[@"age"]=@(_age);

dict[@"username"]=_username;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<RanksDtoModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
RanksDtoModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<RanksDtoModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<RanksDtoModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
RanksDtoModel* sumMdl=[RanksDtoModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(RanksDtoModel*)getFromDict:(NSDictionary*)dict
{
RanksDtoModel* model=[[RanksDtoModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.wealthGradeImg=[dict[@"wealthGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"wealthGradeImg"];

model.upperLevelDelta=[dict[@"upperLevelDelta"] isKindOfClass:[NSNull class]]?0:[dict[@"upperLevelDelta"] doubleValue];

model.anchorGrade=[dict[@"anchorGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorGrade"] intValue];

model.role=[dict[@"role"] isKindOfClass:[NSNull class]]?0:[dict[@"role"] intValue];

model.userGrade=[dict[@"userGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"userGrade"] intValue];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.userGradeImg=[dict[@"userGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"userGradeImg"];

model.delta=[dict[@"delta"] isKindOfClass:[NSNull class]]?0:[dict[@"delta"] doubleValue];

model.nobleMedal=[dict[@"nobleMedal"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleMedal"];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.sort=[dict[@"sort"] isKindOfClass:[NSNull class]]?0:[dict[@"sort"] intValue];

model.nobleGradeImg=[dict[@"nobleGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleGradeImg"];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.nobleAvatarFrame=[dict[@"nobleAvatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleAvatarFrame"];

model.anchorGradeImg=[dict[@"anchorGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorGradeImg"];

model.wealthGrade=[dict[@"wealthGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"wealthGrade"] intValue];

model.nobleGrade=[dict[@"nobleGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"nobleGrade"] intValue];

model.age=[dict[@"age"] isKindOfClass:[NSNull class]]?0:[dict[@"age"] intValue];

model.username=[dict[@"username"] isKindOfClass:[NSNull class]]?@"":dict[@"username"];


 return model;
}

 +(void)cloneObj:(RanksDtoModel*) source target:(RanksDtoModel*)target
{

target.wealthGradeImg=source.wealthGradeImg;

target.upperLevelDelta=source.upperLevelDelta;

target.anchorGrade=source.anchorGrade;

target.role=source.role;

target.userGrade=source.userGrade;

target.sex=source.sex;

target.userGradeImg=source.userGradeImg;

target.delta=source.delta;

target.nobleMedal=source.nobleMedal;

target.avatar=source.avatar;

target.sort=source.sort;

target.nobleGradeImg=source.nobleGradeImg;

target.userId=source.userId;

target.nobleAvatarFrame=source.nobleAvatarFrame;

target.anchorGradeImg=source.anchorGradeImg;

target.wealthGrade=source.wealthGrade;

target.nobleGrade=source.nobleGrade;

target.age=source.age;

target.username=source.username;

}

@end

