//
//  ContentViewController.m
//  LTSegmentedViewController
//
//  Created by LYP on 15/10/5.
//  Copyright © 2015年 LYP. All rights reserved.
//

#import "ContentViewController.h"
#import "NSLayoutConstraint+ActiveConstraint.h"
@interface ContentViewController ()
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ContentViewController

- (void) loadView{
    self.view = [[UIView alloc] initWithFrame:CGRectZero];
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view    
    UILabel *label = self.titleLabel;
    [self.view addSubview:label];
    
    NSLayoutConstraint *centerX_Constraint = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0.f];
    NSLayoutConstraint *centerY_Constraint = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0.f];
    [centerX_Constraint fm_ActiveToView:self.view];
    [centerY_Constraint fm_ActiveToView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString*) description{
    
    return self.titleLabel.text;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) setTitle:(NSString *)title{
    
    [super setTitle:title];
    
    self.titleLabel.text = title;
}

- (UILabel*) titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.font = [UIFont boldSystemFontOfSize:25];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
