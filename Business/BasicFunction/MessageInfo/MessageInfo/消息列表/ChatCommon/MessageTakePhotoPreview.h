//
//  MessageBurnDownAfterReadPreview.h
//  MessageInfo
//
//  Created by SWH05 on 2022/3/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MessageTakePhotoPreview;
typedef void (^TakePhotoPreviewCallBack)(MessageTakePhotoPreview *view ,BOOL isBronDownAfterRead,UIImage *returnImage,BOOL isSend);
@interface MessageTakePhotoPreview : UIView
+ (void)showImageWith:(UIImage *)image callBack:(TakePhotoPreviewCallBack)callBack;
@end

NS_ASSUME_NONNULL_END
