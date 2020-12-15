/**
 *
 * Preference Key Workaround
 * @description
 *      Preferencekey is good but when I want to press a button and send the information
 *      to a parent view its possible but requires a lengthy workaround and doesn't work for every situation
 *      This is a simple workaround making use of SwiftUI's onreceive modifier.
 */

import UIKit
import SwiftUI


/**
 *  PreferenceKey
 *
 *  @description preferencekey workaround,
 *
 *  @note you can add a function to change the value before triggering the object
 *
 */
struct PreferenceKey {
    typealias type = String;
    
    @ObservedObject static public var object = Key();
    
    class Key: ObservableObject {
        
        @Published var value:type = "";
        
    }
    // change value before mutating published variable
    static public func changeValue(value:type) {
        let val = value + "!!!"
        object.value = val;
    }
}
/**
 * Trigger
 *
 * @description
 *          example of how to trigger a change in value
 *          change the published variables value to trigger the onreceive modifier in Receiver
 *
 */
struct Trigger: View {
    
    var newValue:String = "hello";
    var body: some View {
        return Button(action: {
            PreferenceKey.object.value = self.newValue; // triggers onreceive modifier
            // PreferenceKey.changeValue(self.newValue); // example of function usage
        }) {
            Text("Press Me");
        }
        
    }
    
    
}


/**
 * Receiver
 *
 * @description
 *          use onreceive to notify parent view of a button being clicked from child view
 *
 *
 *
 */
struct Receiver: View {
    
    @State var str:String = "";
    
    var body: some View {
        
        VStack {
            Text(str).onReceive(PreferenceKey.object.$value, perform: { val in
                self.str = val; // receives new value and changes state value
            })
            
            Trigger() // button is clicked from this view
        }
    }
}
