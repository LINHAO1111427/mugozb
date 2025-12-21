//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
我的音乐列表
 */
@interface AppUserMusicDTOModel : NSObject 


	/**
封面
 */
@property (nonatomic, copy) NSString * cover;

	/**
音乐id
 */
@property (nonatomic, assign) int64_t musicId;

	/**
原创/作者
 */
@property (nonatomic, copy) NSString * author;

	/**
音乐播放地址
 */
@property (nonatomic, copy) NSString * musicUrl;

	/**
音乐名称
 */
@property (nonatomic, copy) NSString * name;

	/**
id
 */
@property (nonatomic, assign) int64_t id_field;

 +(NSMutableArray<AppUserMusicDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUserMusicDTOModel*>*)list;

 +(AppUserMusicDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppUserMusicDTOModel*) source target:(AppUserMusicDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
