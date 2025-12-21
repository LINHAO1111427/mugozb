//
//  CAuthorityInfoListView.h
//  MineCenter
//
//  Created by ssssssss on 2020/11/27.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CAuthorityInfoListViewDelegate <NSObject>

- (void)authenticationSuccess;

@end


@interface CAuthorityInfoListView : UIView

@property (nonatomic, weak)UIViewController* superVc;
@property (nonatomic, weak)id<CAuthorityInfoListViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
