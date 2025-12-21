//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP音乐
 */
@interface ApiMusicModel : NSObject 


	/**
音乐名称
 */
@property (nonatomic, copy) NSString * name;

	/**
歌曲下载进度
 */
@property (nonatomic, assign) int progress;

	/**
音乐id
 */
@property (nonatomic, copy) NSString * id_field;

	/**
音乐歌词
 */
@property (nonatomic, copy) NSString * lyrics;

	/**
音乐歌手
 */
@property (nonatomic, copy) NSString * authors;

	/**
音乐地址
 */
@property (nonatomic, copy) NSString * playUrl;

 +(NSMutableArray<ApiMusicModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiMusicModel*>*)list;

 +(ApiMusicModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiMusicModel*) source target:(ApiMusicModel*)target;

@end

NS_ASSUME_NONNULL_END
