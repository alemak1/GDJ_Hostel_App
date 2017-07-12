//
//  ProductCategory.h
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/2/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef ProductCategory_h
#define ProductCategory_h

typedef enum GeneralProductCategory{
    BEVERAGE,
    LAST_GENERAL_PRODUCT_CATEGORY
    
}GeneralProductCategory;

typedef enum SpecificProductCategory{
    DAESO_TEA,
    LAST_SPECIFIC_PRODUCT_CATEGORY
    
}SpecificProductCategory;


typedef enum AssortedProductCategory{
    BEER = 0,   //0
    CEREAL = 1,
    COMPUTER = 2,
    BLENDER = 3,
    TV = 4,
    RICE_COOKER = 5,
    MICROWAVE = 6,
    FRUIT = 7,
    COFFEE = 8,
    KIMCHI_STEW = 9,
    CLOTHES = 10,
    SIM_CARD = 11,
    CELL_PHONE = 12,
    LAST_ASSORTED_PRODUCT_INDEX,
    BARBECUE,
    HAIRCUT,
    MAKEUP,
    NOODLES
}AssortedProductCategory;

#endif /* ProductCategory_h */
