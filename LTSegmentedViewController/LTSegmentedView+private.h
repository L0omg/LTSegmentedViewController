//
//  LTSegmentedView+private.h
//  LTSegmentedViewController
//
//  Created by LYP on 15/10/23.
//  Copyright © 2015年 LYP. All rights reserved.
//

#import "LTSegmentedView.h"

@interface LTSegmentedView (private)
- (UIView*) selectedItem;
- (UIView*) itemOfIndex:(NSInteger) index;
- (CGFloat) itemWidth;
- (NSInteger) minimumIndex;
- (NSInteger) maximumIndex;
- (NSInteger) validIndexAt:(NSInteger) index;
- (NSInteger) isValidIndex:(NSInteger) index;
- (NSInteger) frontIndex:(NSInteger) theIndex another:(NSInteger) otherIndex;
- (NSInteger) backIndex:(NSInteger) theIndex another:(NSInteger) otherIndex;
- (CGFloat) minimunOffset;
- (CGFloat) maximumOffset;
- (CGFloat) validOffsetAt:(CGFloat) offSet;
@end
