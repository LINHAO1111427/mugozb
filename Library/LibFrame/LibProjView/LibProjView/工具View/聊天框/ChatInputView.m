
//
//  ChatInputView.m
//  TCDemo
//
//  Created by admin on 2019/11/8.
//  Copyright © 2019 CH. All rights reserved.
//

#import "ChatInputView.h"
#import "EmojiKeyboardView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/PopupTool.h>

///输入框
@interface CInputSubView : UIView <UITextViewDelegate>

@property (nonatomic, weak)UIButton *changeBtn;
@property (nonatomic, weak)UIView *inputBgView;
@property (nonatomic, weak)UITextView *textV;
@property (nonatomic, copy)void(^sendBtnClickBlock)(void);

@end

@implementation CInputSubView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    UIButton *changeBtn = [UIButton buttonWithType:0];
    changeBtn.frame = CGRectMake(self.width - self.height, 0,  self.height, self.height);
    changeBtn.imageEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12);
    changeBtn.selected = NO;
    [changeBtn setImage:[UIImage imageNamed:@"chat_change_face"] forState:UIControlStateNormal];
    [changeBtn setImage:[UIImage imageNamed:@"chat_change_keyboard"] forState:UIControlStateSelected];
    [changeBtn addTarget:self action:@selector(keyBoardChange) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:changeBtn];
    _changeBtn = changeBtn;
    
    UIView *inputBgV = [[UIView alloc] initWithFrame:CGRectMake(10, 5, CGRectGetMinX(changeBtn.frame)-10, self.height-10)];
    inputBgV.backgroundColor = [UIColor whiteColor];
    inputBgV.layer.masksToBounds = YES;
    inputBgV.layer.cornerRadius = inputBgV.frame.size.height/2.0;
    _inputBgView = inputBgV;
    [self addSubview:inputBgV];
    
    UITextView *textV = [[UITextView alloc]initWithFrame:CGRectMake(inputBgV.frame.size.height/2.0, 4, inputBgV.frame.size.width-inputBgV.frame.size.height, inputBgV.frame.size.height-10)];
    textV.backgroundColor = [UIColor clearColor];
    textV.bounces = NO;
    textV.font = [UIFont systemFontOfSize:15];
    textV.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    textV.returnKeyType = UIReturnKeySend;
    textV.textContainerInset = UIEdgeInsetsMake(10, 0, 0, 0);
    textV.delegate = self;
    [self addSubview:textV];
    _textV = textV;
}

- (void)keyBoardChange{
    if (_changeBtn.selected) {
        _textV.inputView = nil;
    }else{
        
        EmojiKeyboardView *emojiV = [[EmojiKeyboardView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, EmojiHeight+kSafeAreaBottom)];
        kWeakSelf(self);
        emojiV.clickHandle = ^(EmojiKeyboardForKeyType type, NSString *emoji) {
            switch (type) {
                case EmojiKeyboardForStr:
                {
                    [emoji changeTextForCostomEmojiAndBounds:CGRectMake(0, -2, 15, 15)];
                    [weakself.textV insertText:emoji];
                }
                    break;
                case EmojiKeyboardForDelete:
                {
                    if (weakself.textV.text.length>0) {
                        NSString *lastStr = [weakself.textV.text substringFromIndex:weakself.textV.text.length-1];
                        if ([lastStr isEqualToString:@"]"]) {
                            for (NSInteger j = weakself.textV.text.length; j>1; j--) {
                                //对应的字符串
                                NSString *correStr = [weakself.textV.text substringWithRange:NSMakeRange(j-2, 1)];
                                if ([correStr isEqualToString:@"["]) {
                                    weakself.textV.text = [weakself.textV.text substringToIndex:j-2];
                                    break;
                                }
                            }
                        }else{
                            [weakself.textV deleteBackward];
                        }
                    }else{
                        [weakself.textV deleteBackward];
                    }
                    
                }
                    break;
                case EmojiKeyboardForSend:
                {
                    if (weakself.sendBtnClickBlock) {
                        weakself.sendBtnClickBlock();
                    }
                }
                    break;
                default:
                    break;
            }
        };
        _textV.inputView = emojiV;
    }
    [_textV reloadInputViews];
    _changeBtn.selected = !_changeBtn.selected;
}


#pragma mark -UITextViewDelegate-
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        if (self.sendBtnClickBlock) {
            self.sendBtnClickBlock();
        }
    }
    if ([text isEqualToString:@""] && textView.text.length > 0) {
        NSString *lastStr = [textView.text substringFromIndex:textView.text.length-1];
        if ([lastStr isEqualToString:@"]"]) {
            for (NSInteger j = textView.text.length; j>1; j--) {
                //对应的字符串
                NSString *correStr = [textView.text substringWithRange:NSMakeRange(j-2, 1)];
                if ([correStr isEqualToString:@"["]) {
                    textView.text = [textView.text substringToIndex:j-2];
                    return NO;
                }
            }
        }
    }
    return YES;
}


@end




@interface ChatInputView ()


@property (nonatomic, strong)CInputSubView *inputView;  ///随键盘弹出收回

@property (nonatomic, copy)void (^sureText)(NSString * _Nullable);

@end

@implementation ChatInputView

- (void)dealloc
{
    [self removeView];
    [self removeNotification];
}

///显示输入框
+ (void)showInput:(NSString *)placeholder inputText:(void (^)(NSString * _Nullable))inputText{
    UIView *inputV = [PopupTool getPopupViewForClass:self];
    if (!inputV) {
        ChatInputView *inputV = [[ChatInputView alloc] init];
        [inputV createUI:placeholder];
        inputV.sureText = inputText;
    }
}



- (void)createUI:(NSString *)placeholder{
    kWeakSelf(self);
    [[PopupTool share] createPopupViewWithLinkView:self allowTapOutside:YES popupBgViewAction:@selector(removeInputView) popupBgViewTarget:self cover:NO];
    [self addNotification];
    self.inputView = [ChatInputView createChatView];
    self.inputView.sendBtnClickBlock = ^{
        [weakself sureInputText];
    };
    self.frame = CGRectMake(0, kScreenHeight, self.inputView.width, self.inputView.height);
    [self addSubview:self.inputView];
    self.inputView.textV.placeholder = placeholder;
    [self.inputView.textV becomeFirstResponder];
}

///删除UI
- (void)removeInputView{
    [self.inputView.textV resignFirstResponder];
}

///动画结束后销毁
- (void)removeView{
    [self removeNotification];
    [[PopupTool share] closePopupView:self];
    _inputView = nil;
}

///输入框UI
+ (CInputSubView *)createChatView{
    CInputSubView *chatInputView = [[CInputSubView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    chatInputView.backgroundColor = kRGB_COLOR(@"#eeeeee");
    return chatInputView;
}


///确认输入信息
- (void)sureInputText{
    NSString *inputText = _inputView.textV.text;
    if (inputText.length == 0) {
        return;
    }
    if (self.sureText) {
        self.sureText(inputText);
    }
    _inputView.textV.text = @"";
    [self.inputView.textV resignFirstResponder];
    [self removeInputView];
}


- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


- (void)keyBoardWillShow:(NSNotification *)notify{
    UIView *superV = [UIApplication sharedApplication].keyWindow;
    if (kiOS13) {
        superV = [UIApplication sharedApplication].windows.firstObject;
    }
    NSTimeInterval time = [notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect endRc = [notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    kWeakSelf(self);
    if (endRc.size.height == EmojiHeight) {
        time = 0;
    }
    [UIView animateWithDuration:time animations:^{
        CGRect selfRc = weakself.frame;
        selfRc.origin.y = endRc.origin.y-selfRc.size.height;
        weakself.frame = selfRc;
    } completion:^(BOOL finished) {
    }];
}


- (void)keyBoardWillHide:(NSNotification *)notify{
    NSTimeInterval time = [notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect endRc = [notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    kWeakSelf(self);
    [UIView animateWithDuration:time animations:^{
        CGRect chatFrame = weakself.frame;
        chatFrame.origin = endRc.origin;
        weakself.frame = chatFrame;
    } completion:^(BOOL finished) {
        weakself.hidden = YES;
        [weakself removeView];
    }];
    
}


+ (UIView *)getInputViewWithPlaceholder:(NSString *)placeholder{
    CInputSubView *InputSubView = [ChatInputView createChatView];
    InputSubView.inputView.userInteractionEnabled = NO;
    InputSubView.changeBtn.userInteractionEnabled = NO;
    InputSubView.sendBtnClickBlock = nil;
    InputSubView.textV.userInteractionEnabled = NO;
    InputSubView.textV.placeholder = placeholder;
    return InputSubView;
}



@end
