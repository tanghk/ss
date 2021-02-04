//
//  SearchReusableView.m
//  FoundingAZ
//
//  Created by mark on 2021/2/1.
//

#import "SearchReusableView.h"

@interface SearchReusableView()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *button;

@property (nonatomic, copy) emptyBlock block;

@end

@implementation SearchReusableView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.label = [[UILabel alloc] init];
    self.label.textColor = [UIColor colorWithHexString:@"#494949" alpha:1];
    self.label.font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
    [self addSubview:self.label];
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
   deleteBtn.hidden = YES;
//    [deleteBtn setImage:[UIImage imageNamed:@"empty"] forState:UIControlStateNormal];
    deleteBtn.frame = CGRectMake(kScreen_Width -48-30, 0, 48+30, 45);
    [deleteBtn addTarget:self action:@selector(deleteBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [deleteBtn setTitle:@"全部清除" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:Color_MainBlack forState:UIControlStateNormal];
    deleteBtn.titleLabel.font =[UIFont M_PingFang_RegularOfSize: Font_12];
    [self addSubview:deleteBtn];
    self.button = deleteBtn;
}

- (void)layoutSubviews {
    self.label.frame = CGRectMake(15, 15, kScreen_Width/2, 24);
}

- (void)showDeleteHistoryBtn:(BOOL)show CallBack:(void(^)(void))callBack {
   self.button.hidden = !show;
    self.block = callBack;
}

- (void)deleteBtnClicked {
    if (self.block) {
        self.block();
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.label.text = title;
}

@end
