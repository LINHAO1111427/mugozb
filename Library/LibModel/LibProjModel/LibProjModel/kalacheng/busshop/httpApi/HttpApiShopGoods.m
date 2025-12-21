//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>
#import <LibProjBase/HttpClient.h>
#import "MJExtension.h"

#import <LibTools/NSDictionary+Json.h>
#import "HttpApiShopGoods.h"




@implementation HttpApiShopGoods



/**
 商品属性添加
 @param goodsId 商品id
 @param shopGoodsAttrCompositeEntities shopGoodsAttrCompositeEntities
 */
+(void) createAttribute:(int64_t)goodsId shopGoodsAttrCompositeEntities:(NSMutableArray<ShopGoodsAttrCompositeModel*>* )shopGoodsAttrCompositeEntities  callback:(CallBackShopGoods_ShopAttrComposeArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@?_uid_=%lli&_token_=%@&_OS_=%@&_OSV_=%@&_OSInfo_=%@",[HttpClient getBaseUrl],@"/api/goods/createAttribute",[HttpClient getUid],[HttpClient getToken],[HttpClient urlEncode:[HttpClient getOSType]],[HttpClient urlEncode:[HttpClient getOSVersion]],[HttpClient urlEncode:[HttpClient getOSInfo]],nil];
 NSString *tmp_para0=[NSString stringWithFormat:@"%@",@(goodsId),nil];
 NSString *tmp_e_para0= [tmp_para0 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
strUrl  =[NSString stringWithFormat:@"%@&goodsId=%@",strUrl,tmp_e_para0,nil];
NSMutableArray *dictPara = [ShopGoodsAttrCompositeModel modelToJSONArray:shopGoodsAttrCompositeEntities];

 [HttpClient jsonPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        NSMutableArray *retArr=[[NSMutableArray alloc] init];
        if(code==1)
        {
            id idArray = dicRet[@"retArr"];
            if([idArray isKindOfClass:[NSArray class]])
            {
                NSArray*  dataArray=idArray;
                for (NSDictionary *dic in dataArray) {
                    ShopAttrComposeModel *handle = [ShopAttrComposeModel getFromDict:dic];
                    [retArr addObject:handle];
                }
            }
        }
        callback(code,strMsg,retArr);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 商品渠道列表
 */
+(void) getChannelList:(CallBackShopGoods_ShopGoodsChannelArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/goods/getChannelList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]};

 [HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        NSMutableArray *retArr=[[NSMutableArray alloc] init];
        if(code==1)
        {
            id idArray = dicRet[@"retArr"];
            if([idArray isKindOfClass:[NSArray class]])
            {
                NSArray*  dataArray=idArray;
                for (NSDictionary *dic in dataArray) {
                    ShopGoodsChannelModel *handle = [ShopGoodsChannelModel getFromDict:dic];
                    [retArr addObject:handle];
                }
            }
        }
        callback(code,strMsg,retArr);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}





/**
 商品录入
 @param categoryId 分类id
 @param channelId 渠道id
 @param detailPicture 商品详情图片地址
 @param favorablePrice 优惠价格
 @param goodsId 商品id
 @param goodsName 商品名称
 @param goodsPicture 商品简介图片地址
 @param present 商品详情
 @param price 商品价格
 @param productLinks 商品链接
 @param type 渠道类型 1：第三方 2：自营
 */
+(void) creatGoods:(ShopGoods_creatGoods*)_mdl callback:(CallBackShopGoods_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/goods/creatGoods",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"categoryId":@(_mdl.categoryId)
,@"channelId":@(_mdl.channelId)
,@"detailPicture":_mdl.detailPicture
,@"favorablePrice":@(_mdl.favorablePrice)
,@"goodsId":@(_mdl.goodsId)
,@"goodsName":_mdl.goodsName
,@"goodsPicture":_mdl.goodsPicture
,@"present":_mdl.present
,@"price":@(_mdl.price)
,@"productLinks":_mdl.productLinks
,@"type":@(_mdl.type)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        HttpNoneModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [HttpNoneModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}

/**
 商品录入
 @param categoryId 分类id
 @param channelId 渠道id
 @param detailPicture 商品详情图片地址
 @param favorablePrice 优惠价格
 @param goodsId 商品id
 @param goodsName 商品名称
 @param goodsPicture 商品简介图片地址
 @param present 商品详情
 @param price 商品价格
 @param productLinks 商品链接
 @param type 渠道类型 1：第三方 2：自营
 */
+(void) creatGoods:(int64_t)categoryId channelId:(int64_t)channelId detailPicture:(NSString *)detailPicture favorablePrice:(double)favorablePrice goodsId:(int64_t)goodsId goodsName:(NSString *)goodsName goodsPicture:(NSString *)goodsPicture present:(NSString *)present price:(double)price productLinks:(NSString *)productLinks type:(int)type  callback:(CallBackShopGoods_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/goods/creatGoods",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"categoryId":@(categoryId)
,@"channelId":@(channelId)
,@"detailPicture":detailPicture
,@"favorablePrice":@(favorablePrice)
,@"goodsId":@(goodsId)
,@"goodsName":goodsName
,@"goodsPicture":goodsPicture
,@"present":present
,@"price":@(price)
,@"productLinks":productLinks
,@"type":@(type)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        HttpNoneModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [HttpNoneModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 设置讲解中状态
 @param liveGoodsId 直播商品id
 @param roomId 房间号
 */
+(void) setExplainStatus:(int64_t)liveGoodsId roomId:(int64_t)roomId  callback:(CallBackShopGoods_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/goods/setExplainStatus",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"liveGoodsId":@(liveGoodsId)
,@"roomId":@(roomId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        HttpNoneModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [HttpNoneModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 删除商品
 @param goodsId 商品id
 */
+(void) delGoods:(int64_t)goodsId  callback:(CallBackShopGoods_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/goods/delGoods",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"goodsId":@(goodsId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        HttpNoneModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [HttpNoneModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 商品列表
 @param pageIndex 当前页
 @param pageSize 每页大小
 @param status 商品状态 0：全部 1：待上架 2：已上架 3：冻结中
 */
+(void) getGoodsList:(int)pageIndex pageSize:(int)pageSize status:(int)status  callback:(CallBackShopGoods_ShopGoodsDTOArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/goods/getGoodsList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"pageIndex":@(pageIndex)
,@"pageSize":@(pageSize)
,@"status":@(status)};

 [HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        NSMutableArray *retArr=[[NSMutableArray alloc] init];
        if(code==1)
        {
            id idArray = dicRet[@"retArr"];
            if([idArray isKindOfClass:[NSArray class]])
            {
                NSArray*  dataArray=idArray;
                for (NSDictionary *dic in dataArray) {
                    ShopGoodsDTOModel *handle = [ShopGoodsDTOModel getFromDict:dic];
                    [retArr addObject:handle];
                }
            }
        }
        callback(code,strMsg,retArr);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 商品详情
 @param goodsId 商品id
 */
+(void) getGoodsDetail:(int64_t)goodsId  callback:(CallBackShopGoods_ShopGoodsDetailDTO)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/goods/getGoodsDetail",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"goodsId":@(goodsId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        ShopGoodsDetailDTOModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [ShopGoodsDetailDTOModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 商品上下架
 @param goodsId 商品id
 @param status 商品状态 1：下架 2：上架
 */
+(void) upAndLower:(int64_t)goodsId status:(int)status  callback:(CallBackShopGoods_ShopGoods)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/goods/upAndLower",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"goodsId":@(goodsId)
,@"status":@(status)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        ShopGoodsModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [ShopGoodsModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 获取商品属性
 @param goodsId 商品id
 */
+(void) getArrDetailList:(int64_t)goodsId  callback:(CallBackShopGoods_ShopGoodsAttrDTOArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/goods/getArrDetailList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"goodsId":@(goodsId)};

 [HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        NSMutableArray *retArr=[[NSMutableArray alloc] init];
        if(code==1)
        {
            id idArray = dicRet[@"retArr"];
            if([idArray isKindOfClass:[NSArray class]])
            {
                NSArray*  dataArray=idArray;
                for (NSDictionary *dic in dataArray) {
                    ShopGoodsAttrDTOModel *handle = [ShopGoodsAttrDTOModel getFromDict:dic];
                    [retArr addObject:handle];
                }
            }
        }
        callback(code,strMsg,retArr);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 商品类别
 */
+(void) getCategoryList:(CallBackShopGoods_ShopGoodsCategoryArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/goods/getCategoryList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]};

 [HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        NSMutableArray *retArr=[[NSMutableArray alloc] init];
        if(code==1)
        {
            id idArray = dicRet[@"retArr"];
            if([idArray isKindOfClass:[NSArray class]])
            {
                NSArray*  dataArray=idArray;
                for (NSDictionary *dic in dataArray) {
                    ShopGoodsCategoryModel *handle = [ShopGoodsCategoryModel getFromDict:dic];
                    [retArr addObject:handle];
                }
            }
        }
        callback(code,strMsg,retArr);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 修改直播间商品排序
 @param liveGoodsId 直播商品id
 @param sort 排序
 */
+(void) updateLiveGoodsSort:(int64_t)liveGoodsId sort:(int)sort  callback:(CallBackShopGoods_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/goods/updateLiveGoodsSort",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"liveGoodsId":@(liveGoodsId)
,@"sort":@(sort)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        HttpNoneModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [HttpNoneModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 商品修改序号
 @param goodsId 商品id
 @param sort 商品排序
 */
+(void) updateGoodsSort:(int64_t)goodsId sort:(int)sort  callback:(CallBackShopGoods_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/goods/updateGoodsSort",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"goodsId":@(goodsId)
,@"sort":@(sort)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        HttpNoneModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [HttpNoneModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}





/**
 商品修改
 @param categoryId 分类id
 @param channelId 渠道id
 @param detailPicture 商品详情图片地址
 @param favorablePrice 优惠价格
 @param goodsId 商品id
 @param goodsName 商品名称
 @param goodsPicture 商品简介图片地址
 @param present 商品详情
 @param price 商品价格
 @param productLinks 商品链接
 @param sort 商品排序
 @param type 渠道类型 1 第三方 2自营
 */
+(void) updateGoods:(ShopGoods_updateGoods*)_mdl callback:(CallBackShopGoods_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/goods/updateGoods",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"categoryId":@(_mdl.categoryId)
,@"channelId":@(_mdl.channelId)
,@"detailPicture":_mdl.detailPicture
,@"favorablePrice":@(_mdl.favorablePrice)
,@"goodsId":@(_mdl.goodsId)
,@"goodsName":_mdl.goodsName
,@"goodsPicture":_mdl.goodsPicture
,@"present":_mdl.present
,@"price":@(_mdl.price)
,@"productLinks":_mdl.productLinks
,@"sort":@(_mdl.sort)
,@"type":@(_mdl.type)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        HttpNoneModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [HttpNoneModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}

/**
 商品修改
 @param categoryId 分类id
 @param channelId 渠道id
 @param detailPicture 商品详情图片地址
 @param favorablePrice 优惠价格
 @param goodsId 商品id
 @param goodsName 商品名称
 @param goodsPicture 商品简介图片地址
 @param present 商品详情
 @param price 商品价格
 @param productLinks 商品链接
 @param sort 商品排序
 @param type 渠道类型 1 第三方 2自营
 */
+(void) updateGoods:(int64_t)categoryId channelId:(int64_t)channelId detailPicture:(NSString *)detailPicture favorablePrice:(double)favorablePrice goodsId:(int64_t)goodsId goodsName:(NSString *)goodsName goodsPicture:(NSString *)goodsPicture present:(NSString *)present price:(double)price productLinks:(NSString *)productLinks sort:(int)sort type:(int)type  callback:(CallBackShopGoods_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/goods/updateGoods",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"categoryId":@(categoryId)
,@"channelId":@(channelId)
,@"detailPicture":detailPicture
,@"favorablePrice":@(favorablePrice)
,@"goodsId":@(goodsId)
,@"goodsName":goodsName
,@"goodsPicture":goodsPicture
,@"present":present
,@"price":@(price)
,@"productLinks":productLinks
,@"sort":@(sort)
,@"type":@(type)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        HttpNoneModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [HttpNoneModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 直播开播商品列表
 @param pageIndex 当前页
 @param pageSize 每页大小
 @param status 商品状态 0：全部 1：待上架 2：已上架 3：冻结中
 */
+(void) getLiveGoodsList:(int)pageIndex pageSize:(int)pageSize status:(int)status  callback:(CallBackShopGoods_ShopGoodsDTOArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/goods/getLiveGoodsList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"pageIndex":@(pageIndex)
,@"pageSize":@(pageSize)
,@"status":@(status)};

 [HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        NSMutableArray *retArr=[[NSMutableArray alloc] init];
        if(code==1)
        {
            id idArray = dicRet[@"retArr"];
            if([idArray isKindOfClass:[NSArray class]])
            {
                NSArray*  dataArray=idArray;
                for (NSDictionary *dic in dataArray) {
                    ShopGoodsDTOModel *handle = [ShopGoodsDTOModel getFromDict:dic];
                    [retArr addObject:handle];
                }
            }
        }
        callback(code,strMsg,retArr);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 获取商品属性组合值列表
 @param goodsId 商品id
 */
+(void) getAttrCompose:(int64_t)goodsId  callback:(CallBackShopGoods_ShopAttrAndComposeDTO)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/goods/getAttrCompose",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"goodsId":@(goodsId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        ShopAttrAndComposeDTOModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [ShopAttrAndComposeDTOModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 商品信息
 @param productId 商品id
 */
+(void) getShopGoods:(int64_t)productId  callback:(CallBackShopGoods_ShopGoods)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/goods/getShopGoods",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"productId":@(productId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        ShopGoodsModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [ShopGoodsModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 添加直播商品
 @param goodsId 商品id
 @param optType 操作类型 1：增加 2：删除
 @param sort 排序
 */
+(void) saveLiveGoods:(int64_t)goodsId optType:(int)optType sort:(int)sort  callback:(CallBackShopGoods_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/goods/saveLiveGoods",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"goodsId":@(goodsId)
,@"optType":@(optType)
,@"sort":@(sort)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        HttpNoneModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [HttpNoneModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 设置商品价格与库存
 @param shopAttrComposes shopAttrComposes
 */
+(void) setPriceInventory:(NSMutableArray<ShopAttrComposeModel*>* )shopAttrComposes  callback:(CallBackShopGoods_ShopGoodsAttrArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@?_uid_=%lli&_token_=%@&_OS_=%@&_OSV_=%@&_OSInfo_=%@",[HttpClient getBaseUrl],@"/api/goods/setPriceInventory",[HttpClient getUid],[HttpClient getToken],[HttpClient urlEncode:[HttpClient getOSType]],[HttpClient urlEncode:[HttpClient getOSVersion]],[HttpClient urlEncode:[HttpClient getOSInfo]],nil];
NSMutableArray *dictPara = [ShopAttrComposeModel modelToJSONArray:shopAttrComposes];

 [HttpClient jsonPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        NSMutableArray *retArr=[[NSMutableArray alloc] init];
        if(code==1)
        {
            id idArray = dicRet[@"retArr"];
            if([idArray isKindOfClass:[NSArray class]])
            {
                NSArray*  dataArray=idArray;
                for (NSDictionary *dic in dataArray) {
                    ShopGoodsAttrModel *handle = [ShopGoodsAttrModel getFromDict:dic];
                    [retArr addObject:handle];
                }
            }
        }
        callback(code,strMsg,retArr);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 商品属性修改
 @param goodsId 商品id
 @param shopGoodsAttrCompositeEntities shopGoodsAttrCompositeEntities
 */
+(void) updateAttribute:(int64_t)goodsId shopGoodsAttrCompositeEntities:(NSMutableArray<ShopGoodsAttrCompositeModel*>* )shopGoodsAttrCompositeEntities  callback:(CallBackShopGoods_ShopAttrComposeArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@?_uid_=%lli&_token_=%@&_OS_=%@&_OSV_=%@&_OSInfo_=%@",[HttpClient getBaseUrl],@"/api/goods/updateAttribute",[HttpClient getUid],[HttpClient getToken],[HttpClient urlEncode:[HttpClient getOSType]],[HttpClient urlEncode:[HttpClient getOSVersion]],[HttpClient urlEncode:[HttpClient getOSInfo]],nil];
 NSString *tmp_para0=[NSString stringWithFormat:@"%@",@(goodsId),nil];
 NSString *tmp_e_para0= [tmp_para0 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
strUrl  =[NSString stringWithFormat:@"%@&goodsId=%@",strUrl,tmp_e_para0,nil];
NSMutableArray *dictPara = [ShopGoodsAttrCompositeModel modelToJSONArray:shopGoodsAttrCompositeEntities];

 [HttpClient jsonPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        NSMutableArray *retArr=[[NSMutableArray alloc] init];
        if(code==1)
        {
            id idArray = dicRet[@"retArr"];
            if([idArray isKindOfClass:[NSArray class]])
            {
                NSArray*  dataArray=idArray;
                for (NSDictionary *dic in dataArray) {
                    ShopAttrComposeModel *handle = [ShopAttrComposeModel getFromDict:dic];
                    [retArr addObject:handle];
                }
            }
        }
        callback(code,strMsg,retArr);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 直播间商品列表
 @param anchorId 主播Id
 */
+(void) getLiveGoods:(int64_t)anchorId  callback:(CallBackShopGoods_ShopLiveGoodsDTO)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/goods/getLiveGoods",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"anchorId":@(anchorId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        ShopLiveGoodsDTOModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [ShopLiveGoodsDTOModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}


@end


