//
//  NewVersionTipVC.m
//  JobApp
//
//  Created by 创业酵母 on 2021/01/21.
//


#import "NewVersionTipVC.h"

#define titleHeight  20
#define buttonHeight 35

@interface NewVersionTipVC (){
    
    UIImageView *imgBg;//
    UITextView *txtContent;//新版本更新内容
}

@end

@implementation NewVersionTipVC
@synthesize updateVerSion,updateMsg,updateUrl;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self addSubViews];
    
    [Global shareGlobal].isShowUpdate = YES;
}

- (void)addSubViews
{
    if (!imgBg) {
        CGFloat Width = Width(275);
        imgBg = [[UIImageView alloc] initWithFrame:CGRectMake((kScreen_Width - Width)/2, 0, Width, 0)];
        imgBg.userInteractionEnabled = YES;
        imgBg.backgroundColor = Color_Whitle;
        [self.view addSubview:imgBg];
    }
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(-0.5, -Width(39), imgBg.frameWidth + 1, Width(125))];
    img.image = kImage(@"update");
    [imgBg addSubview:img];
    
    //新版本信息
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(82, 22, imgBg.frameWidth - 25*2, titleHeight)];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.text = [NSString stringWithFormat:@"有新版本%@啦!",_titleKey];//[NSString stringWithFormat:@"升级新版本V%@",updateVerSion];
    tipLabel.textColor = Color_Whitle;
    tipLabel.font = kFont(18);
    tipLabel.frameWidth = getLabelTextWidth(tipLabel);
    [imgBg addSubview:tipLabel];
    
    //内容label
    txtContent = [[UITextView alloc] initWithFrame:CGRectMake(17, tipLabel.frameBottom + Width(48), imgBg.frameWidth-17*2, Height(160))];
//    txtContent.font = kFont(20);
    txtContent.editable = NO;
    txtContent.font = kFont(14);
    txtContent.textColor = Color_MainBlack;
    NSMutableAttributedString *mAryAttr = getAttributeStringWithLineHeight(updateMsg, 5);
    txtContent.attributedText = mAryAttr;
    [imgBg addSubview:txtContent];
    

    
    if (_isforup) {
        UIButton *btnUpdate = [MTools createGradentNewButtonWithTitle:[NSString stringWithFormat:@"立即%@",_titleKey] Font:kFont(16) TitleColor:Color_Whitle frame:CGRectMake((imgBg.frameWidth - Width(233))/2, txtContent.frameBottom + 11, Width(233), buttonHeight)];
        btnUpdate.layer.cornerRadius = 17;
        __weak typeof(self) weakSelf = self;
        [btnUpdate addButtonClickBlock:^(UIButton *btn) {
            weakSelf.updateViewDismiss();
            openUrl(self->updateUrl);
            [Global shareGlobal].isShowUpdate = NO;
            [self dismiss];
        }];
        [imgBg addSubview:btnUpdate];
        imgBg.frameHeight = btnUpdate.frameBottom + 20;
    }else{
        __weak typeof(self) weakSelf = self;
        UIButton *btnUpdate = [MTools createGradentNewButtonWithTitle:[NSString stringWithFormat:@"立即%@",_titleKey] Font:kFont(16) TitleColor:Color_Whitle frame:CGRectMake((imgBg.frameWidth - Width(233))/2, txtContent.frameBottom + 11, Width(233), buttonHeight)];
        btnUpdate.layer.cornerRadius = 17;
//        btnUpdate.backgroundColor = kColor(redColor);
        [btnUpdate addButtonClickBlock:^(UIButton *btn) {
            weakSelf.updateViewDismiss();
            openUrl(self->updateUrl);
            [Global shareGlobal].isShowUpdate = NO;
            [self dismiss];
        }];
        [imgBg addSubview:btnUpdate];
        
        UIButton *btnCancel = [MTools createButtonWithTitle:[NSString stringWithFormat:@"稍后%@",_titleKey] Font:kFont(14) TitleColor:Color_Whitle];
        btnCancel.frame = CGRectMake(0, btnUpdate.frameBottom, imgBg.frameWidth, 36);
        [btnCancel addButtonClickBlock:^(UIButton *btn) {
            weakSelf.cancelAction();
            [Global shareGlobal].isShowUpdate = NO;
            [self dismiss];
        }];
        [imgBg addSubview:btnCancel];
        
        imgBg.frameHeight = btnCancel.frameBottom;
    }
    // 四个数值对应图片中距离上、左、下、右边界的不拉伸部分的范围宽度
//    img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(200, 35, 35, 35) resizingMode:UIImageResizingModeStretch];
    imgBg.layer.cornerRadius = 10;
    imgBg.center = self.view.center;
    
    [imgBg beginAnimation];
    
}

-(void)showAnimation{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@(0.01), @(1.2), @(0.9), @(1)];
    animation.keyTimes = @[@(0), @(0.4), @(0.6), @(1)];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    animation.duration = 0.5;
//    animation.delegate = self;
//    [animation setValue:completion forKey:@"handler"];
    [imgBg.layer addAnimation:animation forKey:@"bouce"];
}

//打开更新链接
- (void)updateNewVersion
{
    NSURL *url = [NSURL URLWithString:updateUrl];
    [[UIApplication sharedApplication] openURL:url];
    [self dismiss];
}

-(void)dismiss{
    
    [imgBg dismissAnimation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [super dismiss];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

