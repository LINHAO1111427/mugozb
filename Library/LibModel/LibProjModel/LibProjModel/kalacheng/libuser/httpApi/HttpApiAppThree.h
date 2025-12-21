//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "ApiFileUploadModel.h"

#import "modelApiFileUploadParamsModel.h"
typedef void (^CallBackAppThree_ApiFileUpload)(int code,NSString *strMsg,ApiFileUploadModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
第三方操作接口
 */
@interface HttpApiAppThree: NSObject



/**
 轩嗵云token提供给app端,文件后缀前端拼接,由于a、上传到轩嗵云的文件必须按照后端统一的命名规则命名；b、后端会定期清理轩嗵云的文件。参数需要区分应用场景已list参数传入,拿到的filePath需要拼接文件路径,和token一并传入轩嗵云 参数案例'[{'scene':1},{'scene':1},{'scene':1}]'
 @param apiFileUploadParams apiFileUploadParams
 */
+(void) getUploadInfo:(NSMutableArray<modelApiFileUploadParamsModel*>* )apiFileUploadParams  callback:(CallBackAppThree_ApiFileUpload)callback;

@end

NS_ASSUME_NONNULL_END
