//
//  test.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 14/06/2022.
//

import Foundation

func listnum(k : Int) -> Int{
    var count : Int = 0
    let kCount = list(num: k*k)
    for i in 0...kCount {
        
    }
    return count
    
}

func list(num : Int) -> Int{
    var num1 = num
    var count : Int = 0
    if num == 0 {
        count += 1
    }
    else {
        while (num1 > 0) {
            num1 /= 10
            count += 1
        }
    }
    return count
}
