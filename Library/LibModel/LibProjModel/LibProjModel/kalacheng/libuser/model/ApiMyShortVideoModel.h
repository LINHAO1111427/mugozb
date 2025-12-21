//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ApiShortVideoDtoModel;
NS_ASSUME_NONNULL_BEGIN




/**
用户的短视频信息
 */
@interface ApiMyShortVideoModel : NSObject 


	/**
购买
 */
@property (nonatomic, strong) NSMutableArray<ApiShortVideoDtoModel*>* buyList;

	/**
喜欢
 */
@property (nonatomic, strong) NSMutableArray<ApiShortVideoDtoModel*>* likeList;

	/**
购买数量
 */
@property (nonatomic, assign) int buyNumber;

	/**
作品
 */
@property (nonatomic, strong) NSMutableArray<ApiShortVideoDtoModel*>* myList;

	/**
作品数量
 */
@property (nonatomic, assign) int myNumber;

	/**
喜欢数量
 */
@property (nonatomic, assign) int likeNumber;

 +(NSMutableArray<ApiMyShortVideoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiMyShortVideoModel*>*)list;

 +(ApiMyShortVideoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiMyShortVideoModel*) source target:(ApiMyShortVideoModel*)target;

@end

NS_ASSUME_NONNULL_END
