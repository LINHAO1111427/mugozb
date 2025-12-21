//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiUserLineRoomModel.h"




 @implementation ApiUserLineRoomModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"serialVersionUID"]=@(_serialVersionUID);

dict[@"status"]=@(_status);

dict[@"uid"]=@(_uid);

dict[@"toRoomId"]=@(_toRoomId);

dict[@"toUid"]=@(_toUid);

dict[@"toStream"]=_toStream;

dict[@"toAvatar"]=_toAvatar;

dict[@"toName"]=_toName;

dict[@"toLiveThumb"]=_toLiveThumb;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUserLineRoomModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiUserLineRoomModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiUserLineRoomModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiUserLineRoomModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiUserLineRoomModel* sumMdl=[ApiUserLineRoomModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiUserLineRoomModel*)getFromDict:(NSDictionary*)dict
{
ApiUserLineRoomModel* model=[[ApiUserLineRoomModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.serialVersionUID=[dict[@"serialVersionUID"] isKindOfClass:[NSNull class]]?0:[dict[@"serialVersionUID"] longLongValue];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];

model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];

model.toRoomId=[dict[@"toRoomId"] isKindOfClass:[NSNull class]]?0:[dict[@"toRoomId"] longLongValue];

model.toUid=[dict[@"toUid"] isKindOfClass:[NSNull class]]?0:[dict[@"toUid"] longLongValue];

model.toStream=[dict[@"toStream"] isKindOfClass:[NSNull class]]?@"":dict[@"toStream"];

model.toAvatar=[dict[@"toAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"toAvatar"];

model.toName=[dict[@"toName"] isKindOfClass:[NSNull class]]?@"":dict[@"toName"];

model.toLiveThumb=[dict[@"toLiveThumb"] isKindOfClass:[NSNull class]]?@"":dict[@"toLiveThumb"];


 return model;
}

 +(void)cloneObj:(ApiUserLineRoomModel*) source target:(ApiUserLineRoomModel*)target
{

target.serialVersionUID=source.serialVersionUID;

target.status=source.status;

target.uid=source.uid;

target.toRoomId=source.toRoomId;

target.toUid=source.toUid;

target.toStream=source.toStream;

target.toAvatar=source.toAvatar;

target.toName=source.toName;

target.toLiveThumb=source.toLiveThumb;

}

@end

