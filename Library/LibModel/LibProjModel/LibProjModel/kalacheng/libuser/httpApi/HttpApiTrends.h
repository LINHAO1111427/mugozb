//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "AppTrendsRecordModel.h"

typedef void (^CallBackTrends_AppTrendsRecordArr)(int code,NSString *strMsg,NSArray<AppTrendsRecordModel*>* arr);
NS_ASSUME_NONNULL_BEGIN



/**
第一次动态和动态接口
 */
@interface HttpApiTrends: NSObject



/**
 获取时间轴
 @param pageIndex 当前页
 @param pageSize 每页大小
 */
+(void) firstTrendsList:(int)pageIndex pageSize:(int)pageSize  callback:(CallBackTrends_AppTrendsRecordArr)callback;

@end

NS_ASSUME_NONNULL_END
