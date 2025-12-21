//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "DrawBlindBoxRecordVOModel.h"




 @implementation DrawBlindBoxRecordVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"toIntroduce"]=_toIntroduce;

dict[@"toLabStrs"]=_toLabStrs;

dict[@"toWechatNo"]=_toWechatNo;

dict[@"drawAvatar"]=_drawAvatar;

dict[@"toUsername"]=_toUsername;

dict[@"toAvatar"]=_toAvatar;

dict[@"drawType"]=@(_drawType);

dict[@"drawGender"]=@(_drawGender);

dict[@"toSchool"]=_toSchool;

dict[@"toUserId"]=@(_toUserId);

dict[@"toAge"]=@(_toAge);

dict[@"createTime"]=[HttpClient stringFromDate:_createTime];

dict[@"toLabIds"]=_toLabIds;

dict[@"toMobile"]=_toMobile;

dict[@"toRealPic"]=_toRealPic;

dict[@"drawUsername"]=_drawUsername;

dict[@"drawCoin"]=@(_drawCoin);

dict[@"toGender"]=@(_toGender);

dict[@"drawUserId"]=@(_drawUserId);

dict[@"id"]=@(_id_field);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<DrawBlindBoxRecordVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
DrawBlindBoxRecordVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<DrawBlindBoxRecordVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<DrawBlindBoxRecordVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
DrawBlindBoxRecordVOModel* sumMdl=[DrawBlindBoxRecordVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(DrawBlindBoxRecordVOModel*)getFromDict:(NSDictionary*)dict
{
DrawBlindBoxRecordVOModel* model=[[DrawBlindBoxRecordVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.toIntroduce=[dict[@"toIntroduce"] isKindOfClass:[NSNull class]]?@"":dict[@"toIntroduce"];

model.toLabStrs=[dict[@"toLabStrs"] isKindOfClass:[NSNull class]]?@"":dict[@"toLabStrs"];

model.toWechatNo=[dict[@"toWechatNo"] isKindOfClass:[NSNull class]]?@"":dict[@"toWechatNo"];

model.drawAvatar=[dict[@"drawAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"drawAvatar"];

model.toUsername=[dict[@"toUsername"] isKindOfClass:[NSNull class]]?@"":dict[@"toUsername"];

model.toAvatar=[dict[@"toAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"toAvatar"];

model.drawType=[dict[@"drawType"] isKindOfClass:[NSNull class]]?0:[dict[@"drawType"] intValue];

model.drawGender=[dict[@"drawGender"] isKindOfClass:[NSNull class]]?0:[dict[@"drawGender"] intValue];

model.toSchool=[dict[@"toSchool"] isKindOfClass:[NSNull class]]?@"":dict[@"toSchool"];

model.toUserId=[dict[@"toUserId"] isKindOfClass:[NSNull class]]?0:[dict[@"toUserId"] longLongValue];

model.toAge=[dict[@"toAge"] isKindOfClass:[NSNull class]]?0:[dict[@"toAge"] intValue];


{
NSString *strDate= dict[@"createTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.createTime=date;
    }
}

model.toLabIds=[dict[@"toLabIds"] isKindOfClass:[NSNull class]]?@"":dict[@"toLabIds"];

model.toMobile=[dict[@"toMobile"] isKindOfClass:[NSNull class]]?@"":dict[@"toMobile"];

model.toRealPic=[dict[@"toRealPic"] isKindOfClass:[NSNull class]]?@"":dict[@"toRealPic"];

model.drawUsername=[dict[@"drawUsername"] isKindOfClass:[NSNull class]]?@"":dict[@"drawUsername"];

model.drawCoin=[dict[@"drawCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"drawCoin"] doubleValue];

model.toGender=[dict[@"toGender"] isKindOfClass:[NSNull class]]?0:[dict[@"toGender"] intValue];

model.drawUserId=[dict[@"drawUserId"] isKindOfClass:[NSNull class]]?0:[dict[@"drawUserId"] longLongValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];


 return model;
}

 +(void)cloneObj:(DrawBlindBoxRecordVOModel*) source target:(DrawBlindBoxRecordVOModel*)target
{

target.toIntroduce=source.toIntroduce;

target.toLabStrs=source.toLabStrs;

target.toWechatNo=source.toWechatNo;

target.drawAvatar=source.drawAvatar;

target.toUsername=source.toUsername;

target.toAvatar=source.toAvatar;

target.drawType=source.drawType;

target.drawGender=source.drawGender;

target.toSchool=source.toSchool;

target.toUserId=source.toUserId;

target.toAge=source.toAge;

target.createTime=source.createTime;

target.toLabIds=source.toLabIds;

target.toMobile=source.toMobile;

target.toRealPic=source.toRealPic;

target.drawUsername=source.drawUsername;

target.drawCoin=source.drawCoin;

target.toGender=source.toGender;

target.drawUserId=source.drawUserId;

target.id_field=source.id_field;

}

@end

