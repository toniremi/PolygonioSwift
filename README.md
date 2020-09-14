# PolygonioSwift

  

[![CI Status](http://img.shields.io/travis/toniremi/PolygonioSwift.svg?style=flat)](https://travis-ci.org/toniremi/PolygonioSwift)

![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/toniremi/PolygonioSwift)

[![License](https://img.shields.io/github/license/toniremi/PolygonioSwift)](LICENSE)


## Example


Simply import PolygonioSwift with:

    import PolygonioSwift

  
then create a polygon swift object like:

    let polygon = PolygonioSwift.Client(key: "YOUR_POLYGON_API_KEY")

and finally simply call any of the endpoints you want to get info from. The names are the same as in polygon.io docs.

    polygon.tickers(sort: .type, type: nil, market: .Stocks, locale: nil, search: "AAPL", active: true) { (result:TickersQueryResponse?, err) in
        // check if we got any errors
        if let err = err {
            print(err)
        } else {
            // results will hold the full response as it comes from Polygon.io
            print(result)
            // the candle data is in an array inside results.tickers
            print(result?.tickers)
        }
    }

Please take a look at the documentation to know what endpoints does polygon.io has and what info to expect back at <a href="https://polygon.io/docs/#getting-started">https://polygon.io/docs/#getting-started</a>.

To run the example project, clone this repo, and open iOS Example.xcworkspace from the iOS Example directory. 

In the examples you can see more methods although all of them work in the same way just changes name and parameter that they will accept.

## Requirements

You need to have a valid and working Polygon API Key. Please create an account at <a href="https://polygon.io/">https://polygon.io/</a> to obtain a valid API key.

## Installation


Add this to your project using Swift Package Manager. In Xcode that is simply: File > Swift Packages > Add Package Dependency... and you're done. Alternative installations options are shown below for legacy projects.


### CocoaPods


If you are already using [CocoaPods](http://cocoapods.org), just add the following line to your  `Podfile`  then run `pod install`.

    pod 'PolygonioSwift'
    

### Carthage


If you are already using [Carthage](https://github.com/Carthage/Carthage), just add to your `Cartfile`:

  
```ogdl

github "toniremi/PolygonioSwift" ~> 0.1

```


Then run `carthage update` to build the framework and drag the built `PolygonioSwift`.framework into your Xcode project.
  

## Author

Antoni Remeseiro Alfonso

## License

PolygonioSwift is available under the MIT license. See [the LICENSE file](LICENSE) for more information.
