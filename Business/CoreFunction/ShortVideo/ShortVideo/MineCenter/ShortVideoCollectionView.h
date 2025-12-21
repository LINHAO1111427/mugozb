//
//  ShortVideoCollectionView.h
//  MineCenter
//
//  Created by KLC on 2020/6/24.
//

#import <UIKit/UIKit.h>
#import <JXPagingView/JXPagerView.h>

NS_ASSUME_NONNULL_BEGIN
@class ShortVideoCollectionView;
@protocol ShortVideoCollectionViewDalegate <NSObject>
@optional
- (void)shortVideoCollectionView:(ShortVideoCollectionView *)shortVideoCollection scrollStatus:(BOOL)canScroll;
- (void)shortVideoCollectionView:(ShortVideoCollectionView *)shortVideoCollection didSelected:(NSInteger)index type:(int)type;
@end
@interface ShortVideoCollectionView : UICollectionView <JXPagerViewListViewDelegate>
@property (nonatomic, assign)int type;
@property (nonatomic, weak)id<ShortVideoCollectionViewDalegate> scrollDelegate;
@end

NS_ASSUME_NONNULL_END
