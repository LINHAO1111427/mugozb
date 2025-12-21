//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiUsableAnchorRespModel.h"




 @implementation ApiUsableAnchorRespModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"ismic"]=@(_ismic);

dict[@"wealthGradeImg"]=_wealthGradeImg;

dict[@"nobleAvatarFrame"]=_nobleAvatarFrame;

dict[@"sex"]=@(_sex);

dict[@"userAvatar"]=_userAvatar;

dict[@"nobleMedal"]=_nobleMedal;

dict[@"id"]=@(_id_field);

dict[@"userName"]=_userName;

dict[@"nobleGradeImg"]=_nobleGradeImg;

dict[@"userId"]=@(_userId);

dict[@"age"]=@(_age);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUsableAnchorRespModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiUsableAnchorRespModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiUsableAnchorRespModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiUsableAnchorRespModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiUsableAnchorRespModel* sumMdl=[ApiUsableAnchorRespModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiUsableAnchorRespModel*)getFromDict:(NSDictionary*)dict
{
ApiUsableAnchorRespModel* model=[[ApiUsableAnchorRespModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.ismic=[dict[@"ismic"] isKindOfClass:[NSNull class]]?0:[dict[@"ismic"] intValue];

model.wealthGradeImg=[dict[@"wealthGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"wealthGradeImg"];

model.nobleAvatarFrame=[dict[@"nobleAvatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleAvatarFrame"];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.userAvatar=[dict[@"userAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"userAvatar"];

model.nobleMedal=[dict[@"nobleMedal"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleMedal"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.nobleGradeImg=[dict[@"nobleGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleGradeImg"];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.age=[dict[@"age"] isKindOfClass:[NSNull class]]?0:[dict[@"age"] intValue];


 return model;
}

 +(void)cloneObj:(ApiUsableAnchorRespModel*) source target:(ApiUsableAnchorRespModel*)target
{

target.ismic=source.ismic;

target.wealthGradeImg=source.wealthGradeImg;

target.nobleAvatarFrame=source.nobleAvatarFrame;

target.sex=source.sex;

target.userAvatar=source.userAvatar;

target.nobleMedal=source.nobleMedal;

target.id_field=source.id_field;

target.userName=source.userName;

target.nobleGradeImg=source.nobleGradeImg;

target.userId=source.userId;

target.age=source.age;

}

@end

