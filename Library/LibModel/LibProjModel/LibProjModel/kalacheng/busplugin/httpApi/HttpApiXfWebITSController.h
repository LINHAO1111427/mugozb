//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "HttpNoneModel.h"

typedef void (^CallBackXfWebITSController_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
科大翻译
 */
@interface HttpApiXfWebITSController: NSObject



/**
 科大讯飞翻译
 @param fromLanguage 源语言（中文：cn 越南语：vi）
 @param text 需要翻译的文字
 @param toLanguage 目标语言（中文：cn 越南语：vi）
 */
+(void) languageConversion:(NSString *)fromLanguage text:(NSString *)text toLanguage:(NSString *)toLanguage  callback:(CallBackXfWebITSController_HttpNone)callback;

@end

NS_ASSUME_NONNULL_END
