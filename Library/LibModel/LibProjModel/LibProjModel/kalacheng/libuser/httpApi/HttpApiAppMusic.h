//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "AppMusicDTOModel.h"

#import "HttpNoneModel.h"

#import "AppUserMusicDTOModel.h"

typedef void (^CallBackAppMusic_AppMusicDTOArr)(int code,NSString *strMsg,NSArray<AppMusicDTOModel*>* arr);
typedef void (^CallBackAppMusic_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackAppMusic_AppUserMusicDTOArr)(int code,NSString *strMsg,NSArray<AppUserMusicDTOModel*>* arr);
NS_ASSUME_NONNULL_BEGIN



/**
app音乐
 */
@interface HttpApiAppMusic: NSObject



/**
 音乐库
 @param name 音乐名称
 @param pageIndex 当前页
 @param pageSize 每页大小
 */
+(void) queryList:(NSString *)name pageIndex:(int)pageIndex pageSize:(int)pageSize  callback:(CallBackAppMusic_AppMusicDTOArr)callback;


/**
 上传音乐
 @param author 歌手名称
 @param cover 音乐封面
 @param musicUrl 音乐地址
 @param name 音乐名称
 */
+(void) uploadMusic:(NSString *)author cover:(NSString *)cover musicUrl:(NSString *)musicUrl name:(NSString *)name  callback:(CallBackAppMusic_HttpNone)callback;


/**
 播放列表
 @param name 音乐名称
 @param pageIndex 当前页
 @param pageSize 每页大小
 */
+(void) queryMyMusicList:(NSString *)name pageIndex:(int)pageIndex pageSize:(int)pageSize  callback:(CallBackAppMusic_AppUserMusicDTOArr)callback;


/**
 添加/移除音乐
 @param musicId 音乐id
 @param type 1添加，2移除
 */
+(void) setMusic:(int64_t)musicId type:(int)type  callback:(CallBackAppMusic_HttpNone)callback;

@end

NS_ASSUME_NONNULL_END
