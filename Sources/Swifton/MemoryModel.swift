public class MemoryModel: HTMLRenderable, JSONRenderable, Equatable {
    static var id = 1
    public static var all = [MemoryModel]() 
    public var attributes = [String: Any]()
    public var id:Int {
        get {
            return attributes["id"] as! Int
        }
        set(newID) {
            attributes["id"] = newID
        }
    }

    required public init(_ attributes: [String: Any]) {
        self.attributes = attributes 
        self.attributes["id"] = self.dynamicType.id
        self.dynamicType.id += 1
    }

    public subscript(name: String) -> Any? {
        get {
            return attributes[name]
        }
        set(newValue) {
            attributes[name] = newValue
        }
    } 

    public static func create(attributes: [String: String]) -> Self {
        var attrs = [String: Any]()
        for (key, value) in attributes {
            if let integer:Int = Int(value) {
                attrs[key] = integer
            } else if let double:Double = Double(value) {
                attrs[key] = double
            } else {
                attrs[key] = value
            }
        }
        let new = self.init(attrs)
        all.append(new)
        return new
    }

    public static func find(id: String?) -> MemoryModel? {
        guard let stringID = id else { return nil }
        guard let intID = Int(stringID) else { return nil }
        return find(intID)
    }

    public static func find(id: Int?) -> MemoryModel? {
        return all.filter{ $0.id == id }.first 
    }

    public static func destroy(model: MemoryModel?) {
        if let m = model {
            all = all.filter({ $0.id != m.id })
        }
    }

    public static func allAttributes() -> Any {
        var items = [Any]()
        for model in all {
            var attrs = model.attributes 
            attrs["id"] = String(model.id)
            items.append(attrs as Any)
        }
        return items as Any
    }

    public static func reset() {
        all = [MemoryModel]() 
        id = 1
    }

    public func update(attributes: [String: String]) {
        var attrs = [String: Any]()
        for (key, value) in attributes {
            if let integer:Int = Int(value) {
                attrs[key] = integer
            } else if let double:Double = Double(value) {
                attrs[key] = double
            } else {
              attrs[key] = value
            }
        }
        self.attributes = attrs
    }
  
    public func renderableAttributes() -> [String: Any] {
        return self.attributes  
    }

    public func renderableJSONAttributes() -> [String: Any] {
        return self.attributes  
    }

}

public func ==(lhs: MemoryModel, rhs: MemoryModel) -> Bool {
    return lhs.id == rhs.id
}

