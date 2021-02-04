//
//  UIButton+CusButton.h
//  iMuGou
//
//  Created by 创业酵母 on 2021/01/21.
//


#import <UIKit/UIKit.h>

typedef void(^BtnBlock)(UIButton * btn);

@interface UIButton (CusButton)

@property(nonatomic, copy)BtnBlock btnBlock;


-(void)addButtonClickBlock:(BtnBlock)btnBlock;

@end
