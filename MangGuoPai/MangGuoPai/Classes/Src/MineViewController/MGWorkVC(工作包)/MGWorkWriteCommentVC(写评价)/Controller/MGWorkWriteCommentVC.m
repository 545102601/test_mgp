//
//  MGWorkWriteCommentVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/15.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkWriteCommentVC.h"
#import "TDSelectListDataView.h"
#import "UITextView+Placeholder.h"

@interface MGWorkWriteCommentVC () <UITextViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *tutorTipLabel;

@property (nonatomic, strong) UILabel *tutorLabel;

@property (nonatomic, strong) UIView *centerLineView;

@property (nonatomic, strong) UILabel *companyTipLabel;

@property (nonatomic, strong) UILabel *scoreTipLabel;

@property (nonatomic, strong) UILabel *scoreNoticeLabel;

@property (nonatomic, strong) UIView *scoreNoticeLineView;

@property (nonatomic, strong) TDSelectListDataView *scoreDataView;

@property (nonatomic, strong) UILabel *commentTipLabel;

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UILabel *inputTipLabel;

@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation MGWorkWriteCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"评价";
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 初始化控件
- (void)setupSubViews {
    
    WEAK
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    BOOL showTutorContent = self.actorModel.tutor_comments.length == 0 ? YES : NO;
    
    _tutorTipLabel = [MGUITool labelWithText:@"导师点评 : " textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _tutorTipLabel.hidden = showTutorContent;
    _tutorTipLabel.frame = CGRectMake(SW(30), SH(30), SW(200), _tutorTipLabel.fontLineHeight);
    _tutorLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _tutorLabel.hidden = showTutorContent;
    
    _tutorLabel.frame = CGRectMake(SW(30), _tutorTipLabel.bottom + SH(20), kScreenWidth - SW(60), _tutorTipLabel.fontLineHeight);
    
    _centerLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), _tutorLabel.bottom, kScreenWidth - SW(48), MGSepLineHeight)];
    _centerLineView.backgroundColor = MGSepColor;
    _centerLineView.hidden = showTutorContent;
    
    CGFloat marginTutorTop = SH(30);
    
    if (!_tutorLabel.hidden) {
        _tutorLabel.attributedText = self.actorModel.tutor_comments_attr;
        _tutorLabel.height = self.actorModel.tutor_comments_height;
        _centerLineView.top = _tutorLabel.bottom;
        marginTutorTop = _centerLineView.bottom;
    }
    
    _companyTipLabel = [MGUITool labelWithText:@"企业点评 : " textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _companyTipLabel.frame = CGRectMake(SW(30), marginTutorTop + SH(30), SW(200), _companyTipLabel.fontLineHeight);
    
    _scoreTipLabel = [MGUITool labelWithText:@"作品得分 : " textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _scoreTipLabel.frame = CGRectMake(SW(30), _companyTipLabel.bottom + SH(30), SW(200), _scoreTipLabel.fontLineHeight);
    
    
    _scoreDataView = [[TDSelectListDataView alloc] initWithFrame:CGRectMake(_scoreTipLabel.right + SW(10), 0, SW(170), SH(50))];
    _scoreDataView.centerY = _scoreTipLabel.centerY;
    _scoreDataView.didSelectListDataViewContentViewRow = ^(NSInteger row) {
        STRONG
        TDSelectListDataViewContentModel *contentModel = self.scoreDataView.dataArray[row];
        [self.scoreDataView setTitleLabelWithTitle:contentModel.name];
    };
    
    _scoreNoticeLabel = [MGUITool labelWithText:@"注意 : 评分作为名次的评价标准，但不会公开显示出来" textColor:MGThemeColor_Red font:PFSC(28)];
    _scoreNoticeLabel.frame = CGRectMake(SW(30), _scoreTipLabel.bottom + SH(44), kScreenWidth - SW(60), _scoreNoticeLabel.fontLineHeight);
    
    _scoreNoticeLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), _scoreNoticeLabel.bottom + SH(36), kScreenWidth - SW(48), MGSepLineHeight)];
    _scoreNoticeLineView.backgroundColor = MGSepColor;
    
    
    _commentTipLabel = [MGUITool labelWithText:@"点评内容 : " textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _commentTipLabel.frame = CGRectMake(SW(30), _scoreNoticeLineView.bottom + SH(30), kScreenWidth - SW(60), _commentTipLabel.fontLineHeight);
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(SW(24), _commentTipLabel.bottom + SH(30), kScreenWidth - SW(48), SH(300))];
    _textView.font = PFSC(28);
    _textView.placeholder = @"请企业代表从[产品理解程度]、[专业能力]、[创新能力]、[市场应用性]四个维度展开考量，最后填入综合分数";
    _textView.textContainerInset = UIEdgeInsetsMake(SW(20), SW(14), SW(20), SW(14));
    _textView.layer.borderColor = MGSepColor.CGColor;
    _textView.layer.borderWidth = MGSepLineHeight;
    _textView.clipsToBounds = YES;
    _textView.layer.cornerRadius = 5;
    _textView.textColor = MGThemeColor_Common_Black;
    _textView.delegate = self;
    
    _inputTipLabel = [MGUITool labelWithText:@"您还可以写100字" textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _inputTipLabel.frame = CGRectMake(SW(30), _textView.bottom + SH(30), kScreenWidth - SW(60), _inputTipLabel.fontLineHeight);
    
    
    
    
    _submitButton = [MGUITool buttonWithBGColor:nil title:@"提交" titleColor:MGThemeColor_Title_Black font:MGThemeFont_28 target:self selector:@selector(submitButtonOnClick)];
    _submitButton.frame = CGRectMake(kScreenWidth - SW(140) - SW(30), _textView.bottom + SH(30), SW(140), SH(60));
    [_submitButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportDefaultColor] forState:UIControlStateNormal];
    [_submitButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportHighLightedColor] forState:UIControlStateHighlighted];
    
    _submitButton.layer.cornerRadius = MGButtonLayerCorner;
    _submitButton.layer.masksToBounds = YES;
    
    
    [_scrollView sd_addSubviews:@[_tutorTipLabel,
                                  _tutorLabel,
                                  _centerLineView,
                                  _companyTipLabel,
                                  _companyTipLabel,
                                  _scoreTipLabel,
                                  _scoreDataView,
                                  _scoreNoticeLabel,
                                  _scoreNoticeLineView,
                                  _commentTipLabel,
                                  _textView,
                                  _inputTipLabel,
                                  _submitButton]];
    
    _scrollView.contentSize = CGSizeMake(kScreenWidth, _submitButton.bottom + SH(40));
    
    [self.view addSubview:_scrollView];
    
    [self setipScoreDataViewData];
    
}
#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
/// 提交
- (void)submitButtonOnClick {
    
    NSString *comment = self.textView.text;
    if ([comment removeBlank].length == 0) {
        [self showMBText:@"请填写评论内容"];
        return;
    }
    
    /// 分数
    NSInteger score = 100;
    for (TDSelectListDataViewContentModel *contentModel in self.scoreDataView.dataArray) {
        if (contentModel.isSelected) {
            score = contentModel.score;
            break;
        }
    }
    
    [MGBussiness loadActor_Comment:@{@"id" : @(self.actorModel.id), @"score" : @(score), @"comment" : comment} completion:^(id results) {
        
        if ([results boolValue]) {
            if (_completionBlock) {
                _completionBlock(self.textView.text);
            }
            PopVC;
        }
        
    } error:nil];
    
    
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate
- (void)textViewDidChange:(UITextView *)textView {
    
    _inputTipLabel.text = [NSString stringWithFormat:@"您还可以写%zd字",100 - textView.text.length];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text stringContainsEmoji]) {
        return NO;
    }
    if (text.length > 0) {
        NSInteger length = textView.text.length + text.length;
        if (length > 100) {
            return NO;
        }
    }
    
    return YES;
}
#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function
/// 初始化分数列表
- (void)setipScoreDataViewData {
    
        NSMutableArray *arrayM = @[].mutableCopy;
        for (int i = 100; i > -1; i--) {
            /// 添加全部
            TDSelectListDataViewContentModel *contentModel = [TDSelectListDataViewContentModel new];
            contentModel.name = [NSString stringWithFormat:@"%zd分", i];
            contentModel.score = i;
            if (i == 100) {
                contentModel.isSelected = YES;
                [self.scoreDataView setTitleLabelWithTitle:contentModel.name];
            }
            [arrayM addObject:contentModel];
        }
        self.scoreDataView.dataArray = arrayM;
    
}
#pragma mark - Getter and Setter

@end
