# Flash ⚡️
[![Swift Version](https://img.shields.io/badge/Swift-4.1-brightgreen.svg)](http://swift.org)
[![Vapor Version](https://img.shields.io/badge/Vapor-3-30B6FC.svg)](http://vapor.codes)
[![Circle CI](https://circleci.com/gh/nodes-vapor/flash/tree/master.svg?style=shield)](https://circleci.com/gh/nodes-vapor/flash)
[![codebeat badge](https://codebeat.co/badges/10cffe07-3d4f-420c-adb9-a98529671bfa)](https://codebeat.co/projects/github-com-nodes-vapor-flash-master)
[![codecov](https://codecov.io/gh/nodes-vapor/flash/branch/master/graph/badge.svg)](https://codecov.io/gh/nodes-vapor/flash)
[![Readme Score](http://readme-score-api.herokuapp.com/score.svg?url=https://github.com/nodes-vapor/flash)](http://clayallsopp.github.io/readme-score?url=https://github.com/nodes-vapor/flash)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/nodes-vapor/flash/master/LICENSE)

This package is to ease using flash message between your views

![image](https://cloud.githubusercontent.com/assets/1279756/21659442/fcfdd126-d2ca-11e6-8157-d6860aa02363.png)

# Installation

Update your `Package.swift` file.
```swift
.package(url: "https://github.com/nodes-vapor/flash", from: "2.0.0-beta")
```

## Getting started 🚀

TODO. While we make the docs, feel free to look at how [Admin Panel](https://github.com/nodes-vapor/admin-panel/tree/vapor-3) uses this package.

### Example of HTML

The below example uses the Vapor 3 [Bootstrap package](https://github.com/nodes-vapor/bootstrap) for generating the alert html.

```html
<div class="alerts">
#flash() {
    #for(flash in all) {
        #bs:alert(flash.bootstrapType) {
            #(flash.message)
        }
    }
}
</div>

```

Add the Flash html to one file and embed it in rest of your views or through a base layout, e.g.: `#embed("alerts")`.


## 🏆 Credits

This package is developed and maintained by the Vapor team at [Nodes](https://www.nodesagency.com).
The package owner for this project is [Brett](https://github.com/brettrtoomey).


## 📄 License

This package is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT)
