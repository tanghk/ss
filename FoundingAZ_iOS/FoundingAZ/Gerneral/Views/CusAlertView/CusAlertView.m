//
//  CusAlertView.m
//  iMuGou
//

#import "CusAlertView.h"
#import <objc/runtime.h>

const char *KCusAlertViewIndexBlock = "CusAlertViewIndexBlock";
const char *KCusAlertViewOkBlock = "CusAlertViewOkBlock";
const char *KCusAlertViewCancelBlock = "CusAlertViewCancelBlock";

@interface UIAlertView (CusAlertView)

@property (nonatomic,copy)CusAlertViewClickedWithIndex indexBlock;
@property (nonatomic,copy)CusAlertViewOkClicked okBlock;
@property (nonatomic,copy)CusAlertViewCancelClicked cancelBlock;

@end

@implementation UIAlertView (CusAlertView)

-(void)setIndexBlock:(CusAlertViewClickedWithIndex)indexBlock{
    objc_setAssociatedObject(self, KCusAlertViewIndexBlock, indexBlock, OBJC_ASSOCIATION_COPY);
}

-(CusAlertViewClickedWithIndex)indexBlock{
    return objc_getAssociatedObject(self, KCusAlertViewIndexBlock);
}

-(void)setOkBlock:(CusAlertViewOkClicked)okBlock{
    objc_setAssociatedObject(self, KCusAlertViewOkBlock, okBlock, OBJC_ASSOCIATION_COPY);
}

-(CusAlertViewOkClicked)okBlock{
    return objc_getAssociatedObject(self, KCusAlertViewOkBlock);
}

-(void)setCancelBlock:(CusAlertViewCancelClicked)cancelBlock{
    objc_setAssociatedObject(self, KCusAlertViewCancelBlock, cancelBlock, OBJC_ASSOCIATION_COPY);
}

-(CusAlertViewCancelClicked)cancelBlock{
    return objc_getAssociatedObject(self, KCusAlertViewCancelBlock);
}

@end

@interface CusAlertView ()<UIAlertViewDelegate>

@end


@implementation CusAlertView

#pragma mark -

+ (void)showCusAlertViewWithTitle:(NSString *)title message:(NSString *)msg cancleButtonTitle:(NSString *)cancelTitle clickHandle:(CusAlertViewClickedWithIndex) handle{
    UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:handle ? self : nil cancelButtonTitle:cancelTitle otherButtonTitles: nil];
    if (handle) {
        alert.indexBlock = handle;
    }
    [alert show];

}

+ (void)showCusAlertViewWithTitle:(NSString *)title message:(NSString *)msg cancleButtonTitle:(NSString *)cancelTitle okButtonTitle:(NSString *)okTitle otherButtonTitleArray:(NSArray*)otherTitleArray clickHandle:(CusAlertViewClickedWithIndex)handle{
    UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:handle ? self : nil cancelButtonTitle:cancelTitle otherButtonTitles:okTitle, nil];
    if (handle) {
        alert.indexBlock = handle;
    }
    for (NSString *otherTitle in otherTitleArray) {
        [alert addButtonWithTitle:otherTitle];
    }
    [alert show];
}
#pragma mark -
+ (void)showCusAlertViewWithTitle:(NSString *)title message:(NSString *)msg cancleButtonTitle:(NSString *)cancelTitle okButtonTitle:(NSString *)okTitle okClickHandle:(CusAlertViewOkClicked)okHandle cancelClickHandle:(CusAlertViewCancelClicked)cancelClickHandle{
    UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:okTitle,nil];
    if (okHandle) {
        alert.okBlock = okHandle;
    }
    if (cancelTitle) {
        alert.cancelBlock = cancelClickHandle;
    }
    [alert show];
}

#pragma mark -
+ (void)showCusAlertViewWithTitle:(NSString *)title message:(NSString *)msg cancleButtonTitle:(NSString *)cancelTitle okButtonTitle:(NSString *)okTitle otherButtonTitleArray:(NSArray*)otherTitleArray{
    [self showCusAlertViewWithTitle:title message:msg cancleButtonTitle:cancelTitle okButtonTitle:okTitle otherButtonTitleArray:otherTitleArray clickHandle:nil];
}

#pragma mark - UIAlertViewDelegate
+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.indexBlock) {
        alertView.indexBlock(buttonIndex);
    }else{
        if (buttonIndex == 0) {//取消
            if (alertView.cancelBlock) {
                alertView.cancelBlock();
            }
        }else{//确定
            if (alertView.okBlock) {
                alertView.okBlock();
            }
        }
    }
}

@end
