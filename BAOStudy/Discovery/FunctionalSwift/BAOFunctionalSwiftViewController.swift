//
//  File.swift
//  BAOStudy
//
//  Created by baochuquan on 2018/12/20.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import UIKit

let _A_ = true
let _B_ = true

typealias Distance = Double

struct Position {
    var x: Double
    var y: Double
}

extension Position {
    func inRange(range: Distance) -> Bool {
        return sqrt(x * x + y * y) <= range
    }

    func minus(p: Position) -> Position {
        return Position(x: x - p.x, y: y - p.y)
    }

    var length: Double {
        return sqrt(x * x + y * y)
    }
}

struct Ship {
    var position: Position
    var firingRange: Distance
    var unsafeRange: Distance
}

extension Ship {
    func canEngageShip(target: Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx * dx + dy * dy)
        return targetDistance <= firingRange
    }

    func canSafelyEngageShip(target: Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx * dx + dy * dy)
        return unsafeRange < targetDistance && targetDistance <= firingRange
    }

    func canSafelyEngageShip1(target: Ship, friendly: Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx * dx + dy * dy)
        let friendlyDx = friendly.position.x - target.position.x
        let friendlyDy = friendly.position.y - target.position.y
        let friendlyDistance = sqrt(friendlyDx * friendlyDx + friendlyDy * friendlyDy)
        return unsafeRange < targetDistance && targetDistance <= firingRange && unsafeRange < friendlyDistance
    }

}

/// MARK - Functional

// 定义函数类型
typealias Region = (Position) -> (Bool)

// 定义结构体
//struct Region {
//    let lookup: (Position) -> (Bool)
//}

func circle(radius: Distance) -> Region {
    return { point in point.length <= radius }
}


func circle2(radius: Distance, center: Position) -> Region {
    return { point in point.minus(p: center).length <= radius }
}

func shift(region: @escaping Region, offset: Position) -> Region {
    return { point in region(point.minus(p: offset)) }
}

func invert(region: @escaping Region) -> Region {
    return { point in !region(point) }
}

func intersection(region1: @escaping Region, region2: @escaping Region) -> Region {
    return { point in region1(point) && region2(point) }
}

func union(region1: @escaping Region, region2: @escaping Region) -> Region {
    return { point in region1(point) || region2(point) }
}

/// 在第一个区域中且不在第二个区域中
func difference(region: @escaping Region, minus: @escaping Region) -> Region {
    return intersection(region1: region, region2: invert(region: minus))
}

/// --------------------------------------------------------------------------------------------------------------------

typealias Filter = (CIImage) -> (CIImage)

/// 模糊滤镜
func blur(_ radius: Double) -> Filter {
    return { image in
        let parameters: [String: Any] = [
            kCIInputRadiusKey: radius,
            kCIInputImageKey: image
        ]
        guard let filter = CIFilter(name: "CIGaussianBlur", parameters: parameters) else {
            fatalError()
        }
        guard let outputImage = filter.outputImage else {
            fatalError()
        }
        return outputImage
    }
}

/// 颜色生成器
func colorGenerator(_ color: UIColor) -> Filter {
    return { _ in
        let c = CIColor(color: color)
        let parameters: [String: Any] = [kCIInputColorKey: c]
        guard let filter = CIFilter(name: "CIConstantColorGenerator", parameters: parameters) else {
            fatalError()
        }
        guard let outputImage = filter.outputImage else {
            fatalError()
        }
        return outputImage
    }
}

/// 合成滤镜
func compositeSourceOver(_ overlay: CIImage) -> Filter {
    return { image in
        let parameters: [String: Any] = [
            kCIInputBackgroundImageKey: image,
            kCIInputImageKey: overlay
        ]
        guard let filter = CIFilter(name: "CISourceOverCompositing", parameters: parameters) else {
            fatalError()
        }
        guard let outputImage = filter.outputImage else {
            fatalError()
        }
        let cropRect = image.extent
        return outputImage.cropped(to: cropRect)
    }
}

/// 颜色叠层滤镜
func colorOverlay(_ color: UIColor) -> Filter {
    return { image in
        let overlay = colorGenerator(color)(image)
        return compositeSourceOver(overlay)(image)
    }
}

/// 滤镜组合
func composeFilters(_ filter1: @escaping Filter, _ filter2: @escaping Filter) -> Filter {
    return { image in filter2(filter1(image)) }
}

/// 引入运算符
precedencegroup MyPrecedence {
    higherThan: AdditionPrecedence      // 优先级,比加法运算高
    associativity: left                 // 结合方向:left, right or none
    assignment: false                   // true=赋值运算符,false=非赋值运算符
}

infix operator >>>: MyPrecedence

func >>>(filter1: @escaping Filter, filter2: @escaping Filter) -> Filter {
    return { image in filter2(filter1(image)) }
}

/// --------------------------------------------------------------------------------------------------------------------

struct City {
    let name: String
    let population: Int
}

extension City {
    func cityByScalingPopulation() -> City {
        return City(name: name, population: population * 100)
    }
}

/// --------------------------------------------------------------------------------------------------------------------

infix operator ??

func ??<T>(optional: T?, defaultValue: T) -> T {
    if let x = optional {
        return x
    } else {
        return defaultValue
    }
}

/// --------------------------------------------------------------------------------------------------------------------

struct Order {
    let orderNumber: Int
    let person: Person?
}

struct Person {
    let name: String
    let address: Address?
}

struct Address {
    let streetName: String
    let city: String
    let state: String?
}

/// --------------------------------------------------------------------------------------------------------------------

//extension Optional {
//    func map<U>(transform: Wrapped -> U) -> U? {
//        guard let x = self else { return nil }
//        return transform(x)
//    }
//
//    func flatMap<U>(f: Wrapped -> U?) -> U? {
//        guard let x = self else { return nil }
//        return f(x)
//    }
//}

/// --------------------------------------------------------------------------------------------------------------------

@objc(BAOFunctionalSwiftViewController)
class BAOFunctionalSwiftViewController: BAOBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 圆心为 (5, 5)，半径为 10
        _ = shift(region: circle(radius: 10), offset: Position(x: 5, y: 5))

        // 使用自定义运算符
        _ = blur(100) >>> colorOverlay(UIColor.gray)

        // Map，Filter，Reduce
        let paris = City(name: "Paris", population: 2241)
        let madrid = City(name: "Madrid", population: 3165)
        let amsterdam = City(name: "Amsterdam", population: 827)
        let berlin = City(name: "Berlin", population: 3562)
        let cities = [paris, madrid, amsterdam, berlin]

        _ = cities.filter { $0.population > 1000 }
            .map { $0.cityByScalingPopulation() }
            .reduce("City: Population") { result, c in
                return result + "\n" + "\(c.name):\(c.population)"
        }

        // Optional Value
        let cities1 = ["Paris": 2241, "Madrid": 3165, "Amsterdam": 827, "Berlin": 3562]
        let madridPopulation: Int? = cities1["Madrid"]
        if madridPopulation != nil {
            print("The population of Madrid is \(madridPopulation! * 1000)")
        } else {
            print("Unknown city: Madrid")
        }

        // 可选绑定
        if let madridPopulation = cities1["Madrid"] {
            print("The population of Madrid is \(madridPopulation * 1000)")
        } else {
            print("Unknown city: Madrid")
        }

        // 可选值链
        let order = Order(orderNumber: 0, person: nil)
        _ = order.person!.address!.state!                       // method 1

        if let myPerson = order.person {                        // method 2
            if let myAddress = myPerson.address {
                if let myState = myAddress.state {
                    print("This order will be shipped to \(myState)")
                }
            }
        }

        if let myState = order.person?.address?.state {         // method 3
            print("This order will be shipped to \(myState)")
        }

    }
}
