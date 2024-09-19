//
//  ImageView.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 19/09/24.
//

import SwiftUI
import Combine

struct ImageView: View {

    @State var image: UIImage = UIImage()
    let imageLoader = ImageLoader()
    let url: String
    
    init(url:String){
        self.url = url
    }
    
    var body: some View {
        Image(uiImage: UIImage(data: imageLoader.data) ?? image)
            .resizable()
            .onReceive(imageLoader.didChance, perform: { data in
                self.image = UIImage(data: data) ?? UIImage()
            })
            .onAppear{
                if image.cgImage == nil{
                    imageLoader.load(url: url)
                }
            }
    }
}

//Colocar esta classe em outro arquivo depois
class ImageLoader: ObservableObject {
    
    var didChance = PassthroughSubject<Data, Never>()
    
    var data = Data(){
        didSet{
            didChance.send(data)
        }
    }
    
    func load(url: String){
        guard let url = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {return}
            DispatchQueue.main.async{
                self.data = data
            }
        }
        task.resume()
    }
}

#Preview {
    ImageView(url: "http://google.com")
}
