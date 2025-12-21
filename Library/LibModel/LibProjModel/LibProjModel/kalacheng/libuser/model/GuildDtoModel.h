//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
公会资料
 */
@interface GuildDtoModel : NSObject 


	/**
公会名称
 */
@property (nonatomic, copy) NSString * name;

	/**
家族LOGO
 */
@property (nonatomic, copy) NSString * logo;

	/**
公会ID
 */
@property (nonatomic, assign) int64_t guildId;

	/**
公会简介
 */
@property (nonatomic, copy) NSString * desr;

 +(NSMutableArray<GuildDtoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GuildDtoModel*>*)list;

 +(GuildDtoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(GuildDtoModel*) source target:(GuildDtoModel*)target;

@end

NS_ASSUME_NONNULL_END
