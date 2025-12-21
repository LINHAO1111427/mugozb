//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "LogisticsBeanModel.h"
#import "TraceBeanModel.h"




 @implementation LogisticsBeanModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"list" : [TraceBeanModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"msg"]=_msg;

dict[@"expName"]=_expName;

dict[@"takeTime"]=_takeTime;

dict[@"expPhone"]=_expPhone;

dict[@"expSite"]=_expSite;

dict[@"updateTime"]=_updateTime;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_list;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
TraceBeanModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"list"]=list;
}//end

dict[@"type"]=_type;

dict[@"issign"]=_issign;

dict[@"number"]=_number;

dict[@"courier"]=_courier;

dict[@"deliverystatus"]=_deliverystatus;

dict[@"courierPhone"]=_courierPhone;

dict[@"logo"]=_logo;

dict[@"status"]=_status;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<LogisticsBeanModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
LogisticsBeanModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<LogisticsBeanModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<LogisticsBeanModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
LogisticsBeanModel* sumMdl=[LogisticsBeanModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(LogisticsBeanModel*)getFromDict:(NSDictionary*)dict
{
LogisticsBeanModel* model=[[LogisticsBeanModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.msg=[dict[@"msg"] isKindOfClass:[NSNull class]]?@"":dict[@"msg"];

model.expName=[dict[@"expName"] isKindOfClass:[NSNull class]]?@"":dict[@"expName"];

model.takeTime=[dict[@"takeTime"] isKindOfClass:[NSNull class]]?@"":dict[@"takeTime"];

model.expPhone=[dict[@"expPhone"] isKindOfClass:[NSNull class]]?@"":dict[@"expPhone"];

model.expSite=[dict[@"expSite"] isKindOfClass:[NSNull class]]?@"":dict[@"expSite"];

model.updateTime=[dict[@"updateTime"] isKindOfClass:[NSNull class]]?@"":dict[@"updateTime"];

model.list=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"list"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
TraceBeanModel* sumMdl=[TraceBeanModel getFromDict:subDic];
[model.list addObject:sumMdl];

}
}

}

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?@"":dict[@"type"];

model.issign=[dict[@"issign"] isKindOfClass:[NSNull class]]?@"":dict[@"issign"];

model.number=[dict[@"number"] isKindOfClass:[NSNull class]]?@"":dict[@"number"];

model.courier=[dict[@"courier"] isKindOfClass:[NSNull class]]?@"":dict[@"courier"];

model.deliverystatus=[dict[@"deliverystatus"] isKindOfClass:[NSNull class]]?@"":dict[@"deliverystatus"];

model.courierPhone=[dict[@"courierPhone"] isKindOfClass:[NSNull class]]?@"":dict[@"courierPhone"];

model.logo=[dict[@"logo"] isKindOfClass:[NSNull class]]?@"":dict[@"logo"];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?@"":dict[@"status"];


 return model;
}

 +(void)cloneObj:(LogisticsBeanModel*) source target:(LogisticsBeanModel*)target
{

target.msg=source.msg;

target.expName=source.expName;

target.takeTime=source.takeTime;

target.expPhone=source.expPhone;

target.expSite=source.expSite;

target.updateTime=source.updateTime;

        if(source.list==nil)
        {
//            target.list=nil;
        }else
        {
            target.list=[[NSMutableArray alloc] init];
            for(int i=0;i<source.list.count;i++)
            {
		  [target.list addObject:[[TraceBeanModel alloc]init]];
            [TraceBeanModel cloneObj:source.list[i] target:target.list[i]];
            }
        }


target.type=source.type;

target.issign=source.issign;

target.number=source.number;

target.courier=source.courier;

target.deliverystatus=source.deliverystatus;

target.courierPhone=source.courierPhone;

target.logo=source.logo;

target.status=source.status;

}

@end

