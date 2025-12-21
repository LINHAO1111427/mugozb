//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "NobLiveGiftModel.h"




 @implementation NobLiveGiftModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"gifticon"]=_gifticon;

dict[@"magic"]=@(_magic);

dict[@"backid"]=@(_backid);

dict[@"orderno"]=@(_orderno);

dict[@"swf"]=_swf;

dict[@"luckOdds"]=@(_luckOdds);

dict[@"needScore"]=@(_needScore);

dict[@"type"]=@(_type);

dict[@"blood"]=@(_blood);

dict[@"swftype"]=@(_swftype);

dict[@"giftname"]=_giftname;

dict[@"number"]=@(_number);

dict[@"addtime"]=[HttpClient stringFromDate:_addtime];

dict[@"luckyPerc"]=@(_luckyPerc);

dict[@"needcoin"]=@(_needcoin);

dict[@"checked"]=@(_checked);

dict[@"id"]=@(_id_field);

dict[@"page"]=@(_page);

dict[@"casting_obj"]=@(_casting_obj);

dict[@"mark"]=@(_mark);

dict[@"swftime"]=@(_swftime);

dict[@"status"]=@(_status);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<NobLiveGiftModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
NobLiveGiftModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<NobLiveGiftModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<NobLiveGiftModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
NobLiveGiftModel* sumMdl=[NobLiveGiftModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(NobLiveGiftModel*)getFromDict:(NSDictionary*)dict
{
NobLiveGiftModel* model=[[NobLiveGiftModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.gifticon=[dict[@"gifticon"] isKindOfClass:[NSNull class]]?@"":dict[@"gifticon"];

model.magic=[dict[@"magic"] isKindOfClass:[NSNull class]]?0:[dict[@"magic"] intValue];

model.backid=[dict[@"backid"] isKindOfClass:[NSNull class]]?0:[dict[@"backid"] longLongValue];

model.orderno=[dict[@"orderno"] isKindOfClass:[NSNull class]]?0:[dict[@"orderno"] intValue];

model.swf=[dict[@"swf"] isKindOfClass:[NSNull class]]?@"":dict[@"swf"];

model.luckOdds=[dict[@"luckOdds"] isKindOfClass:[NSNull class]]?0:[dict[@"luckOdds"] doubleValue];

model.needScore=[dict[@"needScore"] isKindOfClass:[NSNull class]]?0:[dict[@"needScore"] doubleValue];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];

model.blood=[dict[@"blood"] isKindOfClass:[NSNull class]]?0:[dict[@"blood"] intValue];

model.swftype=[dict[@"swftype"] isKindOfClass:[NSNull class]]?0:[dict[@"swftype"] intValue];

model.giftname=[dict[@"giftname"] isKindOfClass:[NSNull class]]?@"":dict[@"giftname"];

model.number=[dict[@"number"] isKindOfClass:[NSNull class]]?0:[dict[@"number"] intValue];


{
NSString *strDate= dict[@"addtime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addtime=date;
    }
}

model.luckyPerc=[dict[@"luckyPerc"] isKindOfClass:[NSNull class]]?0:[dict[@"luckyPerc"] doubleValue];

model.needcoin=[dict[@"needcoin"] isKindOfClass:[NSNull class]]?0:[dict[@"needcoin"] doubleValue];

model.checked=[dict[@"checked"] isKindOfClass:[NSNull class]]?0:[dict[@"checked"] intValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.page=[dict[@"page"] isKindOfClass:[NSNull class]]?0:[dict[@"page"] intValue];

model.casting_obj=[dict[@"casting_obj"] isKindOfClass:[NSNull class]]?0:[dict[@"casting_obj"] intValue];

model.mark=[dict[@"mark"] isKindOfClass:[NSNull class]]?0:[dict[@"mark"] intValue];

model.swftime=[dict[@"swftime"] isKindOfClass:[NSNull class]]?0:[dict[@"swftime"] doubleValue];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];


 return model;
}

 +(void)cloneObj:(NobLiveGiftModel*) source target:(NobLiveGiftModel*)target
{

target.gifticon=source.gifticon;

target.magic=source.magic;

target.backid=source.backid;

target.orderno=source.orderno;

target.swf=source.swf;

target.luckOdds=source.luckOdds;

target.needScore=source.needScore;

target.type=source.type;

target.blood=source.blood;

target.swftype=source.swftype;

target.giftname=source.giftname;

target.number=source.number;

target.addtime=source.addtime;

target.luckyPerc=source.luckyPerc;

target.needcoin=source.needcoin;

target.checked=source.checked;

target.id_field=source.id_field;

target.page=source.page;

target.casting_obj=source.casting_obj;

target.mark=source.mark;

target.swftime=source.swftime;

target.status=source.status;

}

@end

