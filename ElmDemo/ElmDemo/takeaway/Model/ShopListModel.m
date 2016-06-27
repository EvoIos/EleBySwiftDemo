//
//  ShopListModel.m
//  ElmDemo
//
//  Created by z on 16/6/21.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "ShopListModel.h"

@implementation ShopListModel

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [ShopListData class]};
}
@end
@implementation ShopListData

+ (NSDictionary *)objectClassInArray{
    return @{@"shopList" : [ShoplistItem class]};
}

@end


@implementation ShoplistItem

+ (NSDictionary *)objectClassInArray{
    return @{@"specification" : [ShopListSpecification class]};
}

@end


@implementation ShopListSpecification

@end


