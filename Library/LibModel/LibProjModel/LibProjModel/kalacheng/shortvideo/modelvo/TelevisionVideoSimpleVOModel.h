//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
电视剧显示的简单VO(相当与电视剧)
 */
@interface TelevisionVideoSimpleVOModel : NSObject 


	/**
电视剧总集数
 */
@property (nonatomic, assign) int totalEpisodes;

	/**
电视剧封面图
 */
@property (nonatomic, copy) NSString * televisionVideoCoverImg;

	/**
电视剧描述
 */
@property (nonatomic, copy) NSString * televisionVideoDesc;

	/**
电视剧标题
 */
@property (nonatomic, copy) NSString * televisionVideoTitle;

	/**
电视剧标签集
 */
@property (nonatomic, copy) NSString * televisionVideoTagIds;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
电视剧预览图
 */
@property (nonatomic, copy) NSString * televisionVideoImg;

	/**
所属用户
 */
@property (nonatomic, assign) int64_t userId;

 +(NSMutableArray<TelevisionVideoSimpleVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<TelevisionVideoSimpleVOModel*>*)list;

 +(TelevisionVideoSimpleVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(TelevisionVideoSimpleVOModel*) source target:(TelevisionVideoSimpleVOModel*)target;

@end

NS_ASSUME_NONNULL_END
