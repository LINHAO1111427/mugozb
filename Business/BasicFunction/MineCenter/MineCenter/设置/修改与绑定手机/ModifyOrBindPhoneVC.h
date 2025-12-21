//
//  ModifyOrBindPhoneVC.h
//  MineCenter
//
//  Created by ssssssss on 2020/8/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum {
   VcTypeBindPhone = 0,//绑定
   VcTypeModifyPhone //修改
}MobileVcType;
@interface ModifyOrBindPhoneVC : UIViewController
@property (nonatomic, copy)NSString *navTitle;;
@property (nonatomic, assign)MobileVcType type;
@end

NS_ASSUME_NONNULL_END
