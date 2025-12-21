//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "ApiDiscoverModel.h"

#import "ApiMusicModel.h"

typedef void (^CallBackVideoController_ApiDiscover)(int code,NSString *strMsg,ApiDiscoverModel* model);
typedef void (^CallBackVideoController_ApiMusicPageArr)(int code,NSString *strMsg,PageInfo *pageInfo,NSArray<ApiMusicModel*>* arr);
typedef void (^CallBackVideoController_ApiMusic)(int code,NSString *strMsg,ApiMusicModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
动态API（旧）
 */
@interface HttpApiVideoController: NSObject



/**
 发现页接口
 */
+(void) discoverPage:(CallBackVideoController_ApiDiscover)callback;


/**
 音乐列表
 @param keyWord 关键字
 @param page 页数
 @param pageSize 每页的条数
 */
+(void) musicList:(NSString *)keyWord page:(int)page pageSize:(int)pageSize  callback:(CallBackVideoController_ApiMusicPageArr)callback;


/**
 获取音乐地址
 @param id 音乐id
 */
+(void) musicInfo:(NSString *)id_field  callback:(CallBackVideoController_ApiMusic)callback;

@end

NS_ASSUME_NONNULL_END
