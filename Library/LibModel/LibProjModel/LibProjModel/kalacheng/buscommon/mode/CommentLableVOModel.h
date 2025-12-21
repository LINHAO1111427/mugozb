//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
评论标签
 */
@interface CommentLableVOModel : NSObject 


	/**
评价内容
 */
@property (nonatomic, copy) NSString * name;

	/**
字体颜色
 */
@property (nonatomic, copy) NSString * fontColor;

 +(NSMutableArray<CommentLableVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<CommentLableVOModel*>*)list;

 +(CommentLableVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(CommentLableVOModel*) source target:(CommentLableVOModel*)target;

@end

NS_ASSUME_NONNULL_END
