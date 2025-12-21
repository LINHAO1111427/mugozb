//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiFileUploadModel.h"
#import "ApiQinuRespModel.h"




 @implementation ApiFileUploadModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"filePath" : [ApiQinuRespModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"accessKeyId"]=_accessKeyId;

dict[@"secretKeyId"]=_secretKeyId;

dict[@"yunServerUrl"]=_yunServerUrl;

dict[@"obsName"]=_obsName;

dict[@"zone"]=_zone;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_filePath;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ApiQinuRespModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"filePath"]=list;
}//end

dict[@"token"]=_token;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiFileUploadModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiFileUploadModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiFileUploadModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiFileUploadModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiFileUploadModel* sumMdl=[ApiFileUploadModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiFileUploadModel*)getFromDict:(NSDictionary*)dict
{
ApiFileUploadModel* model=[[ApiFileUploadModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.accessKeyId=[dict[@"accessKeyId"] isKindOfClass:[NSNull class]]?@"":dict[@"accessKeyId"];

model.secretKeyId=[dict[@"secretKeyId"] isKindOfClass:[NSNull class]]?@"":dict[@"secretKeyId"];

model.yunServerUrl=[dict[@"yunServerUrl"] isKindOfClass:[NSNull class]]?@"":dict[@"yunServerUrl"];

model.obsName=[dict[@"obsName"] isKindOfClass:[NSNull class]]?@"":dict[@"obsName"];

model.zone=[dict[@"zone"] isKindOfClass:[NSNull class]]?@"":dict[@"zone"];

model.filePath=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"filePath"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiQinuRespModel* sumMdl=[ApiQinuRespModel getFromDict:subDic];
[model.filePath addObject:sumMdl];

}
}

}

model.token=[dict[@"token"] isKindOfClass:[NSNull class]]?@"":dict[@"token"];


 return model;
}

 +(void)cloneObj:(ApiFileUploadModel*) source target:(ApiFileUploadModel*)target
{

target.accessKeyId=source.accessKeyId;

target.secretKeyId=source.secretKeyId;

target.yunServerUrl=source.yunServerUrl;

target.obsName=source.obsName;

target.zone=source.zone;

        if(source.filePath==nil)
        {
//            target.filePath=nil;
        }else
        {
            target.filePath=[[NSMutableArray alloc] init];
            for(int i=0;i<source.filePath.count;i++)
            {
		  [target.filePath addObject:[[ApiQinuRespModel alloc]init]];
            [ApiQinuRespModel cloneObj:source.filePath[i] target:target.filePath[i]];
            }
        }


target.token=source.token;

}

@end

