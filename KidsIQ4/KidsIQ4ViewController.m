//
//  KidsIQ4ViewController.m
//  KidsIQ4
//
//  Created by Chan Komagan on 7/28/12.
//  Copyright (c) 2012 KidsIQ. All rights reserved.
//

#import "KidsIQ4ViewController.h"
#import "ResultIPadController.h"
#import "NameViewIPadController.h"
#import "QuitController.h"

@interface KidsIQ4ViewController()
@property (nonatomic, strong) NSString *nsURL;
@property (nonatomic, strong) NSString *selectedChoice;
@property (nonatomic, strong) NSString *correctChoice;
@end

@interface UIButton (ColoredBackground)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
+ (UIColor *) silverColor;

@end

@implementation KidsIQ4ViewController

@synthesize nsURL = _nsURL;
@synthesize responseData;
@synthesize selectedChoice = _selectedChoice;
@synthesize correctChoice = _correctChoice;
@synthesize usedNumbers;
NSInteger _id = -1;
NSInteger _score = 0;
NSInteger _noOfQuestions = 1;
int count = 1;
NSDictionary *res;
NSString *titleText;
NSString *scoreText;
NSString *btnPressed;
bool reset;

@synthesize name;
@synthesize maxQuestions;



-(void)showLoginViewController {
    
    nameLabel.text = name;
}

-(IBAction)showModalViewController {
    QuitController *tempView = [[QuitController alloc] initWithNibName:@"QuitController" bundle:nil];
    [self presentModalViewController:tempView animated:true];
}

- (IBAction)submit:(id)sender {
    
}

- (void)showbutton {
    submit.enabled = TRUE;
    [submit setTitle: @"Submit" forState: UIControlStateNormal];
	[submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[submit setBackgroundColor:[UIColor brownColor]];
}

- (IBAction)choicea:(id)sender {
    
    [self resetAllChoices];
    choicea = (UIButton *)sender;
    [answerA setTextColor:[UIColor darkGrayColor]];
    [choicea setBackgroundColor:[UIColor darkGrayColor]];
    _selectedChoice = answerA.text;
	btnPressed = @"choicea";
    [self showbutton];
}

- (IBAction)choiceb:(id)sender {
	
    [self resetAllChoices];
    choiceb = (UIButton *)sender;
    [answerB setTextColor:[UIColor darkGrayColor]];
    [choiceb setBackgroundColor:[UIColor darkGrayColor]];
    _selectedChoice = answerB.text;
	btnPressed = @"choiceb";
    [self showbutton];
    
}

- (IBAction)choicec:(id)sender {
    
    [self resetAllChoices];
    choicec = (UIButton *)sender;
    [answerC setTextColor:[UIColor darkGrayColor]];
    [choicec setBackgroundColor:[UIColor darkGrayColor]];
    _selectedChoice = answerC.text;
	btnPressed = @"choicec";
    [self showbutton];
	
}

- (IBAction)choiced:(id)sender {
    
    [self resetAllChoices];
    choiced = (UIButton *)sender;
    [answerD setTextColor:[UIColor darkGrayColor]];
    [choiced setBackgroundColor:[UIColor darkGrayColor]];
    _selectedChoice = answerD.text;
	btnPressed = @"choiced";
    [self showbutton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //_id = [self generateRandomNumber];
    while(_id < 0)
    {
        _id = [self generateRandomNumber];
    }

	if(_noOfQuestions <= maxQuestions)
	{
		submit.enabled = FALSE;
		[submit setTitle: @"Select" forState: UIControlStateNormal];
		[submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[submit setBackgroundColor:[UIColor darkGrayColor]];
        
		_nsURL = [@"http://www.komagan.com/KidsIQ/index.php?format=json&quiz=1&question_id=" stringByAppendingFormat:@"%d ", _id];
        
		NSLog(@"URL=%@",_nsURL);
        
		self.responseData = [NSMutableData data];
		
		NSURLRequest *aRequest = [NSURLRequest requestWithURL:[NSURL URLWithString: _nsURL]];
		//NSLog(@"request established");
		//NSLog(@"didReceiveResponse");
		[[NSURLConnection alloc] initWithRequest:aRequest delegate:self];
        
	}
	else{
		[self showResults];
        //[self showResultsIPad];
        return;
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    //NSLog(@"didFailWithError");
    //NSLog(@"Connection failed: %@", [error description]);
    self.responseData = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //NSLog(@"connectionDidFinishLoading");
    //NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    NSError *myError = nil;
    res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    NSMutableArray *answers = [[NSMutableArray alloc] init];
    
    for(NSDictionary *res1 in res) {
        NSString *preText = [NSString stringWithFormat:@"%d", _noOfQuestions];
        preText = [preText stringByAppendingFormat:@". "];
        question.text = [preText stringByAppendingString:[res1 objectForKey:@"question"]];
        NSString *answer = [res1 objectForKey:@"choice_text"];
        [answers addObject :answer];
        
        NSString *rightChoice = [res1 objectForKey:@"is_right_choice"];
        
        if ([rightChoice isEqualToString:@"1"]) {
            _correctChoice = answer;
        }
    }
    
    NSLog(@"question ***** =%@", question.text);

    if ([res count] == 0)
    {
        NSLog(@"_id = %d", _id);
        [self showResults];
        //[self showResultsIPad];
        return;
    }
    
    answerA.text = [answers objectAtIndex:0];
    answerB.text = [answers objectAtIndex:1];
    answerC.text = [answers objectAtIndex:2];
    answerD.text = [answers objectAtIndex:3];
	[self calculatescore];
}

- (void)resetAllChoices
{
    [answerA setTextColor:[UIColor blackColor]];
    [choicea setBackgroundColor:[UIColor blueColor]];
    [answerB setTextColor:[UIColor blackColor]];
    [choiceb setBackgroundColor:[UIColor blueColor]];
    [answerC setTextColor:[UIColor blackColor]];
    [choicec setBackgroundColor:[UIColor blueColor]];
    [answerD setTextColor:[UIColor blackColor]];
    [choiced setBackgroundColor:[UIColor blueColor]];
    choicea.enabled = YES;
    choiceb.enabled = YES;
    choiceb.enabled = YES;
    choiced.enabled = YES;
}

- (void)resetAll /* restart the quiz */
{
    _id = -1;
    _score = 0;
    reset = YES;  //reset the first set of questions
    _noOfQuestions = 1;
    [self viewDidLoad];
}

- (void)disableAllChoices
{
    for (UIView *view in self.view.subviews){
		view.userInteractionEnabled = NO;
		self->submit.userInteractionEnabled = YES;
	}
}

- (void)enableAllChoices
{
    for (UIView *view in self.view.subviews)
		view.userInteractionEnabled=YES;
}

- (IBAction)checkAnswer
{
    if([submit.titleLabel.text isEqual:@"Submit"])
    {
        if ([_selectedChoice isEqualToString:_correctChoice]) {
            result.text = @"Correct Answer!";
            [result setTextColor:[UIColor greenColor]];
			[self highlightChoice];
            _score++;
        }
        else {
			NSString *preText = @"Incorrect! The correct answer is ";
            result.text = [preText stringByAppendingString:[NSString stringWithFormat:@"%@",_correctChoice]];
            [result setTextColor:[UIColor redColor]];
        }
        _noOfQuestions++;
        //_id++;
        _id = [self generateRandomNumber];
		[self calculatescore];
        [submit setTitle:@"Next" forState:(UIControlState)UIControlStateNormal];
		[submit setBackgroundColor:[UIColor purpleColor]];
		[submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[self disableAllChoices];
        return;
    }
    
    if([submit.titleLabel.text isEqual:@"Next"])
    {
        result.text = @"";
        [self resetAllChoices];
        [self enableAllChoices];
        [self viewDidLoad];
    }
}

- (IBAction)skipQuestion
{
    //_id++;
    //while(_id < 0)
    //{
        _id = [self generateRandomNumber];
    //}
    _noOfQuestions++;
    [self resetAllChoices];
    [self calculatescore];
	result.text =@"";
    [self viewDidLoad];
}

- (void)calculatescore
{
    scoreText = [NSString stringWithFormat:@"%d",_score];
    scoreText = [scoreText stringByAppendingString:@ " / "];
    scoreText = [scoreText stringByAppendingString:[NSString stringWithFormat:@"%d",maxQuestions]];
    if (_noOfQuestions > 0)
    {
        int tally = _score / _noOfQuestions;
        
        if(tally >= 0.9)
        {
            titleText = @"You are practically a genius.";
        }
        if((tally >= 0.7) && (tally <= 0.9))
        {
            titleText = @"That's not bad!";
        }
        if((tally >= 0.5) && (tally <= 0.7))
        {
            titleText = @"I think you can do better?!?";
        }
        if(tally <= 0.5)
        {
            titleText = @"You better start over.";
        }
        
    }
    [score setText: scoreText];
}

-(void)highlightChoice
{
	if([btnPressed isEqual:@"choicea"])
	{
		[choicea setBackgroundColor:[UIColor greenColor]];
		[answerA setTextColor:[UIColor greenColor]];
	}
	
	if([btnPressed isEqual:@"choiceb"])
	{
		[choiceb setBackgroundColor:[UIColor greenColor]];
		[answerB setTextColor:[UIColor greenColor]];
	}
    
	if([btnPressed isEqual:@"choicec"])
	{
		[choicec setBackgroundColor:[UIColor greenColor]];
		[answerC setTextColor:[UIColor greenColor]];
	}
    
	if([btnPressed isEqualToString:@"choiced"])
	{
		[choiced setBackgroundColor:[UIColor greenColor]];
		[answerD setTextColor:[UIColor greenColor]];
	}
}

-(void)showResults
{
    ResultIPadController *resultView = [[ResultIPadController alloc] initWithNibName:@"ResultIPadController" bundle:nil];
    resultView.name = [@"Hi there " stringByAppendingString:[name stringByAppendingString:@""]];
    resultView.titleText = titleText;
    resultView.score = scoreText;
	resultView.maxQuestions = maxQuestions;
	[self resetAll];
    resultView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:resultView animated:true];
}


-(int)generateRandomNumber
{
    int randomNumber = -1;
    //if(count < maxQuestions)
    //{
        randomNumber = (arc4random() % 60)+1;
        NSLog(@"numberWithSet : %@ \n\n",usedNumbers);
        bool myIndex = [usedNumbers containsObject:[NSNumber numberWithInt: randomNumber]];
        if (myIndex == false)
        {
            [usedNumbers addObject:[NSNumber numberWithInt:randomNumber]];
            count++;
            return randomNumber;
        }
        else{
            NSLog(@"number already there : %d", randomNumber);
            return -1;
        }
		
	//}
	return randomNumber;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    nameLabel.text = name;
    usedNumbers = [NSMutableSet setWithCapacity:maxQuestions];
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ResultControllerScreen"]) {
        
    }
}

-(IBAction)dismissView {
    [self dismissModalViewControllerAnimated:YES];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return (orientation != UIDeviceOrientationLandscapeLeft) &&
	(orientation != UIDeviceOrientationLandscapeRight);
}

@end

