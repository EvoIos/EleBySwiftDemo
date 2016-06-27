//
//  TakeawayFilterModel.m
//  ElmDemo
//
//  Created by zhenglanchun on 16/6/4.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "TakeawayFilterModel.h"

@implementation TakeawayFilterModel



+ (NSDictionary *)objectClassInArray{
    return @{@"categoryAllInfo" : [Categoryallinfo class]};
}
@end


@implementation Categoryallinfo

+ (NSDictionary *)objectClassInArray{
    return @{@"categoryDetails" : [Categorydetails class]};
}

@end


@implementation Categorydetails

@end


