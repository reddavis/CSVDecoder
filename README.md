# CSVDecoder

Heavily inspired by [Flight-School/RegularExpressionDecoder](https://github.com/Flight-School/RegularExpressionDecoder), I wanted to build my own decoder to help myself understand how Swift's `Decoder` works.

## Usage

```
import CSVDecoder


internal struct Customer: Decodable
{
    // Internal
    internal let name: String
    internal let age: Int
    internal let city: String
    internal let postcode: String?
    internal let birthplace: String?
    
    // MARK: Coding Keys
    
    internal enum CodingKeys: String, CodingKey
    {
        case name
        case age
        case city
        case postcode
        case birthplace
    }
}

let string = """
name,age,city,postcode,birthplace
John,45,Bath,BA15NF,London
"""

let decoder = CSVDecoder()
let customer = try decoder.decode(Customer.self, from: string)

customer.name
// => "John"
```

## Install

### Carthage

```
github "reddavis/CSVDecoder"
```

## Contact

[Email](mailto:me@red.to)

[Hire](https://red.to)

[Blog](https://blog.red.to)

[Twitter](http://twitter.com/reddavis)

## License

[MIT License](http://www.opensource.org/licenses/MIT).
