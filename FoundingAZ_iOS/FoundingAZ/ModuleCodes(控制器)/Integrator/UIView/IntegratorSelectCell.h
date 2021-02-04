//
//  IntegratorSelectCell.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/24.
//

#import "BaseTableCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface IntegratorSelectCell : BaseTableCell

@property (nonatomic, strong) void(^IntegratorSelectReloadBlock)(void);

@end

NS_ASSUME_NONNULL_END
