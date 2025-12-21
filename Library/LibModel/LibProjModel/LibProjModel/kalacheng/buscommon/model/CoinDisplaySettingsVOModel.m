//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "CoinDisplaySettingsVOModel.h"




 @implementation CoinDisplaySettingsVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"iosChatSquareDisplay"]=@(_iosChatSquareDisplay);

dict[@"iosLiveDisplay"]=@(_iosLiveDisplay);

dict[@"androidLiveDisplay"]=@(_androidLiveDisplay);

dict[@"id"]=@(_id_field);

dict[@"iosCoinShow"]=@(_iosCoinShow);

dict[@"androidCoinShow"]=@(_androidCoinShow);

dict[@"androidChatSquareDisplay"]=@(_androidChatSquareDisplay);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<CoinDisplaySettingsVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
CoinDisplaySettingsVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<CoinDisplaySettingsVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<CoinDisplaySettingsVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
CoinDisplaySettingsVOModel* sumMdl=[CoinDisplaySettingsVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(CoinDisplaySettingsVOModel*)getFromDict:(NSDictionary*)dict
{
CoinDisplaySettingsVOModel* model=[[CoinDisplaySettingsVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.iosChatSquareDisplay=[dict[@"iosChatSquareDisplay"] isKindOfClass:[NSNull class]]?0:[dict[@"iosChatSquareDisplay"] intValue];

model.iosLiveDisplay=[dict[@"iosLiveDisplay"] isKindOfClass:[NSNull class]]?0:[dict[@"iosLiveDisplay"] intValue];

model.androidLiveDisplay=[dict[@"androidLiveDisplay"] isKindOfClass:[NSNull class]]?0:[dict[@"androidLiveDisplay"] intValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.iosCoinShow=[dict[@"iosCoinShow"] isKindOfClass:[NSNull class]]?0:[dict[@"iosCoinShow"] intValue];

model.androidCoinShow=[dict[@"androidCoinShow"] isKindOfClass:[NSNull class]]?0:[dict[@"androidCoinShow"] intValue];

model.androidChatSquareDisplay=[dict[@"androidChatSquareDisplay"] isKindOfClass:[NSNull class]]?0:[dict[@"androidChatSquareDisplay"] intValue];


 return model;
}

 +(void)cloneObj:(CoinDisplaySettingsVOModel*) source target:(CoinDisplaySettingsVOModel*)target
{

target.iosChatSquareDisplay=source.iosChatSquareDisplay;

target.iosLiveDisplay=source.iosLiveDisplay;

target.androidLiveDisplay=source.androidLiveDisplay;

target.id_field=source.id_field;

target.iosCoinShow=source.iosCoinShow;

target.androidCoinShow=source.androidCoinShow;

target.androidChatSquareDisplay=source.androidChatSquareDisplay;

}

@end

