//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiSignInDtoModel.h"
#import "ApiSignInModel.h"




 @implementation ApiSignInDtoModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"signList" : [ApiSignInModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_signList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ApiSignInModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"signList"]=list;
}//end

dict[@"signDay"]=@(_signDay);

dict[@"isSign"]=@(_isSign);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiSignInDtoModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiSignInDtoModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiSignInDtoModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiSignInDtoModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiSignInDtoModel* sumMdl=[ApiSignInDtoModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiSignInDtoModel*)getFromDict:(NSDictionary*)dict
{
ApiSignInDtoModel* model=[[ApiSignInDtoModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.signList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"signList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiSignInModel* sumMdl=[ApiSignInModel getFromDict:subDic];
[model.signList addObject:sumMdl];

}
}

}

model.signDay=[dict[@"signDay"] isKindOfClass:[NSNull class]]?0:[dict[@"signDay"] intValue];

model.isSign=[dict[@"isSign"] isKindOfClass:[NSNull class]]?0:[dict[@"isSign"] intValue];


 return model;
}

 +(void)cloneObj:(ApiSignInDtoModel*) source target:(ApiSignInDtoModel*)target
{

        if(source.signList==nil)
        {
//            target.signList=nil;
        }else
        {
            target.signList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.signList.count;i++)
            {
		  [target.signList addObject:[[ApiSignInModel alloc]init]];
            [ApiSignInModel cloneObj:source.signList[i] target:target.signList[i]];
            }
        }


target.signDay=source.signDay;

target.isSign=source.isSign;

}

@end

