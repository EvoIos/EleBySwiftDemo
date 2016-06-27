//
//  TakeawayHomeModel.m
//  ElmDemo
//
//  Created by z on 16/6/2.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "TakeawayHomeModel.h"

@implementation TakeawayHomeModel


+ (NSDictionary *)objectClassInArray{
    return @{@"ShopList" : [TakeawayHomeShoplist class]};
}
@end
@implementation TakeawayHomeShoplist

+ (NSDictionary *)objectClassInArray{
    return @{@"extendedAttributes" : [TakeawayHomeExtendedattributes class]};
}

@end


@implementation TakeawayHomeShopinfo

+ (NSDictionary *)objectClassInArray{
    return @{@"selfAttributes" : [TakeawayHomeSelfattributes class]};
}

@end


@implementation TakeawayHomeSelfattributes

@end


@implementation TakeawayHomeExtendedattributes

@end


