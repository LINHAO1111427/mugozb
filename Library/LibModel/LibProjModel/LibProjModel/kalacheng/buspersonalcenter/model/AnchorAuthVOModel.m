//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AnchorAuthVOModel.h"
#import "UserInterestTabVOModel.h"
#import "AnchorAuthDOModel.h"
#import "TabTypeDtoModel.h"
#import "StarPriceDOModel.h"
#import "AppLiveChannelModel.h"
#import "PayCallOneVsOneDOModel.h"




 @implementation AnchorAuthVOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"myInterestList" : [UserInterestTabVOModel class],@"auchorAuthShowList" : [AnchorAuthDOModel class],@"interestList" : [TabTypeDtoModel class],@"videoPriceList" : [StarPriceDOModel class],@"oooOneClassifyList" : [AppLiveChannelModel class],@"payCall" : [PayCallOneVsOneDOModel class],@"voicePriceList" : [StarPriceDOModel class],@"wechatPriceList" : [StarPriceDOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"birthday"]=_birthday;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_myInterestList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
UserInterestTabVOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"myInterestList"]=list;
}//end

dict[@"signature"]=_signature;

dict[@"wechatPrice"]=@(_wechatPrice);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_auchorAuthShowList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AnchorAuthDOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"auchorAuthShowList"]=list;
}//end

dict[@"oooTwoClassifyId"]=@(_oooTwoClassifyId);

dict[@"cerNo"]=_cerNo;

dict[@"constellation"]=_constellation;

dict[@"idCardBackView"]=_idCardBackView;

dict[@"height"]=@(_height);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_interestList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
TabTypeDtoModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"interestList"]=list;
}//end

dict[@"oooOneClassifyId"]=@(_oooOneClassifyId);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_videoPriceList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
StarPriceDOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"videoPriceList"]=list;
}//end

dict[@"nickName"]=_nickName;

dict[@"sex"]=@(_sex);

dict[@"wechat"]=_wechat;

dict[@"videoAuth"]=_videoAuth;

dict[@"weight"]=@(_weight);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_oooOneClassifyList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppLiveChannelModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"oooOneClassifyList"]=list;
}//end

dict[@"payCall"]=[_payCall modelToJSONObject];

dict[@"idCardFrontView"]=_idCardFrontView;

dict[@"vocation"]=_vocation;

dict[@"realName"]=_realName;

dict[@"sanwei"]=_sanwei;

dict[@"idCardHandView"]=_idCardHandView;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_voicePriceList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
StarPriceDOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"voicePriceList"]=list;
}//end

dict[@"remarks"]=_remarks;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_wechatPriceList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
StarPriceDOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"wechatPriceList"]=list;
}//end


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AnchorAuthVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AnchorAuthVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AnchorAuthVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AnchorAuthVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AnchorAuthVOModel* sumMdl=[AnchorAuthVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AnchorAuthVOModel*)getFromDict:(NSDictionary*)dict
{
AnchorAuthVOModel* model=[[AnchorAuthVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.birthday=[dict[@"birthday"] isKindOfClass:[NSNull class]]?@"":dict[@"birthday"];

model.myInterestList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"myInterestList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
UserInterestTabVOModel* sumMdl=[UserInterestTabVOModel getFromDict:subDic];
[model.myInterestList addObject:sumMdl];

}
}

}

model.signature=[dict[@"signature"] isKindOfClass:[NSNull class]]?@"":dict[@"signature"];

model.wechatPrice=[dict[@"wechatPrice"] isKindOfClass:[NSNull class]]?0:[dict[@"wechatPrice"] doubleValue];

model.auchorAuthShowList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"auchorAuthShowList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AnchorAuthDOModel* sumMdl=[AnchorAuthDOModel getFromDict:subDic];
[model.auchorAuthShowList addObject:sumMdl];

}
}

}

model.oooTwoClassifyId=[dict[@"oooTwoClassifyId"] isKindOfClass:[NSNull class]]?0:[dict[@"oooTwoClassifyId"] longLongValue];

model.cerNo=[dict[@"cerNo"] isKindOfClass:[NSNull class]]?@"":dict[@"cerNo"];

model.constellation=[dict[@"constellation"] isKindOfClass:[NSNull class]]?@"":dict[@"constellation"];

model.idCardBackView=[dict[@"idCardBackView"] isKindOfClass:[NSNull class]]?@"":dict[@"idCardBackView"];

model.height=[dict[@"height"] isKindOfClass:[NSNull class]]?0:[dict[@"height"] intValue];

model.interestList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"interestList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
TabTypeDtoModel* sumMdl=[TabTypeDtoModel getFromDict:subDic];
[model.interestList addObject:sumMdl];

}
}

}

model.oooOneClassifyId=[dict[@"oooOneClassifyId"] isKindOfClass:[NSNull class]]?0:[dict[@"oooOneClassifyId"] longLongValue];

model.videoPriceList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"videoPriceList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
StarPriceDOModel* sumMdl=[StarPriceDOModel getFromDict:subDic];
[model.videoPriceList addObject:sumMdl];

}
}

}

model.nickName=[dict[@"nickName"] isKindOfClass:[NSNull class]]?@"":dict[@"nickName"];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.wechat=[dict[@"wechat"] isKindOfClass:[NSNull class]]?@"":dict[@"wechat"];

model.videoAuth=[dict[@"videoAuth"] isKindOfClass:[NSNull class]]?@"":dict[@"videoAuth"];

model.weight=[dict[@"weight"] isKindOfClass:[NSNull class]]?0:[dict[@"weight"] doubleValue];

model.oooOneClassifyList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"oooOneClassifyList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppLiveChannelModel* sumMdl=[AppLiveChannelModel getFromDict:subDic];
[model.oooOneClassifyList addObject:sumMdl];

}
}

}


//getFromDict对象转换  
model.payCall=[PayCallOneVsOneDOModel getFromDict:dict[@"payCall"]];

model.idCardFrontView=[dict[@"idCardFrontView"] isKindOfClass:[NSNull class]]?@"":dict[@"idCardFrontView"];

model.vocation=[dict[@"vocation"] isKindOfClass:[NSNull class]]?@"":dict[@"vocation"];

model.realName=[dict[@"realName"] isKindOfClass:[NSNull class]]?@"":dict[@"realName"];

model.sanwei=[dict[@"sanwei"] isKindOfClass:[NSNull class]]?@"":dict[@"sanwei"];

model.idCardHandView=[dict[@"idCardHandView"] isKindOfClass:[NSNull class]]?@"":dict[@"idCardHandView"];

model.voicePriceList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"voicePriceList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
StarPriceDOModel* sumMdl=[StarPriceDOModel getFromDict:subDic];
[model.voicePriceList addObject:sumMdl];

}
}

}

model.remarks=[dict[@"remarks"] isKindOfClass:[NSNull class]]?@"":dict[@"remarks"];

model.wechatPriceList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"wechatPriceList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
StarPriceDOModel* sumMdl=[StarPriceDOModel getFromDict:subDic];
[model.wechatPriceList addObject:sumMdl];

}
}

}


 return model;
}

 +(void)cloneObj:(AnchorAuthVOModel*) source target:(AnchorAuthVOModel*)target
{

target.birthday=source.birthday;

        if(source.myInterestList==nil)
        {
//            target.myInterestList=nil;
        }else
        {
            target.myInterestList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.myInterestList.count;i++)
            {
		  [target.myInterestList addObject:[[UserInterestTabVOModel alloc]init]];
            [UserInterestTabVOModel cloneObj:source.myInterestList[i] target:target.myInterestList[i]];
            }
        }


target.signature=source.signature;

target.wechatPrice=source.wechatPrice;

        if(source.auchorAuthShowList==nil)
        {
//            target.auchorAuthShowList=nil;
        }else
        {
            target.auchorAuthShowList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.auchorAuthShowList.count;i++)
            {
		  [target.auchorAuthShowList addObject:[[AnchorAuthDOModel alloc]init]];
            [AnchorAuthDOModel cloneObj:source.auchorAuthShowList[i] target:target.auchorAuthShowList[i]];
            }
        }


target.oooTwoClassifyId=source.oooTwoClassifyId;

target.cerNo=source.cerNo;

target.constellation=source.constellation;

target.idCardBackView=source.idCardBackView;

target.height=source.height;

        if(source.interestList==nil)
        {
//            target.interestList=nil;
        }else
        {
            target.interestList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.interestList.count;i++)
            {
		  [target.interestList addObject:[[TabTypeDtoModel alloc]init]];
            [TabTypeDtoModel cloneObj:source.interestList[i] target:target.interestList[i]];
            }
        }


target.oooOneClassifyId=source.oooOneClassifyId;

        if(source.videoPriceList==nil)
        {
//            target.videoPriceList=nil;
        }else
        {
            target.videoPriceList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.videoPriceList.count;i++)
            {
		  [target.videoPriceList addObject:[[StarPriceDOModel alloc]init]];
            [StarPriceDOModel cloneObj:source.videoPriceList[i] target:target.videoPriceList[i]];
            }
        }


target.nickName=source.nickName;

target.sex=source.sex;

target.wechat=source.wechat;

target.videoAuth=source.videoAuth;

target.weight=source.weight;

        if(source.oooOneClassifyList==nil)
        {
//            target.oooOneClassifyList=nil;
        }else
        {
            target.oooOneClassifyList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.oooOneClassifyList.count;i++)
            {
		  [target.oooOneClassifyList addObject:[[AppLiveChannelModel alloc]init]];
            [AppLiveChannelModel cloneObj:source.oooOneClassifyList[i] target:target.oooOneClassifyList[i]];
            }
        }

        if(source.payCall==nil)
        {
//            target.payCall=nil;
        }else
        {
            [PayCallOneVsOneDOModel cloneObj:source.payCall target:target.payCall];
        }

target.idCardFrontView=source.idCardFrontView;

target.vocation=source.vocation;

target.realName=source.realName;

target.sanwei=source.sanwei;

target.idCardHandView=source.idCardHandView;

        if(source.voicePriceList==nil)
        {
//            target.voicePriceList=nil;
        }else
        {
            target.voicePriceList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.voicePriceList.count;i++)
            {
		  [target.voicePriceList addObject:[[StarPriceDOModel alloc]init]];
            [StarPriceDOModel cloneObj:source.voicePriceList[i] target:target.voicePriceList[i]];
            }
        }


target.remarks=source.remarks;

        if(source.wechatPriceList==nil)
        {
//            target.wechatPriceList=nil;
        }else
        {
            target.wechatPriceList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.wechatPriceList.count;i++)
            {
		  [target.wechatPriceList addObject:[[StarPriceDOModel alloc]init]];
            [StarPriceDOModel cloneObj:source.wechatPriceList[i] target:target.wechatPriceList[i]];
            }
        }


}

@end

