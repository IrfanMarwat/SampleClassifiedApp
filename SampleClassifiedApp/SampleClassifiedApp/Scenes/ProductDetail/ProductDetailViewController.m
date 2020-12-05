//
//  ProductDetailViewController.m
//  SampleClassifiedApp
//
//  Created by irfan on 04/12/2020.
//

#import "ProductDetailViewController.h"
#import "SampleClassifiedApp-Swift.h"
#import "ProductDetailPresenter.h"
#import <UIKit/UIKit.h>


@interface ProductDetailViewController ()


@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.interactor presentProductDetail];
    [self setupView];
    [self setNavigationBarTransparentWithTintColor:UIColor.redColor];
    [self applyGradient];
}

-(void)setupView {
    self.labelName.text = self.viewModel.name;
    self.labelPrice.text = self.viewModel.price;
    self.labelDate.text = self.viewModel.date;
    UIImage *placeholder = [UIImage imageNamed:@"placeholder"];
    [self.imageViewProduct downloadImage:self.viewModel.imageUrl isThumbnail:FALSE placeholder:placeholder showIndicator:FALSE completion:^(BOOL success) {
    }];
}

-(void)setupInteractor {
    self.interactor = [[ProductDetailInteractor alloc] init];
    ProductDetailPresenter *presenter = [[ProductDetailPresenter alloc] init];
    presenter.viewController = self;
    self.interactor.presenter = presenter;
}

-(void)applyGradient {
    UIColor *gradientColor = [[UIColor alloc] initWithWhite:26.0/255.0 alpha:1.0];
    UIColor *color1 = [gradientColor colorWithAlphaComponent:0.0];
    UIColor *color2 = [UIColor.blackColor colorWithAlphaComponent:1.0];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:color1];
    [array addObject:color2];
    
    [self.gradientView applyGradientWith:array layerFrame:CGRectZero];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
