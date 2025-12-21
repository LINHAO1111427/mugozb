//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "HttpNoneModel.h"

typedef void (^CallBackGuildController_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
公会相关
 */
@interface HttpApiGuildController: NSObject



/**
 申请退出公会
 @param guildId guildId
 @param reason reason
 */
+(void) applyQuitGuild:(int64_t)guildId reason:(NSString *)reason  callback:(CallBackGuildController_HttpNone)callback;
//  /api/guild/toJoinGuild
//  /api/guild/toJoinGuild  此函数没有开放POST请求。
//  /api/guild/toAnchorEquity
//  /api/guild/toAnchorEquity  此函数没有开放POST请求。
//  /api/guild/toGuildDetail
//  /api/guild/toGuildDetail  此函数没有开放POST请求。
//  /api/guild/toGuildList
//  /api/guild/toGuildList  此函数没有开放POST请求。


/**
 申请加入公会
 @param enclosure enclosure
 @param endTime endTime
 @param expectIncome expectIncome
 @param feat feat
 @param guildId guildId
 @param startTime startTime
 */
+(void) applyJoinGuild:(NSString *)enclosure endTime:(NSString *)endTime expectIncome:(double)expectIncome feat:(NSString *)feat guildId:(int64_t)guildId startTime:(NSString *)startTime  callback:(CallBackGuildController_HttpNone)callback;

@end

NS_ASSUME_NONNULL_END
