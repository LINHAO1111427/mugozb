//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiElasticFrameModel.h"




 @implementation ApiElasticFrameModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"serialVersionUID"]=@(_serialVersionUID);

dict[@"roomid"]=@(_roomid);

dict[@"userName"]=_userName;

dict[@"uid"]=@(_uid);

dict[@"avatar"]=_avatar;

dict[@"content"]=_content;

dict[@"type"]=@(_type);

dict[@"childType"]=@(_childType);

dict[@"childTypeName"]=_childTypeName;

dict[@"vipName"]=_vipName;

dict[@"grade"]=_grade;

dict[@"taskName"]=_taskName;

dict[@"taskPoint"]=@(_taskPoint);

dict[@"medalName"]=_medalName;

dict[@"medalLogo"]=_medalLogo;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiElasticFrameModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiElasticFrameModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiElasticFrameModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiElasticFrameModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiElasticFrameModel* sumMdl=[ApiElasticFrameModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiElasticFrameModel*)getFromDict:(NSDictionary*)dict
{
ApiElasticFrameModel* model=[[ApiElasticFrameModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.serialVersionUID=[dict[@"serialVersionUID"] isKindOfClass:[NSNull class]]?0:[dict[@"serialVersionUID"] longLongValue];

model.roomid=[dict[@"roomid"] isKindOfClass:[NSNull class]]?0:[dict[@"roomid"] longLongValue];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.content=[dict[@"content"] isKindOfClass:[NSNull class]]?@"":dict[@"content"];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];

model.childType=[dict[@"childType"] isKindOfClass:[NSNull class]]?0:[dict[@"childType"] intValue];

model.childTypeName=[dict[@"childTypeName"] isKindOfClass:[NSNull class]]?@"":dict[@"childTypeName"];

model.vipName=[dict[@"vipName"] isKindOfClass:[NSNull class]]?@"":dict[@"vipName"];

model.grade=[dict[@"grade"] isKindOfClass:[NSNull class]]?@"":dict[@"grade"];

model.taskName=[dict[@"taskName"] isKindOfClass:[NSNull class]]?@"":dict[@"taskName"];

model.taskPoint=[dict[@"taskPoint"] isKindOfClass:[NSNull class]]?0:[dict[@"taskPoint"] intValue];

model.medalName=[dict[@"medalName"] isKindOfClass:[NSNull class]]?@"":dict[@"medalName"];

model.medalLogo=[dict[@"medalLogo"] isKindOfClass:[NSNull class]]?@"":dict[@"medalLogo"];


 return model;
}

 +(void)cloneObj:(ApiElasticFrameModel*) source target:(ApiElasticFrameModel*)target
{

target.serialVersionUID=source.serialVersionUID;

target.roomid=source.roomid;

target.userName=source.userName;

target.uid=source.uid;

target.avatar=source.avatar;

target.content=source.content;

target.type=source.type;

target.childType=source.childType;

target.childTypeName=source.childTypeName;

target.vipName=source.vipName;

target.grade=source.grade;

target.taskName=source.taskName;

target.taskPoint=source.taskPoint;

target.medalName=source.medalName;

target.medalLogo=source.medalLogo;

}

@end

