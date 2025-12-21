//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
 * 首页列表数据
*/
@interface Home_getHomO2ODataList : NSObject 


 +(Home_getHomO2ODataList*)getFromDict:(NSDictionary*)dict;

 +(NSMutableArray<Home_getHomO2ODataList*>*)getFromArr:(NSArray*)list;


	
	/**
地址
 */
@property (nonatomic, copy) NSString * address;


	
	/**
频道ID
 */
@property (nonatomic, assign) int64_t channelId;


	
	/**
热门类型ID
 */
@property (nonatomic, assign) int64_t hotSortId;


	
	/**
是否推荐 -1:全部 0:不推荐 1:已推荐
 */
@property (nonatomic, assign) int isRecommend;


	
	/**
纬度
 */
@property (nonatomic, assign) double lat;


	
	/**
经度
 */
@property (nonatomic, assign) double lng;


	
	/**
当前页
 */
@property (nonatomic, assign) int pageIndex;


	
	/**
每页大小
 */
@property (nonatomic, assign) int pageSize;


	
	/**
性别 -1:全部 0:默认未设置性别的用户 1:男 2:女
 */
@property (nonatomic, assign) int sex;


	
	/**
标签ID数组， 逗号隔开
 */
@property (nonatomic, copy) NSString * tabIds;


	
	/**
ooo二级分类id(没有就-1)
 */
@property (nonatomic, assign) int64_t twoClassifyId;

@end

NS_ASSUME_NONNULL_END
