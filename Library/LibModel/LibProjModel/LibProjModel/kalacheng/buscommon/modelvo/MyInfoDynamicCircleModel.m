//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "MyInfoDynamicCircleModel.h"




 @implementation MyInfoDynamicCircleModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"dynamicThumb"]=_dynamicThumb;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<MyInfoDynamicCircleModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
MyInfoDynamicCircleModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<MyInfoDynamicCircleModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<MyInfoDynamicCircleModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
MyInfoDynamicCircleModel* sumMdl=[MyInfoDynamicCircleModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(MyInfoDynamicCircleModel*)getFromDict:(NSDictionary*)dict
{
MyInfoDynamicCircleModel* model=[[MyInfoDynamicCircleModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.dynamicThumb=[dict[@"dynamicThumb"] isKindOfClass:[NSNull class]]?@"":dict[@"dynamicThumb"];


 return model;
}

 +(void)cloneObj:(MyInfoDynamicCircleModel*) source target:(MyInfoDynamicCircleModel*)target
{

target.dynamicThumb=source.dynamicThumb;

}

@end

