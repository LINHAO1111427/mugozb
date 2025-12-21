//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopLogisticsDTOModel.h"
#import "LogisticsBeanModel.h"




 @implementation ShopLogisticsDTOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"logisticsBean" : [LogisticsBeanModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"logisticsBean"]=[_logisticsBean modelToJSONObject];


{//start
//modelToJSONObject字段数组对象
NSArray* objList=_logisticsList;
NSMutableArray *list =[[NSMutableArray alloc] init];
if(objList==nil)
{return list; 
}
for(int i=0;i<objList.count;i++)
{
[list addObject:objList[i]];

}
dict[@"logisticsList"]=list;
}//end


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopLogisticsDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopLogisticsDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopLogisticsDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopLogisticsDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopLogisticsDTOModel* sumMdl=[ShopLogisticsDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopLogisticsDTOModel*)getFromDict:(NSDictionary*)dict
{
ShopLogisticsDTOModel* model=[[ShopLogisticsDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }

//getFromDict对象转换  
model.logisticsBean=[LogisticsBeanModel getFromDict:dict[@"logisticsBean"]];

model.logisticsList=[[NSMutableArray alloc] init];
{
//getFromDict普通数组string.+null
NSArray *list = dict[@"logisticsList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSString * dat=list[i];
[model.logisticsList addObject:dat];
}
}

}


 return model;
}

 +(void)cloneObj:(ShopLogisticsDTOModel*) source target:(ShopLogisticsDTOModel*)target
{
        if(source.logisticsBean==nil)
        {
//            target.logisticsBean=nil;
        }else
        {
            [LogisticsBeanModel cloneObj:source.logisticsBean target:target.logisticsBean];
        }

        if(source.logisticsList==nil)
        {
//            target.logisticsList=nil;
        }else
        {
            target.logisticsList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.logisticsList.count;i++)
            {
                [target.logisticsList addObject:source.logisticsList[i]];
            }
        }


}

@end

