//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "CashRecordDTOModel.h"




 @implementation CashRecordDTOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"actualMoney"]=@(_actualMoney);

dict[@"uid"]=@(_uid);

dict[@"cashType"]=@(_cashType);

dict[@"surplusVotes"]=@(_surplusVotes);

dict[@"addtime"]=[HttpClient stringFromDate:_addtime];

dict[@"votes"]=@(_votes);

dict[@"type"]=@(_type);

dict[@"guildId"]=@(_guildId);

dict[@"remarks"]=_remarks;

dict[@"status"]=@(_status);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<CashRecordDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
CashRecordDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<CashRecordDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<CashRecordDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
CashRecordDTOModel* sumMdl=[CashRecordDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(CashRecordDTOModel*)getFromDict:(NSDictionary*)dict
{
CashRecordDTOModel* model=[[CashRecordDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.actualMoney=[dict[@"actualMoney"] isKindOfClass:[NSNull class]]?0:[dict[@"actualMoney"] doubleValue];

model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];

model.cashType=[dict[@"cashType"] isKindOfClass:[NSNull class]]?0:[dict[@"cashType"] intValue];

model.surplusVotes=[dict[@"surplusVotes"] isKindOfClass:[NSNull class]]?0:[dict[@"surplusVotes"] doubleValue];


{
NSString *strDate= dict[@"addtime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addtime=date;
    }
}

model.votes=[dict[@"votes"] isKindOfClass:[NSNull class]]?0:[dict[@"votes"] doubleValue];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];

model.guildId=[dict[@"guildId"] isKindOfClass:[NSNull class]]?0:[dict[@"guildId"] longLongValue];

model.remarks=[dict[@"remarks"] isKindOfClass:[NSNull class]]?@"":dict[@"remarks"];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];


 return model;
}

 +(void)cloneObj:(CashRecordDTOModel*) source target:(CashRecordDTOModel*)target
{

target.actualMoney=source.actualMoney;

target.uid=source.uid;

target.cashType=source.cashType;

target.surplusVotes=source.surplusVotes;

target.addtime=source.addtime;

target.votes=source.votes;

target.type=source.type;

target.guildId=source.guildId;

target.remarks=source.remarks;

target.status=source.status;

}

@end

