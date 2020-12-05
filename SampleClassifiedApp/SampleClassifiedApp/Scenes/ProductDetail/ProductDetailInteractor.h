//
//  ProductDetailInteractor.h
//  SampleClassifiedApp
//
//  Created by irfan on 04/12/2020.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@class Product;

@interface ProductDetailInteractor : NSObject

@property(nonatomic, assign) Product *product;
@property(nonatomic, retain) id presenter;

-(void)presentProductDetail;

@end

NS_ASSUME_NONNULL_END
