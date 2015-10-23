//
//  LTSegmentedView+private.m
//  LTSegmentedViewController
//
//  Created by LYP on 15/10/23.
//  Copyright © 2015年 LYP. All rights reserved.
//

#import "LTSegmentedView+private.h"

@implementation LTSegmentedView (private)
- (LTSegmentedItem*) selectedItem{
    
    if (self.selectedIndex >= 0 && self.selectedIndex < self.items.count) {
        
        return self.items[self.selectedIndex];
    }
    
    return nil;
}

- (CGFloat) itemWidth{
    
    if (self.items.count == 0) {
        
        return 0;
    }else{
        
        return (self.contentView.contentSize.width / self.items.count);
    }
}

- (NSInteger) minimumIndex{
    
    return 0;
}

- (NSInteger) maximumIndex{
    
    return self.items.count - 1;
}

- (NSInteger) validIndexAt:(NSInteger) index{
    
    if (index < self.minimumIndex) {
        
        index = self.minimumIndex;
    }else if (index > self.maximumIndex){
        
        index = self.maximumIndex;
    }
    
    return index;
}

- (NSInteger) isValidIndex:(NSInteger) index{
    
    if (index < self.minimumIndex || index > self.maximumIndex) {
        
        return NO;
    }
    return YES;
}

- (NSInteger) frontIndex:(NSInteger) theIndex another:(NSInteger) otherIndex{
    
    NSInteger frontIndex = theIndex;
    if (frontIndex > otherIndex) {
        
        frontIndex = otherIndex;
    }
    
    return [self validIndexAt:frontIndex];
}

- (CGFloat) minimunOffset{
    
    return 0.f;
}

- (CGFloat) maximumOffset{
    
    return self.contentView.contentSize.width - CGRectGetWidth(self.contentView.frame);
}

- (CGFloat) validOffsetAt:(CGFloat) offSet{
    
    if (offSet < self.minimunOffset) {
        
        offSet = self.minimunOffset;
    }else if (offSet > self.maximumOffset){
        
        offSet = self.maximumOffset;
    }
    
    return offSet;
}
@end
