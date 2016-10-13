//This class is the image provider for the ImageViewer in the gallery

import SKPhotoBrowser

class AnimalImageProvider {

    let animalPhotos: [SKPhoto]

    init(animalPhotos: [Photo]) {
        var images = [SKPhoto]()
        for (index, _) in animalPhotos.enumerated() {
            let url = animalPhotos[index].url
            images.append(SKPhoto.photoWithImageURL(url.absoluteString))
        }
        self.animalPhotos = images
    }
}
