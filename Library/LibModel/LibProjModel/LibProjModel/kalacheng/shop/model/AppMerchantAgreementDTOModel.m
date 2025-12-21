//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppMerchantAgreementDTOModel.h"




 @implementation AppMerchantAgreementDTOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"postExcerpt"]=_postExcerpt;

dict[@"postTitle"]=_postTitle;

dict[@"remake"]=_remake;

dict[@"status"]=@(_status);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppMerchantAgreementDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppMerchantAgreementDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppMerchantAgreementDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppMerchantAgreementDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppMerchantAgreementDTOModel* sumMdl=[AppMerchantAgreementDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppMerchantAgreementDTOModel*)getFromDict:(NSDictionary*)dict
{
AppMerchantAgreementDTOModel* model=[[AppMerchantAgreementDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.postExcerpt=[dict[@"postExcerpt"] isKindOfClass:[NSNull class]]?@"":dict[@"postExcerpt"];

model.postTitle=[dict[@"postTitle"] isKindOfClass:[NSNull class]]?@"":dict[@"postTitle"];

model.remake=[dict[@"remake"] isKindOfClass:[NSNull class]]?@"":dict[@"remake"];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];


 return model;
}

 +(void)cloneObj:(AppMerchantAgreementDTOModel*) source target:(AppMerchantAgreementDTOModel*)target
{

target.postExcerpt=source.postExcerpt;

target.postTitle=source.postTitle;

target.remake=source.remake;

target.status=source.status;

}

@end

