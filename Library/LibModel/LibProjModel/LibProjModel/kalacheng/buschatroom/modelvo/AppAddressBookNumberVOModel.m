//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppAddressBookNumberVOModel.h"




 @implementation AppAddressBookNumberVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"attentionNum"]=@(_attentionNum);

dict[@"fansNum"]=@(_fansNum);

dict[@"remarkNum"]=@(_remarkNum);

dict[@"groupNum"]=@(_groupNum);

dict[@"chummyNum"]=@(_chummyNum);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppAddressBookNumberVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppAddressBookNumberVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppAddressBookNumberVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppAddressBookNumberVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppAddressBookNumberVOModel* sumMdl=[AppAddressBookNumberVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppAddressBookNumberVOModel*)getFromDict:(NSDictionary*)dict
{
AppAddressBookNumberVOModel* model=[[AppAddressBookNumberVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.attentionNum=[dict[@"attentionNum"] isKindOfClass:[NSNull class]]?0:[dict[@"attentionNum"] intValue];

model.fansNum=[dict[@"fansNum"] isKindOfClass:[NSNull class]]?0:[dict[@"fansNum"] intValue];

model.remarkNum=[dict[@"remarkNum"] isKindOfClass:[NSNull class]]?0:[dict[@"remarkNum"] intValue];

model.groupNum=[dict[@"groupNum"] isKindOfClass:[NSNull class]]?0:[dict[@"groupNum"] intValue];

model.chummyNum=[dict[@"chummyNum"] isKindOfClass:[NSNull class]]?0:[dict[@"chummyNum"] intValue];


 return model;
}

 +(void)cloneObj:(AppAddressBookNumberVOModel*) source target:(AppAddressBookNumberVOModel*)target
{

target.attentionNum=source.attentionNum;

target.fansNum=source.fansNum;

target.remarkNum=source.remarkNum;

target.groupNum=source.groupNum;

target.chummyNum=source.chummyNum;

}

@end

