//
//  navtableviewcontroller.m
//  splitviewtest
//
//  Created by wlmligte on 10/12/12.
//  Copyright (c) 2012 wlmligte. All rights reserved.
//

#import "navtableviewcontroller.h"
#import "navViewController.h"

@interface navtableviewcontroller ()

@end

@implementation navtableviewcontroller
navViewController *navController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
 //NSString r = @"test";
    
    
    for (NSInteger x = 1; x < 21; x++) {
        //[_liftPlaatje1 setEnabled:NO];
    }
    //[_liftPlaatje1 setEnabled:NO]; // To toggle enabled / disabled
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IBAction)liftButton:(id)sender {
 /*   UIButton * PressedButton = (UIButton*)sender;
    switch(PressedButton.tag)
    {
        case 1:
            _deTest.text = @"1";
            [navController verandertekst];
            break;
        case 2:
            _deTest.text = @"2";
            
            break;
    }
    */
    //welke knop is ingedrukt
    //verander plaatje van de knop in groe
    //zorg dat je de goeie dingetje load op detailview
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"verandereDeTekst"])
    {
        UIButton * PressedButton = (UIButton*)sender;
        navController = (navViewController*) segue.destinationViewController;
        navController.text = [NSString stringWithFormat:@"%i",PressedButton.tag ];
        
        //PressedButton.backgroundColor = [UIColor redColor];
        UIImage* image = [UIImage imageNamed: @"green.png"];
        [PressedButton  setBackgroundImage:image forState:UIControlStateNormal];
        
    }
    
}
@end
