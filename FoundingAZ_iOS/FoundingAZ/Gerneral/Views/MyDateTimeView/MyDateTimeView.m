//
//  MyDateTimeView.m
//  DateTimePickerViewDemo
//
#import "MyDateTimeView.h"

static CGFloat PickViewHeight = 180;
#define screenWith  [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

@interface MyDateTimeView()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSInteger yearRange;
    NSInteger dayRange;
    NSInteger startYear;
    NSInteger selectedYear;
    NSInteger selectedMonth;
    NSInteger selectedDay;
    NSInteger selectedHour;
    NSInteger selectedMinute;
    NSInteger selectedSecond;
    
    //左边退出按钮
    UIButton *cancelButton;
    //右边的确定按钮
    UIButton *chooseButton;
}

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSString *string;

@end
@implementation MyDateTimeView

- (instancetype)initWithFrame:(CGRect)frame DatePickerViewType:(MyDatePickerViewMode)datePickerType DidConfirmAction:(void (^)(NSString *))didConfirmAction
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.pickerViewMode = datePickerType;
        self.didSelectDateEnd = didConfirmAction;
        //盛放按钮的View
        UIView *upVeiw = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
        upVeiw.backgroundColor = [UIColor whiteColor];
        [self addSubview:upVeiw];

        //左边的取消按钮
        cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(12, 0, 40, 40);
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        cancelButton.backgroundColor = [UIColor clearColor];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [cancelButton setTitleColor:Color_333 forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [upVeiw addSubview:cancelButton];
        
        //右边的确定按钮
        chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        chooseButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 52, 0, 40, 40);
        [chooseButton setTitle:@"确定" forState:UIControlStateNormal];
        chooseButton.backgroundColor = [UIColor clearColor];
        chooseButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [chooseButton setTitleColor:Color_Blue forState:UIControlStateNormal];
        [chooseButton addTarget:self action:@selector(configButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [upVeiw addSubview:chooseButton];
        
        
        self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, upVeiw.frameBottom, upVeiw.frameWidth, PickViewHeight)];
        self.pickerView.backgroundColor = [UIColor whiteColor];
        self.pickerView.dataSource=self;
        self.pickerView.delegate=self;
        [self addSubview:self.pickerView];
        
        
        NSCalendar *calendar0 = [NSCalendar currentCalendar];
        NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
        NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDateComponents *comps  = [calendar0 components:unitFlags fromDate:[NSDate date]];
        NSInteger year=[comps year];
        
        startYear=year-100;
        yearRange=200;
       
        [self setCurrentDate:[NSDate date]];
        
        self.frameHeight = upVeiw.frameHeight+PickViewHeight;
        self.frameY = kScreen_Height-self.frameHeight;
    }
    return self;
}

- (void)cancelButtonClick{
    
    [self removeDatePickView];
}

- (void)configButtonClick{
    
    _didSelectDateEnd(self.string);
    [self removeDatePickView];
}

- (void)show {
    //透明黑幕按钮，点击，移除pickerView
    UIButton *blackBgBtn = [UIButton buttonWithType:UIButtonTypeCustom];//[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    blackBgBtn.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height);
    blackBgBtn.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    blackBgBtn.tag = 1230000;
    [blackBgBtn addTarget:self action:@selector(blackBgBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [getKeyWindow() addSubview:blackBgBtn];
    [getKeyWindow() addSubview:self];
}

- (void)removeDatePickView
{
    [[getKeyWindow() viewWithTag:1230000] removeFromSuperview];
    [self removeFromSuperview];
}

//点击透明黑幕按钮，移除pickerView
-(void)blackBgBtnAction
{
    [self removeDatePickView];
}

//默认时间的处理
-(void)setCurrentDate:(NSDate *)currentDate
{
    //获取当前时间
    NSCalendar *calendar0 = [NSCalendar currentCalendar];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps  = [calendar0 components:unitFlags fromDate:[NSDate date]];
    
    NSInteger year=[comps year];
    NSInteger month=[comps month];
    NSInteger day=[comps day];
    NSInteger hour=[comps hour];
    NSInteger minute=[comps minute];
    NSInteger second=[comps second];
    
    selectedYear=year;
    selectedMonth=month;
    selectedDay=day;
    selectedHour=hour;
    selectedMinute=minute;
    selectedSecond =second;
    
    dayRange=[self isAllDay:year andMonth:month];
    
    if (self.pickerViewMode == MyDatePickerViewDateYearMonthDayHourMinuteMode) {
        [self.pickerView selectRow:year-startYear inComponent:0 animated:NO];
        [self.pickerView selectRow:month-1 inComponent:1 animated:NO];
        [self.pickerView selectRow:day-1 inComponent:2 animated:NO];
        [self.pickerView selectRow:hour inComponent:3 animated:NO];
        [self.pickerView selectRow:minute inComponent:4 animated:NO];
        
        [self pickerView:self.pickerView didSelectRow:year-startYear inComponent:0];
        [self pickerView:self.pickerView didSelectRow:month-1 inComponent:1];
        [self pickerView:self.pickerView didSelectRow:day-1 inComponent:2];
        [self pickerView:self.pickerView didSelectRow:hour inComponent:3];
        [self pickerView:self.pickerView didSelectRow:minute inComponent:4];
        
        
    }else if (self.pickerViewMode == MyDatePickerViewDateYearMonthDayHourMinuteSecondMode){
        [self.pickerView selectRow:year-startYear inComponent:0 animated:NO];
        [self.pickerView selectRow:month-1 inComponent:1 animated:NO];
        [self.pickerView selectRow:day-1 inComponent:2 animated:NO];
        [self.pickerView selectRow:hour inComponent:3 animated:NO];
        [self.pickerView selectRow:minute inComponent:4 animated:NO];
        [self.pickerView selectRow:second inComponent:5 animated:NO];
        
        [self pickerView:self.pickerView didSelectRow:year-startYear inComponent:0];
        [self pickerView:self.pickerView didSelectRow:month-1 inComponent:1];
        [self pickerView:self.pickerView didSelectRow:day-1 inComponent:2];
        [self pickerView:self.pickerView didSelectRow:hour inComponent:3];
        [self pickerView:self.pickerView didSelectRow:minute inComponent:4];
        [self pickerView:self.pickerView didSelectRow:second inComponent:5];
        
    }
    else if (self.pickerViewMode == MyDatePickerViewDateYearMonthDayHourMode){
        [self.pickerView selectRow:year-startYear inComponent:0 animated:NO];
        [self.pickerView selectRow:month-1 inComponent:1 animated:NO];
        [self.pickerView selectRow:day-1 inComponent:2 animated:NO];
        [self.pickerView selectRow:hour inComponent:3 animated:NO];
        
        [self pickerView:self.pickerView didSelectRow:year-startYear inComponent:0];
        [self pickerView:self.pickerView didSelectRow:month-1 inComponent:1];
        [self pickerView:self.pickerView didSelectRow:day-1 inComponent:2];
        [self pickerView:self.pickerView didSelectRow:hour inComponent:3];
     
        
    }
    else if (self.pickerViewMode == MyDatePickerViewDateYearMonthDayMode){
        [self.pickerView selectRow:year-startYear inComponent:0 animated:NO];
        [self.pickerView selectRow:month-1 inComponent:1 animated:NO];
        [self.pickerView selectRow:day-1 inComponent:2 animated:NO];
       
        
        [self pickerView:self.pickerView didSelectRow:year-startYear inComponent:0];
        [self pickerView:self.pickerView didSelectRow:month-1 inComponent:1];
        [self pickerView:self.pickerView didSelectRow:day-1 inComponent:2];
       
    }
    else if (self.pickerViewMode == MyDatePickerViewDateYearMonthMode){
        [self.pickerView selectRow:year-startYear inComponent:0 animated:NO];
        [self.pickerView selectRow:month-1 inComponent:1 animated:NO];
      
        [self pickerView:self.pickerView didSelectRow:year-startYear inComponent:0];
        [self pickerView:self.pickerView didSelectRow:month-1 inComponent:1];

    }
    else if (self.pickerViewMode == MyDatePickerViewDateYearMode){
        [self.pickerView selectRow:year-startYear inComponent:0 animated:NO];
       
        [self pickerView:self.pickerView didSelectRow:year-startYear inComponent:0];
        
        
    }
    [self.pickerView reloadAllComponents];
}

#pragma mark - 选择对应月份的天数
-(NSInteger)isAllDay:(NSInteger)year andMonth:(NSInteger)month
{
    int day=0;
    switch(month)
    {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            day=31;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            day=30;
            break;
        case 2:
        {
            if(((year%4==0)&&(year%100!=0))||(year%400==0))
            {
                day=29;
                break;
            }
            else
            {
                day=28;
                break;
            }
        }
        default:
            break;
    }
    return day;
}

#pragma mark -- UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.pickerViewMode == MyDatePickerViewDateYearMonthDayHourMinuteMode) {
        return 5;
    }else if (self.pickerViewMode == MyDatePickerViewDateYearMonthDayHourMinuteSecondMode){
        return 6;
    }
    else if (self.pickerViewMode == MyDatePickerViewDateYearMonthDayHourMode){
        return 4;
    }
    else if (self.pickerViewMode == MyDatePickerViewDateYearMonthDayMode){
        return 3;
    }
    else if (self.pickerViewMode == MyDatePickerViewDateYearMonthMode){
        return 2;
    }
    else if (self.pickerViewMode == MyDatePickerViewDateYearMode){
        return 1;
    }
    return 0;
}

//确定每一列返回的东西
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.pickerViewMode == MyDatePickerViewDateYearMonthDayHourMinuteMode) {
        switch (component) {
            case 0:
            {
                return yearRange;
            }
                break;
            case 1:
            {
                return 12;
            }
                break;
            case 2:
            {
                return dayRange;
            }
                break;
            case 3:
            {
                return 24;
            }
                break;
            case 4:
            {
                return 60;
            }
                break;
                
            default:
                break;
        }
    }else if (self.pickerViewMode == MyDatePickerViewDateYearMonthDayHourMinuteSecondMode){
        switch (component) {
            case 0:
            {
                return yearRange;
            }
                break;
            case 1:
            {
                return 12;
            }
                break;
            case 2:
            {
                return dayRange;
            }
                break;
            case 3:
            {
                return 24;
            }
                break;
            case 4:
            {
                return 60;
            }
                break;
                
            case 5:
            {
                return 60;
            }
                break;
                
            default:
                break;
        }
    }
    else if (self.pickerViewMode == MyDatePickerViewDateYearMonthDayHourMode){
        switch (component) {
            case 0:
            {
                return yearRange;
            }
                break;
            case 1:
            {
                return 12;
            }
                break;
            case 2:
            {
                return dayRange;
            }
                break;
            case 3:
            {
                return 24;
            }
                break;
            default:
                break;
        }
    }
    else if (self.pickerViewMode == MyDatePickerViewDateYearMonthDayMode){
        switch (component) {
            case 0:
            {
                return yearRange;
            }
                break;
            case 1:
            {
                return 12;
            }
                break;
            case 2:
            {
                return dayRange;
            }
                break;
            default:
                break;
        }
    }
    else if (self.pickerViewMode == MyDatePickerViewDateYearMonthMode){
        switch (component) {
            case 0:
            {
                return yearRange;
            }
                break;
            case 1:
            {
                return 12;
            }
                break;
       
            default:
                break;
        }
    }
    else if (self.pickerViewMode == MyDatePickerViewDateYearMode){
        switch (component) {
            case 0:
            {
                return yearRange;
            }
                break;
                
            default:
                break;
        }
    }
    return 0;
}

#pragma mark -- UIPickerViewDelegate

-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel*label=[[UILabel alloc]init];
    label.font=[UIFont systemFontOfSize:15.0];
    label.textAlignment=NSTextAlignmentCenter;
   
    if (self.pickerViewMode == MyDatePickerViewDateYearMonthDayHourMinuteMode) {
        switch (component) {
            case 0:
            {
                label.text=[NSString stringWithFormat:@"%ld年",(long)(startYear + row)];
            }
                break;
            case 1:
            {
                label.text=[NSString stringWithFormat:@"%ld月",(long)row+1];
            }
                break;
            case 2:
            {
                
                label.text=[NSString stringWithFormat:@"%ld日",(long)row+1];
            }
                break;
            case 3:
            {
                label.textAlignment=NSTextAlignmentRight;
                label.text=[NSString stringWithFormat:@"%ld时",(long)row];
            }
                break;
            case 4:
            {
                label.textAlignment=NSTextAlignmentRight;
                label.text=[NSString stringWithFormat:@"%ld分",(long)row];
            }
                break;
        
            default:
                break;
        }
    }else if (self.pickerViewMode == MyDatePickerViewDateYearMonthDayHourMinuteSecondMode){
        
        switch (component) {
            case 0:
            {
                label.text=[NSString stringWithFormat:@"%ld年",(long)(startYear + row)];
            }
                break;
            case 1:
            {
                label.text=[NSString stringWithFormat:@"%ld月",(long)row+1];
            }
                break;
            case 2:
            {
                
                label.text=[NSString stringWithFormat:@"%ld日",(long)row+1];
            }
                break;
            case 3:
            {
                label.textAlignment=NSTextAlignmentRight;
                label.text=[NSString stringWithFormat:@"%ld时",(long)row];
            }
                break;
            case 4:
            {
                label.textAlignment=NSTextAlignmentRight;
                label.text=[NSString stringWithFormat:@"%ld分",(long)row];
            }
                break;
            case 5:
            {
                label.textAlignment=NSTextAlignmentRight;
                label.text=[NSString stringWithFormat:@"%ld秒",(long)row];
            }
                break;
                
            default:
                break;
        }
    }
    else if (self.pickerViewMode == MyDatePickerViewDateYearMonthDayHourMode){
        
        switch (component) {
            case 0:
            {
                label.text=[NSString stringWithFormat:@"%ld年",(long)(startYear + row)];
            }
                break;
            case 1:
            {
                label.text=[NSString stringWithFormat:@"%ld月",(long)row+1];
            }
                break;
            case 2:
            {
                
                label.text=[NSString stringWithFormat:@"%ld日",(long)row+1];
            }
                break;
            case 3:
            {
                label.textAlignment=NSTextAlignmentRight;
                label.text=[NSString stringWithFormat:@"%ld时",(long)row];
            }
                break;
            default:
                break;
        }
    }
    else if (self.pickerViewMode == MyDatePickerViewDateYearMonthDayMode){
        
        switch (component) {
            case 0:
            {
                label.text=[NSString stringWithFormat:@"%ld年",(long)(startYear + row)];
            }
                break;
            case 1:
            {
                label.text=[NSString stringWithFormat:@"%ld月",(long)row+1];
            }
                break;
            case 2:
            {
                
                label.text=[NSString stringWithFormat:@"%ld日",(long)row+1];
            }
                break;

            default:
                break;
        }
    }
    else if (self.pickerViewMode == MyDatePickerViewDateYearMonthMode){
        
        switch (component) {
            case 0:
            {
                label.text=[NSString stringWithFormat:@"%ld年",(long)(startYear + row)];
            }
                break;
            case 1:
            {
                label.text=[NSString stringWithFormat:@"%ld月",(long)row+1];
            }
                break;
            default:
                break;
        }
    }
    else if (self.pickerViewMode == MyDatePickerViewDateYearMode){
        
        switch (component) {
            case 0:
            {
                label.text=[NSString stringWithFormat:@"%ld年",(long)(startYear + row)];
            }
                break;
            case 1:
            {
                label.text=[NSString stringWithFormat:@"%ld月",(long)row+1];
            }
                break;
            default:
                break;
        }
    }
    return label;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    if (self.pickerViewMode == MyDatePickerViewDateYearMonthDayHourMinuteMode) {
        
       return ([UIScreen mainScreen].bounds.size.width-40)/5;
        
    }else if (self.pickerViewMode == MyDatePickerViewDateYearMonthDayHourMinuteSecondMode){
      return ([UIScreen mainScreen].bounds.size.width-40)/6;
    }
    else if (self.pickerViewMode == MyDatePickerViewDateYearMonthDayHourMode){
      return ([UIScreen mainScreen].bounds.size.width-40)/4;
    }
    else if (self.pickerViewMode == MyDatePickerViewDateYearMonthDayMode){
       return ([UIScreen mainScreen].bounds.size.width-40)/3;
    }
    else if (self.pickerViewMode == MyDatePickerViewDateYearMonthMode){
      return ([UIScreen mainScreen].bounds.size.width-40)/2;
    }
    else if (self.pickerViewMode == MyDatePickerViewDateYearMode){
        return ([UIScreen mainScreen].bounds.size.width-40)/1;
    }
   
    return 0;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 30;
}
// 监听picker的滑动
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (self.pickerViewMode == MyDatePickerViewDateYearMonthDayHourMinuteMode) {
        switch (component) {
            case 0:
            {
                selectedYear=startYear + row;
                dayRange=[self isAllDay:selectedYear andMonth:selectedMonth];
                [self.pickerView reloadComponent:2];
            }
                break;
            case 1:
            {
                selectedMonth=row+1;
                dayRange=[self isAllDay:selectedYear andMonth:selectedMonth];
                [self.pickerView reloadComponent:2];
            }
                break;
            case 2:
            {
                selectedDay=row+1;
            }
                break;
            case 3:
            {
                selectedHour=row;
            }
                break;
            case 4:
            {
                selectedMinute=row;
            }
                break;
                
            default:
                break;
        }
        
        _string =[NSString stringWithFormat:@"%ld-%.2ld-%.2ld %.2ld:%.2ld",(long)selectedYear,(long)selectedMonth,(long)selectedDay,(long)selectedHour,(long)selectedMinute];
    }else if (self.pickerViewMode == MyDatePickerViewDateYearMonthDayHourMinuteSecondMode){
        switch (component) {
            case 0:
            {
                selectedYear=startYear + row;
                dayRange=[self isAllDay:selectedYear andMonth:selectedMonth];
                [self.pickerView reloadComponent:2];
            }
                break;
            case 1:
            {
                selectedMonth=row+1;
                dayRange=[self isAllDay:selectedYear andMonth:selectedMonth];
                [self.pickerView reloadComponent:2];
            }
                break;
            case 2:
            {
                selectedDay=row+1;
            }
                break;
            case 3:
            {
                selectedHour=row;
            }
                break;
            case 4:
            {
                selectedMinute=row;
            }
                break;
            case 5:
            {
                selectedSecond=row;
            }
                break;
            default:
                break;
        }
        
        _string =[NSString stringWithFormat:@"%ld-%.2ld-%.2ld %.2ld:%.2ld:%.2ld",(long)selectedYear,(long)selectedMonth,(long)selectedDay,(long)selectedHour,(long)selectedMinute,(long)selectedSecond];
    }
    else if (self.pickerViewMode == MyDatePickerViewDateYearMonthDayHourMode){
        switch (component) {
            case 0:
            {
                selectedYear=startYear + row;
                dayRange=[self isAllDay:selectedYear andMonth:selectedMonth];
                [self.pickerView reloadComponent:2];
            }
                break;
            case 1:
            {
                selectedMonth=row+1;
                dayRange=[self isAllDay:selectedYear andMonth:selectedMonth];
                [self.pickerView reloadComponent:2];
            }
                break;
            case 2:
            {
                selectedDay=row+1;
            }
                break;
            case 3:
            {
                selectedHour=row;
            }
                break;
          
            default:
                break;
        }
        
        _string =[NSString stringWithFormat:@"%ld-%.2ld-%.2ld %.2ld",(long)selectedYear,(long)selectedMonth,(long)selectedDay,(long)selectedHour];
    }
    else if (self.pickerViewMode == MyDatePickerViewDateYearMonthDayMode){
        switch (component) {
            case 0:
            {
                selectedYear=startYear + row;
                dayRange=[self isAllDay:selectedYear andMonth:selectedMonth];
                [self.pickerView reloadComponent:2];
            }
                break;
            case 1:
            {
                selectedMonth=row+1;
                dayRange=[self isAllDay:selectedYear andMonth:selectedMonth];
                [self.pickerView reloadComponent:2];
            }
                break;
            case 2:
            {
                selectedDay=row+1;
            }
                break;
          
            default:
                break;
        }
        
        _string =[NSString stringWithFormat:@"%ld-%.2ld-%.2ld",(long)selectedYear,(long)selectedMonth,(long)selectedDay];
    }
    else if (self.pickerViewMode == MyDatePickerViewDateYearMonthMode){
        switch (component) {
            case 0:
            {
                selectedYear=startYear + row;
              
            }
                break;
            case 1:
            {
                selectedMonth=row+1;
              
            }
                break;
          
            default:
                break;
        }
        
        _string =[NSString stringWithFormat:@"%ld-%.2ld",(long)selectedYear,(long)selectedMonth];
    }
    else if (self.pickerViewMode == MyDatePickerViewDateYearMode){
        switch (component) {
            case 0:
            {
                selectedYear=startYear + row;
                
            }
                break;
           
            default:
                break;
        }
        
        _string =[NSString stringWithFormat:@"%ld",(long)selectedYear];
    }
}
@end
