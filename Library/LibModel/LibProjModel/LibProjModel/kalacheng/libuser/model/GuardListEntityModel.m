//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "GuardListEntityModel.h"
#import "ApiGuardEntityChildModel.h"




 @implementation GuardListEntityModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"getguardEntityChildList" : [ApiGuardEntityChildModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"number"]=@(_number);

dict[@"lengthType"]=@(_lengthType);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_getguardEntityChildList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ApiGuardEntityChildModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"getguardEntityChildList"]=list;
}//end

dict[@"endTime"]=_endTime;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GuardListEntityModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
GuardListEntityModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<GuardListEntityModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<GuardListEntityModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
GuardListEntityModel* sumMdl=[GuardListEntityModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(GuardListEntityModel*)getFromDict:(NSDictionary*)dict
{
GuardListEntityModel* model=[[GuardListEntityModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.number=[dict[@"number"] isKindOfClass:[NSNull class]]?0:[dict[@"number"] intValue];

model.lengthType=[dict[@"lengthType"] isKindOfClass:[NSNull class]]?0:[dict[@"lengthType"] intValue];

model.getguardEntityChildList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"getguardEntityChildList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiGuardEntityChildModel* sumMdl=[ApiGuardEntityChildModel getFromDict:subDic];
[model.getguardEntityChildList addObject:sumMdl];

}
}

}

model.endTime=[dict[@"endTime"] isKindOfClass:[NSNull class]]?@"":dict[@"endTime"];


 return model;
}

 +(void)cloneObj:(GuardListEntityModel*) source target:(GuardListEntityModel*)target
{

target.number=source.number;

target.lengthType=source.lengthType;

        if(source.getguardEntityChildList==nil)
        {
//            target.getguardEntityChildList=nil;
        }else
        {
            target.getguardEntityChildList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.getguardEntityChildList.count;i++)
            {
		  [target.getguardEntityChildList addObject:[[ApiGuardEntityChildModel alloc]init]];
            [ApiGuardEntityChildModel cloneObj:source.getguardEntityChildList[i] target:target.getguardEntityChildList[i]];
            }
        }


target.endTime=source.endTime;

}

@end

