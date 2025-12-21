//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class AppLiveTagModel;
 @class AppTabInfoModel;
 @class KeyValueDtoModel;
 @class AppAreaModel;
 @class AppSearchRecordModel;
NS_ASSUME_NONNULL_BEGIN




/**
搜索条件
 */
@interface SearchConditionDtoModel : NSObject 


	/**
直播标签
 */
@property (nonatomic, strong) NSMutableArray<AppLiveTagModel*>* liveTagList;

	/**
全部用户标签信息
 */
@property (nonatomic, strong) NSMutableArray<AppTabInfoModel*>* allTabInfoList;

	/**
性别选择
 */
@property (nonatomic, strong) NSMutableArray<KeyValueDtoModel*>* sexs;

	/**
热门城市
 */
@property (nonatomic, strong) NSMutableArray<AppAreaModel*>* hotCitys;

	/**
历史搜索记录
 */
@property (nonatomic, strong) NSMutableArray<AppSearchRecordModel*>* historyRecords;

 +(NSMutableArray<SearchConditionDtoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<SearchConditionDtoModel*>*)list;

 +(SearchConditionDtoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(SearchConditionDtoModel*) source target:(SearchConditionDtoModel*)target;

@end

NS_ASSUME_NONNULL_END
