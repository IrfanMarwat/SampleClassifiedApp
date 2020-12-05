//
//  ProductDetailViewController.h
//  SampleClassifiedApp
//
//  Created by irfan on 04/12/2020.
//

#import <UIKit/UIKit.h>
#import "ProductDetailViewModel.h"
#import "ProductDetailInteractor.h"

NS_ASSUME_NONNULL_BEGIN


@interface ProductDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageViewProduct;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UIView *gradientView;

@property(nonatomic, retain) ProductDetailViewModel *viewModel;
@property(nonatomic, strong) ProductDetailInteractor *interactor;

-(void)setupView;
-(void)setupInteractor;

@end

NS_ASSUME_NONNULL_END
