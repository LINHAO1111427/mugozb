//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
公会排行榜的vo
 */
@interface GuildListVOModel : NSObject 


	/**
序号
 */
@property (nonatomic, assign) int serialNumber;

	/**
公会头像
 */
@property (nonatomic, copy) NSString * guildAvatar;

	/**
公会收益
 */
@property (nonatomic, assign) double guildTotalVotes;

	/**
公会id
 */
@property (nonatomic, assign) int64_t guildId;

	/**
公会简介
 */
@property (nonatomic, copy) NSString * guildDesr;

	/**
公会名称
 */
@property (nonatomic, copy) NSString * guildName;

 +(NSMutableArray<GuildListVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GuildListVOModel*>*)list;

 +(GuildListVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(GuildListVOModel*) source target:(GuildListVOModel*)target;

@end

NS_ASSUME_NONNULL_END
