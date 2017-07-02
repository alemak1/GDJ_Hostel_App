//
//  ProductPriceDisplayController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/2/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "ProductPriceDisplayController.h"
#import "NSString+CurrencyHelperMethods.h"
#import "CurrencyType.h"

@interface ProductPriceDisplayController () <UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *currencyPickerView;


@end

@implementation ProductPriceDisplayController

-(void)viewDidLoad{
    
    [self.currencyPickerView setDelegate:self];
    [self.currencyPickerView setDataSource:self];
    
}


#pragma mark ********** PICKER VIEW DELEGATE AND DATA SOURCE METHODS

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    return 200;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return LAST_CURRENCY_INDEX;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [NSString getCurrencyNameForCurrencyType:(CurrencyType)row];
}

@end

