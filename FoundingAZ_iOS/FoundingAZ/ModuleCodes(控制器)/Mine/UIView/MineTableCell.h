//
//  MineTableCell.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import "BaseTableCell.h"
@class MineModel;

NS_ASSUME_NONNULL_BEGIN

@interface MineTableCell : BaseTableCell

- (void)configureCellWithModel:(MineModel *)contentModel withIndexPath:(NSIndexPath *)indexPath withArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
