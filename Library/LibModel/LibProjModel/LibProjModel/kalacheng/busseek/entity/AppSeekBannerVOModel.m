//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppSeekBannerVOModel.h"




 @implementation AppSeekBannerVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"bannerImage"]=_bannerImage;

dict[@"bannerTitle"]=_bannerTitle;

dict[@"bannerType"]=@(_bannerType);

dict[@"bannerLink"]=_bannerLink;

dict[@"id"]=@(_id_field);

dict[@"isEnable"]=@(_isEnable);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppSeekBannerVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppSeekBannerVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppSeekBannerVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppSeekBannerVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppSeekBannerVOModel* sumMdl=[AppSeekBannerVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppSeekBannerVOModel*)getFromDict:(NSDictionary*)dict
{
AppSeekBannerVOModel* model=[[AppSeekBannerVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.bannerImage=[dict[@"bannerImage"] isKindOfClass:[NSNull class]]?@"":dict[@"bannerImage"];

model.bannerTitle=[dict[@"bannerTitle"] isKindOfClass:[NSNull class]]?@"":dict[@"bannerTitle"];

model.bannerType=[dict[@"bannerType"] isKindOfClass:[NSNull class]]?0:[dict[@"bannerType"] intValue];

model.bannerLink=[dict[@"bannerLink"] isKindOfClass:[NSNull class]]?@"":dict[@"bannerLink"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.isEnable=[dict[@"isEnable"] isKindOfClass:[NSNull class]]?0:[dict[@"isEnable"] intValue];


 return model;
}

 +(void)cloneObj:(AppSeekBannerVOModel*) source target:(AppSeekBannerVOModel*)target
{

target.bannerImage=source.bannerImage;

target.bannerTitle=source.bannerTitle;

target.bannerType=source.bannerType;

target.bannerLink=source.bannerLink;

target.id_field=source.id_field;

target.isEnable=source.isEnable;

}

@end

