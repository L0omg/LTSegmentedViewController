//
//  RootViewController.m
//  LTSegmentedViewController
//
//  Created by LIYINGPENG on 15/10/12.
//  Copyright © 2015年 LYP. All rights reserved.
//

#import "RootViewController.h"
#import "NSLayoutConstraint+ActiveConstraint.h"
#import "ViewController.h"
#import "LTWYSegmentedView.h"
#import "LTUnderLineSegmentedView.h"
#import "LTCoverSegmentedView.h"
@interface RootViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"LTSegmentedViewController Demo";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self makeLayout];
}

- (void) makeLayout{
    
    UITableView *tableView = self.tableView;
    [self.view addSubview:tableView];
    
    NSArray *v_Constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tableView)];
    NSArray *h_Constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tableView)];
    [NSLayoutConstraint fm_ActiveConstraints:v_Constraints toView:self.view];
    [NSLayoutConstraint fm_ActiveConstraints:h_Constraints toView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Protocol
#pragma mark UITableViewDataSource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"网易风格";
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"下划线";
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"覆盖层 ";
        }
            break;
        default:
            break;
    }
    return cell;
}

#pragma mark UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ViewController *viewController = [[ViewController alloc] init];
    switch (indexPath.row) {
        case 0:
        {
            viewController.title = @"网易风格";
            viewController.segmentViewClassName = NSStringFromClass([LTWYSegmentedView class]);
        }
            break;
        case 1:
        {
             viewController.title = @"下划线";
            viewController.segmentViewClassName = NSStringFromClass([LTUnderLineSegmentedView class]);
        }
            break;
        case 2:
        {
            viewController.title = @"覆盖层";
            viewController.segmentViewClassName = NSStringFromClass([LTCoverSegmentedView class]);
        }
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark -Accessor 
- (UITableView*) tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    
    return _tableView;
}
@end
