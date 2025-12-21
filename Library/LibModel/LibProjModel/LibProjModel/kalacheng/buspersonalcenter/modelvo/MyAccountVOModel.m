//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "MyAccountVOModel.h"




 @implementation MyAccountVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"coin"]=@(_coin);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<MyAccountVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
MyAccountVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<MyAccountVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<MyAccountVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
MyAccountVOModel* sumMdl=[MyAccountVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(MyAccountVOModel*)getFromDict:(NSDictionary*)dict
{
MyAccountVOModel* model=[[MyAccountVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.coin=[dict[@"coin"] isKindOfClass:[NSNull class]]?0:[dict[@"coin"] doubleValue];


 return model;
}

 +(void)cloneObj:(MyAccountVOModel*) source target:(MyAccountVOModel*)target
{

target.coin=source.coin;

}

@end

