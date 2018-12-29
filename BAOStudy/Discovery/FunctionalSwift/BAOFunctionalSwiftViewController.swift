//
//  File.swift
//  BAOStudy
//
//  Created by baochuquan on 2018/12/20.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import UIKit
import Foundation

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


func empty<Element>() -> [Element] {
    return []
}

func isEmpty<Element>(set:[Element]) -> Bool {
    return set.isEmpty
}

func contains<Element: Equatable>(_ x: Element, _ set: [Element]) -> Bool {
    return set.contains(x)
}

func insert<Element: Equatable>(x: Element, _ set: [Element]) -> [Element] {
    return contains(x, set) ? set : [x] + set
}

indirect enum BinarySearchTree<Element: Comparable> {
    case Leaf
    case Node(BinarySearchTree<Element>, Element, BinarySearchTree<Element>)
}

extension BinarySearchTree {
    init() {
        self = .Leaf
    }

    init(_ value: Element) {
        self = .Node(.Leaf, value, .Leaf)
    }

    var count: Int {
        switch self {
        case .Leaf:
            return 0
        case let .Node(left, _, right):
            return 1 + left.count + right.count
        }
    }

    var elements: [Element] {
        switch self {
        case .Leaf:
            return []
        case let .Node(left, x, right):
            return left.elements + [x] + right.elements
        }
    }

    var isEmpty: Bool {
        if case .Leaf = self {
            return true
        }
        return false
    }

    var isBST: Bool {
        switch self {
        case .Leaf:
            return true
        case let .Node(left, x, right):
            return left.elements.allSatisfy { y in y < x } && right.elements.allSatisfy { y in y > x } && left.isBST && right.isBST
        }
    }

    func contains(_ x: Element) -> Bool {
        switch self {
        case .Leaf:
            return false
        case let .Node(_, y, _) where x == y:
            return true
        case let .Node(left, y, _) where x < y:
            return left.contains(x)
        case let .Node(_, y, right) where x > y:
            return right.contains(x)
        default:
            fatalError("The impossible occurred")
        }
    }

    mutating func insert(_ x: Element) {
        switch self {
        case .Leaf:
            self = BinarySearchTree(x)
        case .Node(var left, let y, var right):
            if x < y { left.insert(x) }
            if x > y { right.insert(x) }
            self = .Node(left, y, right)
        }
    }
}

/// --------------------------------------------------------------------------------------------------------------------

extension Array {
    var decompose: (Element, [Element])? {
        return isEmpty ? nil : (self[startIndex], Array(self.dropFirst()))
    }
}

struct Trie<Element: Hashable> {
    let isElement: Bool
    let children: [Element: Trie<Element>]
}

extension Trie {
    init() {
        isElement = false
        children = [:]
    }

    init(_ key: [Element]) {
        if let (head, tail) = key.decompose {
            let children = [head: Trie(tail)]
            self = Trie(isElement: false, children: children)
        } else {
            self = Trie(isElement: true, children: [:])
        }
    }

    var elements: [[Element]] {
        var result: [[Element]] = isElement ? [[]] : []
        for (key, value) in children {
            result += value.elements.map { [key] + $0 }
        }
        return result
    }

    func lookup(_ key: [Element]) -> Bool {
        guard let (head, tail) = key.decompose else {
            return isElement
        }
        guard let subtrie = children[head] else {
            return false
        }
        return subtrie.lookup(tail)
    }

    func withPrefix(_ prefix: [Element]) -> Trie<Element>? {
        guard let (head, tail) = prefix.decompose else {
            return self
        }
        guard let remainder = children[head] else {
            return nil
        }
        return remainder.withPrefix(tail)
    }

    func autocomplete(_ key: [Element]) -> [[Element]] {
        guard let trie = withPrefix(key) else {
            return []
        }
        return trie.elements
    }

    func insert(_ key: [Element]) -> Trie<Element> {
        guard let (head, tail) = key.decompose else {
            return Trie(isElement: true, children: children)
        }
        var newChildren = children
        if let nextTrie = children[head] {
            newChildren[head] = nextTrie.insert(tail)
        } else {
            newChildren[head] = Trie(tail)
        }
        return Trie(isElement: isElement, children: newChildren)
    }

}

/// --------------------------------------------------------------------------------------------------------------------

enum Primitive {            // 描述三种类型的元素：椭圆、矩形、文字
    case Ellipse
    case Rectangle
    case Text(String)
}

enum Attribute {            // 描述图表各类样式属性的数据结构
    case FillColor(UIColor)
}

indirect enum Diagram {
    case Primitive(CGSize, Primitive)       // 一个具有确定尺寸图形
    case Beside(Diagram, Diagram)           // 一对水平对齐的图表
    case Below(Diagram, Diagram)            // 一对垂直对齐的图表
    case Attributed(Attribute, Diagram)     // 一个带有样式的图表
    case Align(CGVector, Diagram)           // 用于描述对齐方式
}

extension Diagram {
    var size: CGSize {
        switch self {
        case .Primitive(let size, _):
            return size
        case .Attributed(_, let x):
            return x.size
        case .Beside(let l, let r):
            let sizeL = l.size
            let sizeR = r.size
            return CGSize(width: sizeL.width + sizeR.width, height: max(sizeL.height, sizeR.height))
        case .Below(let t, let b):
            let sizeT = t.size
            let sizeB = b.size
            return CGSize(width: max(sizeT.width, sizeB.width), height: sizeT.height + sizeB.height)
        case .Align(_, let d):
            return d.size
        }
    }
}

func *(l: CGFloat, r: CGSize) -> CGSize {
    return CGSize(width: l * r.width, height: l * r.height)
}

func /(l: CGSize, r: CGSize) -> CGSize {
    return CGSize(width: l.width / r.width, height: l.height / r.height)
}

func *(l: CGSize, r: CGSize) -> CGSize {
    return CGSize(width: l.width * r.width, height: l.height * r.height)
}

func -(l: CGSize, r: CGSize) -> CGSize {
    return CGSize(width: l.width - r.width, height: l.height - r.height)
}

func -(l: CGPoint, r: CGPoint) -> CGPoint {
    return CGPoint(x: l.x - r.x, y: l.y - r.y)
}

extension CGVector {
    var point: CGPoint { return CGPoint(x: dx, y: dy) }
    var size: CGSize { return CGSize(width: dx, height: dy) }
}

extension CGSize {
    var point: CGPoint {
        return CGPoint(x: self.width, y: self.height)
    }

    func fit(vector: CGVector, _ rect: CGRect) -> CGRect {
        let scaleSize = rect.size / self
        let scale = min(scaleSize.width, scaleSize.height)
        let size = scale * self
        let space = vector.size * (size - rect.size)
        return CGRect(origin: rect.origin - space.point, size: size)
    }
}


//extension Sequence where Iterator.Element == CGFloat {
//    func normalize() -> [CGFloat] {
//        let maxVal = self.reduce(0) {  }
//        return self.map { $0 / maxVal }
//    }
//}



//func barGraph(input: [(String, Double)]) -> Diagram {
//    let values: [CGFloat] = input.map { CGFloat($0.1) }
//    let nValues = values.normalize()
//    let bars = hcat(nValues.map { (x: CGFloat) -> Diagram in
//        return rect(width: 1, height: 3 * x).fill(.blackColor()).alignBottom()
//    })
//    let labels = hcat(input.map { x in
//        return text(x.0, width: 1, height: 0.3).alignTop()
//    })
//    return bars --- labels
//}

/// --------------------------------------------------------------------------------------------------------------------

//func pure<A>(value: A) -> Region<A> {
//    return Region { pos in value }
//}
//
//func <*><A, B>(regionF: Region<A -> B>, regionX: Region<A>) -> Region<B> {
//    return Region { pos in regionF.value(pos)(regionX.value(pos)) }
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

        // 添加泛型
        let capitals = [
            "France": "Paris",
            "Spain": "Madrid",
            "The Netherlands": "Amsterdam",
            "Belgium": "Brussels"
        ]
        let mayors = [
            "Paris": "Hidalgo",
            "Madrid": "Carmena",
            "Amsterdam": "Van der Laan",
            "Berlin": "Muller"
        ]

        func mayorOfCapital(country: String) -> String? {
            return capitals[country].flatMap { mayors[$0] }
        }

        //
        let leaf: BinarySearchTree<Int> = .Leaf
        let five: BinarySearchTree<Int> = .Node(leaf, 5, leaf)
    }
}
