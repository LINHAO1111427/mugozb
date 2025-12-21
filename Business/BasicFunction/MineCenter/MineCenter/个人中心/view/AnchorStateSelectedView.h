//
//  AnchorStateSelectedView.h
//  MineCenter
//
//  Created by ssssssss on 2020/9/25.
//

#import <UIKit/UIKit.h>
 

NS_ASSUME_NONNULL_BEGIN
typedef void (^StateSelectedCallback)(BOOL close,int state);
@interface AnchorStateSelectedView : UIView
+ (void)showAnchorStateSelectedViewWith:(int)state CallBack:(StateSelectedCallback)callback;
@end

NS_ASSUME_NONNULL_END
