//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "modelApiFileUploadParamsModel.h"




 @implementation modelApiFileUploadParamsModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"scene"]=@(_scene);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<modelApiFileUploadParamsModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
modelApiFileUploadParamsModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<modelApiFileUploadParamsModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<modelApiFileUploadParamsModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
modelApiFileUploadParamsModel* sumMdl=[modelApiFileUploadParamsModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(modelApiFileUploadParamsModel*)getFromDict:(NSDictionary*)dict
{
modelApiFileUploadParamsModel* model=[[modelApiFileUploadParamsModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.scene=[dict[@"scene"] isKindOfClass:[NSNull class]]?0:[dict[@"scene"] intValue];


 return model;
}

 +(void)cloneObj:(modelApiFileUploadParamsModel*) source target:(modelApiFileUploadParamsModel*)target
{

target.scene=source.scene;

}

@end

