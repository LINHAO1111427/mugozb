//
//  CAuthorityUploadPhotoVc.h
//  MineCenter
//
//  Created by ssssssss on 2020/11/28.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class AnchorAuthVOModel;
typedef  void (^AuthorityUploadPhotoCallBack)(AnchorAuthVOModel *authModel);
@interface CAuthorityUploadPhotoVc : UIViewController
@property (nonatomic, copy)NSString *titleStr;
@property (nonatomic, copy)AuthorityUploadPhotoCallBack completeCallBack;
- (instancetype)initWith:(AnchorAuthVOModel *)authModel;
@end

NS_ASSUME_NONNULL_END
