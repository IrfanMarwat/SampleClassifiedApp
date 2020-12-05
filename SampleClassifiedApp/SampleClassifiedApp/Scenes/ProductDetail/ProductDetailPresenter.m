//
//  ProductDetailPresenter.m
//  SampleClassifiedApp
//
//  Created by irfan on 04/12/2020.
//

#import "ProductDetailPresenter.h"
#import "SampleClassifiedApp-Swift.h"
#import "ProductDetailViewModel.h"

@implementation ProductDetailPresenter

-(void)presentProductDetail: (Product *) product {
    ProductDetailViewModel *viewModel = [[ProductDetailViewModel alloc] init];
    viewModel.name = product.name;
    viewModel.price = product.price;
    viewModel.date = product.dateCreated;
    viewModel.imageUrl = product.imageUrl.firstObject;
    
    self.viewController.viewModel = viewModel;
    
    [self.viewController setupView];
}

@end
