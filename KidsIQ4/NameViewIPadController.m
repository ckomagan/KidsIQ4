//
//  NameViewPadController.m
//  KidsIQ4
//
//  Created by Chan Komagan on 8/26/12.
//  Copyright (c) 2012 KidsIQ. All rights reserved.
//

#import "NameViewIPadController.h"
#import "KidsIQ4ViewController.h"

@interface NameViewIPadController()
@end

@implementation NameViewIPadController
@synthesize levelpicker;
@synthesize levelPickerView;
@synthesize maxQuestions;
NSString *levelSelection;
int level;
int noOfPQuestions = 0;
float tableHeight = 60;

#define LEGAL	@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) finishedSearching {
	[txtField resignFirstResponder];
	autoCompleteTableView.hidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
    nameText.delegate = self;
    noOfPQuestions = maxQuestions;
    levelpicker = [NSArray arrayWithObjects:@"60", @"40",@"20",nil];
    levelPickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    levelPickerView.delegate = self;
    levelPickerView.showsSelectionIndicator = YES;
    [levelPickerView selectRow:1 inComponent:0 animated:YES];
    CGAffineTransform rotate = CGAffineTransformMakeRotation(3.14/2);
    rotate = CGAffineTransformScale(rotate, 0.3, 2.0);
    [self.levelPickerView setTransform:rotate];
    [self.view addSubview:levelPickerView];
    self.levelPickerView.center = CGPointMake(370,650);  
    [nameText setFrame:CGRectMake(150, 270, 450, 70)];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Country.txt" ofType:nil];
	NSData* data = [NSData dataWithContentsOfFile:filePath];
    
	//Convert the bytes from the file into a string
	NSString* string = [[NSString alloc] initWithBytes:[data bytes]
												 length:[data length] 
											   encoding:NSUTF8StringEncoding];
	
	//Split the string around newline characters to create an array
	NSString* delimiter = @"\n";
	NSArray *item = [string componentsSeparatedByString:delimiter];
	elementArray = [[NSMutableArray alloc] initWithArray:item];
	autoCompleteArray = [[NSMutableArray alloc] init];
    
	//Search Bar
	txtField = [[UITextField alloc] initWithFrame:CGRectMake(150, 420, 450, 70)];
	txtField.borderStyle = 3; // rounded, recessed rectangle
	txtField.autocorrectionType = UITextAutocorrectionTypeNo;
	txtField.textAlignment = UITextAlignmentLeft;
	txtField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	txtField.returnKeyType = UIReturnKeyDone;
	txtField.font = [UIFont fontWithName:@"Trebuchet MS" size:60];
	txtField.textColor = [UIColor blackColor];
	[txtField setDelegate:self];
	[self.view addSubview:txtField];
	
	//Autocomplete Table
	autoCompleteTableView = [[UITableView alloc] initWithFrame:CGRectMake(150, 465, 470, tableHeight) style:UITableViewStylePlain];
	autoCompleteTableView.delegate = self;
	autoCompleteTableView.dataSource = self;
	autoCompleteTableView.scrollEnabled = YES;
	autoCompleteTableView.hidden = YES; 
	autoCompleteTableView.rowHeight = tableHeight;
	[self.view addSubview:autoCompleteTableView];	

}

// Take string from Search Textfield and compare it with autocomplete array
- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
	
	// Put anything that starts with this substring into the autoCompleteArray
	// The items in this array is what will show up in the table view
	
	[autoCompleteArray removeAllObjects];
    
	for(NSString *curString in elementArray) {
		NSRange substringRangeLowerCase = [curString rangeOfString:[substring lowercaseString]];
		NSRange substringRangeUpperCase = [curString rangeOfString:[substring uppercaseString]];
        
		if (substringRangeLowerCase.length != 0 || substringRangeUpperCase.length != 0    ) {
			[autoCompleteArray addObject:curString];
		}
	}
	
	autoCompleteTableView.hidden = NO;
	[autoCompleteTableView reloadData];
}

// Close keyboard if the Background is touched
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self.view endEditing:YES];
	[super touchesBegan:touches withEvent:event];
    [self finishedSearching];
}

#pragma mark UITextFieldDelegate methods

// Close keyboard when Enter or Done is pressed
- (BOOL)textFieldShouldReturn:(UITextField *)textField {    
	BOOL isDone = YES;
	
	if (isDone) {
        [self finishedSearching];
		return YES;
	} else {
		return NO;
	}	
} 

// String in Search textfield
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(textField == txtField)
    {
        NSString *substring = [NSString stringWithString:textField.text];
        substring = [substring stringByReplacingCharactersInRange:range withString:string];
        [self searchAutocompleteEntriesWithSubstring:substring];
    }
	return YES;
}

#pragma mark UITableViewDelegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    
	//Resize auto complete table based on how many elements will be displayed in the table
	if (autoCompleteArray.count >=3) {
		autoCompleteTableView.frame = CGRectMake(150, 490, 259, tableHeight*3);
		return autoCompleteArray.count;
	}
	
	else if (autoCompleteArray.count == 2) {
		autoCompleteTableView.frame = CGRectMake(150, 490, 259, tableHeight*2);
		return autoCompleteArray.count;
	}	
	
	else {
		autoCompleteTableView.frame = CGRectMake(150, 490, 259, tableHeight);
		return autoCompleteArray.count;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = nil;
	static NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
	cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier] ;
	}
    
	cell.textLabel.text = [autoCompleteArray objectAtIndex:indexPath.row];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
	txtField.text = selectedCell.textLabel.text;
    [self finishedSearching];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [nameOK setEnabled:NO];
    
}

-(IBAction)validateTextFields:(id)sender
{
    // make sure all fields are have something in them
    if (nameText.text.length  > 0) {
        nameOK.enabled = YES;
    }
    else {
        nameOK.enabled = NO;
    }
}

-(IBAction)dismissView {
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showQuiz"]) {
        KidsIQ4ViewController *quizView = segue.destinationViewController;
        if ([nameText.text isEqualToString:@""]) {
            errorStatus.text = @"Please enter the name.";
            return;
        }
        
        quizView.name = nameText.text;  
        
        quizView.maxQuestions = noOfPQuestions;
        
        [quizView resetAll];
    }
    NSLog(@"%i", noOfPQuestions);
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger numRows = 3;
    noOfPQuestions = 0;
    return numRows;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    levelSelection = [levelpicker objectAtIndex:row];
    NSLog(@"You selected: %@", levelSelection);
    noOfPQuestions = [levelSelection intValue];
    [nameText resignFirstResponder];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return [levelpicker objectAtIndex:row];
}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)backgroundTouched:(id)sender {
    [self.view endEditing:YES];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [nameText resignFirstResponder];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    [nameText resignFirstResponder];
    CGRect rect = CGRectMake(150, 100, 500, 200);
    UILabel *label = [[UILabel alloc]initWithFrame:rect];
    CGAffineTransform rotate = CGAffineTransformMakeRotation(-3.14/2);
    rotate = CGAffineTransformScale(rotate, 0.5, 4.0);
    [label setTransform:rotate];
    label.text = [levelpicker objectAtIndex:row];
    label.font = [UIFont systemFontOfSize:60.0];
    label.textAlignment = UITextAlignmentCenter;
    label.numberOfLines = 2;
    label.lineBreakMode = UILineBreakModeWordWrap;
    label.backgroundColor = [UIColor clearColor];
    label.clipsToBounds = NO;
    noOfPQuestions = 40;
    return label ;
}

- (void)willAnimateRotationToInterfaceOrientation: (UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        titleLabel.center = CGPointMake(230,20);
        nameLabel.center = CGPointMake(230,70);
        [nameText setFrame:CGRectMake(120, 90, 220, 40)];
        choicesLabel.center = CGPointMake(240, 160);
        self.levelPickerView.center = CGPointMake(230,210);
        nameOK.center = CGPointMake(230,270);
    }
    else
    {
        titleLabel.center = CGPointMake(160,43);
        nameLabel.center = CGPointMake(160,97);
        [nameText setFrame:CGRectMake(50, 120, 200, 40)];
        choicesLabel.center = CGPointMake(156, 200);
        self.levelPickerView.center = CGPointMake(160,250);
        nameOK.center = CGPointMake(154,328);
    }
}

@end
