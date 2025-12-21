//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AnchorAuthDOModel.h"




 @implementation AnchorAuthDOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"isRequired"]=@(_isRequired);

dict[@"identification"]=_identification;

dict[@"name"]=_name;

dict[@"isShow"]=@(_isShow);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AnchorAuthDOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AnchorAuthDOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AnchorAuthDOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AnchorAuthDOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AnchorAuthDOModel* sumMdl=[AnchorAuthDOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AnchorAuthDOModel*)getFromDict:(NSDictionary*)dict
{
AnchorAuthDOModel* model=[[AnchorAuthDOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.isRequired=[dict[@"isRequired"] isKindOfClass:[NSNull class]]?0:[dict[@"isRequired"] intValue];

model.identification=[dict[@"identification"] isKindOfClass:[NSNull class]]?@"":dict[@"identification"];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.isShow=[dict[@"isShow"] isKindOfClass:[NSNull class]]?0:[dict[@"isShow"] intValue];


 return model;
}

 +(void)cloneObj:(AnchorAuthDOModel*) source target:(AnchorAuthDOModel*)target
{

target.isRequired=source.isRequired;

target.identification=source.identification;

target.name=source.name;

target.isShow=source.isShow;

}

@end

