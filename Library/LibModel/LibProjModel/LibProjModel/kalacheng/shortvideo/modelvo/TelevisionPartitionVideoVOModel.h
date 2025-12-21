//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class TelevisionVideoSimpleVOModel;
NS_ASSUME_NONNULL_BEGIN




/**
电视剧分区视频VO
 */
@interface TelevisionPartitionVideoVOModel : NSObject 


	/**
分区顺序(默认降序) 1：随机排序（可能出现重复） 2：添加时间 3：观看量 4：点赞数
 */
@property (nonatomic, assign) int partitionSequence;

	/**
电视剧分区名称
 */
@property (nonatomic, copy) NSString * televisionPartitionName;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
分区显示视频数量
 */
@property (nonatomic, assign) int partitionShowNum;

	/**
分区显示视频信息
 */
@property (nonatomic, strong) NSMutableArray<TelevisionVideoSimpleVOModel*>* televisionVideoSimpleVOList;

	/**
分区样式 1：一行一个 2：一行两个 3：一行三个
 */
@property (nonatomic, assign) int partitionStyle;

 +(NSMutableArray<TelevisionPartitionVideoVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<TelevisionPartitionVideoVOModel*>*)list;

 +(TelevisionPartitionVideoVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(TelevisionPartitionVideoVOModel*) source target:(TelevisionPartitionVideoVOModel*)target;

@end

NS_ASSUME_NONNULL_END
