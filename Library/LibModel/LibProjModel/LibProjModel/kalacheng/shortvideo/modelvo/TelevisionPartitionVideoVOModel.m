//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "TelevisionPartitionVideoVOModel.h"
#import "TelevisionVideoSimpleVOModel.h"




 @implementation TelevisionPartitionVideoVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"televisionVideoSimpleVOList" : [TelevisionVideoSimpleVOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"partitionSequence"]=@(_partitionSequence);

dict[@"televisionPartitionName"]=_televisionPartitionName;

dict[@"id"]=@(_id_field);

dict[@"partitionShowNum"]=@(_partitionShowNum);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_televisionVideoSimpleVOList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
TelevisionVideoSimpleVOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"televisionVideoSimpleVOList"]=list;
}//end

dict[@"partitionStyle"]=@(_partitionStyle);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<TelevisionPartitionVideoVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
TelevisionPartitionVideoVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<TelevisionPartitionVideoVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<TelevisionPartitionVideoVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
TelevisionPartitionVideoVOModel* sumMdl=[TelevisionPartitionVideoVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(TelevisionPartitionVideoVOModel*)getFromDict:(NSDictionary*)dict
{
TelevisionPartitionVideoVOModel* model=[[TelevisionPartitionVideoVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.partitionSequence=[dict[@"partitionSequence"] isKindOfClass:[NSNull class]]?0:[dict[@"partitionSequence"] intValue];

model.televisionPartitionName=[dict[@"televisionPartitionName"] isKindOfClass:[NSNull class]]?@"":dict[@"televisionPartitionName"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.partitionShowNum=[dict[@"partitionShowNum"] isKindOfClass:[NSNull class]]?0:[dict[@"partitionShowNum"] intValue];

model.televisionVideoSimpleVOList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"televisionVideoSimpleVOList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
TelevisionVideoSimpleVOModel* sumMdl=[TelevisionVideoSimpleVOModel getFromDict:subDic];
[model.televisionVideoSimpleVOList addObject:sumMdl];

}
}

}

model.partitionStyle=[dict[@"partitionStyle"] isKindOfClass:[NSNull class]]?0:[dict[@"partitionStyle"] intValue];


 return model;
}

 +(void)cloneObj:(TelevisionPartitionVideoVOModel*) source target:(TelevisionPartitionVideoVOModel*)target
{

target.partitionSequence=source.partitionSequence;

target.televisionPartitionName=source.televisionPartitionName;

target.id_field=source.id_field;

target.partitionShowNum=source.partitionShowNum;

        if(source.televisionVideoSimpleVOList==nil)
        {
//            target.televisionVideoSimpleVOList=nil;
        }else
        {
            target.televisionVideoSimpleVOList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.televisionVideoSimpleVOList.count;i++)
            {
		  [target.televisionVideoSimpleVOList addObject:[[TelevisionVideoSimpleVOModel alloc]init]];
            [TelevisionVideoSimpleVOModel cloneObj:source.televisionVideoSimpleVOList[i] target:target.televisionVideoSimpleVOList[i]];
            }
        }


target.partitionStyle=source.partitionStyle;

}

@end

