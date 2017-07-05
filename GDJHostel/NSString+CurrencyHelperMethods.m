//
//  NSString+CurrencyHelperMethods.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/2/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "NSString+CurrencyHelperMethods.h"

@implementation NSString (CurrencyHelperMethods)


+(NSString*) getCurrencyAbbreviationForCurrencyType:(CurrencyType)currencyType{
    switch (currencyType) {
        case AUD:
            return @"AUD";
        case BGN:
            return @"BGN";
        case BRL:
            return @"BRL";
        case CAD:
            return @"CAD";
        case CHF:
            return @"CHF";
        case CNY:
            return @"CNY";
        case CZK:
            return @"CZK";
        case DKK:
            return @"DKK";
        case GBP:
            return @"GBP";
        case HKD:
            return @"HKD";
        case HRK:
            return @"HRK";
        case HUF:
            return @"HUF";
        case JPY:
            return @"JPY";
        case KRW:
            return @"KRW";
        case MYR:
            return @"MYR";
        case NOK:
            return @"NOK";
        case NZD:
            return @"NZD";
        case PHP:
            return @"PHP";
        case PLN:
            return @"PLN";
        case RON:
            return @"RON";
        case RUB:
            return @"RUB";
        case SEK:
            return @"SEK";
        case SGD:
            return @"SGD";
        case THB:
            return @"THB";
        case USD:
            return @"USD";
        default:
            return nil;
    }
    
    return nil;
}

+(NSString*) getCurrencyNameForCurrencyType:(CurrencyType)currencyType{
    switch (currencyType) {
        case AUD:
            return @"Australian Dollar";
        case BGN:
            return @"Bulgarian Lev";
        case BRL:
            return @"Brazilian Real";
        case CAD:
            return @"Canadian Dollar";
        case CHF:
            return @"Swiss France";
        case CNY:
            return @"Chinese Yen";
        case CZK:
            return @"Czech Koruan";
        case DKK:
            return @"Danish Krone";
        case GBP:
            return @"British Pound";
        case HKD:
            return @"Hong Kong Dollar";
        case HRK:
            return @"Croatian Kuna";
        case HUF:
            return @"Hungarian Forint";
        case JPY:
            return @"Japanese Yen";
        case KRW:
            return @"Korean Won";
        case MYR:
            return @"Malaysian Ringgit";
        case NOK:
            return @"Norwegian Krone";
        case NZD:
            return @"New Zealand Dollar";
        case PHP:
            return @"Phillippines Peso";
        case PLN:
            return @"Polish Zloty";
        case RON:
            return @"Romanian Leu";
        case RUB:
            return @"Russian Ruble";
        case SEK:
            return @"Swedish Krona";
        case SGD:
            return @"Singapore Dollar";
        case THB:
            return @"Thai Baht";
        case USD:
            return @"US Dollar";
        default:
            return nil;
    }
    return nil;
}

+(NSString*)getAssortedProductImagePathFor:(AssortedProductCategory)productCategory{
    switch (productCategory) {
        case KIMCHI_STEW:
            return @"kimchi_stew";
        case NOODLES:
            return @"noodles";
        case MAKEUP:
            return @"makeup";
        case SIM_CARD:
            return @"sim_card";
        case CLOTHES:
            return @"red_shirt";
        case BARBECUE:
            return @"barbecue";
        case CELL_PHONE:
            return @"cell_phone";
        case HAIRCUT:
            return @"haircut";
        case BEER:
            return @"beerA";
        case COMPUTER:
            return @"laptopA";
        case CEREAL:
            return @"cerealA";
        case MICROWAVE:
            return @"microwaveA";
        case BLENDER:
            return @"blenderA";
        case FRUIT:
            return @"fruitA";
        case COFFEE:
            return @"coffeeGlassA";
        case TV:
            return @"tvA";
        case RICE_COOKER:
            return @"riceCookerA";
        default:
            return nil;
    }
}

+(NSString*)getSearchQueryAssociatedWithAssortedProductCategory:(AssortedProductCategory)assortedProductCategory{
    
    switch(assortedProductCategory){
        case KIMCHI_STEW:
            return @"restaurant";
        case NOODLES:
            return @"noodle";
        case MAKEUP:
            return @"cosmetics";
        case SIM_CARD:
            return @"sim card";
        case CLOTHES:
            return @"clothes";
        case BARBECUE:
            return @"korean barbecue";
        case CELL_PHONE:
            return @"cell phone";
        case HAIRCUT:
            return @"haircut";
        case BEER:
            return @"convenience store";
        case COMPUTER:
            return @"electronics";
        case CEREAL:
            return @"emart";
        case MICROWAVE:
            return @"electronics";
        case BLENDER:
            return @"electronics";
        case FRUIT:
            return @"emart";
        case COFFEE:
            return @"convenience store";
        case TV:
            return @"electronics";
        case RICE_COOKER:
            return @"electronics";
        default:
            return nil;
    }
}

@end
