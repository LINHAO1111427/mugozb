//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "TraceBeanModel.h"




 @implementation TraceBeanModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"time"]=_time;

dict[@"status"]=_status;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<TraceBeanModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
TraceBeanModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<TraceBeanModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<TraceBeanModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
TraceBeanModel* sumMdl=[TraceBeanModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(TraceBeanModel*)getFromDict:(NSDictionary*)dict
{
TraceBeanModel* model=[[TraceBeanModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.time=[dict[@"time"] isKindOfClass:[NSNull class]]?@"":dict[@"time"];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?@"":dict[@"status"];


 return model;
}

 +(void)cloneObj:(TraceBeanModel*) source target:(TraceBeanModel*)target
{

target.time=source.time;

target.status=source.status;

}

@end

