#import <Foundation/Foundation.h>

%hook NSURLConnection

+ (NSData *)sendSynchronousRequest:(NSURLRequest *)request returningResponse:(NSURLResponse **)response error:(NSError **)error {
    NSURL *originalURL = request.URL;

    NSString *plistPath = @"/var/mobile/Library/Preferences/ndbx-pref.plist";
    NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSString *weatherURL = [prefs objectForKey:@"WeatherURL"];
    NSString *stocksURL = [prefs objectForKey:@"StocksURL"];

    if (weatherURL == nil) {
        weatherURL = @"notdbrand.com:8000";
    }
    if (stocksURL == nil) {
        stocksURL = @"notdbrand.com:8000";
    }

    if ([originalURL.host rangeOfString:@"yahooapis.com"].location != NSNotFound) {
        NSString *urlString = originalURL.absoluteString;
        if ([urlString rangeOfString:@"iphone-wu.apple.com"].location != NSNotFound) {
            urlString = [urlString stringByReplacingOccurrencesOfString:@"iphone-wu.apple.com" withString:weatherURL];
        } else {
            urlString = [urlString stringByReplacingOccurrencesOfString:@"apple-mobile.query.yahooapis.com" withString:stocksURL];
        }

        NSURL *redirectURL = [NSURL URLWithString:urlString];
        NSMutableURLRequest *newRequest = [request mutableCopy];
        newRequest.URL = redirectURL;

        return %orig(newRequest, response, error);
    }

    return %orig(request, response, error);
}

- (id)initWithRequest:(NSURLRequest *)request delegate:(id)delegate startImmediately:(BOOL)startImmediately {
    NSURL *originalURL = request.URL;

    NSString *plistPath = @"/var/mobile/Library/Preferences/ndbx-pref.plist";
    NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSString *weatherURL = [prefs objectForKey:@"WeatherURL"];
    NSString *stocksURL = [prefs objectForKey:@"StocksURL"];

    if (weatherURL == nil) {
        weatherURL = @"notdbrand.com:8000";
    }
    if (stocksURL == nil) {
        stocksURL = @"notdbrand.com:8000";
    }

    if ([originalURL.host rangeOfString:@"yahooapis.com"].location != NSNotFound) {
        NSString *urlString = originalURL.absoluteString;
        if ([urlString rangeOfString:@"iphone-wu.apple.com"].location != NSNotFound) {
            urlString = [urlString stringByReplacingOccurrencesOfString:@"iphone-wu.apple.com" withString:weatherURL];
        } else {
            urlString = [urlString stringByReplacingOccurrencesOfString:@"apple-mobile.query.yahooapis.com" withString:stocksURL];
        }

        NSURL *redirectURL = [NSURL URLWithString:urlString];
        NSMutableURLRequest *newRequest = [request mutableCopy];
        newRequest.URL = redirectURL;

        return %orig(newRequest, delegate, startImmediately);
    }

    return %orig(request, delegate, startImmediately);
}

%end

%hook NSURLRequest

+ (id)requestWithURL:(NSURL *)URL {
    NSString *originalURL = [URL absoluteString];

    NSString *plistPath = @"/var/mobile/Library/Preferences/ndbx-pref.plist";
    NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSString *weatherURL = [prefs objectForKey:@"WeatherURL"];
    NSString *stocksURL = [prefs objectForKey:@"StocksURL"];

    if (weatherURL == nil) {
        weatherURL = @"notdbrand.com:8000";
    }
    if (stocksURL == nil) {
        stocksURL = @"notdbrand.com:8000";
    }

    if ([originalURL rangeOfString:@"iphone-wu.apple.com"].location != NSNotFound) {
        NSString *newURLString = [originalURL stringByReplacingOccurrencesOfString:@"iphone-wu.apple.com" withString:weatherURL];
        NSURL *newURL = [NSURL URLWithString:newURLString];
        return %orig(newURL);
    }
    if ([originalURL rangeOfString:@"apple-mobile.query.yahooapis.com"].location != NSNotFound) {
        NSString *newURLString = [originalURL stringByReplacingOccurrencesOfString:@"apple-mobile.query.yahooapis.com" withString:stocksURL];
        NSURL *newURL = [NSURL URLWithString:newURLString];
        return %orig(newURL);
    }

    return %orig;
}

%end

