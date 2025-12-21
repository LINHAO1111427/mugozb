//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiUserBlackInfoVOModel.h"




 @implementation ApiUserBlackInfoVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"wealthGradeImg"]=_wealthGradeImg;

dict[@"userSex"]=@(_userSex);

dict[@"charmGradeImg"]=_charmGradeImg;

dict[@"signature"]=_signature;

dict[@"userAvatar"]=_userAvatar;

dict[@"userGradeImg"]=_userGradeImg;

dict[@"nobleMedal"]=_nobleMedal;

dict[@"nobleName"]=_nobleName;

dict[@"userName"]=_userName;

dict[@"nobleGradeImg"]=_nobleGradeImg;

dict[@"userId"]=@(_userId);

dict[@"userAge"]=@(_userAge);

dict[@"nobleAvatarFrame"]=_nobleAvatarFrame;

dict[@"anchorGradeImg"]=_anchorGradeImg;

dict[@"userRole"]=@(_userRole);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUserBlackInfoVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiUserBlackInfoVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiUserBlackInfoVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiUserBlackInfoVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiUserBlackInfoVOModel* sumMdl=[ApiUserBlackInfoVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiUserBlackInfoVOModel*)getFromDict:(NSDictionary*)dict
{
ApiUserBlackInfoVOModel* model=[[ApiUserBlackInfoVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.wealthGradeImg=[dict[@"wealthGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"wealthGradeImg"];

model.userSex=[dict[@"userSex"] isKindOfClass:[NSNull class]]?0:[dict[@"userSex"] intValue];

model.charmGradeImg=[dict[@"charmGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"charmGradeImg"];

model.signature=[dict[@"signature"] isKindOfClass:[NSNull class]]?@"":dict[@"signature"];

model.userAvatar=[dict[@"userAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"userAvatar"];

model.userGradeImg=[dict[@"userGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"userGradeImg"];

model.nobleMedal=[dict[@"nobleMedal"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleMedal"];

model.nobleName=[dict[@"nobleName"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleName"];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.nobleGradeImg=[dict[@"nobleGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleGradeImg"];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.userAge=[dict[@"userAge"] isKindOfClass:[NSNull class]]?0:[dict[@"userAge"] intValue];

model.nobleAvatarFrame=[dict[@"nobleAvatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleAvatarFrame"];

model.anchorGradeImg=[dict[@"anchorGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorGradeImg"];

model.userRole=[dict[@"userRole"] isKindOfClass:[NSNull class]]?0:[dict[@"userRole"] intValue];


 return model;
}

 +(void)cloneObj:(ApiUserBlackInfoVOModel*) source target:(ApiUserBlackInfoVOModel*)target
{

target.wealthGradeImg=source.wealthGradeImg;

target.userSex=source.userSex;

target.charmGradeImg=source.charmGradeImg;

target.signature=source.signature;

target.userAvatar=source.userAvatar;

target.userGradeImg=source.userGradeImg;

target.nobleMedal=source.nobleMedal;

target.nobleName=source.nobleName;

target.userName=source.userName;

target.nobleGradeImg=source.nobleGradeImg;

target.userId=source.userId;

target.userAge=source.userAge;

target.nobleAvatarFrame=source.nobleAvatarFrame;

target.anchorGradeImg=source.anchorGradeImg;

target.userRole=source.userRole;

}

@end

