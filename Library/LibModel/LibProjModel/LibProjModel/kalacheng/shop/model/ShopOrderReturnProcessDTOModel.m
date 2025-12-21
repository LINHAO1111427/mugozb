//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopOrderReturnProcessDTOModel.h"




 @implementation ShopOrderReturnProcessDTOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"nodeName"]=_nodeName;

dict[@"upTime"]=[HttpClient stringFromDate:_upTime];

dict[@"nodeNo"]=@(_nodeNo);

dict[@"operateStatus"]=@(_operateStatus);

dict[@"orderNo"]=_orderNo;

dict[@"nodeStatus"]=@(_nodeStatus);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopOrderReturnProcessDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopOrderReturnProcessDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopOrderReturnProcessDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopOrderReturnProcessDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopOrderReturnProcessDTOModel* sumMdl=[ShopOrderReturnProcessDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopOrderReturnProcessDTOModel*)getFromDict:(NSDictionary*)dict
{
ShopOrderReturnProcessDTOModel* model=[[ShopOrderReturnProcessDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.nodeName=[dict[@"nodeName"] isKindOfClass:[NSNull class]]?@"":dict[@"nodeName"];


{
NSString *strDate= dict[@"upTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.upTime=date;
    }
}

model.nodeNo=[dict[@"nodeNo"] isKindOfClass:[NSNull class]]?0:[dict[@"nodeNo"] intValue];

model.operateStatus=[dict[@"operateStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"operateStatus"] intValue];

model.orderNo=[dict[@"orderNo"] isKindOfClass:[NSNull class]]?@"":dict[@"orderNo"];

model.nodeStatus=[dict[@"nodeStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"nodeStatus"] intValue];


 return model;
}

 +(void)cloneObj:(ShopOrderReturnProcessDTOModel*) source target:(ShopOrderReturnProcessDTOModel*)target
{

target.nodeName=source.nodeName;

target.upTime=source.upTime;

target.nodeNo=source.nodeNo;

target.operateStatus=source.operateStatus;

target.orderNo=source.orderNo;

target.nodeStatus=source.nodeStatus;

}

@end

