//
//  ForceAlertController.m
//  TCDemo
//
//  Created by admin on 2019/10/24.
//  Copyright © 2019 CH. All rights reserved.
//

#import "ForceAlertController.h"
#import <Masonry/Masonry.h>

@interface ForceAlertController ()

@property (nonatomic, copy)NSString *itemTitle;
@property (nonatomic, copy)NSString *message;
@property (nonatomic, weak)UIView *weakBgV;
@property (nonatomic, copy)NSArray *optionArr;

@end

@implementation ForceAlertController

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    _weakBgV.layer.masksToBounds = YES;
    _weakBgV.layer.cornerRadius = 10.0;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}

+ (id)alertTitle:(NSString *)title message:(NSString *)message{
    ForceAlertController *alertVC = [[ForceAlertController alloc] init];
    alertVC.itemTitle = title;
    alertVC.message  = message;
    return  alertVC;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    if (_textFields.count) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];

}

#pragma mark -- 点击事件
- (void)bgViewClick{
    [self.view endEditing:YES];
}

- (void)optionBtnClick:(UIButton *)btn{
    if (btn.tag - 9009 <self.optionArr.count) {
        void (^handle)(void) = self.optionArr[btn.tag - 9009][@"handle"];
        if (handle) {
            handle();
        }
        [self dismissViewControllerAnimated:YES completion:nil];
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
        CGRect rc = weakself.weakBgV.frame;
        rc.origin.y = keyboardRect.origin.y - rc.size.height-20;
        weakself.weakBgV.frame = rc;
    }];
    
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{   NSTimeInterval time = [aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:time animations:^{
        weakself.weakBgV.center = weakself.view.center;
    }];
}


- (void)createUI{
    __weak typeof(self) weakself = self;
    UIControl *bgView = [[UIControl alloc] init];
    bgView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.98];
    [self.view addSubview:bgView];
    _weakBgV = bgView;
    [bgView addTarget:self action:@selector(bgViewClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleL = [[UILabel alloc] init];
    [bgView addSubview:titleL];
    if (_itemTitle.length) {
        titleL.text = _itemTitle;
        titleL.numberOfLines = 0;
        titleL.textAlignment = NSTextAlignmentCenter;
        titleL.font= [UIFont boldSystemFontOfSize:15];
        titleL.textColor = [UIColor blackColor];
    }
    UILabel *messageL = [[UILabel alloc] init];
    [bgView addSubview:messageL];
    if (_message.length) {
        messageL.text = _message;
        messageL.numberOfLines = 0;
        messageL.textAlignment = NSTextAlignmentCenter;
        messageL.font= [UIFont systemFontOfSize:13];
        messageL.textColor = [UIColor blackColor];
    }
    ///textF的背景View
    UIView *textFBgView = [[UIView alloc] init];
    [bgView addSubview:textFBgView];
    
    ///按钮背景
    UIView *content = [[UIView alloc] init];
    [bgView addSubview:content];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [content addSubview:line];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
    }];
    
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).mas_offset(20);
        make.left.equalTo(bgView).mas_offset(20);
        make.right.equalTo(bgView).mas_offset(-20);
        make.bottom.equalTo(messageL.mas_top).mas_offset(-10);
        make.width.lessThanOrEqualTo(@(self.view.frame.size.width-80));
    }];
    
    [messageL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).mas_offset(20);
        make.right.equalTo(bgView).mas_offset(-20);
        make.bottom.equalTo(textFBgView.mas_top).mas_offset(-10);
        make.width.lessThanOrEqualTo(@(self.view.frame.size.width-80));
    }];
    
    [textFBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bgView);
        make.height.mas_equalTo(weakself.textFields.count*35);
        make.bottom.equalTo(content.mas_top).mas_offset(-10);
    }];
    
    CGFloat maxWidth = 220.0;
    switch (_optionArr.count) {
        case 0:
        {
            maxWidth = 220.0;
        }
            break;
        case 1:
        {
            maxWidth = 240.0;
        }
            break;
        case 2:
        {
            maxWidth = 260.0;
        }
            break;
        case 3:
        {
            maxWidth = 280.0;
        }
            break;
        case 5:
        {
            maxWidth = 300.0;
        }
            break;
        default:
        {
            maxWidth = self.view.frame.size.width-80.0;
        }
            break;
    }
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(bgView);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(maxWidth);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.top.left.right.equalTo(content);
    }];
    
    [content layoutIfNeeded];
    
    if (_textFields.count) {
        for (int i = 0; i<_textFields.count; i++) {
            UITextField *textF = _textFields[i];
            textF.frame = CGRectMake(30, i*35, maxWidth-60, 30);
            textF.layer.masksToBounds = YES;
            textF.layer.cornerRadius = 4.0;
            textF.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
            textF.layer.borderWidth = 0.6;
            [textFBgView addSubview:textF];
        }
    }
    
    if (_optionArr.count) {
        CGFloat btnW = maxWidth/_optionArr.count;
        for (int i = 0; i<_optionArr.count; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*btnW, 0, btnW, content.frame.size.height)];
            [btn setTitle:_optionArr[i][@"title"] forState:UIControlStateNormal];
            [btn setTitleColor:_optionArr[i][@"titleColor"]?_optionArr[i][@"titleColor"]:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            btn.tag = i+9009;
            [content addSubview:btn];
            if (i) {
                UIView *btnLine = [[UIView alloc] initWithFrame:CGRectMake(0, -0.5, 1, btn.frame.size.height)];
                btnLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
                [btn addSubview:btnLine];
            }
            
            [btn addTarget:self action:@selector(optionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField * _Nonnull))configurationHandler{

    UITextField *textF = [[UITextField alloc] init];
    textF.backgroundColor = [UIColor whiteColor];
    textF.font = [UIFont systemFontOfSize:14];
    textF.textAlignment = NSTextAlignmentCenter;

    __weak typeof(UITextField *) weaktextF = textF;
    if (configurationHandler) {
        configurationHandler(weaktextF);
    }
    NSMutableArray *muArr = [[NSMutableArray alloc] initWithCapacity:1];
    if (_textFields.count) {
        [muArr addObjectsFromArray:_textFields];
    }
    [muArr addObject:textF];
    _textFields = [NSArray arrayWithArray:muArr];
}

- (void)addOptions:(NSString *)option textColor:(UIColor *)color clickHandle:(void (^)(void))handle{
    
    NSMutableDictionary *item = [[NSMutableDictionary alloc] initWithCapacity:1];
    [item setObject:option forKey:@"title"];
    if (color) {
        [item setObject:color forKey:@"titleColor"];
    }
    if (handle) {
        [item setObject:handle forKey:@"handle"];
    }
    NSMutableArray *muArr = [[NSMutableArray alloc] initWithCapacity:1];
    if (_optionArr.count) {
        [muArr addObjectsFromArray:_optionArr];
    }
    [muArr addObject:item];
    _optionArr = [NSArray arrayWithArray:muArr];
    
}


- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    
    [self.view endEditing:YES];
    
    if (!_force) {
        if (_textFields.count) {
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        }
        [super dismissViewControllerAnimated:flag completion:completion];
        _textFields  = nil;
        _optionArr = nil;
    }
    
}

@end
