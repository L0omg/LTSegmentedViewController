//
//  ViewController.m
//  LTSegmentedViewController
//
//  Created by LYP on 15/9/13.
//  Copyright (c) 2015年 LYP. All rights reserved.
//

#import "ViewController.h"
#import "LTSegmentedItem.h"
#import "XIBItem.h"
#import "LTUnderLineSegmentedView.h"
#import "LTCoverSegmentedView.h"
#import "NSLayoutConstraint+ActiveConstraint.h"
#import "ContentViewController.h"
#import "LTSegmentedViewController.h"
@interface ViewController ()<LTSegmentedViewControllerDataSource>
@property (nonatomic, strong) ContentViewController *firstViewController;
@property (nonatomic, strong) ContentViewController *secondViewController;
@property (nonatomic, strong) ContentViewController *thirdViewController;
@property (nonatomic, strong) ContentViewController *fourthViewController;
@property (nonatomic, strong) ContentViewController *fifthViewController;
@property (nonatomic, strong) ContentViewController *sixthViewController;
@property (nonatomic, strong) ContentViewController *seventhViewController;
@property (nonatomic, strong) ContentViewController *eighthViewController;
@property (nonatomic, strong) ContentViewController *ninthViewController;
@property (nonatomic, strong) ContentViewController *tenthViewController;
@property (nonatomic, strong) LTSegmentedViewController *segmentedViewController;
@property (nonatomic, strong) LTSegmentedView *segmentedView;

@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, assign) BOOL animation;

@end

@implementation ViewController

- (void) loadView{
    
    self.view = [[UIView alloc] initWithFrame:CGRectZero];
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.viewControllers = @[self.firstViewController, self.secondViewController, self.thirdViewController, self.fourthViewController, self.fifthViewController, self.sixthViewController, self.seventhViewController, self.eighthViewController, self.ninthViewController, self.tenthViewController];
    
    UIView *pageView = self.segmentedViewController.view;
    pageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSArray *v_Constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[pageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(pageView)];
    NSArray *h_Constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[pageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(pageView)];
    [NSLayoutConstraint fm_ActiveConstraints:v_Constraints toView:self.view];
    [NSLayoutConstraint fm_ActiveConstraints:h_Constraints toView:self.view];
    
    UIBarButtonItem* itemOne = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStyleDone target:self action:@selector(jumpToOnePage)];
    UIBarButtonItem* itemTen = [[UIBarButtonItem alloc] initWithTitle:@"-" style:UIBarButtonItemStyleDone target:self action:@selector(jumpToTenPage)];
    UIBarButtonItem* itemIns = [[UIBarButtonItem alloc] initWithTitle:@"^" style:UIBarButtonItemStyleDone target:self action:@selector(insertItem)];
    self.navigationItem.rightBarButtonItems = @[itemOne, itemTen, itemIns];
}

- (void) jumpToOnePage{
    
    [self.segmentedView addItem:[[LTSegmentedItem alloc] initWithTitle:[NSString stringWithFormat:@"%ld", (long)self.segmentedView.items.count] icon:[UIImage imageNamed:@"fengxian"] action:^(LTSegmentedItem *item) {
        
        
    }]];
//    [self.segmentedViewController jumpToPage:1];
}

- (void) jumpToTenPage{
    
    [self.segmentedView removeItemAtIndex:self.segmentedView.selectedIndex];
//    [self.segmentedViewController jumpToPage:8];
}

- (void) insertItem{
    
    
    [self.segmentedView insertItem:[[LTSegmentedItem alloc] initWithTitle:[NSString stringWithFormat:@"%ld", (long)self.segmentedView.items.count] icon:[UIImage imageNamed:@"fengxian"] action:^(LTSegmentedItem *item) {
        
        
    }] atIndex:self.segmentedView.selectedIndex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Protocol
#pragma mark LTSegmentedViewControllerDataSource <NSObject>
- (UIViewController*) segmentedViewController:(LTSegmentedViewController*) segmentedViewController viewControllerAtIndex:(NSInteger) index{
    
    if (index < self.viewControllers.count) {
        
        return self.viewControllers[index];
    }
    
    return nil;
}

- (NSInteger) segmentedViewController:(LTSegmentedViewController*) segmentedViewController indexAtViewController:(UIViewController*) viewController{
    
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    if (index == NSNotFound) {
        
        index = 0;
    }
    
    return index;
}
#pragma mark -Accessor
- (LTSegmentedViewController*) segmentedViewController{
    
    if (!_segmentedViewController) {
        
        _segmentedViewController = [[LTSegmentedViewController alloc] initWithSegmentedView:self.segmentedView dataSource:self];
        _segmentedViewController.embedSegmentedView = YES;
        [self willMoveToParentViewController:_segmentedViewController];
        [self addChildViewController:_segmentedViewController];
        [self.view addSubview:_segmentedViewController.view];
    }
    
    return _segmentedViewController;
}

- (LTSegmentedView*) segmentedView{
    
    if (!_segmentedView) {
        
        __weak typeof(self) weakSelf = self;
        NSMutableArray *items = [NSMutableArray arrayWithCapacity:0];
        if ([self.segmentItemClassName isEqualToString:NSStringFromClass([XIBItem class])]){
            
            NSArray *titles = @[@"花样滑冰" ,@"棒球", @"保龄球", @"冰壶", @"网球", @"滑冰", @"电子竞技", @"橄榄球", @"高尔夫球", @"滑板车"];
            for (NSUInteger i = 0; i < 10; i ++) {
                
                UIImage *normalImage = [UIImage imageNamed:[NSString stringWithFormat:@"%ld_gray", (long)i]];
                UIImage *selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%ld_green", (long)i]];
                UIColor *normalColor = UIColorFromRGBHex(0xAAAAAA);
                UIColor *selectedColor = [UIColor greenColor];
                
                XIBItem *item = [XIBItem itemWithImage:normalImage title:titles[i]];
                [item setImage:normalImage state:XIBItemStateNormal];
                [item setImage:selectedImage state:XIBItemStateSelected];
                [item setTextColor:normalColor state:XIBItemStateNormal];
                [item setTextColor:selectedColor state:XIBItemStateSelected];
                [items addObject:item];
            }
        }else{
            
            for (NSUInteger i = 0; i < 10; i++) {
                
                LTSegmentedItem *item = [[LTSegmentedItem alloc] initWithTitle:[self.viewControllers[i] title] icon:nil action:^(LTSegmentedItem *item) {
                    
                    [weakSelf.segmentedViewController jumpToPage:i];
                }];
                
                [items addObject:item];
            }
        }
        
        LTSegmentedView *segmentedView = [[NSClassFromString(self.segmentViewClassName) alloc] initWithItems:items];
        segmentedView.contentView.backgroundColor = [UIColor whiteColor];
        segmentedView.seperateLineView.backgroundColor = UIColorFromRGBHex(0xDEDEDE);
        _segmentedView = segmentedView;
    }
    
    return _segmentedView;
}

- (ContentViewController*) firstViewController{
    
    if (!_firstViewController) {
        
        _firstViewController = [[ContentViewController alloc] init];
        _firstViewController.title = @"First";
    }
    
    return _firstViewController;
}

- (ContentViewController*) secondViewController{
    
    if (!_secondViewController) {
        
        _secondViewController = [[ContentViewController alloc] init];
        _secondViewController.title = @"Second";
    }
    
    return _secondViewController;
}

- (ContentViewController*) thirdViewController{
    
    if (!_thirdViewController) {
        
        _thirdViewController = [[ContentViewController alloc] init];
        _thirdViewController.title = @"Third";
    }
    
    return _thirdViewController;
}

- (ContentViewController*) fourthViewController{
    
    if (!_fourthViewController) {
        
        _fourthViewController = [[ContentViewController alloc] init];
        _fourthViewController.title = @"Fourth";
    }
    
    return _fourthViewController;
}

- (ContentViewController*) fifthViewController{
    
    if (!_fifthViewController) {
        
        _fifthViewController = [[ContentViewController alloc] init];
        _fifthViewController.title = @"Fifth";
    }
    
    return _fifthViewController;
}

- (ContentViewController*) sixthViewController{
    
    if (!_sixthViewController) {
        
        _sixthViewController = [[ContentViewController alloc] init];
        _sixthViewController.title = @"sixth";
    }
    
    return _sixthViewController;
}

- (ContentViewController*) seventhViewController{
    
    if (!_seventhViewController) {
        
        _seventhViewController = [[ContentViewController alloc] init];
        _seventhViewController.title = @"seventh";
    }
    
    return _seventhViewController;
}

- (ContentViewController*) eighthViewController{
    
    if (!_eighthViewController) {
        
        _eighthViewController = [[ContentViewController alloc] init];
        _eighthViewController.title = @"eight";
    }
    
    return _eighthViewController;
}

- (ContentViewController*) ninthViewController{
    
    if (!_ninthViewController) {
        
        _ninthViewController = [[ContentViewController alloc] init];
        _ninthViewController.title = @"ninth";
    }
    
    return _ninthViewController;
}

- (ContentViewController*) tenthViewController{
    
    if (!_tenthViewController) {
        
        _tenthViewController = [[ContentViewController alloc] init];
        _tenthViewController.title = @"tenth";
    }
    
    return _tenthViewController;
}
@end
