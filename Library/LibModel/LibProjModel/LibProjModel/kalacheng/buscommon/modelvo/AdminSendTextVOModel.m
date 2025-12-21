//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AdminSendTextVOModel.h"




 @implementation AdminSendTextVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"serialVersionUID"]=@(_serialVersionUID);

dict[@"userId"]=@(_userId);

dict[@"msgContext"]=_msgContext;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AdminSendTextVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AdminSendTextVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AdminSendTextVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AdminSendTextVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AdminSendTextVOModel* sumMdl=[AdminSendTextVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AdminSendTextVOModel*)getFromDict:(NSDictionary*)dict
{
AdminSendTextVOModel* model=[[AdminSendTextVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.serialVersionUID=[dict[@"serialVersionUID"] isKindOfClass:[NSNull class]]?0:[dict[@"serialVersionUID"] longLongValue];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.msgContext=[dict[@"msgContext"] isKindOfClass:[NSNull class]]?@"":dict[@"msgContext"];


 return model;
}

 +(void)cloneObj:(AdminSendTextVOModel*) source target:(AdminSendTextVOModel*)target
{

target.serialVersionUID=source.serialVersionUID;

target.userId=source.userId;

target.msgContext=source.msgContext;

}

@end

