//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppLongVideoClassifyDTOModel.h"




 @implementation AppLongVideoClassifyDTOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"adsUrl"]=_adsUrl;

dict[@"carouselImageUrl"]=_carouselImageUrl;

dict[@"isAds"]=@(_isAds);

dict[@"id"]=@(_id_field);

dict[@"superiorId"]=@(_superiorId);

dict[@"classifyName"]=_classifyName;

dict[@"carouselImageAdsUrl"]=_carouselImageAdsUrl;

dict[@"serialNo"]=@(_serialNo);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppLongVideoClassifyDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppLongVideoClassifyDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppLongVideoClassifyDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppLongVideoClassifyDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppLongVideoClassifyDTOModel* sumMdl=[AppLongVideoClassifyDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppLongVideoClassifyDTOModel*)getFromDict:(NSDictionary*)dict
{
AppLongVideoClassifyDTOModel* model=[[AppLongVideoClassifyDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.adsUrl=[dict[@"adsUrl"] isKindOfClass:[NSNull class]]?@"":dict[@"adsUrl"];

model.carouselImageUrl=[dict[@"carouselImageUrl"] isKindOfClass:[NSNull class]]?@"":dict[@"carouselImageUrl"];

model.isAds=[dict[@"isAds"] isKindOfClass:[NSNull class]]?0:[dict[@"isAds"] intValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.superiorId=[dict[@"superiorId"] isKindOfClass:[NSNull class]]?0:[dict[@"superiorId"] longLongValue];

model.classifyName=[dict[@"classifyName"] isKindOfClass:[NSNull class]]?@"":dict[@"classifyName"];

model.carouselImageAdsUrl=[dict[@"carouselImageAdsUrl"] isKindOfClass:[NSNull class]]?@"":dict[@"carouselImageAdsUrl"];

model.serialNo=[dict[@"serialNo"] isKindOfClass:[NSNull class]]?0:[dict[@"serialNo"] intValue];


 return model;
}

 +(void)cloneObj:(AppLongVideoClassifyDTOModel*) source target:(AppLongVideoClassifyDTOModel*)target
{

target.adsUrl=source.adsUrl;

target.carouselImageUrl=source.carouselImageUrl;

target.isAds=source.isAds;

target.id_field=source.id_field;

target.superiorId=source.superiorId;

target.classifyName=source.classifyName;

target.carouselImageAdsUrl=source.carouselImageAdsUrl;

target.serialNo=source.serialNo;

}

@end

