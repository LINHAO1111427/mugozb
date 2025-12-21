//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppShareConfigModel.h"




 @implementation AppShareConfigModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"shareTitle"]=_shareTitle;

dict[@"familyShareTitle"]=_familyShareTitle;

dict[@"ipaEwm"]=_ipaEwm;

dict[@"logo"]=_logo;

dict[@"shareDes"]=_shareDes;

dict[@"familyShareDes"]=_familyShareDes;

dict[@"id"]=@(_id_field);

dict[@"inviteShareDes"]=_inviteShareDes;

dict[@"videoShareDes"]=_videoShareDes;

dict[@"videoShareTitle"]=_videoShareTitle;

dict[@"apkEwm"]=_apkEwm;

dict[@"inviteShareTitle"]=_inviteShareTitle;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppShareConfigModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppShareConfigModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppShareConfigModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppShareConfigModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppShareConfigModel* sumMdl=[AppShareConfigModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppShareConfigModel*)getFromDict:(NSDictionary*)dict
{
AppShareConfigModel* model=[[AppShareConfigModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.shareTitle=[dict[@"shareTitle"] isKindOfClass:[NSNull class]]?@"":dict[@"shareTitle"];

model.familyShareTitle=[dict[@"familyShareTitle"] isKindOfClass:[NSNull class]]?@"":dict[@"familyShareTitle"];

model.ipaEwm=[dict[@"ipaEwm"] isKindOfClass:[NSNull class]]?@"":dict[@"ipaEwm"];

model.logo=[dict[@"logo"] isKindOfClass:[NSNull class]]?@"":dict[@"logo"];

model.shareDes=[dict[@"shareDes"] isKindOfClass:[NSNull class]]?@"":dict[@"shareDes"];

model.familyShareDes=[dict[@"familyShareDes"] isKindOfClass:[NSNull class]]?@"":dict[@"familyShareDes"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.inviteShareDes=[dict[@"inviteShareDes"] isKindOfClass:[NSNull class]]?@"":dict[@"inviteShareDes"];

model.videoShareDes=[dict[@"videoShareDes"] isKindOfClass:[NSNull class]]?@"":dict[@"videoShareDes"];

model.videoShareTitle=[dict[@"videoShareTitle"] isKindOfClass:[NSNull class]]?@"":dict[@"videoShareTitle"];

model.apkEwm=[dict[@"apkEwm"] isKindOfClass:[NSNull class]]?@"":dict[@"apkEwm"];

model.inviteShareTitle=[dict[@"inviteShareTitle"] isKindOfClass:[NSNull class]]?@"":dict[@"inviteShareTitle"];


 return model;
}

 +(void)cloneObj:(AppShareConfigModel*) source target:(AppShareConfigModel*)target
{

target.shareTitle=source.shareTitle;

target.familyShareTitle=source.familyShareTitle;

target.ipaEwm=source.ipaEwm;

target.logo=source.logo;

target.shareDes=source.shareDes;

target.familyShareDes=source.familyShareDes;

target.id_field=source.id_field;

target.inviteShareDes=source.inviteShareDes;

target.videoShareDes=source.videoShareDes;

target.videoShareTitle=source.videoShareTitle;

target.apkEwm=source.apkEwm;

target.inviteShareTitle=source.inviteShareTitle;

}

@end

