//
//  ViewController.h
//  LTSegmentedViewController
//
//  Created by LYP on 15/9/13.
//  Copyright (c) 2015年 LYP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTPageViewController.h"
@interface ViewController : UIViewController<LTPageViewControllerDataSource, LTPageViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) LTPageViewController *pageViewController;

@end

