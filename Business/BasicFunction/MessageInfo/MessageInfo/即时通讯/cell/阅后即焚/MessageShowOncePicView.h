//
//  MessageShowOncePicView.h
//  MessageInfo
//
//  Created by shirley on 2022/2/9.
//

#import <UIKit/UIKit.h>
#import "MessageContentObj.h"


NS_ASSUME_NONNULL_BEGIN

@interface MessageShowOncePicView : UIView

@property (nonatomic, weak)UIImageView *pic;
@property (nonatomic, weak)UILabel *titleL;


- (void)showPic:(MessageShowOncePicModel *)picModel isOwner:(BOOL)isOwner;

@end

NS_ASSUME_NONNULL_END
