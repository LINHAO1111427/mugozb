//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiUsersLiveWishModel.h"
#import "ApiWishUserModel.h"




 @implementation ApiUsersLiveWishModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"wishUserList" : [ApiWishUserModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"gifticon"]=_gifticon;

dict[@"needScore"]=@(_needScore);

dict[@"num"]=@(_num);

dict[@"type"]=@(_type);

dict[@"giftname"]=_giftname;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_wishUserList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ApiWishUserModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"wishUserList"]=list;
}//end

dict[@"giftid"]=@(_giftid);

dict[@"uid"]=@(_uid);

dict[@"isCheck"]=@(_isCheck);

dict[@"addtime"]=[HttpClient stringFromDate:_addtime];

dict[@"needcoin"]=@(_needcoin);

dict[@"id"]=@(_id_field);

dict[@"sendNum"]=@(_sendNum);

dict[@"status"]=@(_status);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUsersLiveWishModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiUsersLiveWishModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiUsersLiveWishModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiUsersLiveWishModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiUsersLiveWishModel* sumMdl=[ApiUsersLiveWishModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiUsersLiveWishModel*)getFromDict:(NSDictionary*)dict
{
ApiUsersLiveWishModel* model=[[ApiUsersLiveWishModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.gifticon=[dict[@"gifticon"] isKindOfClass:[NSNull class]]?@"":dict[@"gifticon"];

model.needScore=[dict[@"needScore"] isKindOfClass:[NSNull class]]?0:[dict[@"needScore"] doubleValue];

model.num=[dict[@"num"] isKindOfClass:[NSNull class]]?0:[dict[@"num"] intValue];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];

model.giftname=[dict[@"giftname"] isKindOfClass:[NSNull class]]?@"":dict[@"giftname"];

model.wishUserList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"wishUserList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiWishUserModel* sumMdl=[ApiWishUserModel getFromDict:subDic];
[model.wishUserList addObject:sumMdl];

}
}

}

model.giftid=[dict[@"giftid"] isKindOfClass:[NSNull class]]?0:[dict[@"giftid"] intValue];

model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];

model.isCheck=[dict[@"isCheck"] isKindOfClass:[NSNull class]]?0:[dict[@"isCheck"] intValue];


{
NSString *strDate= dict[@"addtime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addtime=date;
    }
}

model.needcoin=[dict[@"needcoin"] isKindOfClass:[NSNull class]]?0:[dict[@"needcoin"] doubleValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.sendNum=[dict[@"sendNum"] isKindOfClass:[NSNull class]]?0:[dict[@"sendNum"] intValue];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];


 return model;
}

 +(void)cloneObj:(ApiUsersLiveWishModel*) source target:(ApiUsersLiveWishModel*)target
{

target.gifticon=source.gifticon;

target.needScore=source.needScore;

target.num=source.num;

target.type=source.type;

target.giftname=source.giftname;

        if(source.wishUserList==nil)
        {
//            target.wishUserList=nil;
        }else
        {
            target.wishUserList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.wishUserList.count;i++)
            {
		  [target.wishUserList addObject:[[ApiWishUserModel alloc]init]];
            [ApiWishUserModel cloneObj:source.wishUserList[i] target:target.wishUserList[i]];
            }
        }


target.giftid=source.giftid;

target.uid=source.uid;

target.isCheck=source.isCheck;

target.addtime=source.addtime;

target.needcoin=source.needcoin;

target.id_field=source.id_field;

target.sendNum=source.sendNum;

target.status=source.status;

}

@end

