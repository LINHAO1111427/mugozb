//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "MountDetailDTOModel.h"
#import "AppCarModel.h"
#import "AppLiangModel.h"




 @implementation MountDetailDTOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"appCar" : [AppCarModel class],@"liang" : [AppLiangModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"buyuname"]=_buyuname;

dict[@"vcUnit"]=_vcUnit;

dict[@"appCar"]=[_appCar modelToJSONObject];

dict[@"liang"]=[_liang modelToJSONObject];


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<MountDetailDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
MountDetailDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<MountDetailDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<MountDetailDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
MountDetailDTOModel* sumMdl=[MountDetailDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(MountDetailDTOModel*)getFromDict:(NSDictionary*)dict
{
MountDetailDTOModel* model=[[MountDetailDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.buyuname=[dict[@"buyuname"] isKindOfClass:[NSNull class]]?@"":dict[@"buyuname"];

model.vcUnit=[dict[@"vcUnit"] isKindOfClass:[NSNull class]]?@"":dict[@"vcUnit"];


//getFromDict对象转换  
model.appCar=[AppCarModel getFromDict:dict[@"appCar"]];


//getFromDict对象转换  
model.liang=[AppLiangModel getFromDict:dict[@"liang"]];


 return model;
}

 +(void)cloneObj:(MountDetailDTOModel*) source target:(MountDetailDTOModel*)target
{

target.buyuname=source.buyuname;

target.vcUnit=source.vcUnit;
        if(source.appCar==nil)
        {
//            target.appCar=nil;
        }else
        {
            [AppCarModel cloneObj:source.appCar target:target.appCar];
        }
        if(source.liang==nil)
        {
//            target.liang=nil;
        }else
        {
            [AppLiangModel cloneObj:source.liang target:target.liang];
        }

}

@end

