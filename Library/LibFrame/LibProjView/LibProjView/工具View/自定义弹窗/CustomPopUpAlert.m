//
//  CustomPopUpAlert.m
//  LibProjView
//
//  Created by klc on 2020/4/1.
//  Copyright © 2020 . All rights reserved.
//

#import "CustomPopUpAlert.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <LibProjModel/KLCAppConfig.h>
#define FontWidthScale   ((CGFloat)((kScreenWidth < kScreenHeight ? kScreenWidth :kScreenHeight) / 375.0))
@interface CustomPopUpAlert ()<UITextFieldDelegate>
@property (nonatomic, copy)NSString *itemTitle;
@property (nonatomic, copy)NSString *message;

@property (strong, nonatomic)  UIView *contentView;
@property (strong, nonatomic)  UILabel *titleLabel;
@property (strong, nonatomic)  UILabel *decLabel;
@property (strong, nonatomic)  UIButton *sureBtn;
@property (strong, nonatomic)  UIButton *closeBtn;
@property (strong, nonatomic)  UIButton *cancelBtn;
@property (strong, nonatomic) UITextField *passwordField;

@property (nonatomic,assign)LiveRoomType liveType;

@property (strong, nonatomic)NSMutableArray *labelArray;
@property (nonatomic, assign) BOOL secureTextEntry;//是否是密码类型，默认YES
@property (nonatomic,strong)NSString *contentString;

@end

@implementation CustomPopUpAlert

- (void)dealloc{
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}

+ (id)alertTitle:(NSString *)title message:(NSString *)message liveType:(LiveRoomType)liveType{
    
    CustomPopUpAlert *alertVC = [[CustomPopUpAlert alloc] init];
    alertVC.itemTitle = title;
    alertVC.message  = message;
    alertVC.liveType = liveType;
    return  alertVC;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    
    if (self.liveType == LiveTypeForPassword) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    
}

#pragma mark -- 点击事件

- (void)bgViewClick{
    if (self.clickCancelBlock) {
        self.clickCancelBlock();
    }
    [self KeyboardRecovery];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)createUI{
    
    UIControl *bgView = [[UIControl alloc] initWithFrame:self.view.frame];
    //       bgView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.98];
    [self.view addSubview:bgView];
    
    [bgView addTarget:self action:@selector(bgViewClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(40, [[UIScreen mainScreen] bounds].size.height/2 - 90, [[UIScreen mainScreen] bounds].size.width - 80, 180)];
    self.contentView.layer.cornerRadius = 8;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.contents = (id)[UIImage imageNamed:@"live_tanchuang_bg"].CGImage;
    self.contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];;
    [bgView addSubview:self.contentView];
    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20,  [[UIScreen mainScreen] bounds].size.width - 80 - 30,  20)];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment  = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.text = self.itemTitle;
    self.titleLabel.numberOfLines = 0;
    [self.contentView addSubview:self.titleLabel];
    
    self.decLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 50,  [[UIScreen mainScreen] bounds].size.width - 80 - 30, self.contentView.height - 80 - 40)];
    self.decLabel.textColor = [UIColor whiteColor];
    self.decLabel.textAlignment  = NSTextAlignmentCenter;
    self.decLabel.font = [UIFont systemFontOfSize:14];
    self.decLabel.numberOfLines = 1;
    [self.contentView addSubview:self.decLabel];
    
    
    self.sureBtn  = [[UIButton alloc] initWithFrame:CGRectMake(70, self.contentView.height - 60,  [[UIScreen mainScreen] bounds].size.width - 80 - 140, 40)];
    self.sureBtn.backgroundColor = [UIColor whiteColor];
    [self.sureBtn setTitle:kLocalizationMsg(@"我要去看看") forState:UIControlStateNormal];
    self.sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.sureBtn setTitleColor:kRGB(216, 56, 202) forState:UIControlStateNormal];
    self.sureBtn.layer.cornerRadius = 20;
    self.sureBtn.layer.masksToBounds = YES;
    [self.sureBtn addTarget:self action:@selector(clickSureBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.sureBtn];
    
    self.closeBtn = [[UIButton alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - 90, CGRectGetMinY(self.contentView.frame) - 60,  80, 80)];
    [self.closeBtn setImage:[UIImage imageNamed:@"live_guanbi"] forState:UIControlStateNormal];
    [bgView addSubview:self.closeBtn];
    [self.closeBtn addTarget:self action:@selector(clickCloseBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.cancelBtn  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,  0, 0)];
    self.cancelBtn.backgroundColor = [UIColor whiteColor];
    [self.cancelBtn setTitle:kLocalizationMsg(@"取消") forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.cancelBtn setTitleColor:kRGB(216, 56, 202) forState:UIControlStateNormal];
    self.cancelBtn.layer.cornerRadius = 20;
    self.cancelBtn.layer.masksToBounds = YES;
    [self.cancelBtn addTarget:self action:@selector(clickCloseBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.cancelBtn];
    self.cancelBtn.hidden = YES;
    
    
    [self AssignDifferentValues];
}

-(void)AssignDifferentValues{
    switch (self.liveType) {
        case LiveTypeForTicket:
            [self LiveTypeForTicketStyle];
            break;
        case LiveTypeForTime:
            [self LiveTypeForTimeStyle];
            break;
        case LiveTypeForPassword:
            [self LiveTypeForPasswordStyle];
            break;
        case LiveTypeForNoble:
            [self LiveTypeForNobleStyle];
            break;
        case LiveTypeForPasswordOther:
            [self LiveTypeForPasswordOtherStyle];
            break;
        case LiveTypeForBalanceInsufficient:
            [self LiveTypeForBalanceInsufficientStyle];
            break;
        case LiveTypeForAnchorAndAnchor:
            [self LiveTypeForAnchorAndAnchorStyle];
        case LiveTypeForCommon:
            [self LiveTypeForCommonStyle];
            break;
        default:
            break;
    }
}



-(void)LiveTypeForTicketStyle{
    self.contentView.layer.contents = (id)[UIImage imageNamed:@"live_tanchuang_bg"].CGImage;
    self.decLabel.text = [NSString stringWithFormat:kLocalizationMsg(@"%@ %@/张"),self.message, KLCAppConfig.unitStr];
    [self updataUI:self.decLabel.text];
}


-(void)LiveTypeForTimeStyle{
    self.contentView.layer.contents = (id)[UIImage imageNamed:@"live_tanchuang_bg"].CGImage;
    self.decLabel.text = [NSString stringWithFormat:kLocalizationMsg(@"%@ %@/分钟"),self.message,KLCAppConfig.unitStr];
    [self updataUI:self.decLabel.text];
}

-(void)LiveTypeForPasswordStyle{
    self.contentView.layer.contents = (id)[UIImage imageNamed:@"live_tanchuang_bg"].CGImage;
    [self modifyStyle];
}


-(void)LiveTypeForNobleStyle{
    self.contentView.layer.contents = (id)[UIImage imageNamed:@"live_tanchuang_bg"].CGImage;
    self.decLabel.text = kLocalizationMsg(@"仅贵族能进入该房间");
    [self.sureBtn setTitle:kLocalizationMsg(@"去开通贵族") forState:UIControlStateNormal];
    
}

-(void)LiveTypeForPasswordOtherStyle{
    self.contentView.layer.contents = (id)[UIImage imageNamed:@"live_tanchuang_bg"].CGImage;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEditChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    [self modifyStyleForSix];
}

-(void)LiveTypeForBalanceInsufficientStyle{
    self.titleLabel.text = @"";
    self.decLabel.text = self.message;
    self.decLabel.frame = CGRectMake(15, 40,  [[UIScreen mainScreen] bounds].size.width - 80 - 30, self.contentView.height - 80 - 40);
    self.contentView.layer.contents = (id)[UIImage imageNamed:@"live_tips_tanchuang"].CGImage;
    [self.sureBtn setTitle:kLocalizationMsg(@"立即充值") forState:UIControlStateNormal];
    [self.sureBtn setTitleColor: kRGB_COLOR(@"#7851DF") forState:UIControlStateNormal];
}

-(void)LiveTypeForAnchorAndAnchorStyle{
    self.titleLabel.text = self.itemTitle;
    self.titleLabel.frame = CGRectMake(15, 50,  [[UIScreen mainScreen] bounds].size.width - 80 - 30,  20);
    self.decLabel.text = self.message;
    //    self.decLabel.numberOfLines = 2;
    self.decLabel.frame = CGRectMake(15, 70,  [[UIScreen mainScreen] bounds].size.width - 80 - 30, self.contentView.height - 80 - 70);
    self.contentView.layer.contents = (id)[UIImage imageNamed:@"live_tips_tanchuang"].CGImage;
    [self.sureBtn setTitle:kLocalizationMsg(@"继续通话") forState:UIControlStateNormal];
    self.cancelBtn.hidden = NO;
    
    self.cancelBtn.frame = CGRectMake(30, self.contentView.height - 60,  ([[UIScreen mainScreen] bounds].size.width - 80 - 90)/2, 40);
    
    self.sureBtn.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width - 80 - 90)/2 +60, self.contentView.height - 60,  ([[UIScreen mainScreen] bounds].size.width - 80 - 90)/2, 40);
    
    [self.sureBtn setTitleColor: kRGB_COLOR(@"#7851DF") forState:UIControlStateNormal];
    
    [self.cancelBtn setTitleColor: kRGB_COLOR(@"#7851DF") forState:UIControlStateNormal];
    
}


-(void)LiveTypeForCommonStyle{
    self.titleLabel.textColor = kRGB_COLOR(@"#444444");
    self.decLabel.textColor = kRGB_COLOR(@"#444444");
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.decLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.text = self.itemTitle;
    self.titleLabel.frame = CGRectMake(15, 40,  [[UIScreen mainScreen] bounds].size.width - 80 - 30,  20);
    self.decLabel.text = self.message;
    self.decLabel.frame = CGRectMake(15, 65,  [[UIScreen mainScreen] bounds].size.width - 80 - 30, self.contentView.height - 80 - 70);
    self.closeBtn.hidden  = YES;
    self.contentView.layer.contents = (id)[kRGB_COLOR(@"#ffffff") imageWithColor].CGImage;
    [self.sureBtn setTitle:kLocalizationMsg(@"我知道了") forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.sureBtn.backgroundColor = [ProjConfig normalColors];
}


-(void)updataUI:(NSString *)textStr{
    
    CGFloat widthContentView = [textStr widthWithFont:[UIFont systemFontOfSize:14] constrainedToHeight:self.contentView.height - 80 - 40];
    
    self.decLabel.frame = CGRectMake((self.contentView.width - widthContentView - 50)/2 , 60,  widthContentView + 50, self.contentView.height - 80 - 60);
    
    self.decLabel.layer.cornerRadius = self.decLabel.height/2;
    self.decLabel.layer.masksToBounds = YES;
    self.decLabel.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
}


// 密码房间1样式
-(void)modifyStyle{
    
    self.decLabel.hidden = YES;
    
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(80, 60,  [[UIScreen mainScreen] bounds].size.width - 80 - 160, self.contentView.height - 80 - 60)];
    self.passwordField.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
    self.passwordField.textAlignment = NSTextAlignmentCenter;
    self.passwordField.layer.cornerRadius = self.passwordField.height/2;
    self.passwordField.layer.masksToBounds = YES;
    self.passwordField.keyboardType = UIKeyboardTypeNumberPad;
    self.passwordField.font = [UIFont systemFontOfSize:14];
    self.passwordField.textColor = [UIColor whiteColor];
    self.passwordField.placeholder = kLocalizationMsg(@"请输入密码");
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:kLocalizationMsg(@"请输入密码") attributes:
                                      @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                        NSFontAttributeName:self.passwordField.font}];
    self.passwordField.attributedPlaceholder = attrString;
    self.passwordField.delegate = self;
    self.passwordField.returnKeyType = UIReturnKeyDone;
    [self.contentView addSubview:self.passwordField];
    
}


// 密码房间2样式(6格)
-(void)modifyStyleForSix{
    [self.sureBtn setTitle:kLocalizationMsg(@"请输入房间密码") forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
    self.sureBtn.backgroundColor = [UIColor clearColor];
    self.sureBtn.enabled = NO;
    self.decLabel.hidden = YES;
    self.secureTextEntry = YES;
    
    CGFloat labelWidth = 34 * (FontWidthScale>1?:1);
    CGFloat spaceMargin = (self.contentView.size.width - 80 - labelWidth*6)/5.0;
    
    for (int i = 0; i < 6; i ++){
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(40 + labelWidth *i + spaceMargin * i , 60, labelWidth, self.contentView.height - 80 - 60)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        label.layer.cornerRadius = 5;
        label.layer.masksToBounds = YES;
        label.backgroundColor = [UIColor whiteColor];
        
        UIView *keyLineView = [[UIView alloc]init];
        keyLineView.backgroundColor = [UIColor orangeColor];
        keyLineView.tag = 1006;
        keyLineView.hidden = YES;
        [label addSubview:keyLineView];
        [keyLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(8);
            make.bottom.mas_equalTo(-8);
            make.width.equalTo(@1.5);
        }];
        
        if(self.secureTextEntry){
            label.font = [UIFont systemFontOfSize:13];
        }else{
            label.font = [UIFont systemFontOfSize:19];
        }
        [self.contentView addSubview:label];
        [self.labelArray addObject:label];
    }
    self.passwordField = [[UITextField alloc]initWithFrame:CGRectMake(40, 60, self.contentView.frame.size.width - 80, self.contentView.height - 80 - 60)];
    self.passwordField.delegate = self;
    self.passwordField.keyboardType = UIKeyboardTypeNumberPad;
    self.passwordField.tintColor = [UIColor clearColor];
    self.passwordField.font = [UIFont systemFontOfSize:0];
    [self.contentView addSubview:self.passwordField];
    
}

-(void)textViewEditChanged:(NSNotification *)notification{
    
    UITextField *textField = (UITextField *)notification.object;
    if(textField == self.passwordField){
        
        NSUInteger maxLength = 6;
        NSString *contentText = textField.text;
        
        UITextRange *selectedRange = [textField markedTextRange];
        NSInteger markedTextLength = [textField offsetFromPosition:selectedRange.start toPosition:selectedRange.end];
        if (markedTextLength == 0) {
            if (contentText.length > maxLength) {
                NSRange rangeRange = [contentText rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
                textField.text = [contentText substringWithRange:rangeRange];
            }
        }
        
        
        NSString *textYZMStr = textField.text;
        NSInteger wordIndex = textYZMStr.length-1;
        
        //清空光标；
        for(NSInteger i = 0; i<self.labelArray.count; i++){
            UILabel *label = self.labelArray[i];
            UIView *keyLine = [label viewWithTag:1006];
            keyLine.hidden = YES;
        }
        
        if(wordIndex>=0){
            NSString *lastWord = [textYZMStr substringFromIndex:textYZMStr.length -1];
            UILabel *label = self.labelArray[wordIndex];
            label.text = self.secureTextEntry?@"●":lastWord;
            if(self.secureTextEntry){
                label.font = [UIFont systemFontOfSize:13];
            }else{
                label.font = [UIFont systemFontOfSize:19];
            }
            
            
            //显示下一个光标；
            if(wordIndex+1< self.labelArray.count){
                UILabel *afterLabel = self.labelArray[wordIndex+1];
                UIView *keyLine = [afterLabel viewWithTag:1006];
                keyLine.hidden = NO;
            }
            
            //清空之后的数据；
            for (NSInteger index = wordIndex+1; index < self.labelArray.count; index ++) {
                UILabel *afterFindLabel = self.labelArray[index];
                afterFindLabel.text = @"";
            }
            
        }else{
            
            //全部清空label显示数据；
            for(NSInteger i = 0; i<self.labelArray.count; i++){
                UILabel *label = self.labelArray[i];
                label.text = @"";
            }
            
            UILabel *firstLabel = self.labelArray[0];
            UIView *keyLine = [firstLabel viewWithTag:1006];
            keyLine.hidden = NO;
        }
        
        //输入满6位 回调；
        if (wordIndex == 5) {
            if (self.clickSureBlock) {
                self.clickSureBlock(self.contentString);
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            [self KeyboardRecovery];
        }
        
        
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    NSInteger totalCount = self.labelArray.count;
    NSInteger findKeyLineIndex = -1; //默认光标显示在第一个
    for (NSInteger i = totalCount-1; i>=0; i--) {
        UILabel *label = self.labelArray[i];
        if(label.text.length){
            findKeyLineIndex = i; //找到最后一个数字位置；
            break;
        }
    }
    
    findKeyLineIndex++; //后一个位置显示光标
    
    if(findKeyLineIndex< self.labelArray.count){
        UILabel *findKeyLabel = self.labelArray[findKeyLineIndex];
        UIView *keyLine = [findKeyLabel viewWithTag:1006];
        keyLine.hidden = NO;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //结束时需隐藏自定义光标 : 清空光标
    for(NSInteger i = 0; i<self.labelArray.count; i++){
        UILabel *label = self.labelArray[i];
        UIView *keyLine = [label viewWithTag:1006];
        keyLine.hidden = YES;
    }
}




-(void)clickSureBtn{
    
    NSString *passwordStr = @"";
    if (self.liveType == LiveTypeForPassword) {
        passwordStr = self.passwordField.text;
    }
    
    if (self.clickSureBlock) {
        self.clickSureBlock(passwordStr);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    [self KeyboardRecovery];
    
}

-(void)clickCloseBtn{
    if (self.clickCancelBlock) {
        self.clickCancelBlock();
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    [self KeyboardRecovery];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
    
}

-(void)KeyboardRecovery{
    if (self.liveType == LiveTypeForPassword) {
        [self.passwordField resignFirstResponder];
    }
}



#pragma mark -- 获取键盘高度
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSTimeInterval time = [aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardRect = [[aNotification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:time animations:^{
        CGRect rc = weakself.contentView.frame;
        rc.origin.y = keyboardRect.origin.y - rc.size.height-20;
        weakself.contentView.frame = rc;
        weakself.closeBtn.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - 90, CGRectGetMinY(self.contentView.frame) - 60,  80, 80);
    }];
    
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{   NSTimeInterval time = [aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:time animations:^{
        weakself.contentView.center = weakself.view.center;
        weakself.closeBtn.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - 90, CGRectGetMinY(self.contentView.frame) - 60,  80, 80);
    }];
}


-(NSMutableArray *)labelArray{
    if (!_labelArray) {
        _labelArray = [NSMutableArray array];
    }
    return _labelArray;
}

-(NSString *)contentString{
    
    if(self.secureTextEntry){
        
        return self.passwordField.text;
    }else{
        NSString *string = @"";
        for (UILabel *label in self.labelArray){
            string = [NSString stringWithFormat:@"%@%@",string,label.text];
        }
        return string;
    }
}

///余额不足弹框 + 去充值弹框
+ (void)showLiveTypeForBalanceInsufficient{
    CustomPopUpAlert *customAlert = [CustomPopUpAlert alertTitle:@"" message:kLocalizationMsg(@"您的余额不足，先去充值吧！") liveType:LiveTypeForBalanceInsufficient];
    customAlert.clickCancelBlock = ^{
        
    };
    customAlert.clickSureBlock = ^(NSString * _Nonnull passwordStr) {
        [RouteManager routeForName:RN_center_myAccountAC currentC:[ProjConfig currentVC]];
    };
    [[ProjConfig currentVC] presentViewController:customAlert animated:YES completion:nil];
}

//获取当前控制器
-(UIViewController *)getCurrentVC{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
}

@end
