//
//  UITextView+Placeholder.m
//  Pods
//
//  Created by shaolei on 17/4/6.
//
//

#import "UITextView+Placeholder.h"
#import <objc/runtime.h>

static const void *textView_placeHolder_textColor ;
static const void *textView_placeHolder_text ;
static const void *textView_placeHolder ;
static const void *textView_plaseHolder_context ;

@interface UITextView ()

@property(nonatomic, weak, nullable) UITextView *placeHolderTextView;
    
@end

@implementation UITextView (Placeholder)


- (void)dealloc
{
   [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    objc_removeAssociatedObjects(self);
    if (self.observationInfo) {
        [self removeObserver:self forKeyPath:@"text" context:&textView_plaseHolder_context];
    }
}

-(void)setPlaceHolderTextView:(UITextView *)placeHolderTextView{
    objc_setAssociatedObject(self, &textView_placeHolder, placeHolderTextView,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
    
- (UITextView *)placeHolderTextView{
    UITextView *textV = objc_getAssociatedObject(self, &textView_placeHolder);
    if (!textV) {
        textV = [[UITextView alloc] initWithFrame:self.bounds];
        textV.backgroundColor = [UIColor clearColor];
        textV.userInteractionEnabled = NO;
        textV.hidden = YES;
        {
            textV.font = self.font;
            textV.textAlignment = self.textAlignment;
            textV.contentInset = self.contentInset;
            textV.textContainerInset = self.textContainerInset;
            textV.textContainer.lineFragmentPadding = self.textContainer.lineFragmentPadding;
        }
        [self addSubview:textV];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(superTextValueDidChange:) name:UITextViewTextDidChangeNotification object:nil];
        [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:&textView_plaseHolder_context];
        self.clipsToBounds = YES;
        self.placeHolderTextView = textV;
    }
    return textV;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    [self valueDidChangeWithPlaceholder];
}

- (void)superTextValueDidChange:(NSNotification *)notify{
    [self valueDidChangeWithPlaceholder];
}

-(BOOL)valueDidChangeWithPlaceholder{
    if (!self.text.length && self.placeholder.length) {
       return  !(self.placeHolderTextView.hidden = NO);
    }
    return  !(self.placeHolderTextView.hidden = YES);
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    if ([placeholderColor isEqual:self.placeholderColor]) {
        return;
    }
    objc_setAssociatedObject(self, &textView_placeHolder_textColor, placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.placeHolderTextView.textColor = self.placeholderColor;
}

-(void)setPlaceholder:(NSString *)placeholder{
    if ([placeholder isEqualToString:self.placeholder]) {
        return;
    }
    objc_setAssociatedObject(self, &textView_placeHolder_text, placeholder, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    self.placeHolderTextView.textColor = self.placeholderColor;
    self.placeHolderTextView.text = self.placeholder;
    [self valueDidChangeWithPlaceholder];
}

- (UIColor *)placeholderColor{
    UIColor *color = objc_getAssociatedObject(self, &textView_placeHolder_textColor);
    if (!color) {
        return [UIColor colorWithRed:193.0/255.0 green:193.0/255.0 blue:193.0/255.0 alpha:1.0];
    }
    return color;
}

- (NSString *)placeholder{
    return objc_getAssociatedObject(self, &textView_placeHolder_text);
}


@end
