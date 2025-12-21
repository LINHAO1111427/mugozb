//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppUserDataImgModel.h"
#import "AppUserDataReviewVOModel.h"




 @implementation AppUserDataImgModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"appUserAvatar" : [AppUserDataReviewVOModel class],@"appUserPortrait" : [AppUserDataReviewVOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"appUserAvatar"]=[_appUserAvatar modelToJSONObject];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_appUserPortrait;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppUserDataReviewVOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"appUserPortrait"]=list;
}//end


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUserDataImgModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppUserDataImgModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppUserDataImgModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppUserDataImgModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppUserDataImgModel* sumMdl=[AppUserDataImgModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppUserDataImgModel*)getFromDict:(NSDictionary*)dict
{
AppUserDataImgModel* model=[[AppUserDataImgModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }

//getFromDict对象转换  
model.appUserAvatar=[AppUserDataReviewVOModel getFromDict:dict[@"appUserAvatar"]];

model.appUserPortrait=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"appUserPortrait"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppUserDataReviewVOModel* sumMdl=[AppUserDataReviewVOModel getFromDict:subDic];
[model.appUserPortrait addObject:sumMdl];

}
}

}


 return model;
}

 +(void)cloneObj:(AppUserDataImgModel*) source target:(AppUserDataImgModel*)target
{
        if(source.appUserAvatar==nil)
        {
//            target.appUserAvatar=nil;
        }else
        {
            [AppUserDataReviewVOModel cloneObj:source.appUserAvatar target:target.appUserAvatar];
        }

        if(source.appUserPortrait==nil)
        {
//            target.appUserPortrait=nil;
        }else
        {
            target.appUserPortrait=[[NSMutableArray alloc] init];
            for(int i=0;i<source.appUserPortrait.count;i++)
            {
		  [target.appUserPortrait addObject:[[AppUserDataReviewVOModel alloc]init]];
            [AppUserDataReviewVOModel cloneObj:source.appUserPortrait[i] target:target.appUserPortrait[i]];
            }
        }


}

@end

