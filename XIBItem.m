//
//  XIBItem.m
//  LTSegmentedViewController
//
//  Created by LYP on 15/10/24.
//  Copyright © 2015年 LYP. All rights reserved.
//

#import "XIBItem.h"
#import "LTSegmentedViewItemProtocol.h"
@interface XIBItem()
@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *selectedImage;
@property (nonatomic, strong) UIColor *titleNormalColor;
@property (nonatomic, strong) UIColor *titleSelectedColor;
@end

@implementation XIBItem
+ (instancetype) itemWithImage:(UIImage*) image title:(NSString*) title{
    
    XIBItem *item = [[[NSBundle mainBundle] loadNibNamed:@"XIBItem" owner:nil options:nil] firstObject];
    item.iconImageView.image = image;
    item.textLabel.text = title;
    item.normalImage = image;
    item.selectedImage = image;
    item.titleNormalColor = [UIColor whiteColor];
    item.titleSelectedColor = [UIColor whiteColor];
    
    return item;
}

- (void) setImage:(UIImage*) image state:(XIBItemState) state{
    
    switch (state) {
        case XIBItemStateNormal:
        {
            self.normalImage = image;
        }
            break;
            
        case XIBItemStateSelected:
        {
            self.selectedImage = image;
        }
            break;
    }
}

- (void) setTextColor:(UIColor*) textColor state:(XIBItemState) state{
    
    switch (state) {
        case XIBItemStateNormal:
        {
            self.titleNormalColor = textColor;
        }
            break;
        
        case XIBItemStateSelected:
        {
            self.titleSelectedColor = textColor;
        }
            break;
    }
}

- (void) willSelectItem:(UIView<LTSegmentedViewItemProtocol>*) item percent:(CGFloat) percent{
    
    
}

- (void) didSelectItem:(UIView<LTSegmentedViewItemProtocol>*) item{
    
    self.textLabel.textColor = self.titleSelectedColor;
    self.iconImageView.image = self.selectedImage;
}

- (void) willDeselectItem:(UIView<LTSegmentedViewItemProtocol>*) item percent:(CGFloat) percent{
    
    
}

- (void) didDeselectItem:(UIView<LTSegmentedViewItemProtocol>*) item{
    
    self.textLabel.textColor = self.titleNormalColor;
    self.iconImageView.image = self.normalImage;
}
@end
