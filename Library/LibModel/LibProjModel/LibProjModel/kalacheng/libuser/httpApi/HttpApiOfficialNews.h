//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "AppOfficialNewsDTOModel.h"

typedef void (^CallBackOfficialNews_AppOfficialNewsDTOArr)(int code,NSString *strMsg,NSArray<AppOfficialNewsDTOModel*>* arr);
typedef void (^CallBackOfficialNews_AppOfficialNewsDTO)(int code,NSString *strMsg,AppOfficialNewsDTOModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
官方消息
 */
@interface HttpApiOfficialNews: NSObject



/**
 查询官方消息列表
 @param pageIndex pageIndex
 @param pageSize pageSize
 */
+(void) getOfficialNewsList:(int)pageIndex pageSize:(int)pageSize  callback:(CallBackOfficialNews_AppOfficialNewsDTOArr)callback;


/**
 查看官方消息
 @param id 消息id
 */
+(void) messageViewed:(int64_t)id_field  callback:(CallBackOfficialNews_AppOfficialNewsDTO)callback;

@end

NS_ASSUME_NONNULL_END
