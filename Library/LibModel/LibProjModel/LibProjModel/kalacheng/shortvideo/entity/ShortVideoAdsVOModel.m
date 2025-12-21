//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShortVideoAdsVOModel.h"




 @implementation ShortVideoAdsVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"adsBannerUrl"]=_adsBannerUrl;

dict[@"adsUrl"]=_adsUrl;

dict[@"avatarAds"]=_avatarAds;

dict[@"adsTitle"]=_adsTitle;

dict[@"adsType"]=@(_adsType);

dict[@"id"]=@(_id_field);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShortVideoAdsVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShortVideoAdsVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShortVideoAdsVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShortVideoAdsVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShortVideoAdsVOModel* sumMdl=[ShortVideoAdsVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShortVideoAdsVOModel*)getFromDict:(NSDictionary*)dict
{
ShortVideoAdsVOModel* model=[[ShortVideoAdsVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.adsBannerUrl=[dict[@"adsBannerUrl"] isKindOfClass:[NSNull class]]?@"":dict[@"adsBannerUrl"];

model.adsUrl=[dict[@"adsUrl"] isKindOfClass:[NSNull class]]?@"":dict[@"adsUrl"];

model.avatarAds=[dict[@"avatarAds"] isKindOfClass:[NSNull class]]?@"":dict[@"avatarAds"];

model.adsTitle=[dict[@"adsTitle"] isKindOfClass:[NSNull class]]?@"":dict[@"adsTitle"];

model.adsType=[dict[@"adsType"] isKindOfClass:[NSNull class]]?0:[dict[@"adsType"] intValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];


 return model;
}

 +(void)cloneObj:(ShortVideoAdsVOModel*) source target:(ShortVideoAdsVOModel*)target
{

target.adsBannerUrl=source.adsBannerUrl;

target.adsUrl=source.adsUrl;

target.avatarAds=source.avatarAds;

target.adsTitle=source.adsTitle;

target.adsType=source.adsType;

target.id_field=source.id_field;

}

@end

