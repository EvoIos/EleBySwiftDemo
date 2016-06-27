//
//  TakeawayHomeModel.h
//  ElmDemo
//
//  Created by z on 16/6/2.
//  Copyright © 2016年 LC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class TakeawayHomeShoplist,TakeawayHomeShopinfo,TakeawayHomeSelfattributes,TakeawayHomeExtendedattributes;
@interface TakeawayHomeModel : NSObject

@property (nonatomic, strong) NSArray<TakeawayHomeShoplist *> *ShopList;

@end
@interface TakeawayHomeShoplist : NSObject

@property (nonatomic, strong) TakeawayHomeShopinfo *ShopInfo;

@property (nonatomic, strong) NSArray<TakeawayHomeExtendedattributes *> *extendedAttributes;

@end

@interface TakeawayHomeShopinfo : NSObject

@property (nonatomic, copy) NSString *develiyTime;

@property (nonatomic) CGFloat shippingCosts;

@property (nonatomic) CGFloat shopRatings;

@property (nonatomic, copy) NSString *shopName;

@property (nonatomic, copy) NSString *shopImg;

@property (nonatomic, copy) NSString *shippingGetPrice;

@property (nonatomic, copy) NSString *develiyDistance;

@property (nonatomic, strong) NSArray<TakeawayHomeSelfattributes *> *selfAttributes;

@property (nonatomic, copy) NSString *shopSoldCopies;

@end

@interface TakeawayHomeSelfattributes : NSObject

@property (nonatomic, copy) NSString *attributes;

@end

@interface TakeawayHomeExtendedattributes : NSObject

@property (nonatomic, copy) NSString *extendedLabel;

@property (nonatomic, copy) NSString *extendedDetails;

@end

