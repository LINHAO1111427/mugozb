//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "CommentLableVOModel.h"




 @implementation CommentLableVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"name"]=_name;

dict[@"fontColor"]=_fontColor;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<CommentLableVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
CommentLableVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<CommentLableVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<CommentLableVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
CommentLableVOModel* sumMdl=[CommentLableVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(CommentLableVOModel*)getFromDict:(NSDictionary*)dict
{
CommentLableVOModel* model=[[CommentLableVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.fontColor=[dict[@"fontColor"] isKindOfClass:[NSNull class]]?@"":dict[@"fontColor"];


 return model;
}

 +(void)cloneObj:(CommentLableVOModel*) source target:(CommentLableVOModel*)target
{

target.name=source.name;

target.fontColor=source.fontColor;

}

@end

