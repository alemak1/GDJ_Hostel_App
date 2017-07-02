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
    BARBECUE,
    CELL_PHONE,
    HAIRCUT,
    KIMCHI_STEW,
    MAKEUP,
    NOODLES,
    RED_SHIRT,
    SIM_CARD,
    LAST_ASSORTED_PRODUCT_INDEX
}AssortedProductCategory;

#endif /* ProductCategory_h */