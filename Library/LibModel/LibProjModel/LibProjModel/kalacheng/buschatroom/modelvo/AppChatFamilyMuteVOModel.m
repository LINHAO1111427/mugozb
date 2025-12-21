//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppChatFamilyMuteVOModel.h"




 @implementation AppChatFamilyMuteVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"familyId"]=@(_familyId);

dict[@"nobleAvatarFrame"]=_nobleAvatarFrame;

dict[@"expireTime"]=[HttpClient stringFromDate:_expireTime];

dict[@"muteDuration"]=@(_muteDuration);

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"userAvatar"]=_userAvatar;

dict[@"gradeImg"]=_gradeImg;

dict[@"id"]=@(_id_field);

dict[@"userName"]=_userName;

dict[@"userId"]=@(_userId);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppChatFamilyMuteVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppChatFamilyMuteVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppChatFamilyMuteVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppChatFamilyMuteVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppChatFamilyMuteVOModel* sumMdl=[AppChatFamilyMuteVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppChatFamilyMuteVOModel*)getFromDict:(NSDictionary*)dict
{
AppChatFamilyMuteVOModel* model=[[AppChatFamilyMuteVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.familyId=[dict[@"familyId"] isKindOfClass:[NSNull class]]?0:[dict[@"familyId"] longLongValue];

model.nobleAvatarFrame=[dict[@"nobleAvatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleAvatarFrame"];


{
NSString *strDate= dict[@"expireTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.expireTime=date;
    }
}

model.muteDuration=[dict[@"muteDuration"] isKindOfClass:[NSNull class]]?0:[dict[@"muteDuration"] intValue];


{
NSString *strDate= dict[@"addTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addTime=date;
    }
}

model.userAvatar=[dict[@"userAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"userAvatar"];

model.gradeImg=[dict[@"gradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"gradeImg"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];


 return model;
}

 +(void)cloneObj:(AppChatFamilyMuteVOModel*) source target:(AppChatFamilyMuteVOModel*)target
{

target.familyId=source.familyId;

target.nobleAvatarFrame=source.nobleAvatarFrame;

target.expireTime=source.expireTime;

target.muteDuration=source.muteDuration;

target.addTime=source.addTime;

target.userAvatar=source.userAvatar;

target.gradeImg=source.gradeImg;

target.id_field=source.id_field;

target.userName=source.userName;

target.userId=source.userId;

}

@end

