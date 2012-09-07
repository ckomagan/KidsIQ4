//
//  ResultController.m
//  KidsIQ4
//
//  Created by Chan Komagan on 8/26/12.
//  Copyright (c) 2012 KidsIQ. All rights reserved.
//

#import "ResultIPadController.h"
#import "KidsIQ4ViewController.h"
#import "NameViewIPadController.h"

@interface ResultIPadController()
@end

@implementation ResultIPadController
@synthesize name;
@synthesize titleText;
@synthesize score;
@synthesize maxQuestions;
bool reset = NO;

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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    nameLabel.text = name;
    titleLabel.text = titleText;
    scoreLabel.text = [@"Your score is: " stringByAppendingString:score];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(IBAction)dismissView {
    
    KidsIQ4ViewController *quiView = [[KidsIQ4ViewController alloc] initWithNibName:@"KidsIQ4ViewController" bundle:nil];
    [self dismissModalViewControllerAnimated:YES];
    quiView.maxQuestions = maxQuestions;
    [self presentModalViewController:quiView animated:false];
}

-(IBAction)loginScreen {
    
    NameViewIPadController *vc = [[UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil]  instantiateViewControllerWithIdentifier:@"NameViewIPadController"];
    vc.maxQuestions = 0;
    [self presentModalViewController:vc animated:false];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
