//
//  CAuthorityVideoRecordVc.h
//  MineCenter
//
//  Created by ssssssss on 2020/11/30.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class AnchorAuthVOModel;
typedef void(^VideoRecordViewCompletionBlock)(AnchorAuthVOModel *authModel);
@interface CAuthorityVideoRecordVc : UIViewController
- (instancetype)initWith:(AnchorAuthVOModel *)authModel;
@property (nonatomic, copy) VideoRecordViewCompletionBlock completionBlock;
@end

NS_ASSUME_NONNULL_END
