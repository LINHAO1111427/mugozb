//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "TelevisionEpisodeCommentVOModel.h"




 @implementation TelevisionEpisodeCommentVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"wealthGradeImg"]=_wealthGradeImg;

dict[@"userSex"]=@(_userSex);

dict[@"comments"]=_comments;

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"charmGradeImg"]=_charmGradeImg;

dict[@"userAvatar"]=_userAvatar;

dict[@"userGradeImg"]=_userGradeImg;

dict[@"nobleMedal"]=_nobleMedal;

dict[@"nobleName"]=_nobleName;

dict[@"userName"]=_userName;

dict[@"nobleGradeImg"]=_nobleGradeImg;

dict[@"toUserId"]=@(_toUserId);

dict[@"userId"]=@(_userId);

dict[@"userAge"]=@(_userAge);

dict[@"addTimeStr"]=_addTimeStr;

dict[@"toCommentId"]=@(_toCommentId);

dict[@"nobleAvatarFrame"]=_nobleAvatarFrame;

dict[@"anchorGradeImg"]=_anchorGradeImg;

dict[@"commentType"]=@(_commentType);

dict[@"commentId"]=@(_commentId);

dict[@"toUserName"]=_toUserName;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<TelevisionEpisodeCommentVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
TelevisionEpisodeCommentVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<TelevisionEpisodeCommentVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<TelevisionEpisodeCommentVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
TelevisionEpisodeCommentVOModel* sumMdl=[TelevisionEpisodeCommentVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(TelevisionEpisodeCommentVOModel*)getFromDict:(NSDictionary*)dict
{
TelevisionEpisodeCommentVOModel* model=[[TelevisionEpisodeCommentVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.wealthGradeImg=[dict[@"wealthGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"wealthGradeImg"];

model.userSex=[dict[@"userSex"] isKindOfClass:[NSNull class]]?0:[dict[@"userSex"] intValue];

model.comments=[dict[@"comments"] isKindOfClass:[NSNull class]]?@"":dict[@"comments"];


{
NSString *strDate= dict[@"addTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addTime=date;
    }
}

model.charmGradeImg=[dict[@"charmGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"charmGradeImg"];

model.userAvatar=[dict[@"userAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"userAvatar"];

model.userGradeImg=[dict[@"userGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"userGradeImg"];

model.nobleMedal=[dict[@"nobleMedal"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleMedal"];

model.nobleName=[dict[@"nobleName"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleName"];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.nobleGradeImg=[dict[@"nobleGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleGradeImg"];

model.toUserId=[dict[@"toUserId"] isKindOfClass:[NSNull class]]?0:[dict[@"toUserId"] longLongValue];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.userAge=[dict[@"userAge"] isKindOfClass:[NSNull class]]?0:[dict[@"userAge"] intValue];

model.addTimeStr=[dict[@"addTimeStr"] isKindOfClass:[NSNull class]]?@"":dict[@"addTimeStr"];

model.toCommentId=[dict[@"toCommentId"] isKindOfClass:[NSNull class]]?0:[dict[@"toCommentId"] longLongValue];

model.nobleAvatarFrame=[dict[@"nobleAvatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleAvatarFrame"];

model.anchorGradeImg=[dict[@"anchorGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorGradeImg"];

model.commentType=[dict[@"commentType"] isKindOfClass:[NSNull class]]?0:[dict[@"commentType"] intValue];

model.commentId=[dict[@"commentId"] isKindOfClass:[NSNull class]]?0:[dict[@"commentId"] longLongValue];

model.toUserName=[dict[@"toUserName"] isKindOfClass:[NSNull class]]?@"":dict[@"toUserName"];


 return model;
}

 +(void)cloneObj:(TelevisionEpisodeCommentVOModel*) source target:(TelevisionEpisodeCommentVOModel*)target
{

target.wealthGradeImg=source.wealthGradeImg;

target.userSex=source.userSex;

target.comments=source.comments;

target.addTime=source.addTime;

target.charmGradeImg=source.charmGradeImg;

target.userAvatar=source.userAvatar;

target.userGradeImg=source.userGradeImg;

target.nobleMedal=source.nobleMedal;

target.nobleName=source.nobleName;

target.userName=source.userName;

target.nobleGradeImg=source.nobleGradeImg;

target.toUserId=source.toUserId;

target.userId=source.userId;

target.userAge=source.userAge;

target.addTimeStr=source.addTimeStr;

target.toCommentId=source.toCommentId;

target.nobleAvatarFrame=source.nobleAvatarFrame;

target.anchorGradeImg=source.anchorGradeImg;

target.commentType=source.commentType;

target.commentId=source.commentId;

target.toUserName=source.toUserName;

}

@end

