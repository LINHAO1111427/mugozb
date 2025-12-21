//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiLineBeforeOOOModel.h"




 @implementation ApiLineBeforeOOOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"typeVal"]=_typeVal;

dict[@"isPopup"]=@(_isPopup);

dict[@"typeDec"]=_typeDec;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiLineBeforeOOOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiLineBeforeOOOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiLineBeforeOOOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiLineBeforeOOOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiLineBeforeOOOModel* sumMdl=[ApiLineBeforeOOOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiLineBeforeOOOModel*)getFromDict:(NSDictionary*)dict
{
ApiLineBeforeOOOModel* model=[[ApiLineBeforeOOOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.typeVal=[dict[@"typeVal"] isKindOfClass:[NSNull class]]?@"":dict[@"typeVal"];

model.isPopup=[dict[@"isPopup"] isKindOfClass:[NSNull class]]?0:[dict[@"isPopup"] intValue];

model.typeDec=[dict[@"typeDec"] isKindOfClass:[NSNull class]]?@"":dict[@"typeDec"];


 return model;
}

 +(void)cloneObj:(ApiLineBeforeOOOModel*) source target:(ApiLineBeforeOOOModel*)target
{

target.typeVal=source.typeVal;

target.isPopup=source.isPopup;

target.typeDec=source.typeDec;

}

@end

