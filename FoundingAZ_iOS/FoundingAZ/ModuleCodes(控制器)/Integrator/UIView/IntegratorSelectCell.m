//
//  IntegratorSelectCell.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/24.
//

#import "IntegratorSelectCell.h"
#import "IntegrEnterModel.h"
#import "CompaScaleVC.h"
#import "WorkPickerVC.h"

@interface IntegratorSelectCell ()

@property (nonatomic, strong) UIImageView *lineImageV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *conLabel;
@property (nonatomic, strong) UIImageView *arrowImageV;
@property (nonatomic, strong) UIButton *cellBtn;

@property (nonatomic, strong) IntegrEnterModel *tModel;

@end

@implementation IntegratorSelectCell

- (void)configSubView{
    
    UIImageView *lineImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@""];
    lineImageV.backgroundColor = Color_Separator;
    [self addSubview:lineImageV];
    self.lineImageV = lineImageV;
    
    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_RegularOfSize:Font_16] textColor:Color_MainBlack textAlignment:NSTextAlignmentLeft backgroundColor:[UIColor whiteColor] text:@""];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel *conLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_RegularOfSize:Font_16] textColor:Color_MainBlack textAlignment:NSTextAlignmentLeft backgroundColor:[UIColor whiteColor] text:@""];
    conLabel.numberOfLines = 0;
    [self addSubview:conLabel];
    self.conLabel = conLabel;
    
    UIImageView *arrowImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@"G_arrow_right"];
    [self addSubview:arrowImageV];
    self.arrowImageV = arrowImageV;
    
    UIButton *cellBtn = [UIButton createButtonWithFrame:CGRectZero normalImage:@""];
    [cellBtn addTarget:self action:@selector(cellClickBtn) forControlEvents:UIControlEventTouchUpInside];
    cellBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:cellBtn];
    self.cellBtn = cellBtn;
}

- (void)layout{
    
    [self.lineImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(16);
        make.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(17);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(64);
    }];
    
    [self.conLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel.mas_right).with.offset(24);
        make.top.mas_equalTo(17);
        make.right.mas_equalTo(-24-18-10);
    }];
    
    [self.arrowImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(18, 18));
        make.right.mas_equalTo(-24);
    }];
    
    [self.cellBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.bottom.mas_equalTo(0);
    }];
}

- (void)configureCellWithModel:(IntegrEnterModel *)contentModel{
    
    self.tModel = contentModel;
    
    self.titleLabel.text = contentModel.title;
    
    if ([NSString stringIsEmpty:contentModel.conStr]) {
        self.conLabel.text = contentModel.placeHolderStr;
        self.conLabel.textColor = Color_MainGray_one;
    }else{
        self.conLabel.text = contentModel.conStr;
        self.conLabel.textColor = Color_MainBlack;
    }
}

#pragma mark cell点击事件
- (void)cellClickBtn{
    
    [self.viewController.view endEditing:NO];
    
    if (self.tModel.integrEnterType == IntegrEnterType_scale) {
        CompaScaleVC *vc = [[CompaScaleVC alloc] init];
        vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self.viewController presentViewController:vc animated:NO completion:nil];
    }else if (self.tModel.integrEnterType == IntegrEnterType_technology) {
        CompaScaleVC *vc = [[CompaScaleVC alloc] init];
        vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self.viewController presentViewController:vc animated:NO completion:nil];
    }else if (self.tModel.integrEnterType == IntegrEnterType_industry) {
        CompaScaleVC *vc = [[CompaScaleVC alloc] init];
        vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self.viewController presentViewController:vc animated:NO completion:nil];
    }else if (self.tModel.integrEnterType == IntegrEnterType_area) {
        [self didSelectWithAddressData];
    }
}

#pragma mark 地址
- (void)didSelectWithAddressData{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"map" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    WorkPickerVC *vc = [[WorkPickerVC alloc] init];
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    vc.fromType = 1;
    vc.numberOfSection = 3;
    vc.titleStr = [NSString stringWithFormat:@"请选择%@",@"所属地区"];
    vc.dataArr = arr;
    [self.viewController  presentViewController:vc animated:NO completion:nil];
    
    @weakify(self);
    vc.WorkPickerSelectBlock = ^(NSString * _Nonnull str) {
        @strongify(self);
        self.tModel.conStr = str;
        
        if (self.IntegratorSelectReloadBlock) {
            self.IntegratorSelectReloadBlock();
        }
    };
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
