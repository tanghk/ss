//
//  VerfiyPhoneCell.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import "BaseTableCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface VerfiyPhoneCell : BaseTableCell

@property (nonatomic, strong) UITextField *phoneField;
@property (nonatomic, strong) UIButton *sendCodeBtn;
@property (nonatomic, strong) UIButton *clearBtn;

//倒计时按钮赋值
- (void)setWithCodeBtnTime:(NSInteger)afterTime isExistAfterTime:(BOOL)state;

@end

NS_ASSUME_NONNULL_END
