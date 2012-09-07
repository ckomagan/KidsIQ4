//
//  NameViewPadController.h
//  KidsIQ4
//
//  Created by Chan Komagan on 8/26/12.
//  Copyright (c) 2012 KidsIQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NameViewIPadController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *choicesLabel;
    IBOutlet UILabel *errorStatus;
    IBOutlet UITextField *nameText;
    IBOutlet UITextField *choiceText;
    IBOutlet UIButton *nameOK;
    IBOutlet UIPickerView *levelPickerView;
    NSMutableArray *autoCompleteArray;
	NSMutableArray *elementArray, *lowerCaseElementArray;
	UITextField *txtField;
	UITableView *autoCompleteTableView;
}

@property (nonatomic, retain) NSArray *levelpicker;

@property (nonatomic, retain) UIPickerView *levelPickerView;

@property int maxQuestions;

-(IBAction)validateTextFields:(id)sender;
-(IBAction)dismissView;
-(IBAction)selectedRow;
-(IBAction)textFieldReturn:(id)sender;

@end