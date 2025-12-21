//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "UserSimpleInfoModel.h"




 @implementation UserSimpleInfoModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"userid"]=@(_userid);

dict[@"userName"]=_userName;

dict[@"nobleGrade"]=@(_nobleGrade);

dict[@"CksmtTPrivilege"]=@(_CksmtTPrivilege);

dict[@"isSvip"]=@(_isSvip);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<UserSimpleInfoModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
UserSimpleInfoModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<UserSimpleInfoModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<UserSimpleInfoModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
UserSimpleInfoModel* sumMdl=[UserSimpleInfoModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(UserSimpleInfoModel*)getFromDict:(NSDictionary*)dict
{
UserSimpleInfoModel* model=[[UserSimpleInfoModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.userid=[dict[@"userid"] isKindOfClass:[NSNull class]]?0:[dict[@"userid"] longLongValue];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.nobleGrade=[dict[@"nobleGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"nobleGrade"] intValue];

model.CksmtTPrivilege=[dict[@"CksmtTPrivilege"] isKindOfClass:[NSNull class]]?0:[dict[@"CksmtTPrivilege"] intValue];

model.isSvip=[dict[@"isSvip"] isKindOfClass:[NSNull class]]?0:[dict[@"isSvip"] intValue];


 return model;
}

 +(void)cloneObj:(UserSimpleInfoModel*) source target:(UserSimpleInfoModel*)target
{

target.userid=source.userid;

target.userName=source.userName;

target.nobleGrade=source.nobleGrade;

target.CksmtTPrivilege=source.CksmtTPrivilege;

target.isSvip=source.isSvip;

}

@end

