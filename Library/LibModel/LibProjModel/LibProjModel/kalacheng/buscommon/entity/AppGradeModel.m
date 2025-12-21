//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppGradeModel.h"




 @implementation AppGradeModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"vipCarName"]=_vipCarName;

dict[@"startVal"]=@(_startVal);

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"appCarId"]=@(_appCarId);

dict[@"callDiscount"]=@(_callDiscount);

dict[@"type"]=@(_type);

dict[@"medalLv"]=@(_medalLv);

dict[@"isEnable"]=@(_isEnable);

dict[@"gradeIcon"]=_gradeIcon;

dict[@"isJoinActiveAuth"]=@(_isJoinActiveAuth);

dict[@"unit"]=_unit;

dict[@"isSysRecommend"]=@(_isSysRecommend);

dict[@"rechargeDiscount"]=@(_rechargeDiscount);

dict[@"grade"]=@(_grade);

dict[@"avatarFrame"]=_avatarFrame;

dict[@"name"]=_name;

dict[@"id"]=@(_id_field);

dict[@"medalId"]=@(_medalId);

dict[@"micBorderId"]=@(_micBorderId);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppGradeModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppGradeModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppGradeModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppGradeModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppGradeModel* sumMdl=[AppGradeModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppGradeModel*)getFromDict:(NSDictionary*)dict
{
AppGradeModel* model=[[AppGradeModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.vipCarName=[dict[@"vipCarName"] isKindOfClass:[NSNull class]]?@"":dict[@"vipCarName"];

model.startVal=[dict[@"startVal"] isKindOfClass:[NSNull class]]?0:[dict[@"startVal"] intValue];


{
NSString *strDate= dict[@"addTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addTime=date;
    }
}

model.appCarId=[dict[@"appCarId"] isKindOfClass:[NSNull class]]?0:[dict[@"appCarId"] intValue];

model.callDiscount=[dict[@"callDiscount"] isKindOfClass:[NSNull class]]?0:[dict[@"callDiscount"] doubleValue];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];

model.medalLv=[dict[@"medalLv"] isKindOfClass:[NSNull class]]?0:[dict[@"medalLv"] intValue];

model.isEnable=[dict[@"isEnable"] isKindOfClass:[NSNull class]]?0:[dict[@"isEnable"] intValue];

model.gradeIcon=[dict[@"gradeIcon"] isKindOfClass:[NSNull class]]?@"":dict[@"gradeIcon"];

model.isJoinActiveAuth=[dict[@"isJoinActiveAuth"] isKindOfClass:[NSNull class]]?0:[dict[@"isJoinActiveAuth"] intValue];

model.unit=[dict[@"unit"] isKindOfClass:[NSNull class]]?@"":dict[@"unit"];

model.isSysRecommend=[dict[@"isSysRecommend"] isKindOfClass:[NSNull class]]?0:[dict[@"isSysRecommend"] intValue];

model.rechargeDiscount=[dict[@"rechargeDiscount"] isKindOfClass:[NSNull class]]?0:[dict[@"rechargeDiscount"] doubleValue];

model.grade=[dict[@"grade"] isKindOfClass:[NSNull class]]?0:[dict[@"grade"] intValue];

model.avatarFrame=[dict[@"avatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"avatarFrame"];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.medalId=[dict[@"medalId"] isKindOfClass:[NSNull class]]?0:[dict[@"medalId"] longLongValue];

model.micBorderId=[dict[@"micBorderId"] isKindOfClass:[NSNull class]]?0:[dict[@"micBorderId"] longLongValue];


 return model;
}

 +(void)cloneObj:(AppGradeModel*) source target:(AppGradeModel*)target
{

target.vipCarName=source.vipCarName;

target.startVal=source.startVal;

target.addTime=source.addTime;

target.appCarId=source.appCarId;

target.callDiscount=source.callDiscount;

target.type=source.type;

target.medalLv=source.medalLv;

target.isEnable=source.isEnable;

target.gradeIcon=source.gradeIcon;

target.isJoinActiveAuth=source.isJoinActiveAuth;

target.unit=source.unit;

target.isSysRecommend=source.isSysRecommend;

target.rechargeDiscount=source.rechargeDiscount;

target.grade=source.grade;

target.avatarFrame=source.avatarFrame;

target.name=source.name;

target.id_field=source.id_field;

target.medalId=source.medalId;

target.micBorderId=source.micBorderId;

}

@end

