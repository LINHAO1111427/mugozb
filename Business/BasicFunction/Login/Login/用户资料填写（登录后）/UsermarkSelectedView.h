//
//  UsermarkSelectedView.h
//  Login
//
//  Created by klc on 2020/4/25.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/TabInfoDtoModel.h>
NS_ASSUME_NONNULL_BEGIN
@interface UsermarkSelectedView : UIView
@property (assign, nonatomic) BOOL selected;
@property (strong, nonatomic) TabInfoDtoModel *tabModel;
- (instancetype)initWithFrame:(CGRect)frame callBlock:(void (^)(TabInfoDtoModel *model,BOOL selected))callback;
@end

NS_ASSUME_NONNULL_END
