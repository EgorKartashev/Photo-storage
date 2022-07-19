
import Foundation

class SaveData: Codable {
    
var password: String
    
    init(password: String){
        self.password = password
    }
    
    public enum CodingKeys: String, CodingKey {
           case password
       }
       
       // распаковщик / декодер, достает из дата, обязательно первым писать
       required public init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self) // контейнер типа кодинг кейс
           
           self.password = try container.decode(String.self, forKey: .password) // достаем из контейнера нейм тиипа стринг по ключи нейм
         
       }
       
       // упаковщик, упаковывает в дата
       public func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)
           
           try container.encode(self.password, forKey: .password)
        
           
       }
       

}

extension UserDefaults {
    
    func set<T: Encodable>(encodable: T, forKey key: String){
        if let data = try? JSONEncoder().encode(encodable){
            set(data, forKey: key)
        }
    }
    
    func value<T: Decodable>(_ type: T.Type, forKey key:String) -> T? {
        if let data = object(forKey: key) as? Data,
           let value = try? JSONDecoder().decode(type, from: data){
            return value
        }
        return nil
    }
}
