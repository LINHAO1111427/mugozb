//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "FixedWithdrawRuleVOModel.h"




 @implementation FixedWithdrawRuleVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"sortNum"]=@(_sortNum);

dict[@"id"]=@(_id_field);

dict[@"withdrawNum"]=@(_withdrawNum);

dict[@"isEnable"]=@(_isEnable);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<FixedWithdrawRuleVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
FixedWithdrawRuleVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<FixedWithdrawRuleVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<FixedWithdrawRuleVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
FixedWithdrawRuleVOModel* sumMdl=[FixedWithdrawRuleVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(FixedWithdrawRuleVOModel*)getFromDict:(NSDictionary*)dict
{
FixedWithdrawRuleVOModel* model=[[FixedWithdrawRuleVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.sortNum=[dict[@"sortNum"] isKindOfClass:[NSNull class]]?0:[dict[@"sortNum"] intValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] intValue];

model.withdrawNum=[dict[@"withdrawNum"] isKindOfClass:[NSNull class]]?0:[dict[@"withdrawNum"] doubleValue];

model.isEnable=[dict[@"isEnable"] isKindOfClass:[NSNull class]]?0:[dict[@"isEnable"] intValue];


 return model;
}

 +(void)cloneObj:(FixedWithdrawRuleVOModel*) source target:(FixedWithdrawRuleVOModel*)target
{

target.sortNum=source.sortNum;

target.id_field=source.id_field;

target.withdrawNum=source.withdrawNum;

target.isEnable=source.isEnable;

}

@end

