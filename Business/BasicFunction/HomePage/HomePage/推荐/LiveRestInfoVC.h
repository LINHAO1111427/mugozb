//
//  LiveRestInfoVC.h
//  HomePage
//
//  Created by klc on 2020/6/5.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <JXCategoryView/JXCategoryListContainerView.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveRestInfoVC : UIViewController <JXCategoryListContentViewDelegate>

@property(nonatomic, strong)AppHomeHallDTOModel *dtoModel;

///1视频 2语音
@property(nonatomic, copy)NSNumber *liveType;

@end

NS_ASSUME_NONNULL_END
