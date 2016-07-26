//This class is the image provider for the ImageViewer in the gallery

import ImageViewer

class AnimalImageProvider: ImageProvider {

    let animalPhotos: [Photo]

    init(animalPhotos: [Photo]) {
        self.animalPhotos = animalPhotos
    }

    func provideImage(completion: UIImage? -> Void) {
        completion(animalPhotos.first?.image)
    }

    func provideImage(atIndex index: Int, completion: UIImage? -> Void) {
        completion(animalPhotos[index].image)
    }
}
