//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "SingleStringModel.h"

#import "InviteDtoModel.h"

#import "HttpNoneModel.h"

#import "CfgSearchDateModel.h"

typedef void (^CallBackSupport_SingleString)(int code,NSString *strMsg,SingleStringModel* model);
typedef void (^CallBackSupport_InviteDto)(int code,NSString *strMsg,InviteDtoModel* model);
typedef void (^CallBackSupport_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackSupport_CfgSearchDateArr)(int code,NSString *strMsg,NSArray<CfgSearchDateModel*>* arr);
NS_ASSUME_NONNULL_BEGIN



/**
系统支持接口
 */
@interface HttpApiSupport: NSObject



/**
 根据生日获取星座
 @param date 生日
 */
+(void) getStarByDate:(NSString *)date  callback:(CallBackSupport_SingleString)callback;


/**
 获取邀请码
 */
+(void) getInviteCodeInfo:(CallBackSupport_InviteDto)callback;


/**
 万能通用二维码生成器
 @param content 二维码的内容：如链接地址，邀请码等
 @param height 二维码高度
 @param width 二维码宽度
 */
+(void) qrCode:(NSString *)content height:(int)height width:(int)width  callback:(CallBackSupport_HttpNone)callback;


/**
 获取查询时间
 */
+(void) getSearchDate:(CallBackSupport_CfgSearchDateArr)callback;
//  /api/support/getShareImg
//  /api/support/getShareImg  此函数没有开放POST请求。

@end

NS_ASSUME_NONNULL_END
