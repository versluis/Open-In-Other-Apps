//
//  ViewController.m
//  DocumentInteractionDemo
//
//  Created by Jay Versluis on 09/01/2014.
//  Copyright (c) 2014 Pinkstone Pictures LLC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIBarButtonItem *openButton;
@property (nonatomic, strong) UIDocumentInteractionController *controller;

- (IBAction)buttonPressed:(id)sender;
- (IBAction)sendButtonPressed:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIDocumentInteractionController *)controller {
    
    if (!_controller) {
        _controller = [[UIDocumentInteractionController alloc]init];
        _controller.delegate = self;
    }
    return _controller;
}

- (IBAction)buttonPressed:(id)sender {
    
    // here's a URL from our bundle
    NSURL *documentURL = [[NSBundle mainBundle]URLForResource:@"Colours" withExtension:@"zip"];
    
    // pass it to our document interaction controller
    self.controller.URL = documentURL;
    
    // present the preview
    [self.controller presentPreviewAnimated:YES];
}

- (IBAction)sendButtonPressed:(id)sender {
    
    // send a ZIP file over to Dropbox
    NSURL *zipURL = [[NSBundle mainBundle]URLForResource:@"Colours" withExtension:@"zip"];
    self.controller.URL = zipURL;
    
    if (![self.controller presentOpenInMenuFromBarButtonItem:self.openButton animated:YES]) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"You don't have an app installed that can handle ZIP files." delegate:self cancelButtonTitle:@"Thanks!" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}

#pragma mark - Delegate Methods

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    
    return  self;
}

- (void)documentInteractionController:(UIDocumentInteractionController *)controller willBeginSendingToApplication:(NSString *)application {
    
    NSLog(@"Starting to send this puppy to %@", application);
}

- (void)documentInteractionController:(UIDocumentInteractionController *)controller didEndSendingToApplication:(NSString *)application {
    
    NSLog(@"We're done sending the document.");
}

@end
