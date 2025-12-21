//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "GuildDtoModel.h"

#import "AdminUserModel.h"

#import "LiveRoomInfoVOModel.h"

typedef void (^CallBackApiGuild_GuildDtoArr)(int code,NSString *strMsg,NSArray<GuildDtoModel*>* arr);
typedef void (^CallBackApiGuild_AdminUserArr)(int code,NSString *strMsg,NSArray<AdminUserModel*>* arr);
typedef void (^CallBackApiGuild_LiveRoomInfoVOArr)(int code,NSString *strMsg,NSArray<LiveRoomInfoVOModel*>* arr);
NS_ASSUME_NONNULL_BEGIN



/**
H5公会相关
 */
@interface HttpApiApiGuild: NSObject



/**
 查询公会列表
 */
+(void) queryGuildList:(CallBackApiGuild_GuildDtoArr)callback;


/**
 获取所有的公会
 */
+(void) getGuildAll:(CallBackApiGuild_AdminUserArr)callback;


/**
 获取公会正在直播的房间
 @param guildId 公会id
 */
+(void) getGuildLiveRoom:(int64_t)guildId  callback:(CallBackApiGuild_LiveRoomInfoVOArr)callback;

@end

NS_ASSUME_NONNULL_END
