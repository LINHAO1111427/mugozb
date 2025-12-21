//
//  HomeLiveVideoViewController.h
//  HomePage
//
//  Created by klc on 2020/6/5.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <JXCategoryView/JXCategoryListContainerView.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeLiveVideoViewController : UIViewController<JXCategoryListContentViewDelegate>

///1视频 2语音
@property(nonatomic,assign)int liveType;


@end

NS_ASSUME_NONNULL_END
