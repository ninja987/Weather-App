//
//  WAViewController.m
//  WeatherApp
//
//  Created by Rohith R Gurram on 9/14/16.
//  Copyright © 2016 Rohith R Gurram. All rights reserved.
//

#import "WAViewController.h"
#import "WAWeatherResponse.h"
#import "WANetworkClass.h"
#import "WAActivityView.h"

@interface WAViewController() <UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *cityBar;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UIImageView *weatherImage;
@property (strong, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (strong, nonatomic) IBOutlet UILabel *geoLabel;
@property (strong, nonatomic) IBOutlet UILabel *cloudinessLbl;
@property (strong, nonatomic) IBOutlet UILabel *windLabel;
@property (strong, nonatomic) IBOutlet UILabel *pressureLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunriseLabel;
@property (strong, nonatomic) IBOutlet UILabel *humidityLabel;
@property (strong, nonatomic) IBOutlet UILabel *sunsetLabel;

@property (strong, nonatomic) IBOutlet UILabel *cloudnsLbl;
@property (weak, nonatomic) IBOutlet UILabel *windLbl;
@property (weak, nonatomic) IBOutlet UILabel *pressureLbl;
@property (weak, nonatomic) IBOutlet UILabel *humidityLbl;
@property (weak, nonatomic) IBOutlet UILabel *sunriseLbl;
@property (weak, nonatomic) IBOutlet UILabel *sunsetLbl;
@property (weak, nonatomic) IBOutlet UILabel *geoLbl;

@property (strong, nonatomic) WAWeatherResponse *weatherResponse;
@property (strong, nonatomic) WAActivityView *spinner;

@end

@implementation WAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.cityLabel setHidden:YES];
    [self.weatherImage setHidden:YES];
    [self.temperatureLabel setHidden:YES];
    [self.cloudinessLbl setHidden:YES];
    [self.windLabel setHidden:YES];
    [self.pressureLabel setHidden:YES];
    [self.humidityLabel setHidden:YES];
    [self.sunriseLabel setHidden:YES];
    [self.sunsetLabel setHidden:YES];
    [self.geoLabel setHidden:YES];

    [self.cloudnsLbl setHidden:YES];
    [self.windLbl setHidden:YES];
    [self.pressureLbl setHidden:YES];
    [self.humidityLbl setHidden:YES];
    [self.sunriseLbl setHidden:YES];
    [self.sunsetLbl setHidden:YES];
    [self.geoLbl setHidden:YES];
    
    //Adding tap gesture in order to hide keyboard when a user taps on the area outside search bar and keyboard.
    UITapGestureRecognizer *viewTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:viewTapRecognizer];
    
    //Auto-loading the last searched city upon app launch.
    NSDictionary *results = [[NSUserDefaults standardUserDefaults] objectForKey:@"kLastSearchedCityResults"];
    if (results != nil) {
        self.weatherResponse = [[WAWeatherResponse alloc] initWithResponse:results];
        [self updateViewWithWeatherData];
    }
}

#pragma mark - UISearchBarDelegate Method

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.cityBar resignFirstResponder];
    
    WANetworkClass *networkClass = [[WANetworkClass alloc] init];
    
    [self addSpinnerToView];
    
    NSString *url = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@&APPID=674bef3d65bdbfdc1d06c6667377b973", self.cityBar.text];
    
    //Eliminates empty white spaces from being added in the url string and in turn prevents the app from crashing.
    NSString *urlString = [url stringByReplacingOccurrencesOfString:@" " withString:@""];

    [networkClass downloadJsonDataWithUrl:urlString completionHandler:^(NSDictionary * _Nullable results, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self removeSpinnerFromView];
            if (error != nil) {
                [self showAlertWithMessage:[error description] withCode:[NSNumber numberWithInteger:[error code]]];
            }
            else if (results == nil || [results[@"cod"] integerValue] == 404) {
                [self showAlertWithMessage:@"No results found at this moment. Please try again later" withCode:@100];
            }
            else
            {
                //Storing the results to NSUserDefaults.
                [[NSUserDefaults standardUserDefaults] setObject:results forKey:@"kLastSearchedCityResults"];
                self.weatherResponse = [[WAWeatherResponse alloc] initWithResponse:results];
                [self updateViewWithWeatherData];
            }
        });
    }];
}

#pragma mark - UI Helper Methods

/*!
 * @discussion Updates the user with relative weather data of a particular city.
 * @param no parameters needed.
 * @return void.
 */

- (void)updateViewWithWeatherData
{
    [self.cloudnsLbl setHidden:NO];
    [self.windLbl setHidden:NO];
    [self.pressureLbl setHidden:NO];
    [self.humidityLbl setHidden:NO];
    [self.sunriseLbl setHidden:NO];
    [self.sunsetLbl setHidden:NO];
    [self.geoLbl setHidden:NO];
    
    [self.cityLabel setHidden:NO];
    [self.weatherImage setHidden:NO];
    [self.temperatureLabel setHidden:NO];
    [self.cloudinessLbl setHidden:NO];
    [self.windLabel setHidden:NO];
    [self.pressureLabel setHidden:NO];
    [self.humidityLabel setHidden:NO];
    [self.sunriseLabel setHidden:NO];
    [self.sunsetLabel setHidden:NO];
    [self.geoLabel setHidden:NO];

    //Setting texts for all the labels
    [self.cityLabel setText:self.weatherResponse.city];
    [self.weatherImage setImage:self.weatherResponse.weatherModel.wIconImage];
    [self.cloudinessLbl setText:self.weatherResponse.weatherModel.wDescription];
    [self.windLabel setText:self.weatherResponse.windSpeed];
    [self.pressureLabel setText:self.weatherResponse.pressure];
    [self.humidityLabel setText:self.weatherResponse.humidity];
    [self.temperatureLabel setText:self.weatherResponse.temperature];
    [self.sunriseLabel setText:self.weatherResponse.sunrise];
    [self.sunsetLabel setText:self.weatherResponse.sunset];
    [self.geoLabel setText:self.weatherResponse.coordinates];
}

- (void)viewTapped:(UITapGestureRecognizer *)recognizer
{
    [self.view endEditing:YES];
}

// Shows alert in case of an error
- (void)showAlertWithMessage:(NSString *)message withCode:(NSNumber *)code
{
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:[NSString stringWithFormat:@"Error %d",
                                                          [code intValue]]
                                message:message
                                preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertActionDismiss =
    [UIAlertAction actionWithTitle:@"Close"
                             style:UIAlertActionStyleDefault
                           handler:Nil];
    
    [alert addAction:alertActionDismiss];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:Nil];
    });
}

- (void)addSpinnerToView
{
    // Check that a spinner does not already exists
    if (self.spinner == nil) {
        self.spinner = [[WAActivityView alloc] init];
        self.spinner.center = self.view.center;
        [self.spinner startAnimating];
        [self.view addSubview: self.spinner];
    }
}

- (void)removeSpinnerFromView
{
    [self.spinner stopAnimating];
    [self.spinner removeFromSuperview];
    self.spinner = nil;
}

@end
