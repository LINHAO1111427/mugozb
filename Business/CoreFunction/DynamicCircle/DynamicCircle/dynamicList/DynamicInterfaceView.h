//
//  DynamicInterFaceView.h
//  DynamicCircle
//
//  Created by ssssssss on 2020/7/28.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/ApiUserVideoModel.h>
NS_ASSUME_NONNULL_BEGIN
@class DynamicInterfaceView;
@protocol DynamicInterfaceViewDelagte <NSObject>
@optional
- (void)dynamicInterfaceViewBtnClick:(DynamicInterfaceView *)faceView dynamicModel:(ApiUserVideoModel *)model index:(NSInteger)index;
- (void)dynamicInterfaceViewBtnClick:(DynamicInterfaceView *)faceView userInfoJump:(int64_t)user_id;
- (void)dynamicInterfaceViewBtnClick:(DynamicInterfaceView *)faceView reportDyanamic:(ApiUserVideoModel *)model;
@end
@interface DynamicInterfaceView : UIView
@property (nonatomic, strong)ApiUserVideoModel *model;
@property (nonatomic, strong)NSIndexPath *indexPath;
@property (nonatomic, weak)id<DynamicInterfaceViewDelagte> delegate;
@end

NS_ASSUME_NONNULL_END
