//
//  LeaderBoardController.m
//  KidsIQ5
//
//  Created by Chan Komagan on 8/20/12.
//  Copyright (c) 2012 KidsIQ. All rights reserved.
//

#import "LeaderBoardController.h"
#import "NameViewIPadController.h"
#import "ASIFormDataRequest.h"

@interface LeaderBoardController()
@property (nonatomic, strong) NSString *nsURL;
@end;

@implementation LeaderBoardController

NSIndexPath *currentSelection;
@synthesize nsURL;
@synthesize responseData;
NSDictionary *res;
NSString *name, *score, *country;
NSMutableArray *leaders;
int leadercount = 0;

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
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    leaders = [[NSMutableArray alloc] init];
    copyNameList = nameList = [[NSMutableArray alloc] init];
    copyCountryList = countryList = [[NSMutableArray alloc] init];
    copyScoreList = scoreList = [[NSMutableArray alloc] init];
    
    [leaderList setDelegate:self];
    [leaderList setDataSource:self];
    [self receiveData];
    
}

-(void)receiveData
{
    nsURL = @"http://www.komagan.com/KidsIQ/leaders.php?format=json&getleaders=1";
    self.responseData = [NSMutableData data];
    NSURLRequest *aRequest = [NSURLRequest requestWithURL:[NSURL URLWithString: nsURL]];
    [[NSURLConnection alloc] initWithRequest:aRequest delegate:self];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
    NSError *myError = nil;
    res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];

    //[leaderList beginUpdates];
    for(NSDictionary *res1 in res) {
        name = [res1 objectForKey:@"name"];        
        score = [res1 objectForKey:@"score"];
        country = [res1 objectForKey:@"country"];
        
        NSString *space = @"       ";
        NSString *row = [name stringByAppendingString:[space stringByAppendingString:[country stringByAppendingString:[space stringByAppendingString:score]]]];
        //NSLog(@"%@", row);
        [nameList addObject:name];
        [countryList addObject:country];
        [scoreList addObject:score];
        [leaders addObject:row];
    }
    //[leaderList endUpdates];
    [leaderList reloadData];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    self.responseData = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

-(IBAction)dismissView {
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)showMoreLeaders {
    
    nameList = [NSArray arrayWithArray:[copyNameList subarrayWithRange:NSMakeRange(7, [copyNameList count]-7)]];
    scoreList = [NSArray arrayWithArray:[copyScoreList subarrayWithRange:NSMakeRange(7, [copyScoreList count]-7)]];
    countryList = [NSArray arrayWithArray:[copyCountryList subarrayWithRange:NSMakeRange(7, [copyCountryList count]-7)]];
    prevLeaders.hidden = FALSE;
    [leaderList reloadData];
}

-(IBAction)showPreviousLeaders {
    
    nameList = [NSArray arrayWithArray:[copyNameList subarrayWithRange:NSMakeRange(0, 6)]];
    scoreList = [NSArray arrayWithArray:[copyScoreList subarrayWithRange:NSMakeRange(0, 6)]];
    countryList = [NSArray arrayWithArray:[copyCountryList subarrayWithRange:NSMakeRange(0, 6)]];
    prevLeaders.hidden = TRUE;
    [leaderList reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    cell = [leaderList dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    id path = @"http://www.geonames.org/flags/x/us.gif";
    NSURL *url = [NSURL URLWithString:path];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData: data];
    
    UILabel *cellLabelS1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, cell.frame.size.width, cell.frame.size.height)];
    
    [cellLabelS1 viewWithTag:1];
    cellLabelS1.text = [nameList objectAtIndex:indexPath.row];
    cellLabelS1.font = [UIFont boldSystemFontOfSize: 35.0];
    [cell addSubview:cellLabelS1];
    
    UILabel *cellLabelS2 = [[UILabel alloc] initWithFrame:CGRectMake(250, 0, cell.frame.size.width, cell.frame.size.height)];

    [cellLabelS2 viewWithTag:2];
    cellLabelS2.text = [scoreList objectAtIndex:indexPath.row];
    cellLabelS2.font = [UIFont systemFontOfSize: 35.0];
    [cell addSubview:cellLabelS2];

    UILabel *cellLabelS3 = [[UILabel alloc] initWithFrame:CGRectMake(420, 0, cell.frame.size.width, cell.frame.size.height)];
    
    [cellLabelS3 viewWithTag:2];
    cellLabelS3.text = [countryList objectAtIndex:indexPath.row];
    cellLabelS3.font = [UIFont systemFontOfSize: 35.0];
    [cell addSubview:cellLabelS3];
    
    //leaderList.backgroundColor = [UIColor redColor];
    //leaderList.separatorColor = [UIColor clearColor];

    //[cell.imageView setImage:img];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([nameList count] >= 6)
    {
        moreLeaders.hidden = FALSE;
        return 6;
    }
    else {
        return [nameList count];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    currentSelection = indexPath;
    //[self performSegueWithIdentifier:@"offerDetailsPage" sender:self];
}

-(IBAction)loginScreen {
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil]  instantiateViewControllerWithIdentifier:@"NameViewController"];
    [self presentModalViewController:vc animated:false];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return (orientation != UIDeviceOrientationLandscapeLeft) &&
	(orientation != UIDeviceOrientationLandscapeRight);
}

@end
