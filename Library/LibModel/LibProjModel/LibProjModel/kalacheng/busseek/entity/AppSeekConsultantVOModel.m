//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppSeekConsultantVOModel.h"




 @implementation AppSeekConsultantVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"approvalStatus"]=@(_approvalStatus);

dict[@"frontView"]=_frontView;

dict[@"approvalRemark"]=_approvalRemark;

dict[@"handsetView"]=_handsetView;

dict[@"backView"]=_backView;

dict[@"approvalTime"]=[HttpClient stringFromDate:_approvalTime];

dict[@"id"]=@(_id_field);

dict[@"userId"]=@(_userId);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppSeekConsultantVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppSeekConsultantVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppSeekConsultantVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppSeekConsultantVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppSeekConsultantVOModel* sumMdl=[AppSeekConsultantVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppSeekConsultantVOModel*)getFromDict:(NSDictionary*)dict
{
AppSeekConsultantVOModel* model=[[AppSeekConsultantVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.approvalStatus=[dict[@"approvalStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"approvalStatus"] intValue];

model.frontView=[dict[@"frontView"] isKindOfClass:[NSNull class]]?@"":dict[@"frontView"];

model.approvalRemark=[dict[@"approvalRemark"] isKindOfClass:[NSNull class]]?@"":dict[@"approvalRemark"];

model.handsetView=[dict[@"handsetView"] isKindOfClass:[NSNull class]]?@"":dict[@"handsetView"];

model.backView=[dict[@"backView"] isKindOfClass:[NSNull class]]?@"":dict[@"backView"];


{
NSString *strDate= dict[@"approvalTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.approvalTime=date;
    }
}

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];


 return model;
}

 +(void)cloneObj:(AppSeekConsultantVOModel*) source target:(AppSeekConsultantVOModel*)target
{

target.approvalStatus=source.approvalStatus;

target.frontView=source.frontView;

target.approvalRemark=source.approvalRemark;

target.handsetView=source.handsetView;

target.backView=source.backView;

target.approvalTime=source.approvalTime;

target.id_field=source.id_field;

target.userId=source.userId;

}

@end

