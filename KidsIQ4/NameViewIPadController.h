//
//  NameViewController.h
//  KidsIQ4
//
//  Created by Chan Komagan on 7/28/12.
//  Copyright (c) 2012 KidsIQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface NameViewIPadController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver, UIAlertViewDelegate, UITableViewDelegate, UITextFieldDelegate>
{
    IBOutlet UILabel *nameLabel, *titleLabel, *choicesLabel, *errorStatus;
    IBOutlet UIButton *nameOK, *backButton;
    IBOutlet UIPickerView *levelPickerView;
    IBOutlet UISegmentedControl *segmentedControl;
    IBOutlet UILabel *statusLabel;
    UIAlertView *askToPurchase;
    UITextField *nameText, *countryText;
    UITableView *countryTableView;
    NSMutableArray *autoCompleteArray, *elementArray, *lowerCaseElementArray;
}

@property (nonatomic, retain) NSArray *levelpicker;
@property (nonatomic, retain) UIPickerView *levelPickerView;
@property (nonatomic, retain)  UILabel *statusLabel;
@property (nonatomic, retain) NSMutableData *responseData;
@property int maxQuestions;

-(void)validateTextField;
-(IBAction)dismissView;
-(IBAction)textFieldReturn:(id)sender;
-(IBAction)valueChanged;
-(BOOL)IAPItemPurchased;
-(void)triggerPurchase;
-(IBAction)deleteKeyChain:(id)sender;

@end