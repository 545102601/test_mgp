//
//  MGScheduleVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/28.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGScheduleVC.h"
#import "FSCalendar.h"
#import "MGScheduleCalendarCell.h"
#import "MGScheduleBlankCell.h"
#import "MGSchedulePeopleCollectionView.h"
#import "MGSchedulePeopleModel.h"

@interface MGScheduleVC ()<FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance>

@property (weak, nonatomic) FSCalendar *calendar;

@property (strong, nonatomic) NSCalendar *gregorian;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@property (nonatomic, strong) UIButton *previousButton;

@property (nonatomic, strong) UIButton *nextButton;

@property (nonatomic, strong) UIButton *lookButton;

@property (nonatomic, strong) UIButton *resetScheduleButton;

@property (nonatomic, strong) UIButton *addScheduleButton;

@property (nonatomic, strong) UILabel *selectClassLabel;

@property (nonatomic, strong) MGSchedulePeopleCollectionView *collectionView;

@end

@implementation MGScheduleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setRightButtonWithTitle:@"今天" target:self selector:@selector(rightButtonOnClick)];
    
    
}


#pragma mark - 初始化控件
- (void)setupSubViews {

    
    [self setupCalendar];
    [self setPreAndNextButton];
    
    _selectClassLabel = [MGUITool labelWithText:@"选择上课时间" textColor:MGThemeColor_Title_Black font:PFSC(30) textAlignment:NSTextAlignmentCenter];
    _selectClassLabel.frame = CGRectMake(0, 0, kScreenWidth, SH(80));
    [self.view addSubview:_selectClassLabel];
    [self.view addSubview:self.collectionView];
    
    [self setBottomView];
    
    
}

#pragma mark - 加载数据
- (void)loadData {

    NSString *start_date = [[NSDate date] stringWithFormat:@"yyyy-MM-dd"];
    
    [MGBussiness loadSchedule_Calendar:@{@"start_date" : start_date} completion:^(id results) {
        
        NSLog(@"1");
        
    } error:nil];
    
}


#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

- (void)rightButtonOnClick {
    [_calendar setCurrentPage:[NSDate date] animated:YES];
}

- (void)previousClicked:(id)sender
{
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *previousMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:currentMonth options:0];
    [self.calendar setCurrentPage:previousMonth animated:YES];

}

- (void)nextClicked:(id)sender
{
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *nextMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:currentMonth options:0];
    [self.calendar setCurrentPage:nextMonth animated:YES];
}

/// 重新安排
- (void)resetScheduleButtonOnClick {
    
    
}

/// 添加安排
- (void)addScheduleButtonOnClick {
    
    
    
}

/// 查看这个时段的订单
- (void)lookButtonOnClick {
    
    
}

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate
#pragma mark - FSCalendarDataSource

- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    return nil;
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
    return nil;
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar {
    
    self.title = [_calendar.currentPage stringWithFormat:@"YYYY年MM月"];
    
}
- (NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date
{
    if ([self.gregorian isDateInToday:date]) {
        return @"今";
    }
    return nil;
}

- (FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    MGScheduleCalendarCell *cell = [calendar dequeueReusableCellWithIdentifier:@"MGScheduleCalendarCellID" forDate:date atMonthPosition:monthPosition];
    return cell;
}
- (FSCalendarBlankCell *)calendar:(FSCalendar *)calendar blankCellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    MGScheduleBlankCell *cell = (MGScheduleBlankCell *)[calendar dequeueReusableBlankCellWithIdentifier:@"cell1" forDate:date atMonthPosition:monthPosition];
    return cell;
}
- (void)calendar:(FSCalendar *)calendar willDisplayCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition: (FSCalendarMonthPosition)monthPosition
{
    [self configureCell:cell forDate:date atMonthPosition:monthPosition];
}

#pragma mark - FSCalendarDelegate

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{    
    calendar.height = bounds.size.height;
    
    self.selectClassLabel.top = calendar.bottom;
    self.collectionView.top = self.selectClassLabel.bottom;
}

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    return monthPosition == FSCalendarMonthPositionCurrent;
}

- (BOOL)calendar:(FSCalendar *)calendar shouldDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    return monthPosition == FSCalendarMonthPositionCurrent;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did select date %@",[self.dateFormatter stringFromDate:date]);
    [self configureVisibleCells];
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did deselect date %@",[self.dateFormatter stringFromDate:date]);
    [self configureVisibleCells];
}

- (NSArray<UIColor *> *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventDefaultColorsForDate:(NSDate *)date
{
    if ([self.gregorian isDateInToday:date]) {
        return @[[UIColor orangeColor]];
    }
    return @[appearance.eventDefaultColor];
}

#pragma mark - Private methods

- (void)configureVisibleCells
{
    [self.calendar.visibleCells enumerateObjectsUsingBlock:^(__kindof FSCalendarCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDate *date = [self.calendar dateForCell:obj];
        FSCalendarMonthPosition position = [self.calendar monthPositionForCell:obj];
        [self configureCell:obj forDate:date atMonthPosition:position];
    }];
}

- (void)configureCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    MGScheduleCalendarCell *diyCell = (MGScheduleCalendarCell *)cell;

    if ([self.calendar.selectedDates containsObject:date]) {
        diyCell.selectionLayer.hidden = NO;
    } else {
        diyCell.selectionLayer.hidden = YES;
    }
    
}

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function
- (void)setupCalendar {
    
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(SW(24),  64, kScreenWidth - SW(48), SH(680))];
    calendar.dataSource = self;
    calendar.delegate = self;
    
    self.calendar = calendar;
    [self.view addSubview:calendar];
    
    /// 设置标题
    self.title = [_calendar.currentPage stringWithFormat:@"YYYY年MM月"];
    
    _calendar.appearance.weekdayFont = PFSC(30);
    _calendar.appearance.weekdayTextColor = colorHex(@"#252525");
    _calendar.appearance.weekHeaderViewWeekendsColor = colorHex(@"#FBCC38");
    
    
    _calendar.appearance.titleFont = PFSC(32);
    _calendar.appearance.titleDefaultColor = colorHex(@"#252525");
    _calendar.appearance.titleSelectionColor = [UIColor whiteColor];
    
    _calendar.appearance.borderRadius = 0;
    
    _calendar.appearance.titleTodayColor = colorHex(@"#252525");
    
    _calendar.appearance.selectionColor = colorHex(@"#FBCC38");
    
    _calendar.appearance.titleWeekendColor = colorHex(@"#FBCC38");
    
    _calendar.appearance.titleOffset = CGPointMake(0, SH(6));
    
    /// 隐藏头部
    _calendar.headerHeight = 0;
    _calendar.weekdayHeight = SH(80);
    /// 设置周1开始
    _calendar.firstWeekday = 2;
    
    _calendar.calendarWeekdayView.backgroundColor = MGBackgroundViewColor;
    
    _calendar.layer.masksToBounds = YES;
    
    
    _calendar.placeholderType = FSCalendarPlaceholderTypeNone;
    
    [_calendar registerClass:[MGScheduleCalendarCell class] forCellReuseIdentifier:@"MGScheduleCalendarCellID"];
    
    [calendar registerClass:[MGScheduleBlankCell class] forBlankCellReuseIdentifier:@"cell1"];
    
    
    self.gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";

    
}

/// 设置切换时间按钮
- (void)setPreAndNextButton {
    
    _previousButton = [TDExpendClickButton buttonWithType:UIButtonTypeCustom];
    _previousButton.frame = CGRectMake(self.navigationBar.titleLabel.left - SW(24) - SW(20), 0, SW(24), SW(24));
    _previousButton.centerY = self.navigationBar.titleLabel.centerY;
    [_previousButton setImage:[UIImage imageNamed:@"record_left_more1"] forState:UIControlStateNormal];
    [_previousButton addTarget:self action:@selector(previousClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _nextButton = [TDExpendClickButton buttonWithType:UIButtonTypeCustom];
    _nextButton.frame = CGRectMake(self.navigationBar.titleLabel.right + SW(20), 0, SW(24), SW(24));
    _nextButton.centerY = self.navigationBar.titleLabel.centerY;
    [_nextButton setImage:[UIImage imageNamed:@"record_right_more1"] forState:UIControlStateNormal];
    [_nextButton addTarget:self action:@selector(nextClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationBar addSubview:_previousButton];
    [self.navigationBar addSubview:_nextButton];
}
/// 设置底部
- (void)setBottomView {
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - SH(100), kScreenWidth, SH(100))];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    UIButton *resetScheduleButton = [MGUITool buttonWithBGColor:nil title:@"重新安排" titleColor:MGThemeColor_Black font:MGThemeFont_28 target:self selector:@selector(resetScheduleButtonOnClick)];
    [resetScheduleButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportDefaultColor] forState:UIControlStateNormal];
    [resetScheduleButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportHighLightedColor] forState:UIControlStateHighlighted];
    resetScheduleButton.frame = CGRectMake(SW(60), SH(20), SW(140), SH(60));
    resetScheduleButton.layer.cornerRadius = MGButtonLayerCorner;
    resetScheduleButton.layer.masksToBounds = YES;
    _resetScheduleButton = resetScheduleButton;
    
    UIButton *addScheduleButton = [MGUITool buttonWithBGColor:nil title:@"添加安排" titleColor:MGThemeColor_Black font:MGThemeFont_28 target:self selector:@selector(addScheduleButtonOnClick)];
    [addScheduleButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportDefaultColor] forState:UIControlStateNormal];
    [addScheduleButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportHighLightedColor] forState:UIControlStateHighlighted];
    addScheduleButton.frame = CGRectMake(0, SH(20), SW(140), SH(60));
    addScheduleButton.centerX = kScreenWidth * 0.5;
    addScheduleButton.layer.cornerRadius = MGButtonLayerCorner;
    addScheduleButton.layer.masksToBounds = YES;
    _addScheduleButton = addScheduleButton;
    
    UIButton *lookButton = [MGUITool buttonWithBGColor:[UIColor whiteColor] title:@"查看这个时段的订单" titleColor:MGThemeShenYellowColor font:MGThemeFont_28 target:self selector:@selector(lookButtonOnClick)];
    
    lookButton.frame = CGRectMake(kScreenWidth - SW(286) - SW(30), SH(20), SW(286), SH(60));
    lookButton.layer.cornerRadius = MGButtonLayerCorner;
    lookButton.layer.masksToBounds = YES;
    lookButton.layer.borderWidth = MGSepLineHeight;
    lookButton.layer.borderColor = MGThemeShenYellowColor.CGColor;
    _lookButton = lookButton;
    
    [bottomView sd_addSubviews:@[resetScheduleButton, addScheduleButton, lookButton]];
    
    [self.view addSubview:bottomView];
    
    
}

#pragma mark - Getter and Setter

- (MGSchedulePeopleCollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[MGSchedulePeopleCollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SH(58) * 5 + 4 * SH(10))];
        
//        for (int i = 1; i < 1; i++) {
//            MGSchedulePeopleModel *model = [MGSchedulePeopleModel new];
//            model.people = 0;
//            model.time = [NSString stringWithFormat:<#(nonnull NSString *), ...#>];
//            
//        }
        
    }
    return _collectionView;
}

@end
