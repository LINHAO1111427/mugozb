//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "EnableInvtHostModel.h"




 @implementation EnableInvtHostModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"headNo"]=@(_headNo);

dict[@"videoCoin"]=@(_videoCoin);

dict[@"invited"]=@(_invited);

dict[@"avatar"]=_avatar;

dict[@"nobleGrade"]=@(_nobleGrade);

dict[@"poster"]=_poster;

dict[@"userid"]=@(_userid);

dict[@"username"]=_username;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<EnableInvtHostModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
EnableInvtHostModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<EnableInvtHostModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<EnableInvtHostModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
EnableInvtHostModel* sumMdl=[EnableInvtHostModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(EnableInvtHostModel*)getFromDict:(NSDictionary*)dict
{
EnableInvtHostModel* model=[[EnableInvtHostModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.headNo=[dict[@"headNo"] isKindOfClass:[NSNull class]]?0:[dict[@"headNo"] longLongValue];

model.videoCoin=[dict[@"videoCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"videoCoin"] doubleValue];

model.invited=[dict[@"invited"] isKindOfClass:[NSNull class]]?0:[dict[@"invited"] intValue];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.nobleGrade=[dict[@"nobleGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"nobleGrade"] intValue];

model.poster=[dict[@"poster"] isKindOfClass:[NSNull class]]?@"":dict[@"poster"];

model.userid=[dict[@"userid"] isKindOfClass:[NSNull class]]?0:[dict[@"userid"] longLongValue];

model.username=[dict[@"username"] isKindOfClass:[NSNull class]]?@"":dict[@"username"];


 return model;
}

 +(void)cloneObj:(EnableInvtHostModel*) source target:(EnableInvtHostModel*)target
{

target.headNo=source.headNo;

target.videoCoin=source.videoCoin;

target.invited=source.invited;

target.avatar=source.avatar;

target.nobleGrade=source.nobleGrade;

target.poster=source.poster;

target.userid=source.userid;

target.username=source.username;

}

@end

