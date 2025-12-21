//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppInviteImgModel.h"




 @implementation AppInviteImgModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"id"]=@(_id_field);

dict[@"sort"]=@(_sort);

dict[@"isTip"]=@(_isTip);

dict[@"url"]=_url;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppInviteImgModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppInviteImgModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppInviteImgModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppInviteImgModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppInviteImgModel* sumMdl=[AppInviteImgModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppInviteImgModel*)getFromDict:(NSDictionary*)dict
{
AppInviteImgModel* model=[[AppInviteImgModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.sort=[dict[@"sort"] isKindOfClass:[NSNull class]]?0:[dict[@"sort"] intValue];

model.isTip=[dict[@"isTip"] isKindOfClass:[NSNull class]]?0:[dict[@"isTip"] intValue];

model.url=[dict[@"url"] isKindOfClass:[NSNull class]]?@"":dict[@"url"];


 return model;
}

 +(void)cloneObj:(AppInviteImgModel*) source target:(AppInviteImgModel*)target
{

target.id_field=source.id_field;

target.sort=source.sort;

target.isTip=source.isTip;

target.url=source.url;

}

@end

