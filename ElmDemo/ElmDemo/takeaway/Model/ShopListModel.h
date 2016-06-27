//
//  ShopListModel.h
//  ElmDemo
//
//  Created by z on 16/6/21.
//  Copyright © 2016年 LC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ShopListData,ShoplistItem,ShopListSpecification;
@interface ShopListModel : NSObject

@property (nonatomic, strong) NSArray<ShopListData *> *data;

@end
@interface ShopListData : NSObject

@property (nonatomic, strong) NSArray<ShoplistItem *> *shopList;

@property (nonatomic, copy) NSString *categories;

@end

@interface ShoplistItem : NSObject

@property (nonatomic, assign) NSInteger oldPrice;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, assign) CGFloat rateScore;

@property (nonatomic, strong) NSArray<ShopListSpecification *> *specification;

@property (nonatomic, copy) NSString *tips;

@property (nonatomic, assign) NSInteger monthSoldCopies;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *img;

@end

@interface ShopListSpecification : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger price;

@end

