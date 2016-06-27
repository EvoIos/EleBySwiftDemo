//
//  TakeawayFilterModel.h
//  ElmDemo
//
//  Created by zhenglanchun on 16/6/4.
//  Copyright © 2016年 LC. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Categoryallinfo,Categorydetails;
@interface TakeawayFilterModel : NSObject

@property (nonatomic, strong) NSArray<Categoryallinfo *> *categoryAllInfo;


@end



@interface Categoryallinfo : NSObject

@property (nonatomic, strong) NSArray<Categorydetails *> *categoryDetails;

@property (nonatomic, copy) NSString *categoryName;

@property (nonatomic, copy) NSString *categorImg;

@property (nonatomic, assign) NSInteger categoryTotalCount;

@end

@interface Categorydetails : NSObject

@property (nonatomic, copy) NSString *shopItemName;

@property (nonatomic, copy) NSString *shopItemCount;

@end

