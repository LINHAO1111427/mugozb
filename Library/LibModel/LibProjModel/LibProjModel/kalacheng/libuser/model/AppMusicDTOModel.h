//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
音乐列表
 */
@interface AppMusicDTOModel : NSObject 


	/**
封面
 */
@property (nonatomic, copy) NSString * cover;

	/**
是否添加：1已添加，0未添加
 */
@property (nonatomic, assign) int added;

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

 +(NSMutableArray<AppMusicDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppMusicDTOModel*>*)list;

 +(AppMusicDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppMusicDTOModel*) source target:(AppMusicDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
