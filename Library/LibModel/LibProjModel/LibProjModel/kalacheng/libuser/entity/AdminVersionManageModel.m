//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AdminVersionManageModel.h"




 @implementation AdminVersionManageModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"ipaPackUrl"]=_ipaPackUrl;

dict[@"ipaVersionCode"]=@(_ipaVersionCode);

dict[@"iosPackName"]=_iosPackName;

dict[@"ipaPlistUrl"]=_ipaPlistUrl;

dict[@"ipaDesc"]=_ipaDesc;

dict[@"ipaShelves"]=@(_ipaShelves);

dict[@"apkUrl"]=_apkUrl;

dict[@"iosIconUrl"]=_iosIconUrl;

dict[@"ipaUrl"]=_ipaUrl;

dict[@"ipaVersion"]=_ipaVersion;

dict[@"apkDesc"]=_apkDesc;

dict[@"iosApplicationName"]=_iosApplicationName;

dict[@"apkVersion"]=_apkVersion;

dict[@"iosOpenInstall"]=@(_iosOpenInstall);

dict[@"apkVersionCode"]=@(_apkVersionCode);

dict[@"isConstraintIpa"]=@(_isConstraintIpa);

dict[@"id"]=@(_id_field);

dict[@"isConstraintApk"]=@(_isConstraintApk);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AdminVersionManageModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AdminVersionManageModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AdminVersionManageModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AdminVersionManageModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AdminVersionManageModel* sumMdl=[AdminVersionManageModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AdminVersionManageModel*)getFromDict:(NSDictionary*)dict
{
AdminVersionManageModel* model=[[AdminVersionManageModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.ipaPackUrl=[dict[@"ipaPackUrl"] isKindOfClass:[NSNull class]]?@"":dict[@"ipaPackUrl"];

model.ipaVersionCode=[dict[@"ipaVersionCode"] isKindOfClass:[NSNull class]]?0:[dict[@"ipaVersionCode"] intValue];

model.iosPackName=[dict[@"iosPackName"] isKindOfClass:[NSNull class]]?@"":dict[@"iosPackName"];

model.ipaPlistUrl=[dict[@"ipaPlistUrl"] isKindOfClass:[NSNull class]]?@"":dict[@"ipaPlistUrl"];

model.ipaDesc=[dict[@"ipaDesc"] isKindOfClass:[NSNull class]]?@"":dict[@"ipaDesc"];

model.ipaShelves=[dict[@"ipaShelves"] isKindOfClass:[NSNull class]]?0:[dict[@"ipaShelves"] intValue];

model.apkUrl=[dict[@"apkUrl"] isKindOfClass:[NSNull class]]?@"":dict[@"apkUrl"];

model.iosIconUrl=[dict[@"iosIconUrl"] isKindOfClass:[NSNull class]]?@"":dict[@"iosIconUrl"];

model.ipaUrl=[dict[@"ipaUrl"] isKindOfClass:[NSNull class]]?@"":dict[@"ipaUrl"];

model.ipaVersion=[dict[@"ipaVersion"] isKindOfClass:[NSNull class]]?@"":dict[@"ipaVersion"];

model.apkDesc=[dict[@"apkDesc"] isKindOfClass:[NSNull class]]?@"":dict[@"apkDesc"];

model.iosApplicationName=[dict[@"iosApplicationName"] isKindOfClass:[NSNull class]]?@"":dict[@"iosApplicationName"];

model.apkVersion=[dict[@"apkVersion"] isKindOfClass:[NSNull class]]?@"":dict[@"apkVersion"];

model.iosOpenInstall=[dict[@"iosOpenInstall"] isKindOfClass:[NSNull class]]?0:[dict[@"iosOpenInstall"] intValue];

model.apkVersionCode=[dict[@"apkVersionCode"] isKindOfClass:[NSNull class]]?0:[dict[@"apkVersionCode"] intValue];

model.isConstraintIpa=[dict[@"isConstraintIpa"] isKindOfClass:[NSNull class]]?0:[dict[@"isConstraintIpa"] intValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.isConstraintApk=[dict[@"isConstraintApk"] isKindOfClass:[NSNull class]]?0:[dict[@"isConstraintApk"] intValue];


 return model;
}

 +(void)cloneObj:(AdminVersionManageModel*) source target:(AdminVersionManageModel*)target
{

target.ipaPackUrl=source.ipaPackUrl;

target.ipaVersionCode=source.ipaVersionCode;

target.iosPackName=source.iosPackName;

target.ipaPlistUrl=source.ipaPlistUrl;

target.ipaDesc=source.ipaDesc;

target.ipaShelves=source.ipaShelves;

target.apkUrl=source.apkUrl;

target.iosIconUrl=source.iosIconUrl;

target.ipaUrl=source.ipaUrl;

target.ipaVersion=source.ipaVersion;

target.apkDesc=source.apkDesc;

target.iosApplicationName=source.iosApplicationName;

target.apkVersion=source.apkVersion;

target.iosOpenInstall=source.iosOpenInstall;

target.apkVersionCode=source.apkVersionCode;

target.isConstraintIpa=source.isConstraintIpa;

target.id_field=source.id_field;

target.isConstraintApk=source.isConstraintApk;

}

@end

