//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppSeekUserVOModel.h"




 @implementation AppSeekUserVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"unitPrice"]=@(_unitPrice);

dict[@"role"]=@(_role);

dict[@"distance"]=@(_distance);

dict[@"signature"]=_signature;

dict[@"skillTagArr"]=_skillTagArr;

dict[@"skillTextDescription"]=_skillTextDescription;

dict[@"sex"]=@(_sex);

dict[@"userAvatar"]=_userAvatar;

dict[@"userName"]=_userName;

dict[@"userId"]=@(_userId);

dict[@"anchorGradeImg"]=_anchorGradeImg;

dict[@"featuredPicture"]=_featuredPicture;

dict[@"skillNameArr"]=_skillNameArr;

dict[@"skillImage"]=_skillImage;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppSeekUserVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppSeekUserVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppSeekUserVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppSeekUserVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppSeekUserVOModel* sumMdl=[AppSeekUserVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppSeekUserVOModel*)getFromDict:(NSDictionary*)dict
{
AppSeekUserVOModel* model=[[AppSeekUserVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.unitPrice=[dict[@"unitPrice"] isKindOfClass:[NSNull class]]?0:[dict[@"unitPrice"] doubleValue];

model.role=[dict[@"role"] isKindOfClass:[NSNull class]]?0:[dict[@"role"] intValue];

model.distance=[dict[@"distance"] isKindOfClass:[NSNull class]]?0:[dict[@"distance"] doubleValue];

model.signature=[dict[@"signature"] isKindOfClass:[NSNull class]]?@"":dict[@"signature"];

model.skillTagArr=[dict[@"skillTagArr"] isKindOfClass:[NSNull class]]?@"":dict[@"skillTagArr"];

model.skillTextDescription=[dict[@"skillTextDescription"] isKindOfClass:[NSNull class]]?@"":dict[@"skillTextDescription"];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.userAvatar=[dict[@"userAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"userAvatar"];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.anchorGradeImg=[dict[@"anchorGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorGradeImg"];

model.featuredPicture=[dict[@"featuredPicture"] isKindOfClass:[NSNull class]]?@"":dict[@"featuredPicture"];

model.skillNameArr=[dict[@"skillNameArr"] isKindOfClass:[NSNull class]]?@"":dict[@"skillNameArr"];

model.skillImage=[dict[@"skillImage"] isKindOfClass:[NSNull class]]?@"":dict[@"skillImage"];


 return model;
}

 +(void)cloneObj:(AppSeekUserVOModel*) source target:(AppSeekUserVOModel*)target
{

target.unitPrice=source.unitPrice;

target.role=source.role;

target.distance=source.distance;

target.signature=source.signature;

target.skillTagArr=source.skillTagArr;

target.skillTextDescription=source.skillTextDescription;

target.sex=source.sex;

target.userAvatar=source.userAvatar;

target.userName=source.userName;

target.userId=source.userId;

target.anchorGradeImg=source.anchorGradeImg;

target.featuredPicture=source.featuredPicture;

target.skillNameArr=source.skillNameArr;

target.skillImage=source.skillImage;

}

@end

