//
//  ProductDetailInteractor.m
//  SampleClassifiedApp
//
//  Created by irfan on 04/12/2020.
//

#import "ProductDetailInteractor.h"
#import "ProductDetailPresenter.h"

@implementation ProductDetailInteractor

-(void)presentProductDetail {
    [((ProductDetailPresenter *)self.presenter) presentProductDetail: _product];
}


@end
