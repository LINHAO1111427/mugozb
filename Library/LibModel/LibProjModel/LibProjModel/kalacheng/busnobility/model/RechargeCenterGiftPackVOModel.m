//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "RechargeCenterGiftPackVOModel.h"
#import "GiftPackVOModel.h"




 @implementation RechargeCenterGiftPackVOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"giftList" : [GiftPackVOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_giftList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
GiftPackVOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"giftList"]=list;
}//end

dict[@"name"]=_name;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<RechargeCenterGiftPackVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
RechargeCenterGiftPackVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<RechargeCenterGiftPackVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<RechargeCenterGiftPackVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
RechargeCenterGiftPackVOModel* sumMdl=[RechargeCenterGiftPackVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(RechargeCenterGiftPackVOModel*)getFromDict:(NSDictionary*)dict
{
RechargeCenterGiftPackVOModel* model=[[RechargeCenterGiftPackVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.giftList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"giftList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
GiftPackVOModel* sumMdl=[GiftPackVOModel getFromDict:subDic];
[model.giftList addObject:sumMdl];

}
}

}

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];


 return model;
}

 +(void)cloneObj:(RechargeCenterGiftPackVOModel*) source target:(RechargeCenterGiftPackVOModel*)target
{

        if(source.giftList==nil)
        {
//            target.giftList=nil;
        }else
        {
            target.giftList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.giftList.count;i++)
            {
		  [target.giftList addObject:[[GiftPackVOModel alloc]init]];
            [GiftPackVOModel cloneObj:source.giftList[i] target:target.giftList[i]];
            }
        }


target.name=source.name;

}

@end

