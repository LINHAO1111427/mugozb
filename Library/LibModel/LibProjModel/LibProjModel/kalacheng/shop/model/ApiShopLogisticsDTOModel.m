//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiShopLogisticsDTOModel.h"
#import "LogisticsNodeDTOModel.h"




 @implementation ApiShopLogisticsDTOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"nodeList" : [LogisticsNodeDTOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"number"]=_number;

dict[@"expName"]=_expName;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_nodeList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
LogisticsNodeDTOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"nodeList"]=list;
}//end


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiShopLogisticsDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiShopLogisticsDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiShopLogisticsDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiShopLogisticsDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiShopLogisticsDTOModel* sumMdl=[ApiShopLogisticsDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiShopLogisticsDTOModel*)getFromDict:(NSDictionary*)dict
{
ApiShopLogisticsDTOModel* model=[[ApiShopLogisticsDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.number=[dict[@"number"] isKindOfClass:[NSNull class]]?@"":dict[@"number"];

model.expName=[dict[@"expName"] isKindOfClass:[NSNull class]]?@"":dict[@"expName"];

model.nodeList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"nodeList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
LogisticsNodeDTOModel* sumMdl=[LogisticsNodeDTOModel getFromDict:subDic];
[model.nodeList addObject:sumMdl];

}
}

}


 return model;
}

 +(void)cloneObj:(ApiShopLogisticsDTOModel*) source target:(ApiShopLogisticsDTOModel*)target
{

target.number=source.number;

target.expName=source.expName;

        if(source.nodeList==nil)
        {
//            target.nodeList=nil;
        }else
        {
            target.nodeList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.nodeList.count;i++)
            {
		  [target.nodeList addObject:[[LogisticsNodeDTOModel alloc]init]];
            [LogisticsNodeDTOModel cloneObj:source.nodeList[i] target:target.nodeList[i]];
            }
        }


}

@end

