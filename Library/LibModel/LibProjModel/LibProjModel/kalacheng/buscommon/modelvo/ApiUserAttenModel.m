//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiUserAttenModel.h"




 @implementation ApiUserAttenModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"wealthGradeImg"]=_wealthGradeImg;

dict[@"role"]=@(_role);

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"liveType"]=@(_liveType);

dict[@"sex"]=@(_sex);

dict[@"userGradeImg"]=_userGradeImg;

dict[@"avatar"]=_avatar;

dict[@"nobleGradeImg"]=_nobleGradeImg;

dict[@"roomId"]=@(_roomId);

dict[@"nobleAvatarFrame"]=_nobleAvatarFrame;

dict[@"uid"]=@(_uid);

dict[@"anchorGradeImg"]=_anchorGradeImg;

dict[@"age"]=@(_age);

dict[@"status"]=@(_status);

dict[@"username"]=_username;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUserAttenModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiUserAttenModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiUserAttenModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiUserAttenModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiUserAttenModel* sumMdl=[ApiUserAttenModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiUserAttenModel*)getFromDict:(NSDictionary*)dict
{
ApiUserAttenModel* model=[[ApiUserAttenModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.wealthGradeImg=[dict[@"wealthGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"wealthGradeImg"];

model.role=[dict[@"role"] isKindOfClass:[NSNull class]]?0:[dict[@"role"] intValue];


{
NSString *strDate= dict[@"addTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addTime=date;
    }
}

model.liveType=[dict[@"liveType"] isKindOfClass:[NSNull class]]?0:[dict[@"liveType"] intValue];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.userGradeImg=[dict[@"userGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"userGradeImg"];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.nobleGradeImg=[dict[@"nobleGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleGradeImg"];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];

model.nobleAvatarFrame=[dict[@"nobleAvatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleAvatarFrame"];

model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];

model.anchorGradeImg=[dict[@"anchorGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorGradeImg"];

model.age=[dict[@"age"] isKindOfClass:[NSNull class]]?0:[dict[@"age"] intValue];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];

model.username=[dict[@"username"] isKindOfClass:[NSNull class]]?@"":dict[@"username"];


 return model;
}

 +(void)cloneObj:(ApiUserAttenModel*) source target:(ApiUserAttenModel*)target
{

target.wealthGradeImg=source.wealthGradeImg;

target.role=source.role;

target.addTime=source.addTime;

target.liveType=source.liveType;

target.sex=source.sex;

target.userGradeImg=source.userGradeImg;

target.avatar=source.avatar;

target.nobleGradeImg=source.nobleGradeImg;

target.roomId=source.roomId;

target.nobleAvatarFrame=source.nobleAvatarFrame;

target.uid=source.uid;

target.anchorGradeImg=source.anchorGradeImg;

target.age=source.age;

target.status=source.status;

target.username=source.username;

}

@end

