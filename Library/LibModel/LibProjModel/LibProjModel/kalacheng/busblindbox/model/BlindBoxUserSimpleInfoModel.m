//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "BlindBoxUserSimpleInfoModel.h"




 @implementation BlindBoxUserSimpleInfoModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"avatar"]=_avatar;

dict[@"userName"]=_userName;

dict[@"userId"]=@(_userId);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<BlindBoxUserSimpleInfoModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
BlindBoxUserSimpleInfoModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<BlindBoxUserSimpleInfoModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<BlindBoxUserSimpleInfoModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
BlindBoxUserSimpleInfoModel* sumMdl=[BlindBoxUserSimpleInfoModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(BlindBoxUserSimpleInfoModel*)getFromDict:(NSDictionary*)dict
{
BlindBoxUserSimpleInfoModel* model=[[BlindBoxUserSimpleInfoModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];


 return model;
}

 +(void)cloneObj:(BlindBoxUserSimpleInfoModel*) source target:(BlindBoxUserSimpleInfoModel*)target
{

target.avatar=source.avatar;

target.userName=source.userName;

target.userId=source.userId;

}

@end

