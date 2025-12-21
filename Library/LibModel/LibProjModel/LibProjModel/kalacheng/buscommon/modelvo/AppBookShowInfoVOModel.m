//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppBookShowInfoVOModel.h"




 @implementation AppBookShowInfoVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"userSex"]=@(_userSex);

dict[@"groupType"]=@(_groupType);

dict[@"showName"]=_showName;

dict[@"liveType"]=@(_liveType);

dict[@"topId"]=@(_topId);

dict[@"showWord"]=_showWord;

dict[@"roomId"]=@(_roomId);

dict[@"userAge"]=@(_userAge);

dict[@"userOrGroupId"]=@(_userOrGroupId);

dict[@"createTime"]=[HttpClient stringFromDate:_createTime];

dict[@"isTop"]=@(_isTop);

dict[@"userRole"]=@(_userRole);

dict[@"showIcon"]=_showIcon;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppBookShowInfoVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppBookShowInfoVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppBookShowInfoVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppBookShowInfoVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppBookShowInfoVOModel* sumMdl=[AppBookShowInfoVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppBookShowInfoVOModel*)getFromDict:(NSDictionary*)dict
{
AppBookShowInfoVOModel* model=[[AppBookShowInfoVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.userSex=[dict[@"userSex"] isKindOfClass:[NSNull class]]?0:[dict[@"userSex"] intValue];

model.groupType=[dict[@"groupType"] isKindOfClass:[NSNull class]]?0:[dict[@"groupType"] intValue];

model.showName=[dict[@"showName"] isKindOfClass:[NSNull class]]?@"":dict[@"showName"];

model.liveType=[dict[@"liveType"] isKindOfClass:[NSNull class]]?0:[dict[@"liveType"] longLongValue];

model.topId=[dict[@"topId"] isKindOfClass:[NSNull class]]?0:[dict[@"topId"] intValue];

model.showWord=[dict[@"showWord"] isKindOfClass:[NSNull class]]?@"":dict[@"showWord"];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];

model.userAge=[dict[@"userAge"] isKindOfClass:[NSNull class]]?0:[dict[@"userAge"] intValue];

model.userOrGroupId=[dict[@"userOrGroupId"] isKindOfClass:[NSNull class]]?0:[dict[@"userOrGroupId"] longLongValue];


{
NSString *strDate= dict[@"createTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.createTime=date;
    }
}

model.isTop=[dict[@"isTop"] isKindOfClass:[NSNull class]]?0:[dict[@"isTop"] intValue];

model.userRole=[dict[@"userRole"] isKindOfClass:[NSNull class]]?0:[dict[@"userRole"] intValue];

model.showIcon=[dict[@"showIcon"] isKindOfClass:[NSNull class]]?@"":dict[@"showIcon"];


 return model;
}

 +(void)cloneObj:(AppBookShowInfoVOModel*) source target:(AppBookShowInfoVOModel*)target
{

target.userSex=source.userSex;

target.groupType=source.groupType;

target.showName=source.showName;

target.liveType=source.liveType;

target.topId=source.topId;

target.showWord=source.showWord;

target.roomId=source.roomId;

target.userAge=source.userAge;

target.userOrGroupId=source.userOrGroupId;

target.createTime=source.createTime;

target.isTop=source.isTop;

target.userRole=source.userRole;

target.showIcon=source.showIcon;

}

@end

