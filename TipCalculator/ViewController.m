//
//  ViewController.m
//  TipCalculator
//
//  Created by Erin Luu on 2016-11-11.
//  Copyright © 2016 Erin Luu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UITextField *tipPercentageTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UISlider *adjustTipPercentage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:self.view.window];
}
- (IBAction)updatePercentage:(UISlider *)sender {
    self.tipPercentageTextField.text = [NSString stringWithFormat:@"%.2f", sender.value];
}
- (IBAction)calculateTip:(UIButton *)sender {
    float billAmount = [self.billAmountTextField.text floatValue];
    float tipPercentage = [self.tipPercentageTextField.text floatValue];
    float tipAmount = billAmount * (tipPercentage/100);
    self.tipAmountLabel.text = [NSString stringWithFormat:@"Tip Amount: $%.2f", tipAmount];
}

#pragma Keyboard Show Hide Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)scrollViewTapRecognizer:(UITapGestureRecognizer *)sender {
    [UIView animateWithDuration:0.6 animations:^{
        [self.billAmountTextField resignFirstResponder];
        [self.tipPercentageTextField resignFirstResponder];
    }];
}

-(void) keyboardWillShow: (NSNotification *) sender {
    CGSize keyboardSize = [[[sender userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.scrollView.frame;
        f.size.height -= keyboardSize.height;
        self.scrollView.frame = f;
    }];
    
}
-(void) keyboardWillHide: (NSNotification *) sender {
    CGSize keyboardSize = [[[sender userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.scrollView.frame;
        f.size.height += keyboardSize.height;
        self.scrollView.frame = f;
    }];
}
@end
