//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "BlindBoxUserInfoVOModel.h"
#import "BlindBoxLabelVOModel.h"




 @implementation BlindBoxUserInfoVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"labList" : [BlindBoxLabelVOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"gender"]=@(_gender);

dict[@"labIds"]=_labIds;

dict[@"realPic"]=_realPic;

dict[@"introduce"]=_introduce;

dict[@"drawNum"]=@(_drawNum);

dict[@"currDrawCoin"]=@(_currDrawCoin);

dict[@"mobile"]=_mobile;

dict[@"lastCount"]=@(_lastCount);

dict[@"remark"]=@(_remark);

dict[@"avatar"]=_avatar;

dict[@"reasonType"]=@(_reasonType);

dict[@"currSaveCoin"]=@(_currSaveCoin);

dict[@"createTime"]=[HttpClient stringFromDate:_createTime];

dict[@"school"]=_school;

dict[@"id"]=@(_id_field);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_labList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
BlindBoxLabelVOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"labList"]=list;
}//end

dict[@"appUserId"]=@(_appUserId);

dict[@"age"]=@(_age);

dict[@"status"]=@(_status);

dict[@"username"]=_username;

dict[@"wechatNo"]=_wechatNo;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<BlindBoxUserInfoVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
BlindBoxUserInfoVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<BlindBoxUserInfoVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<BlindBoxUserInfoVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
BlindBoxUserInfoVOModel* sumMdl=[BlindBoxUserInfoVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(BlindBoxUserInfoVOModel*)getFromDict:(NSDictionary*)dict
{
BlindBoxUserInfoVOModel* model=[[BlindBoxUserInfoVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.gender=[dict[@"gender"] isKindOfClass:[NSNull class]]?0:[dict[@"gender"] intValue];

model.labIds=[dict[@"labIds"] isKindOfClass:[NSNull class]]?@"":dict[@"labIds"];

model.realPic=[dict[@"realPic"] isKindOfClass:[NSNull class]]?@"":dict[@"realPic"];

model.introduce=[dict[@"introduce"] isKindOfClass:[NSNull class]]?@"":dict[@"introduce"];

model.drawNum=[dict[@"drawNum"] isKindOfClass:[NSNull class]]?0:[dict[@"drawNum"] intValue];

model.currDrawCoin=[dict[@"currDrawCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"currDrawCoin"] doubleValue];

model.mobile=[dict[@"mobile"] isKindOfClass:[NSNull class]]?@"":dict[@"mobile"];

model.lastCount=[dict[@"lastCount"] isKindOfClass:[NSNull class]]?0:[dict[@"lastCount"] intValue];

model.remark=[dict[@"remark"] isKindOfClass:[NSNull class]]?0:[dict[@"remark"] intValue];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.reasonType=[dict[@"reasonType"] isKindOfClass:[NSNull class]]?0:[dict[@"reasonType"] intValue];

model.currSaveCoin=[dict[@"currSaveCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"currSaveCoin"] doubleValue];


{
NSString *strDate= dict[@"createTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.createTime=date;
    }
}

model.school=[dict[@"school"] isKindOfClass:[NSNull class]]?@"":dict[@"school"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.labList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"labList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
BlindBoxLabelVOModel* sumMdl=[BlindBoxLabelVOModel getFromDict:subDic];
[model.labList addObject:sumMdl];

}
}

}

model.appUserId=[dict[@"appUserId"] isKindOfClass:[NSNull class]]?0:[dict[@"appUserId"] longLongValue];

model.age=[dict[@"age"] isKindOfClass:[NSNull class]]?0:[dict[@"age"] intValue];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];

model.username=[dict[@"username"] isKindOfClass:[NSNull class]]?@"":dict[@"username"];

model.wechatNo=[dict[@"wechatNo"] isKindOfClass:[NSNull class]]?@"":dict[@"wechatNo"];


 return model;
}

 +(void)cloneObj:(BlindBoxUserInfoVOModel*) source target:(BlindBoxUserInfoVOModel*)target
{

target.gender=source.gender;

target.labIds=source.labIds;

target.realPic=source.realPic;

target.introduce=source.introduce;

target.drawNum=source.drawNum;

target.currDrawCoin=source.currDrawCoin;

target.mobile=source.mobile;

target.lastCount=source.lastCount;

target.remark=source.remark;

target.avatar=source.avatar;

target.reasonType=source.reasonType;

target.currSaveCoin=source.currSaveCoin;

target.createTime=source.createTime;

target.school=source.school;

target.id_field=source.id_field;

        if(source.labList==nil)
        {
//            target.labList=nil;
        }else
        {
            target.labList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.labList.count;i++)
            {
		  [target.labList addObject:[[BlindBoxLabelVOModel alloc]init]];
            [BlindBoxLabelVOModel cloneObj:source.labList[i] target:target.labList[i]];
            }
        }


target.appUserId=source.appUserId;

target.age=source.age;

target.status=source.status;

target.username=source.username;

target.wechatNo=source.wechatNo;

}

@end

