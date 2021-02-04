//
//  MineItemsCell.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import "BaseCollectionCell.h"
#import "MineModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MineItemsCell : BaseCollectionCell
- (void)configureCellWithModel:(MineModel *)contentModel;
@end

NS_ASSUME_NONNULL_END
