//
//  KoreanProduct.h
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/2/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef KoreanProduct_h
#define KoreanProduct_h

#import <Foundation/Foundation.h>
#import "ProductCategory.h"

@interface KoreanProduct : NSObject




typedef enum
@property NSString* name;
@property NSString* brand;
@property NSString* imagePath;
@property NSNumber* priceInKRW;
@property NSInteger unityQuantity;
@property GeneralProductCategory generalCategory;
@property SpecificProductCategory specificCategory;




@end

#endif /* KoreanProduct_h */
