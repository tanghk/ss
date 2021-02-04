//
//  UIButton+CusButton.m
//  iMuGou
//

#import "UIButton+CusButton.h"
#import <objc/runtime.h>

static char * const btnBlocKey = "btnBlock";

@implementation UIButton (CusButton)

-(void)setBtnBlock:(BtnBlock)btnBlock
{
    objc_setAssociatedObject(self, btnBlocKey, btnBlock, OBJC_ASSOCIATION_COPY);
}

-(BtnBlock)btnBlock
{
    return  objc_getAssociatedObject(self, btnBlocKey);
}

-(void)addButtonClickBlock:(BtnBlock)btnBlock{
    
    [self addTarget:self action:@selector(btnBlockClick:) forControlEvents:UIControlEventTouchUpInside];
    self.btnBlock = btnBlock;
}


-(void)btnBlockClick:(UIButton *)btn
{
    if (self.btnBlock) {
        self.btnBlock(btn);
    }
}




@end
