//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiSendVideoUnReadNumberModel.h"




 @implementation ApiSendVideoUnReadNumberModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"serialVersionUID"]=@(_serialVersionUID);

dict[@"number"]=@(_number);

dict[@"code"]=@(_code);

dict[@"msg"]=_msg;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiSendVideoUnReadNumberModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiSendVideoUnReadNumberModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiSendVideoUnReadNumberModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiSendVideoUnReadNumberModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiSendVideoUnReadNumberModel* sumMdl=[ApiSendVideoUnReadNumberModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiSendVideoUnReadNumberModel*)getFromDict:(NSDictionary*)dict
{
ApiSendVideoUnReadNumberModel* model=[[ApiSendVideoUnReadNumberModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.serialVersionUID=[dict[@"serialVersionUID"] isKindOfClass:[NSNull class]]?0:[dict[@"serialVersionUID"] longLongValue];

model.number=[dict[@"number"] isKindOfClass:[NSNull class]]?0:[dict[@"number"] intValue];

model.code=[dict[@"code"] isKindOfClass:[NSNull class]]?0:[dict[@"code"] intValue];

model.msg=[dict[@"msg"] isKindOfClass:[NSNull class]]?@"":dict[@"msg"];


 return model;
}

 +(void)cloneObj:(ApiSendVideoUnReadNumberModel*) source target:(ApiSendVideoUnReadNumberModel*)target
{

target.serialVersionUID=source.serialVersionUID;

target.number=source.number;

target.code=source.code;

target.msg=source.msg;

}

@end

