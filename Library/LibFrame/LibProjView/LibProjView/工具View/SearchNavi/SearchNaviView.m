//
//  SearchNaviView.m
//  TCDemo
//
//  Created by admin on 2019/10/25.
//  Copyright © 2019 CH. All rights reserved.
//

#import "SearchNaviView.h"

@interface SearchNaviView ()<UITextFieldDelegate>

@property (nonatomic, weak)UITextField *textF;

@end

@implementation SearchNaviView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationUserLogout object:nil];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = self.frame.size.height/2.0;
        [self createUI];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textValueChange) name:UITextFieldTextDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogoutNotify) name:NotificationUserLogout object:nil];
    }
    return self;
}

- (void)textValueChange{
    if (_textF.text.length > 0 && self.searchText) {
        self.searchText(_textF.text);
    }
}

- (void)setSearchPlaceholder:(NSString *)searchPlaceholder{
    _searchPlaceholder = searchPlaceholder;
    _textF.placeholder = searchPlaceholder;
}

- (void)createUI{

    UIImageView *searchImgV = [[UIImageView alloc] initWithFrame:CGRectMake(8, 3, self.frame.size.height-8, self.frame.size.height-8)];
    searchImgV.image = [UIImage imageNamed:@"live_PK_list_searchBar"];
    [self addSubview:searchImgV];
    
    UITextField *textF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(searchImgV.frame)+5, 2.5, self.frame.size.width-CGRectGetMaxX(searchImgV.frame)-10, self.frame.size.height-5)];
    textF.font = [UIFont systemFontOfSize:15];
    textF.tintColor = [UIColor lightGrayColor];
    textF.returnKeyType = UIReturnKeySearch;
    textF.delegate = self;
    textF.placeholder = kLocalizationMsg(@"请输入您要搜索的昵称或ID");
    textF.clearButtonMode = UITextFieldViewModeAlways;
    [self addSubview:textF];
    _textF = textF;
}

- (void)userLogoutNotify{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationUserLogout object:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    
    if (self.searchText) {
        self.searchText(textField.text);
    }
    
    return YES;
}

@end
