//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AssistantUserInfoVOModel.h"




 @implementation AssistantUserInfoVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"wealthGradeImg"]=_wealthGradeImg;

dict[@"no"]=@(_no);

dict[@"sex"]=@(_sex);

dict[@"userAvatar"]=_userAvatar;

dict[@"nobleMedal"]=_nobleMedal;

dict[@"noTalking"]=@(_noTalking);

dict[@"userName"]=_userName;

dict[@"nobleGradeImg"]=_nobleGradeImg;

dict[@"userId"]=@(_userId);

dict[@"onOffState"]=@(_onOffState);

dict[@"nobleAvatarFrame"]=_nobleAvatarFrame;

dict[@"isPresenter"]=@(_isPresenter);

dict[@"gradeImg"]=_gradeImg;

dict[@"age"]=@(_age);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AssistantUserInfoVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AssistantUserInfoVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AssistantUserInfoVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AssistantUserInfoVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AssistantUserInfoVOModel* sumMdl=[AssistantUserInfoVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AssistantUserInfoVOModel*)getFromDict:(NSDictionary*)dict
{
AssistantUserInfoVOModel* model=[[AssistantUserInfoVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.wealthGradeImg=[dict[@"wealthGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"wealthGradeImg"];

model.no=[dict[@"no"] isKindOfClass:[NSNull class]]?0:[dict[@"no"] intValue];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.userAvatar=[dict[@"userAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"userAvatar"];

model.nobleMedal=[dict[@"nobleMedal"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleMedal"];

model.noTalking=[dict[@"noTalking"] isKindOfClass:[NSNull class]]?0:[dict[@"noTalking"] intValue];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.nobleGradeImg=[dict[@"nobleGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleGradeImg"];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.onOffState=[dict[@"onOffState"] isKindOfClass:[NSNull class]]?0:[dict[@"onOffState"] intValue];

model.nobleAvatarFrame=[dict[@"nobleAvatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleAvatarFrame"];

model.isPresenter=[dict[@"isPresenter"] isKindOfClass:[NSNull class]]?0:[dict[@"isPresenter"] intValue];

model.gradeImg=[dict[@"gradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"gradeImg"];

model.age=[dict[@"age"] isKindOfClass:[NSNull class]]?0:[dict[@"age"] intValue];


 return model;
}

 +(void)cloneObj:(AssistantUserInfoVOModel*) source target:(AssistantUserInfoVOModel*)target
{

target.wealthGradeImg=source.wealthGradeImg;

target.no=source.no;

target.sex=source.sex;

target.userAvatar=source.userAvatar;

target.nobleMedal=source.nobleMedal;

target.noTalking=source.noTalking;

target.userName=source.userName;

target.nobleGradeImg=source.nobleGradeImg;

target.userId=source.userId;

target.onOffState=source.onOffState;

target.nobleAvatarFrame=source.nobleAvatarFrame;

target.isPresenter=source.isPresenter;

target.gradeImg=source.gradeImg;

target.age=source.age;

}

@end

