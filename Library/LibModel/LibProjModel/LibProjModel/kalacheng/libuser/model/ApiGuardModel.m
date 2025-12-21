//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiGuardModel.h"
#import "GuardEffectModel.h"




 @implementation ApiGuardModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"guardEffectList" : [GuardEffectModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"msg"]=_msg;

dict[@"lengthTime"]=@(_lengthTime);

dict[@"lengthType"]=@(_lengthType);

dict[@"orderno"]=@(_orderno);

dict[@"addtime"]=[HttpClient stringFromDate:_addtime];

dict[@"length"]=@(_length);

dict[@"name"]=_name;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_guardEffectList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
GuardEffectModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"guardEffectList"]=list;
}//end

dict[@"type"]=@(_type);

dict[@"tid"]=@(_tid);

dict[@"coin"]=@(_coin);

dict[@"uptime"]=[HttpClient stringFromDate:_uptime];


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiGuardModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiGuardModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiGuardModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiGuardModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiGuardModel* sumMdl=[ApiGuardModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiGuardModel*)getFromDict:(NSDictionary*)dict
{
ApiGuardModel* model=[[ApiGuardModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.msg=[dict[@"msg"] isKindOfClass:[NSNull class]]?@"":dict[@"msg"];

model.lengthTime=[dict[@"lengthTime"] isKindOfClass:[NSNull class]]?0:[dict[@"lengthTime"] intValue];

model.lengthType=[dict[@"lengthType"] isKindOfClass:[NSNull class]]?0:[dict[@"lengthType"] intValue];

model.orderno=[dict[@"orderno"] isKindOfClass:[NSNull class]]?0:[dict[@"orderno"] intValue];


{
NSString *strDate= dict[@"addtime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addtime=date;
    }
}

model.length=[dict[@"length"] isKindOfClass:[NSNull class]]?0:[dict[@"length"] intValue];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.guardEffectList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"guardEffectList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
GuardEffectModel* sumMdl=[GuardEffectModel getFromDict:subDic];
[model.guardEffectList addObject:sumMdl];

}
}

}

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];

model.tid=[dict[@"tid"] isKindOfClass:[NSNull class]]?0:[dict[@"tid"] longLongValue];

model.coin=[dict[@"coin"] isKindOfClass:[NSNull class]]?0:[dict[@"coin"] doubleValue];


{
NSString *strDate= dict[@"uptime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.uptime=date;
    }
}


 return model;
}

 +(void)cloneObj:(ApiGuardModel*) source target:(ApiGuardModel*)target
{

target.msg=source.msg;

target.lengthTime=source.lengthTime;

target.lengthType=source.lengthType;

target.orderno=source.orderno;

target.addtime=source.addtime;

target.length=source.length;

target.name=source.name;

        if(source.guardEffectList==nil)
        {
//            target.guardEffectList=nil;
        }else
        {
            target.guardEffectList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.guardEffectList.count;i++)
            {
		  [target.guardEffectList addObject:[[GuardEffectModel alloc]init]];
            [GuardEffectModel cloneObj:source.guardEffectList[i] target:target.guardEffectList[i]];
            }
        }


target.type=source.type;

target.tid=source.tid;

target.coin=source.coin;

target.uptime=source.uptime;

}

@end

