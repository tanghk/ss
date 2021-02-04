//
//  VerfiyPhoneVC.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import "VerfiyPhoneVC.h"
#import "VerfiyPhoneCell.h"
#import "VerfiyPhoneModel.h"
#import "SetNewPassVC.h"

#define ConTextFieldTag       2000

static NSString *VerfiyPhoneCell_ID = @"verfiyPhoneCell_ID";

@interface VerfiyPhoneVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIButton *nextUnBtn;
@property (nonatomic, strong) UITextField *tempField;

@property (nonatomic, strong) NSString *phoneStr;//输入的手机号码
@property (nonatomic, strong) NSString *codeStr;//输入的短信验证码

@property (nonatomic, assign) NSInteger inteIndex;

@end

@implementation VerfiyPhoneVC

- (void)initWithData{
    
    self.phoneStr = @"";
    self.codeStr = @"";
    self.inteIndex = 0;
    
    self.dataArray = [VerfiyPhoneModel getWithVerfiyPhoneViewData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
}

#pragma mark 发送验证码按钮点击事件
- (void)sendCodeBtnClick:(UIButton *)btn{
    
    [self begainTimerCountDown];
}

#pragma mark 开始倒计时
- (void)begainTimerCountDown {
        
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    
    NSTimeInterval seconds = 60;
    NSDate *endTime = [NSDate dateWithTimeIntervalSinceNow:seconds];
    
    dispatch_source_set_event_handler(_timer, ^{
        
        int interval = [endTime timeIntervalSinceNow];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (interval > 0) {
                [self updateWithCodeTime:interval withState:YES];
            }else {
                [self updateWithCodeTime:interval withState:NO];
                dispatch_source_cancel(_timer);
            }
        });
    });
    
    dispatch_resume(_timer);
}

#pragma mark 更新倒计时按钮的显示
- (void)updateWithCodeTime:(NSInteger)afterTime withState:(BOOL)state{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    VerfiyPhoneCell *cell = (VerfiyPhoneCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    [cell setWithCodeBtnTime:afterTime isExistAfterTime:state];
}

#pragma mark 清除按钮点击事件
- (void)clearBtnClick:(UIButton *)btn{
    
    if (btn.tag - ConTextFieldTag == 0) {
        self.phoneStr = @"";
    }else{
        self.codeStr = @"";
    }
    [self reloadWithCellDataIndex];
}

#pragma mark 下一步按钮点击事件
- (void)nextBtnClick{
    
    if (self.nextBtn.hidden) {
        return;
    }
    
    NSString *tStr = self.phoneStr;
    tStr = [tStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    SetNewPassVC *vc = [[SetNewPassVC alloc] init];
    vc.phoneStr = tStr;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    self.tempField = textField;
    return YES;
}

#pragma mark UITextFieldDelegate
-(void)textFieldDidChange:(UITextField *)textField{
    
    if (textField.tag - ConTextFieldTag == 0) {
        if (textField.text.length > self.inteIndex) {
            if (textField.text.length == 1 && ![textField.text isEqualToString:@"1"]) {
                [MBProgressHUD showMessageInWindow:@"请输入正确的手机号码"];
                textField.text = @"";
            }
            if (textField.text.length >= 4) {//输入
                NSMutableString * str = [[NSMutableString alloc ] initWithString:textField.text];
                if ([[textField.text substringWithRange:NSMakeRange(3, 1)] isEqualToString:@" "]) {
                    //不做处理
                }else{
                   [str insertString:@" " atIndex:3];
                }
                textField.text = str;
            }
            if (textField.text.length >= 9) {//输入
                NSMutableString * str = [[NSMutableString alloc ] initWithString:textField.text];
                if ([[textField.text substringWithRange:NSMakeRange(8, 1)] isEqualToString:@" "]) {
                    //不做处理
                }else{
                   [str insertString:@" " atIndex:8];
                }
                textField.text = str;
            }
            if (textField.text.length >= 13 ) {//输入完成
                textField.text = [textField.text substringToIndex:13];
            }
            self.inteIndex = textField.text.length;
            
        }else if (textField.text.length < self.inteIndex){//删除
            if (textField.text.length == 4 || textField.text.length == 9) {
                textField.text = [NSString stringWithFormat:@"%@",textField.text];
                textField.text = [textField.text substringToIndex:(textField.text.length-1)];
            }
            self.inteIndex = textField.text.length;
        }
        self.phoneStr = textField.text;
    }else{
        if (textField.text.length >= 6 ) {//输入完成
            textField.text = [textField.text substringToIndex:6];
        }
        self.codeStr = textField.text;
    }
    
    [self reloadWithCellDataIndex];
}

#pragma mark 刷新cell的显示
- (void)reloadWithCellDataIndex{
    
    BOOL phoneState = NO;
    BOOL codeState = NO;
    
    for (VerfiyPhoneModel *model in self.dataArray) {
        if (model.VerfiyPhoneType == VerfiyPhoneType_phone) {
            model.conStr = self.phoneStr;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            VerfiyPhoneCell *cell = (VerfiyPhoneCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            [cell configureCellWithModel:model];
            
            if (self.phoneStr.length >= 13) {
                phoneState = YES;
            }else{
                phoneState = NO;
            }
        }else if (model.VerfiyPhoneType == VerfiyPhoneType_code){
            model.conStr = self.codeStr;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            VerfiyPhoneCell *cell = (VerfiyPhoneCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            [cell configureCellWithModel:model];
            
            if (self.codeStr.length >= 6) {
                codeState = YES;
            }else{
                codeState = NO;
            }
        }
    }
    
    if (phoneState && codeState) {
        self.nextBtn.hidden = NO;
        self.nextUnBtn.hidden = YES;
    }else{
        self.nextBtn.hidden = YES;
        self.nextUnBtn.hidden = NO;
    }
}

/*
 * UI部分
 */
- (void)initWithNaviUI{
    [super initWithNaviUI];
    
    [self setNavigationTitle:@"" isShowBack:YES hasLine:NO];
}

- (void)initWithMainUI{
    [super initWithMainUI];
    
    self.tableFrame = CGRectMake(0, kTopHeight, kScreen_Width, kScreen_Height-kTopHeight);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registerClass:[VerfiyPhoneCell class] forCellReuseIdentifier:VerfiyPhoneCell_ID];
    
    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = self.footView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 64.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VerfiyPhoneModel *model = [self.dataArray safeObjectIndex:indexPath.row];
    
    VerfiyPhoneCell *cell = [tableView dequeueReusableCellWithIdentifier:VerfiyPhoneCell_ID forIndexPath:indexPath];
    
    [cell.sendCodeBtn addTarget:self action:@selector(sendCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.phoneField.tag = indexPath.row + ConTextFieldTag;
    cell.phoneField.delegate = self;
    [cell.phoneField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    cell.clearBtn.tag = indexPath.row + ConTextFieldTag;
    [cell.clearBtn addTarget:self action:@selector(clearBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell configureCellWithModel:model];
    
    return cell;
}

/*
 * creat headView
 */
- (UIView *)headView{
    
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 8+33+8)];
        _headView.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectMake(25, 8, 150, 33) font:[UIFont M_PingFang_MediumOfSize:Font_24] textColor:Color_MainBlack textAlignment:NSTextAlignmentLeft backgroundColor:[UIColor whiteColor] text:@"验证手机号"];
        [_headView addSubview:titleLabel];
    }
    
    return _headView;
}

/*
 * creat footView
 */
- (UIView *)footView{
    
    if (!_footView) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 27+52)];
        _footView.backgroundColor = [UIColor whiteColor];
        
        //
        UIButton *nextBtn = [UIButton createButtonWithFrame:CGRectMake(24, 27, kScreen_Width-2*24, 52) titleColor:[UIColor whiteColor] font:[UIFont M_PingFang_MediumOfSize:Font_17] backgroundColor:Color_MainBlue title:@"下一步"];
        ViewShadow(nextBtn, Color_MainBlue, CGSizeMake(0, 2), 6, 0.3);
        nextBtn.layer.cornerRadius = 8.0;
        [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
        nextBtn.hidden = YES;
        [_footView addSubview:nextBtn];
        self.nextBtn = nextBtn;
        
        NSArray *colorArray = @[(id)[HEXACOLOR(0x36A8FF, 1.0) CGColor],
                                (id)[HEXACOLOR(0x2A71FF, 1.0) CGColor]];
        NSArray *colorLocationArray = @[@0, @1];
        CAGradientLayer *nextBtnLayer =  [CAGradientLayer layer];
        nextBtnLayer.frame = CGRectMake(0, 0, CGRectGetWidth(nextBtn.bounds), CGRectGetHeight(self.nextBtn.bounds));
        [nextBtnLayer setLocations:colorLocationArray];
        [nextBtnLayer setColors:colorArray];
        [nextBtnLayer setStartPoint:CGPointMake(1, 0.5)];
        [nextBtnLayer setEndPoint:CGPointMake(0, 0.5)];
        [nextBtnLayer setCornerRadius:8.0];
        [nextBtn.layer addSublayer:nextBtnLayer];
        [nextBtn.layer insertSublayer:nextBtnLayer atIndex:0];
        
        //
        UIButton *nextUnBtn = [UIButton createButtonWithFrame:CGRectMake(24, 27, kScreen_Width-2*24, 52) titleColor:[UIColor whiteColor] font:[UIFont M_PingFang_MediumOfSize:Font_17] backgroundColor:Color_MainGray_one title:@"下一步"];
        ViewRadius(nextUnBtn, 8.0);
        [nextUnBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
        nextUnBtn.hidden = NO;
        [_footView addSubview:nextUnBtn];
        self.nextUnBtn = nextUnBtn;
    }
    
    return _footView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
