//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppChatFamilyMsgTopVOModel.h"




 @implementation AppChatFamilyMsgTopVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"sex"]=@(_sex);

dict[@"userAvatar"]=_userAvatar;

dict[@"userName"]=_userName;

dict[@"nobleGradeImg"]=_nobleGradeImg;

dict[@"userId"]=@(_userId);

dict[@"isShow"]=@(_isShow);

dict[@"familyId"]=@(_familyId);

dict[@"nobleAvatarFrame"]=_nobleAvatarFrame;

dict[@"gradeImg"]=_gradeImg;

dict[@"id"]=@(_id_field);

dict[@"topMsgContent"]=_topMsgContent;

dict[@"age"]=@(_age);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppChatFamilyMsgTopVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppChatFamilyMsgTopVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppChatFamilyMsgTopVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppChatFamilyMsgTopVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppChatFamilyMsgTopVOModel* sumMdl=[AppChatFamilyMsgTopVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppChatFamilyMsgTopVOModel*)getFromDict:(NSDictionary*)dict
{
AppChatFamilyMsgTopVOModel* model=[[AppChatFamilyMsgTopVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }

{
NSString *strDate= dict[@"addTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addTime=date;
    }
}

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.userAvatar=[dict[@"userAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"userAvatar"];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.nobleGradeImg=[dict[@"nobleGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleGradeImg"];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.isShow=[dict[@"isShow"] isKindOfClass:[NSNull class]]?0:[dict[@"isShow"] intValue];

model.familyId=[dict[@"familyId"] isKindOfClass:[NSNull class]]?0:[dict[@"familyId"] longLongValue];

model.nobleAvatarFrame=[dict[@"nobleAvatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleAvatarFrame"];

model.gradeImg=[dict[@"gradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"gradeImg"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.topMsgContent=[dict[@"topMsgContent"] isKindOfClass:[NSNull class]]?@"":dict[@"topMsgContent"];

model.age=[dict[@"age"] isKindOfClass:[NSNull class]]?0:[dict[@"age"] intValue];


 return model;
}

 +(void)cloneObj:(AppChatFamilyMsgTopVOModel*) source target:(AppChatFamilyMsgTopVOModel*)target
{

target.addTime=source.addTime;

target.sex=source.sex;

target.userAvatar=source.userAvatar;

target.userName=source.userName;

target.nobleGradeImg=source.nobleGradeImg;

target.userId=source.userId;

target.isShow=source.isShow;

target.familyId=source.familyId;

target.nobleAvatarFrame=source.nobleAvatarFrame;

target.gradeImg=source.gradeImg;

target.id_field=source.id_field;

target.topMsgContent=source.topMsgContent;

target.age=source.age;

}

@end

