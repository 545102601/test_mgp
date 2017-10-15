//
//  MGHomeSearchBarView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/13.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGHomeSearchBarView.h"

@interface MGHomeSearchBarView () <UITextFieldDelegate>
/// 背景
@property (nonatomic, strong) UIView *bgView;
/// 搜索输入框
@property (nonatomic, strong) UITextField *searchTextField;
/// 搜索按钮
@property (nonatomic, strong) UIButton *searchButton;

@end

@implementation MGHomeSearchBarView

- (void)prepareFrameViewUI:(CGRect)frame {

    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    _bgView.layer.cornerRadius = 5;
    _bgView.backgroundColor = [UIColor whiteColor];
//    [_bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewTap)]];
    
    _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchButton.frame = CGRectMake(frame.size.width - SW(20) - SW(44), 0, SW(44), SW(44));
    [_searchButton setImage:[UIImage imageNamed:@"home_sousuo"] forState:UIControlStateNormal];
    _searchButton.centerY = _bgView.centerY;
    [_searchButton addTarget:self action:@selector(searchButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _searchTextField = [MGUITool textFieldWithTextColor:MGThemeColor_subTitle_Black font:PFSC(21) placeText:@"输入您需要的工作包或导师" placeColor:MGThemeColor_subTitle_Black placeFont:PFSC(21)];
    _searchTextField.delegate = self;
    _searchTextField.returnKeyType = UIReturnKeySearch;
    _searchTextField.frame = CGRectMake(SW(20), 0, _searchButton.left - SW(20) - SW(20), SW(44));
    _searchTextField.centerY = _bgView.centerY + SH(2);
    
    
    [_bgView sd_addSubviews:@[_searchButton, _searchTextField]];

    [self addSubview:_bgView];
}
/// 
- (void)bgViewTap {
    if (_searchBarViewTapBlock) {
        _searchBarViewTapBlock();
    }
    
}

- (void)searchButtonOnClick {
    NSString *text = [_searchTextField.text removeBlank];
    if (text.length > 0) {
        [self endEditing:YES];
        if (_searchEventBlock) {
            _searchEventBlock(_searchTextField.text);
        }
    }
    
}
- (void)setSearchText:(NSString *)searchText {
    _searchText = searchText;
    
    self.searchTextField.text = searchText;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *text = [_searchTextField.text removeBlank];
    if (text.length ==  0) {
        return NO;
    }
    [self searchButtonOnClick];
    
    return YES;
}

@end
