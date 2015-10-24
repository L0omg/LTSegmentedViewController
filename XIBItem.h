//
//  XIBItem.h
//  LTSegmentedViewController
//
//  Created by LYP on 15/10/24.
//  Copyright © 2015年 LYP. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XIBItemState) {
    XIBItemStateNormal,
    XIBItemStateSelected,
};

@interface XIBItem : UIView
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
+ (instancetype) itemWithImage:(UIImage*) image title:(NSString*) title;
- (void) setImage:(UIImage*) image state:(XIBItemState) state;
- (void) setTextColor:(UIColor*) textColor state:(XIBItemState) state;
@end
