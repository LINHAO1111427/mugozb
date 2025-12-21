//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "MyTrendsVOModel.h"
#import "AppTrendsRecordModel.h"




 @implementation MyTrendsVOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"trends" : [AppTrendsRecordModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_trends;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppTrendsRecordModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"trends"]=list;
}//end


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<MyTrendsVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
MyTrendsVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<MyTrendsVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<MyTrendsVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
MyTrendsVOModel* sumMdl=[MyTrendsVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(MyTrendsVOModel*)getFromDict:(NSDictionary*)dict
{
MyTrendsVOModel* model=[[MyTrendsVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.trends=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"trends"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppTrendsRecordModel* sumMdl=[AppTrendsRecordModel getFromDict:subDic];
[model.trends addObject:sumMdl];

}
}

}


 return model;
}

 +(void)cloneObj:(MyTrendsVOModel*) source target:(MyTrendsVOModel*)target
{

        if(source.trends==nil)
        {
//            target.trends=nil;
        }else
        {
            target.trends=[[NSMutableArray alloc] init];
            for(int i=0;i<source.trends.count;i++)
            {
		  [target.trends addObject:[[AppTrendsRecordModel alloc]init]];
            [AppTrendsRecordModel cloneObj:source.trends[i] target:target.trends[i]];
            }
        }


}

@end

