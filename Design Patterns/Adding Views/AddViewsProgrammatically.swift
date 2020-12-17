import UIKit
import SwiftUI

/**
 *
 * @description storing and adding views to a parent view using design patterns
 */

/**
 *
 * Data Types to track type of view
 *
 */
enum DataType: Int {
    
    case NUMBER = 0
    case CHAR = 1
    case OPERATOR = 2
}

/**
*
* @description holder/proxy for the view
*
*/
protocol ViewStrategy {
    
    func getView() -> AnyView;
    func getValue () -> String;
}
/**
*
* @description object to be held in array and track type of object
*
*/
protocol RootParent {
    
    var strategy:ViewStrategy {get set};
    
    func getType() -> DataType;
    func getView() -> AnyView;
    func getStrategy() -> ViewStrategy;
}

/**
 *
 * @description example views that can be held in stack
 *
 */
struct OneView: View {
    
    var body:some View {
        
        Text("1")
    }
}

struct SView:View {
    
    var body:some View {
        
        Text("S")
    }
}
struct PlusView:View {
    
    var body:some View {
        
        Text("+")
    }
}

/**
 *
 * @description holds the char s and its corresponding view
 *  @note used the name SStrat to stop any naming collisions with factory functions
 */
class SStrat:ViewStrategy {
    
    init () {
    }
    
    func getValue()-> String {
        return "S";
    }
        
    func getView() -> AnyView {
        return AnyView(SView());
    }
    
}

/**
*
* @description holds the number 1 and its corresponding view
*/
class One:ViewStrategy {
    
    init () {
    }
    
    func getValue() -> String {
        return "1";
    }
    
    func getView() -> AnyView {
        return AnyView(OneView());
    }
    
}

/**
*
* @description holds the number 1 and its corresponding view
*/
class Plus:ViewStrategy {
    
    init () {
    }
    
    func getValue() -> String {
        return "+";
    }
    
    func getView() -> AnyView {
        return AnyView(PlusView());
    }
    
}

/**
 *
 * @description containers to hold different strategies
 * @note this container will hold a number
 */
class Number:RootParent {
    var strategy: ViewStrategy
    
    
    init (strategy:ViewStrategy) {
        self.strategy = strategy;
    }
    
    func getType() -> DataType {
        return DataType.NUMBER;
        
    }
    
    func getView() -> AnyView {
        return strategy.getView();
    }
    
    func getStrategy() -> ViewStrategy {
        return strategy;
    }
}

/**
*
* @description containers to hold different strategies
* @note this container will hold a char
*/
class Char:RootParent {
    var strategy: ViewStrategy
    
    
    init (strategy:ViewStrategy) {
        self.strategy = strategy;
    }
    
    func getType() -> DataType {
        return DataType.CHAR;
    }
    
    func getView() -> AnyView {
        return strategy.getView();
    }
    
    func getStrategy() -> ViewStrategy {
        return strategy;
    }
}


/**
*
* @description containers to hold different strategies
* @note this container will hold an operator
*/
class Operator:RootParent {
    var strategy: ViewStrategy
    
    
    init (strategy:ViewStrategy) {
        self.strategy = strategy;
    }
    
    func getType() -> DataType {
        return DataType.OPERATOR;
    }
    
    func getView() -> AnyView {
        return strategy.getView();
    }
    
    func getStrategy() -> ViewStrategy {
        return strategy;
    }
}
/*
 * @description factory to create different symbols
 *
 */
class SymbolFactory {
    
    init (){
        
    }
    /**
     *
     *
     */
    public func one() -> RootParent {
        return Number(strategy: One());
    }
    /**
    *
    * @description holds the char s and its corresponding view
    *  @note used the name SStrat to stop any naming collisions with factory functions
     * if I named the class s, the compiler would pick the factory function not the class
    */
    public func s() -> RootParent {
        return Char(strategy: SStrat());
    }
    
    
    /**
     *
     *
     */
    public func plus() -> RootParent {
        return Operator(strategy: Plus());
    }

    
}

/*
 *
 * @description example of adding views programmatically
 *
 */
struct contentView: View {
    
    var views:[RootParent] = [];
    var factory: SymbolFactory = SymbolFactory();
    
    init () {
        views.append(factory.one());
        views.append(factory.s());
        views.append(factory.plus());
    }
    
    
    var body: some View {
        HStack {
            ForEach (0 ..< views.count) {
                self.views[$0].getView();
            }
        }
    }
}

