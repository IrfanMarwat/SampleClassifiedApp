//
//  ProductDetailPresenter.h
//  SampleClassifiedApp
//
//  Created by irfan on 04/12/2020.
//

#import <Foundation/Foundation.h>
#import "ProductDetailViewController.h"

@class Product;

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailPresenter : NSObject

@property(nonatomic, weak) ProductDetailViewController *viewController;
-(void)presentProductDetail: (Product *) product;

@end

NS_ASSUME_NONNULL_END
